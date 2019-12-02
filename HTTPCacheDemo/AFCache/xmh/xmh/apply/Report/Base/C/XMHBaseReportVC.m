//
//  XMHBaseReportVC.m
//  xmh
//
//  Created by kfw on 2019/7/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBaseReportVC.h"
#import "XMHCalendar.h"
#import "XMHCalendarCell.h"
#import "XMHMonthAndWeekView.h"
#import "XMHMonthAndWeekBgView.h"
#import "XMHReportFullView.h"
#import "XMHReportFilterVC.h"

/** 筛选 */
NSString *const XMHReportH5MethodName_Filter = @"Filter";
/** 排行 */
NSString *const XMHReportH5MethodName_Rank = @"Rank";
/** 全屏 */
NSString *const XMHReportH5MethodName_FullScreen = @"FullScreen";
/** 业绩来源 */
NSString *const XMHReportH5MethodName_ResultsSource = @"ResultsSource";
/** 详情 */
NSString *const XMHReportH5MethodName_EmployeeDetails = @"EmployeeDetails";



@interface XMHBaseReportVC () <FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance, UIGestureRecognizerDelegate, WKNavigationDelegate, WKUIDelegate>
{
    void * _KVOContext;
}
/** 手势 */
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;
@property (nonatomic, strong) XMHPickerView *pickerView;
@property (nonatomic, strong) WKWebView *webView;
/** 底部 */
@property (nonatomic, strong) UIView *bottomView;
/** 日历 */
@property (strong, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorian;
/** 选中日期 */
@property (strong, nonatomic) NSMutableArray *selectedDatesTypeDay;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
/** 记录创建的日历view */
@property (nonatomic, strong) UIView *calendarView;

/** 周、月 */
@property (nonatomic, strong) XMHMonthAndWeekBgView *monthAndWeekView;
/** 当前时间 */
@property (nonatomic, strong) NSDate *currentDate;
/** 月数据 */
@property (nonatomic, strong) NSMutableArray *monthDataArray;
/** 报表url */
@property (nonatomic, strong) NSURL *reportUrl;
/** 全屏报表 */
@property (nonatomic, strong) XMHReportFullView *reportFullView;
/** 保留所有年份 */
@property (nonatomic, strong) NSMutableDictionary *dateDic;
/** 最高、最低 */
@property (nonatomic, copy) NSString *upDown;
@end

@implementation XMHBaseReportVC

- (void)dealloc {
    MzzLog(@"XMHBaseReportVC dealloc");
    [self.calendar removeObserver:self forKeyPath:@"scope" context:_KVOContext];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self config];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self createUI];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.calendarView action:@selector(handleScopeGesture:)];
    self.scopeGesture = panGesture;
    panGesture.delegate = self;
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:panGesture];
    
    // While the scope gesture begin, the pan gesture of tableView should cancel.
    //    [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:panGesture];
    [self.webView.scrollView.panGestureRecognizer requireGestureRecognizerToFail:panGesture];
}

#pragma mark - Getter

- (NSArray <XMHMonthAndWeekModel *> *)selectedDates {
    WeakSelf
    if (_dateType == XMHBaseReportVCDateTypeDay) {
        __block NSMutableArray *selectDateArray = NSMutableArray.new;
        [weakSelf.calendar.selectedDates enumerateObjectsUsingBlock:^(NSDate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XMHMonthAndWeekModel *model = XMHMonthAndWeekModel.new;
            model.firstDate = obj;
            model.lastDate = obj;
            [selectDateArray addObject:model];
        }];
        return (NSArray *)selectDateArray;
    } else {
        return _monthAndWeekView.selectModelArray;
    }
    return nil;
}

- (NSArray <NSDictionary *> *)selectedTimestampTs{
    NSMutableArray *timestampTsArr = [NSMutableArray array];
    // 转换时间戳
    [self.selectedDates enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XMHMonthAndWeekModel *model = obj;
        NSNumber *first= @(model.firstDate.timeIntervalSince1970);
        NSNumber *last= @(model.lastDate.timeIntervalSince1970);
        
        NSDictionary *dic = @{@"start_time":first,@"end_time":last};
        [timestampTsArr safeAddObject:dic];
    }];
    return [timestampTsArr copy];
}

- (XMHReportFullView *)reportFullView {
    if (_reportFullView) return _reportFullView;
    _reportFullView = [[XMHReportFullView alloc] initWithFrame:CGRectMake(0, 0, self.view.height, self.view.width) delegate:self];
    _reportFullView.transform = CGAffineTransformRotate(_reportFullView.transform, M_PI_2);
    _reportFullView.x = 0; // y轴
    _reportFullView.y = 0;
    _reportFullView.webView = self.webView;
//    [[_reportFullView.webView configuration].userContentController addScriptMessageHandler:self name:XMHReportH5MethodName_FullScreen];
//    [[_reportFullView.webView configuration].userContentController addScriptMessageHandler:self name:XMHReportH5MethodName_ResultsSource];
//    [[_reportFullView.webView configuration].userContentController addScriptMessageHandler:self name:XMHReportH5MethodName_EmployeeDetails];
    return _reportFullView;
}

- (NSMutableDictionary *)dateDic {
    if (_dateDic) return _dateDic;
    _dateDic = NSMutableDictionary.new;
    return _dateDic;
}

#pragma mark - Private

- (void)config {
    _reportType = XMHBaseReportVCTypeYeJi;
    _dateType = XMHBaseReportVCDateTypeDay;
}

- (void)createUI {
    [self createNav];
    [self createCalendar];
    [self createWebView];
}

- (void)createNav {
    
    NSString *title = @"日报表";
    if (_dateType == XMHBaseReportVCDateTypeWeek) {
        title = @"周报表";
    }else if (_dateType == XMHBaseReportVCDateTypeMonth){
        title = @"月报表";
    }
    [self.navView setNavViewTitle:title backBtnShow:YES rightBtnTitle:@""];
    [self.navView.rightBtn setTitle:@"重置" forState:UIControlStateNormal];
    WeakSelf
    self.navView.NavViewRightBlock = ^{
        [weakSelf resetClick];
    };
    self.navView.backgroundColor = kColorTheme;
}

- (void)createBottomView {
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height - kSafeAreaBottom - 69, self.view.width, 69)];
    _bottomView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_bottomView];
    
    UIButton *weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weekBtn setTitle:@"周报库" forState:UIControlStateNormal];
    [weekBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    weekBtn.backgroundColor = kLabelText_Commen_Color_ea007e;
    weekBtn.layer.cornerRadius = 3;
    weekBtn.tag = 100;
    [weekBtn addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:weekBtn];
    
    UIButton *monthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [monthBtn setTitle:@"月报库" forState:UIControlStateNormal];
    [monthBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    monthBtn.backgroundColor = kLabelText_Commen_Color_ea007e;
    monthBtn.tag = 101;
    [monthBtn addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    monthBtn.layer.cornerRadius = 3;
    [_bottomView addSubview:monthBtn];
    
    [_bottomView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(-12);
    }];
    
    [_bottomView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:165 leadSpacing:15 tailSpacing:15];
}

// 创建日历
- (void)createCalendar {
    // 根据类型创建日历类型
    if (_dateType == XMHBaseReportVCDateTypeDay) {
        [self createBottomView];
        [self createDayCalendar];
    } else if (_dateType == XMHBaseReportVCDateTypeWeek) {
        [self createWeekOrMonthCalendar:XMHMonthAndWeekCollectionViewTypeWeek];
    } else if (_dateType == XMHBaseReportVCDateTypeMonth) {
        [self createWeekOrMonthCalendar:XMHMonthAndWeekCollectionViewTypeMonth];
    }
}

/**
 创建天日历
 */
- (void)createDayCalendar {
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    CGFloat height = 366;
    FSCalendar *calendar = [[FSCalendar alloc] init];
    self.calendarView = calendar;
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.swipeToChooseGesture.enabled = YES;
    calendar.allowsMultipleSelection = YES;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    [calendar registerClass:[XMHCalendarCell class] forCellReuseIdentifier:@"XMHCalendarCell"];
     self.calendar.frame = CGRectMake(0, KNaviBarHeight, self.view.width, height);
    
    // 不显示周,只显示日
    self.calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    self.calendar.appearance.weekdayTextColor = [ColorTools colorWithHexString:@"#FF9072"];
    self.calendar.appearance.weekdayFont =  FONT_SIZE(16);
    self.calendar.appearance.titleFont =  FONT_SIZE(16);
    self.calendar.appearance.subtitleFont = FONT_SIZE(0);
    self.calendar.appearance.titleDefaultColor = UIColor.blackColor;
    self.calendar.appearance.titleSelectionColor = UIColor.blackColor;
//    self.calendar.appearance.selectionColor = UIColor.blueColor;
    // 默认进来是白色的
    self.calendar.appearance.titleTodayColor = UIColor.whiteColor;
    // 不能选的日期颜色
    self.calendar.appearance.titlePlaceholderColor = UIColor.blackColor;//[ColorTools colorWithHexString:@"#cccccc"];
    self.calendar.calendarHeaderView.hidden = YES;
    // 不显示头部
    self.calendar.headerHeight = 0;
    self.calendar.swipeToChooseGesture.enabled = YES;
    self.calendar.allowsMultipleSelection = YES;
    // 设置可选择范围
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    // 当天默认是选中状态
    [self.calendar selectDate:[NSDate date] scrollToDate:YES];
    [self sureClick];
    
    
    [self.calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
    //展示不是本月的日期
    self.calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
    self.calendar.scope = FSCalendarScopeWeek;
}

/**
 创建 周或月日历
 
 @param type 日历类型
 */
- (void)createWeekOrMonthCalendar:(XMHMonthAndWeekCollectionViewType)type {
    CGFloat monthAndWeekViewHeight = type == XMHMonthAndWeekCollectionViewTypeMonth ? 135 + kDateBarHeight : 300 + kDateBarHeight;
    self.monthAndWeekView = [[XMHMonthAndWeekBgView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight, self.view.width, monthAndWeekViewHeight)];
    _monthAndWeekView.type = type;
    [_monthAndWeekView configDefaultIsFold:YES]; // 日历收起状态
    [self.view addSubview:_monthAndWeekView];
    
    self.calendarView = _monthAndWeekView;
    
    __weak typeof(self) _self = self;
    [_monthAndWeekView setFrameDidChangeBlock:^{
        __strong typeof(_self) self = _self;
        [self updateWebViewFrameTopViewHeight:self.monthAndWeekView.bottom];
    }];
    
    [_monthAndWeekView.dateNavBarView setChangeYearBlock:^(NSInteger tag) {
        __strong typeof(_self) self = _self;
        NSUInteger year = self.currentDate.year;
        // 左
        if (tag == 1) {
            year--;
        }
        // 右
        else if (tag == 2) {
            year++;
        }
        
        // 不允许超过当前时间
        if (year > NSDate.date.year) {
            return;
        }
        
        self.currentDate = [NSDate dateFromYear:(int)year Month:1 Day:1];
        [self getWeekOrMonthData];
    }];
    
    [_monthAndWeekView setDidSelectItemAtIndexPathBlock:^(XMHMonthAndWeekModel * _Nonnull mdoel) {
        __strong typeof(_self) self = _self;
        [self didSelectItemModel:mdoel];
    }];
    
    self.currentDate = [NSDate date];
    [self getWeekOrMonthData];
}

- (void)createWebView {
    self.webView = [[WKWebView alloc] init];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = YES;
//    _webView.scrollView.delegate = self;
    [self.view addSubview:_webView];
    [self updateWebViewFrameTopViewHeight:self.calendarView.bottom];
    
    [self addScriptMessage];
}

- (void)createPickerView{
    self.pickerView = [[XMHPickerView alloc] init];
    _pickerView.type = PickerViewTypeCustom;
//    _pickerView.selectComponent = 0;
    __weak typeof(self) _self = self;
        
    [_pickerView setSureBlock:^(XMHItemModel *  _Nonnull model) {
        __strong typeof(_self) self = _self;
        [self.webView evaluateJavaScript:[NSString stringWithFormat:@"RankParam('%@')",model.idStr] completionHandler:nil];
    }];
    [self.view addSubview:_pickerView];
}

/**
 更新webView frame

 @param topHeight CGRectGetMaxY(各种日历frame)
 */
- (void)updateWebViewFrameTopViewHeight:(CGFloat)topHeight {
    CGFloat webViewH = self.view.height - kSafeAreaBottom - topHeight - self.bottomView.height;
    _webView.frame = CGRectMake(0, topHeight, self.view.width, webViewH);
}

#pragma mark - FSCalendar Private

- (void)configureVisibleCells
{
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    XMHCalendarCell *diyCell = (XMHCalendarCell *)cell;
    [diyCell.eventIndicator removeFromSuperview];
    // Configure selection layer

    if ([self compareWithToday:date]) {
        diyCell.titleLabel.textColor = [ColorTools colorWithHexString:@"#cccccc"];
    }
    
    SelectionType selectionType = SelectionTypeNone;
    if ([self.calendar.selectedDates containsObject:date]) {
        NSDate *previousDate = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:date options:0];
        NSDate *nextDate = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:1 toDate:date options:0];
        if ([self.calendar.selectedDates containsObject:date]) {
            if ([self.calendar.selectedDates containsObject:previousDate] && [self.calendar.selectedDates containsObject:nextDate]) {
                selectionType = SelectionTypeMiddle;
            } else if ([self.calendar.selectedDates containsObject:previousDate] && [self.calendar.selectedDates containsObject:date]) {
                selectionType = SelectionTypeRightBorder;
            } else if ([self.calendar.selectedDates containsObject:nextDate]) {
                selectionType = SelectionTypeLeftBorder;
            } else {//今日,在当前月范围内走SelectionTypeSingle状态
                selectionType = SelectionTypeSingle;
            }
        }
    }else {

        if ([self.gregorian isDateInToday:date]) {
            selectionType = SelectionTypeToday;
        }else{
            selectionType = SelectionTypeNone;
        }
    }
    if (selectionType == SelectionTypeNone) {
        diyCell.selectionType = selectionType;
        diyCell.selectionLayer.hidden = YES;
        return;
    }
    
    diyCell.selectionLayer.hidden = NO;
    diyCell.selectionType = selectionType;

}

// 根据UI更改,默认可选日期为黑色,不可选日期为灰,若UI不要求.采用此方式更佳: self.calendar.appearance.titlePlaceholderColor = [ColorTools colorWithHexString:@"#cccccc"];
- (BOOL)compareWithToday:(NSDate *)date
{
    BOOL result = NO;
    NSComparisonResult comparisonResult = [self.gregorian compareDate:[NSDate date] toDate:date toUnitGranularity:NSCalendarUnitDay];
    
    if (comparisonResult == NSOrderedAscending) {
        result = YES;
    }
    return result;
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
}

#pragma mark - GetData

- (void)getWeekOrMonthData {
    NSDate *date = NSDate.new;
    NSUInteger currentYear = date.year;
    NSUInteger currentMonth = date.month;
//    NSUInteger weekOfYear = date.weekOfYear;
    [_monthAndWeekView.dateNavBarView setYear:_currentDate.getYear];
    if (_monthAndWeekView.type == XMHMonthAndWeekCollectionViewTypeWeek) {
        __block NSMutableArray *dataArray = NSMutableArray.new;
        NSInteger weekOfYear;
        NSArray *weekArr = [_currentDate getAllWeekDate:_currentDate weekOfYear:&weekOfYear];
        [weekArr enumerateObjectsUsingBlock:^(NSDictionary *weekDic, NSUInteger idx, BOOL * _Nonnull stop) {
            XMHMonthAndWeekModel *model = XMHMonthAndWeekModel.new;
            model.firstDate = weekDic[@"startDate"];
            model.lastDate = weekDic[@"endDate"];
            model.weekNum = idx + 1;
//            model.title = [NSString stringWithFormat:@"第%@周", [[XMHMonthAndWeekModel sharedformatter] stringFromNumber:@(model.weekNum)]];
            model.title = [NSString stringWithFormat:@"第%@周", @(model.weekNum)];
            model.subTitle = [NSString stringWithFormat:@"%ld/%ld-%ld/%ld", (unsigned long)model.firstDate.getMonth, (unsigned long)model.firstDate.getDay, (unsigned long)model.lastDate.getMonth, (unsigned long)model.lastDate.getDay];
            model.enable = [weekDic[@"enable"] boolValue];
            [dataArray addObject:model];
            // 设置当前周选中状态
            if (model.firstDate.year == currentYear && model.weekNum == weekOfYear) {
                model.select = YES;
                model.isCurrentDate = YES;
            }
        }];
        
        _monthAndWeekView.collectionView.dataArray = dataArray;
    } else {
        self.monthDataArray = NSMutableArray.new;
        for (int i = 1; i <= 12; i++) {
            XMHMonthAndWeekModel *model = XMHMonthAndWeekModel.new;
            [self.monthDataArray addObject:model];
            model.firstDate = [NSDate dateFromYear:(int)_currentDate.year Month:i Day:1];
            model.title = [NSString stringWithFormat:@"%lu月", (unsigned long)model.firstDate.month];
            model.lastDate = [NSDate dateFromYear:(int)_currentDate.year Month:i Day:(int)[NSDate numberOfDaysInMonth:model.firstDate]];
            model.monthNum = i;
            
            // 超过当前月份，不可点击
            if (model.firstDate.year == currentYear && i > currentMonth) {
                model.enable = NO;
            }
            // 设置当前月选中状态
            if (model.firstDate.year == currentYear && i == currentMonth) {
                model.select = YES;
                model.isCurrentDate = YES;
            }
        }
        _monthAndWeekView.collectionView.dataArray = self.monthDataArray;
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == _KVOContext) {
        FSCalendarScope oldScope = [change[NSKeyValueChangeOldKey] unsignedIntegerValue];
        FSCalendarScope newScope = [change[NSKeyValueChangeNewKey] unsignedIntegerValue];
        NSLog(@"From %@ to %@",(oldScope==FSCalendarScopeWeek?@"week":@"month"),(newScope==FSCalendarScopeWeek?@"week":@"month"));
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Public

/**
 重置
 */
- (void)resetClick {
    WeakSelf
    if (_dateType == XMHBaseReportVCDateTypeDay) {
        [weakSelf.calendar.selectedDates enumerateObjectsUsingBlock:^(NSDate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 重置，不取消当天的
            [weakSelf.calendar deselectDate:obj];
        }];
        [self.calendar selectDate:[NSDate date]];
        [self.calendar reloadData];
    } else if (_dateType == XMHBaseReportVCDateTypeWeek) {
        // 清空选中日期集合
        [_monthAndWeekView.collectionView resetSelectModelArray];

        self.currentDate = [NSDate date];
        // 记录选中按钮位置
        [_monthAndWeekView setDefaultSelectCellOffset];
        [self getWeekOrMonthData];
//        [_monthAndWeekView.collectionView.dataArray enumerateObjectsUsingBlock:^(XMHMonthAndWeekModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            // 重置，不取消当周的
////            obj.select = obj.weekNum == _monthAndWeekView.collectionView.dataArray.count;
//            obj.select = obj.isCurrentDate;
//        }];
//        // 刷新
//        _monthAndWeekView.collectionView.dataArray = _monthAndWeekView.collectionView.dataArray;
    } else if (_dateType == XMHBaseReportVCDateTypeMonth) {
        // 清空选中日期集合
        [_monthAndWeekView.collectionView resetSelectModelArray];

        self.currentDate = [NSDate date];
        // 记录选中按钮位置
        [_monthAndWeekView setDefaultSelectCellOffset];
        [self getWeekOrMonthData];
//        [_monthAndWeekView.collectionView.dataArray enumerateObjectsUsingBlock:^(XMHMonthAndWeekModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            // 重置，不取消当月的
////            obj.select = obj.monthNum == currentMonth;
//            obj.select = obj.isCurrentDate;
//        }];
//        // 刷新
//        _monthAndWeekView.collectionView.dataArray = _monthAndWeekView.collectionView.dataArray;
    }
    [self.webView reload];
}

- (void)sureClick{
    [self.webView reload];
}
/**
 加载web url
 */
- (void)loadWebViewUrl:(NSURL *)url {
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

/**
 加载报表 url
 */
- (void)loadWebViewReportUrl:(NSURL *)url {
    self.reportUrl = url;
}

/**
 注册js调用OC方法。viewWillDisappear: 记得移除
 */
- (void)addScriptMessage {
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:XMHReportH5MethodName_Filter];
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:XMHReportH5MethodName_Rank];
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:XMHReportH5MethodName_FullScreen];
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:XMHReportH5MethodName_ResultsSource];
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:XMHReportH5MethodName_EmployeeDetails];
}

/**
 移除注册的方法 // 需要注意的是addScriptMessageHandler很容易引起循环引用.因此这里要记得移除handlers
 注意： 此方法已经废弃。通过runtime已经打破循环引用
 */
- (void)removeScriptMessage {
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:XMHReportH5MethodName_Filter];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:XMHReportH5MethodName_Rank];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:XMHReportH5MethodName_FullScreen];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:XMHReportH5MethodName_ResultsSource];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:XMHReportH5MethodName_EmployeeDetails];
//    [[_reportFullView.webView configuration].userContentController removeScriptMessageHandlerForName:XMHReportH5MethodName_FullScreen];
}

/**
 OC调用JavaScript方法

 @param jsStr 方法字符串，如 @"setType('123')" 或 @"setType"
 @param completionHandler 回调
 */
- (void)evaluateJavaScript:(NSString *)jsStr completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler {
    if (IsEmpty(jsStr)) return;
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable res, NSError * _Nullable error) {
        MzzLog(@"H5交互--Method:%@, Error:%@", jsStr, error);
        if (completionHandler) completionHandler(res, error);
    }];
}

/**
 报表全屏显示
 */
- (void)showReportFullView {
    [self.view addSubview:self.reportFullView];
    NSString * jsStr = [NSString stringWithFormat:@"FullScreenParam('%@')",@"1"];
    [self.reportFullView.webView evaluateJavaScript:jsStr completionHandler:nil];
//    [self.reportFullView loadWebViewReportUrl:self.reportUrl];
}

/**
 报表全屏隐藏
 */
- (void)hiddenReportFullView {
    self.webView.backgroundColor = kColorTheme;
    [self.view addSubview:_webView];
    NSString * jsStr = [NSString stringWithFormat:@"FullScreenParam('%@')",@"0"];
    [self.reportFullView.webView evaluateJavaScript:jsStr completionHandler:nil];
    [self updateWebViewFrameTopViewHeight:self.calendarView.bottom];
    [self.reportFullView removeFromSuperview];
    self.reportFullView = nil;
}

/**
 选中日期回调

 @param model 日期model
 */
- (void)didSelectItemModel:(XMHMonthAndWeekModel *)model {
    MzzLog(@"%@ select：%d", model.firstDate, model.select);
    [self sureClick];
}

#pragma mark - Click

/**
 周报库（sender.tag == 100）、月报库（sender.tag == 101）事件
 */
- (void)dateBtnClick:(UIButton *)sender {
    XMHBaseReportVCDateType dateType = XMHBaseReportVCDateTypeWeek;
    // 周报库
    if (sender.tag == 100) {
        dateType = XMHBaseReportVCDateTypeWeek;
    }
    // 月报库
    else if (sender.tag == 101) {
        dateType = XMHBaseReportVCDateTypeMonth;
    }
    // self指向：1 当 XMHBaseReportVC 子类实例化。 self 指向这个子类实例。
    XMHBaseReportVC *vc = self.class.new;
    vc.reportType = _reportType;
    vc.dateType = dateType;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    // 全屏，手势取消
    if (_reportFullView) return NO;
    
    if (_dateType == XMHBaseReportVCDateTypeDay) {
        BOOL shouldBegin = _webView.scrollView.contentOffset.y <= -_webView.scrollView.contentInset.top;
        if (shouldBegin) {
            CGPoint velocity = [self.scopeGesture velocityInView:self.view];
            switch (self.calendar.scope) {
                case FSCalendarScopeMonth:
                    return velocity.y < 0;
                case FSCalendarScopeWeek:
                    return velocity.y > 0;
            }
        }
        return shouldBegin;
    } else {
        CGPoint point2 = [self.scopeGesture locationInView:self.view];
        if (CGRectContainsPoint(_monthAndWeekView.frame, point2)) {
            return NO;
        }
        else if (CGRectContainsPoint(_webView.frame, point2)) {
            BOOL shouldBegin = _webView.scrollView.contentOffset.y <= -_webView.scrollView.contentInset.top;
            if (shouldBegin) {
                CGPoint velocity = [self.scopeGesture velocityInView:self.view];
                // 收起
                if (_monthAndWeekView.isFold) {
                    BOOL fold = velocity.y < 0;
                    return fold;
                }
                // 展开
                else {
                    BOOL fold = velocity.y > 0;
                    return fold;
                }
            }
            return shouldBegin;
        }
    }
    return NO;
}

#pragma mark - <FSCalendarDelegate>

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    self.calendar.height = CGRectGetHeight(bounds);
    [self updateWebViewFrameTopViewHeight:self.calendar.bottom];
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{

    // 上个月和下个月部分日期在当前月时,点击不跳动
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
    [self sureClick];
    [self configureVisibleCells];
    
    XMHMonthAndWeekModel *model = XMHMonthAndWeekModel.new;
    model.select = YES;
    model.firstDate = date;
    model.lastDate = date;
    [self didSelectItemModel:model];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
 
    [self configureVisibleCells];
    
    XMHMonthAndWeekModel *model = XMHMonthAndWeekModel.new;
    model.select = NO;
    model.firstDate = date;
    model.lastDate = date;
    [self didSelectItemModel:model];
}

// 业务逻辑:保证有一个日期被选中
- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    if (calendar.selectedDates.count > 1) {
        
        return YES;
    }
    return NO;
}

#pragma mark - FSCalendarDataSource

//能显示的最小日期
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [NSDate dateWithTimeIntervalSince1970:0];
}
// 能显示的最大日期
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    //获取当前时间
    NSDate *date = [NSDate date];
    //变为数字
    NSString* str = [self.dateFormatter stringFromDate:date];
    
    return [self.dateFormatter dateFromString:str];
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @"今";
    }
    return nil;
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    XMHCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"XMHCalendarCell" forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    return 2;
}


#pragma mark - WKNavigationDelegate

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [XMHWebSignTools loadWebViewJs:self.webView];
    /** 只有全屏才会调用js */
//    if ([webView isEqual:self.reportFullView.webView]) {
//        NSString * jsStr = [NSString stringWithFormat:@"FullScreenParam('%@')",@"1"];
//        [self.reportFullView.webView evaluateJavaScript:jsStr completionHandler:nil];
//    }
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];

    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;

    NSString * type = [self typeenumToStringtype];
    NSString * jsStr = [NSString stringWithFormat:@"H5PostParam('%@','%@','%@','%@','%@')",framId,type,self.selectedTimestampTs.jsonData,joinCode,infomodel.data.token];
    
    /** 测试数据 */
//    NSString * jsStr = [NSString stringWithFormat:@"H5PostParam('%@','%@','%@','%@','%@')",@"790",@"day",@"",@"SJ000003",@"bd87ae6fa859aca3b37140cfdc5f4e9d"];
//    if(self.selectedTimestampTs.count == 0) return;
    [self.webView evaluateJavaScript:jsStr completionHandler:nil];

//    [self.reportFullView.webView evaluateJavaScript:jsStr completionHandler:nil];
}

#pragma mark - WKScriptMessageHandler

/**
 js调用OC代理方法
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    MzzLog(@"%@() %@", message.name, message.body);
    WeakSelf
    /** 排名 */
    if ([message.name isEqualToString:XMHReportH5MethodName_Rank]) {
        [self createPickerView];
    }
    /** 筛选 */
    else if ([message.name isEqualToString:XMHReportH5MethodName_Filter]){
        XMHReportFilterVC * filterVC = [[XMHReportFilterVC alloc]init];
        filterVC.reportType = _reportType;
        /** 非员工报表
            H5 筛选规则
            只比对 id 即可得出结果
         */
        filterVC.XMHReportFilterVCBlock = ^(NSString * pidMerge){
            
            [weakSelf evaluateJavaScript:[NSString stringWithFormat:@"FilterParam('%@')",pidMerge] completionHandler:nil];
        };
        /** 员工报表专属
            H5 筛选规则
            当account 为空时筛选的是门店      比对 store_code 得出结果
            当account 不为空时筛选的是员工     比对 account 得出结果
         */
        filterVC.XMHReportEmpioyFilterVCBlock = ^(NSString * _Nonnull json) {
            [weakSelf evaluateJavaScript:[NSString stringWithFormat:@"EmployFilterParam('%@')",json] completionHandler:nil];
        };
        [self.navigationController pushViewController:filterVC animated:NO];
    }
    /** 全屏 */
    else if ([message.name isEqualToString:XMHReportH5MethodName_FullScreen]){
        if ([[NSString stringWithFormat:@"%@",message.body] isEqualToString:@"1"]) {
            [self hiddenReportFullView];
//            [self.webView reload];
        }else{
            [self showReportFullView];
        }
        
        
    }
}

/**
 交互。可输入的文本。

 @param webView webView
 @param prompt js调用的方法名字
 @param defaultText js 的传参
 @param frame frame
 @param completionHandler OC返回参数
 */
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
//    NSString *returnParam;
//    if ([prompt isEqualToString:XMHFormTaskH5MethodName_getType]) {
//        // 1 创建 2 编辑
//        XMHFormTaskCreateVCType taskType = ((XMHFormRowDescriptor *)self.rowDescriptor).taskType;
//        NSString *taskTypeStr = @(taskType).stringValue;
//        returnParam = taskTypeStr;
//        completionHandler(taskTypeStr);//这里就是要返回给JS的返回值
//    }
    MzzLog(@"method:%@() param:%@", prompt, defaultText);
}

- (NSString *)typeenumToStringtype
{
    NSString * type = @"";
    if (self.dateType == XMHBaseReportVCDateTypeDay) {
        type = @"day";
    }
    else if (self.dateType == XMHBaseReportVCDateTypeWeek){
        type = @"week";
    }
    else if (self.dateType == XMHBaseReportVCDateTypeMonth){
        type = @"month";
    }
    return type;
}
@end
