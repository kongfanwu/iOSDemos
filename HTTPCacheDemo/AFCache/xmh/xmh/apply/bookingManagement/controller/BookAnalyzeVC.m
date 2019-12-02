//
//  BookAnalyzeVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookAnalyzeVC.h"
#import <WebKit/WebKit.h>
#import "BookCommonCell.h"
#import "CustomerTbHeader.h"
#import "LDatePickView.h"
/** 自定义View */
#import "BookTbSectionHeader.h"
#import "BStateView.h"
#import "CustomerTbHeader.h"
#import "BDetailDataView.h"
#import "CommonHeaderView.h"
#import "CustomerTbHeader.h"
#import "LXCalendarView.h"
#import "BookAnalyzeDetailView.h"
/** 自定义Cell */
#import "BookCommonCell.h"
#import "LolHomeModel.h"
#import "BookCommonCell1.h"
#import "BookCustomerCollectionViewCell.h"
#import "BookAllCustomerCell.h"
#import "BookCommonCell2.h"
#import "BookAnalyzeCollectionCell.h"

/** Model */
#import "COrganizeModel.h"
#import "LolHomeListModel.h"
#import "HomePageHeadModel.h"
#import "LolCalendarModelList.h"
#import "LolGuKeListModel.h"
#import "LolHomeGuKeModel.h"
#import "LolGuKeStateModelList.h"
#import "BookParamModel.h"
#import "LolHomeListModel.h"

/** 通用 */
#import "DateSubViewModel.h"
#import "LolDateManager.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "RolesTools.h"
#import "GuideView.h"
#import "BookRequest.h"
#import "ShareWorkInstance.h"
/** VC */
#import "FWDDetailViewController.h"
#import "BookWaitVC.h"
#import "BookDoneVC.h"
#import "BookFastVC.h"
#import "BookDetailVC.h"
#import "BookAnalyzeOneCustomerVC.h"
#import "BookChartHomeVC.h"
#import "BookChartVC.h"
#import "XMHRefreshGifHeader.h"
@interface BookAnalyzeVC ()
<   UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource,
WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler
>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)CustomerTbHeader * tbHeader;
@property (nonatomic, strong)LXCalendarView * calendar;
@property (nonatomic, strong)BStateView * stateView;
@property (nonatomic, strong)CustomerTbHeader * topDataView;
@property (nonatomic, strong)BDetailDataView * detailDataView;
@property (nonatomic, strong)BookTbSectionHeader * bookTbSectionHeader;
@property (nonatomic, strong)UICollectionView * allCustomerCollectionView;
@property (nonatomic, strong)WKWebView * oneCustomerWebView;
@property (nonatomic, strong)UIButton * bookBtn;
/** 选择日期 */
@property (nonatomic, strong)LDatePickView * datePickView;
/** 选择器 */
@property (nonatomic, strong)UISegmentedControl * segmentedControl;
/** 开始时间 */
@property (nonatomic, copy)NSString *startTime;
/** 结束时间 */
@property (nonatomic, copy)NSString *endTime;
/** 是否为整月 */
@property (nonatomic, assign)BOOL isMonth;
/** 选择的单个日期 */
@property (nonatomic, copy)NSString *selectTime;
/** 详情数据View */
@property (nonatomic, strong)BookAnalyzeDetailView * analyzeDetailView;
/** 层级 */
@property (nonatomic, copy)NSString *selectLevel;
/** 是否是加载更多 */
@property (nonatomic, assign)BOOL isMore;

/** 选择器标题 */
@property (nonatomic, strong)NSArray * segmentTitles;
/** level */
@property (nonatomic, strong)NSDictionary * levelDic;
/** collectionView 数据源 */
@property (nonatomic, strong)NSMutableArray * customerDataSource;

@property (nonatomic, copy)NSString * cellType;

@property (nonatomic, assign)BOOL isFront;
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
/** 八筒数据是否展开 */
//@property (nonatomic, assign)BOOL isUnfold;
/** 八筒数据是否展开 */
@property (nonatomic, assign) BOOL isUnfold;
@end

@implementation BookAnalyzeVC
{
    COrganizeModel *_organizeModel;
    LolHomeListModel *_homeListModel;
    HomePageHeadModel *_homePageHeadModel;
    LolCalendarModelList *_lolCalendarModelList;
    LolGuKeListModel *_guKeListModel;
    LolGuKeStateModelList *_customerStateModelList;
    NSString *_oneCustomerSelectDate;
    /** 页码 */
    NSInteger _currentPage;
    /** 单个顾客user_id */
    NSString *_userID;
    /** 全部顾客界面加载更多时用 */
//    NSMutableArray * _dataSource;
    /** 是否展示层级按钮 */
    BOOL _isShowCengji;
    
}
- (void)dealloc
{
    NSLog(@"BookAnalyzeVC dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;
    /** 初始化数据 */
    _isMonth = YES;
    _isMore = YES;
    _currentPage = 1;
    _customerDataSource = [[NSMutableArray alloc] init];
    _levelDic = @{@"员工":@"yg",@"顾客":@"gk",@"层级":@"cj",@"门店":@"md"};
    /** 监测日期月份变化 */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(monthChange:) name:@"dateChange" object:nil];
    [self initSubViews];
    
    if (_pageType == BookAnalyzePageTypeDJL) {
        _cellType = @"2";
    }else if (_pageType == BookAnalyzePageTypeManagement){
        _cellType = @"1";
    }else if (_pageType == BookAnalyzePageTypeDZ){
        _cellType = @"3";
    }else if (_pageType == BookAnalyzePageTypeStaff){
        _cellType = @"4";
    }else{}
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[_oneCustomerWebView configuration].userContentController  removeScriptMessageHandlerForName:@"getUserCalendar"];
    [[_oneCustomerWebView configuration].userContentController  removeScriptMessageHandlerForName:@"GuKeCalenderReload"];
}

- (void)initSubViews
{
    [self.navView setNavViewTitle:@"预约分析" backBtnShow:YES];
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 108);
    self.logoView.image = UIImageName(@"stgkgl_ditu");
    [self.view addSubview:self.datePickView];
    
    if (_pageType == BookAnalyzePageTypeStaff || _pageType == BookAnalyzePageTypeDZ) {
        _segmentTitles = @[@"员工",@"顾客"];
    }else{
        _segmentTitles = @[@"层级",@"门店"];
    }
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.allCustomerCollectionView];
    [self requestCalendarData];
    [self requestHomeTopData];
    [self resetTbHeaderView];
}
/** 重新加载TbHeaderView */
- (void)resetTbHeaderView
{
    if (_pageType == BookAnalyzePageTypeDJL) {
        _tbView.tableHeaderView = [self managerDJLTbHeaderView];
        _selectLevel = @"md";
    }else{
        _tbView.tableHeaderView = [self managerTbHeaderView];
    }
}
- (LDatePickView *)datePickView
{
    WeakSelf
    if (!_datePickView) {
        _datePickView = [[LDatePickView alloc] initWithFrame:CGRectMake(15, Heigh_Nav, SCREEN_WIDTH - 15 * 2 , 34) dateBlock:^(NSString *start, NSString *end) {
            weakSelf.startTime = start;
            weakSelf.endTime = end;
            weakSelf.isMonth = YES;
            /** 获取八筒数据 */
            [weakSelf requestHomeTopData];
//            /** 切换日期时没有列表数据 */
//            [weakSelf.dataSource removeAllObjects];
//            [weakSelf.tbView reloadData];
            
        }];
        _datePickView.backgroundColor = [UIColor whiteColor];
    }
    return _datePickView;
}
- (UISegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:_segmentTitles];
        _segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 10, 180, 25);
        [_segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: kBtn_Commen_Color} forState:UIControlStateNormal];
        //设置选中状态下的文字颜色和字体
        [_segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
        _segmentedControl.tintColor = kBtn_Commen_Color;
        _segmentedControl.selectedSegmentIndex = 0;
        [self segementValueChane:_segmentedControl];
        [_segmentedControl addTarget:self action:@selector(segementValueChane:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

/** UITableView */
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, _datePickView.bottom + 15, SCREEN_WIDTH, SCREEN_HEIGHT - _datePickView.bottom - 15) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.backgroundColor = [UIColor whiteColor];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tbView;
}
- (UICollectionView *)allCustomerCollectionView
{
    if (!_allCustomerCollectionView) {
        /** 每行几个单元格 */
        NSInteger nums = 4;
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 15 *2 - 9 * (nums - 1))/nums, 80);;
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 0, 15);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _allCustomerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _datePickView.bottom + 15, SCREEN_WIDTH, SCREEN_HEIGHT - _datePickView.bottom - 15) collectionViewLayout:layout];
        _allCustomerCollectionView.delegate = self;
        _allCustomerCollectionView.dataSource = self;
        _allCustomerCollectionView.contentInset = UIEdgeInsetsMake((160 + 44 + 85 + 45), 0, 0, 0);
        _allCustomerCollectionView.showsHorizontalScrollIndicator = NO;
        [_allCustomerCollectionView registerNib:[UINib nibWithNibName:@"BookAnalyzeCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BookAllCustomerCell"];
        _allCustomerCollectionView.backgroundColor = [UIColor whiteColor];
        _allCustomerCollectionView.pagingEnabled = NO;
        _allCustomerCollectionView.hidden = YES;
//        [_allCustomerCollectionView addSubview:self.allCustomerCVHeaderView];
        _allCustomerCollectionView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshCollectionViewData];
//        }];
        __weak typeof(self) _self = self;
        _allCustomerCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestMoreData];
        }];
    }
    return _allCustomerCollectionView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self refreshCollectionViewData];
        }];
    }
    return _gifHeader;
}
- (CustomerTbHeader *)topDataView
{
    WeakSelf
    if (!_topDataView) {
        _topDataView = loadNibName(@"CustomerTbHeader");
        [_topDataView updateCustomerTbHeaderTitle:nil];
        [_topDataView updateCustomerModule:@"YYGL"];
        _topDataView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
        _topDataView.CustomerTbHeaderMoreBlock = ^(BOOL isSelect) {
            if (isSelect) {
                weakSelf.topDataView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 270);
            }else{
                weakSelf.topDataView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
            }
        };
    }
    return _topDataView;
}
- (BDetailDataView *)detailDataView
{
    if (!_detailDataView) {
        _detailDataView = loadNibName(@"BDetailDataView");
    }
    return _detailDataView;
}
- (LXCalendarView *)calendar
{
    WeakSelf
    if (!_calendar) {
        _calendar = [[LXCalendarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
        _calendar.currentMonthTitleColor = [ColorTools colorWithHexString:@"#2c2c2c"];
        _calendar.lastMonthTitleColor = kLabelText_Commen_Color_9;
        _calendar.nextMonthTitleColor = kLabelText_Commen_Color_9;
        _calendar.isHaveAnimation = YES;
        _calendar.isCanScroll = NO;
        _calendar.isShowLastAndNextBtn = YES;
        _calendar.isShowLastAndNextDate = NO;
        _calendar.todayTitleColor = [UIColor purpleColor];
        _calendar.selectBackColor = [ColorTools colorWithHexString:@"e5e5e5"];;
        _calendar.backgroundColor = [UIColor whiteColor];
        _calendar.selectBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
            weakSelf.isMonth = NO;
            weakSelf.selectTime = [LolDateManager formatterDateString:[NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day]];
            NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
            [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate * selectDate = [myDateFormatter dateFromString:weakSelf.selectTime];
            NSDate * currentDate = [NSDate date];
            NSString * currentDateStr = [myDateFormatter stringFromDate:currentDate];
            currentDate = [myDateFormatter dateFromString:currentDateStr];
            NSComparisonResult result = [currentDate compare:selectDate];
            if (result == NSOrderedAscending || result == NSOrderedSame){
                //结束时间大于开始时间
                weakSelf.isFront = NO;
            }else if (result == NSOrderedDescending){
                //结束时间小于开始时间
                weakSelf.isFront = YES;
            }
            [weakSelf requestHomeListData];
            [weakSelf requestCalendarData];
        };
    }
    return _calendar;
}
/** 日历月份变更 */
- (void)monthChange:(NSNotification *)notif
{
    _isMonth = YES;
    MzzLog(@"%@.....%@",notif.object,notif.name);
    _startTime = [self dateToString:notif.object withDateFormat:@"yyyy-MM-dd"];
    [self requestCalendarData];
    
}
/** 日期转化为字符串 */
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
- (BookAnalyzeDetailView *)analyzeDetailView
{
    if (!_analyzeDetailView) {
        _analyzeDetailView = loadNibName(@"BookAnalyzeDetailView");
    }
    return _analyzeDetailView;
}
- (BStateView *)stateView
{
    if (!_stateView) {
        _stateView = loadNibName(@"BStateView");
        BOOL isDJL = NO;
        if (_pageType == BookAnalyzePageTypeDJL) {
            isDJL = YES;
        }
        [_stateView updateBStateViewisShowRestByPageType:@"店经理" isDJL:isDJL];
    }
    return _stateView;
}

-(WKWebView *)oneCustomerWebView
{
    if (!_oneCustomerWebView) {
        _oneCustomerWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 450)];
        _oneCustomerWebView.UIDelegate = self;
        _oneCustomerWebView.navigationDelegate = self;
        _oneCustomerWebView.scrollView.scrollEnabled = NO;
        [[_oneCustomerWebView configuration].userContentController addScriptMessageHandler:self name:@"getUserCalendar"];
        [[_oneCustomerWebView configuration].userContentController addScriptMessageHandler:self name:@"GuKeCalenderReload"];
        [_oneCustomerWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beauty/yuyue_time.html",SERVER_H5]]]];
    }
    return _oneCustomerWebView;
}
- (UIView *)managerTbHeaderView
{
    WeakSelf
    UIView * tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160 + 44 + 350 + 110 + 25 + 20)];
    self.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 10, 180, 25);
    self.topDataView.frame = CGRectMake(0, _segmentedControl.bottom + 10, SCREEN_WIDTH, 160);
    __weak CustomerTbHeader * weaktopDataView = _topDataView;
    self.stateView.frame = CGRectMake(0, _topDataView.bottom, SCREEN_WIDTH, 44);
    self.calendar.frame = CGRectMake(0, _stateView.bottom, SCREEN_WIDTH, 350);
    self.analyzeDetailView.frame = CGRectMake(0, weakSelf.calendar.bottom, SCREEN_WIDTH, 110);
    [tbHeaderView addSubview:_segmentedControl];
    [tbHeaderView addSubview:_topDataView];
    [tbHeaderView addSubview:_stateView];
    [tbHeaderView addSubview:_calendar];
    [tbHeaderView addSubview:_analyzeDetailView];
    __weak UIView * tbHeaderViewWeek = tbHeaderView;
    _topDataView.CustomerTbHeaderMoreBlock = ^(BOOL isSelect) {
        if (isSelect) {
            weakSelf.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 10, 180, 25);
            weaktopDataView.frame = CGRectMake(0, weakSelf.segmentedControl.bottom + 10, SCREEN_WIDTH, 270);
            weakSelf.stateView.frame = CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, 44);
            weakSelf.calendar.frame =  CGRectMake(0, weakSelf.stateView.bottom, SCREEN_WIDTH, 350);
            weakSelf.analyzeDetailView.frame = CGRectMake(0, weakSelf.calendar.bottom, SCREEN_WIDTH, 110);
            tbHeaderViewWeek.frame = CGRectMake(0, 0, SCREEN_WIDTH, 270 + 44 + 350 + 110 + 25 + 20);
            weakSelf.tbView.tableHeaderView = tbHeaderViewWeek;
            
        }else{
            weakSelf.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 10, 180, 25);
            weaktopDataView.frame = CGRectMake(0, weakSelf.segmentedControl.bottom + 10, SCREEN_WIDTH, 160);
            weakSelf.stateView.frame = CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, 44);
            weakSelf.calendar.frame =  CGRectMake(0, weakSelf.stateView.bottom, SCREEN_WIDTH, 350);
            weakSelf.analyzeDetailView.frame = CGRectMake(0, weakSelf.calendar.bottom, SCREEN_WIDTH, 110);
            tbHeaderViewWeek.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160 + 44 + 350 + 110 + 25 + 20);
            weakSelf.tbView.tableHeaderView = tbHeaderViewWeek;
        }
    };
    tbHeaderView.backgroundColor = [UIColor whiteColor];
    return tbHeaderView;
}
- (UIView *)managerDJLTbHeaderView
{
    WeakSelf
    UIView * tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160 + 44 + 350 + 110  + 10)];
    self.topDataView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    __weak CustomerTbHeader * weaktopDataView = _topDataView;
    self.stateView.frame = CGRectMake(0, _topDataView.bottom, SCREEN_WIDTH, 44);
    self.calendar.frame = CGRectMake(0, _stateView.bottom, SCREEN_WIDTH, 350);
    self.analyzeDetailView.frame = CGRectMake(0, weakSelf.calendar.bottom, SCREEN_WIDTH, 110);
    [tbHeaderView addSubview:_topDataView];
    [tbHeaderView addSubview:_stateView];
    [tbHeaderView addSubview:_calendar];
    [tbHeaderView addSubview:_analyzeDetailView];
    _topDataView.CustomerTbHeaderMoreBlock = ^(BOOL isSelect) {
        if (isSelect) {
            weaktopDataView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 270);
            weakSelf.stateView.frame = CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, 44);
            weakSelf.calendar.frame =  CGRectMake(0, weakSelf.stateView.bottom, SCREEN_WIDTH, 350);
            weakSelf.analyzeDetailView.frame = CGRectMake(0, weakSelf.calendar.bottom, SCREEN_WIDTH, 110);
            tbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 270 + 44 + 350 + 110 + 10);
            weakSelf.tbView.tableHeaderView = tbHeaderView;
            
        }else{
            weaktopDataView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
            weakSelf.stateView.frame = CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, 44);
            weakSelf.calendar.frame =  CGRectMake(0, weakSelf.stateView.bottom, SCREEN_WIDTH, 350);
            weakSelf.analyzeDetailView.frame = CGRectMake(0, weakSelf.calendar.bottom, SCREEN_WIDTH, 110);
            tbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160 + 44 + 350 + 110 +  10);
            weakSelf.tbView.tableHeaderView = tbHeaderView;
        }
    };
    tbHeaderView.backgroundColor = [UIColor whiteColor];
    return tbHeaderView;
}

- (UIView *)allCustomerCVHeaderView
{
    WeakSelf
    CGFloat totalH = 25 + 20;
    CGFloat dataViewTop = 10;
    UIView * tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, -(160 + 44 + 85 + totalH), SCREEN_WIDTH, 160 + 44 + 85 + totalH)];
    self.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 10, 180, 25);
    self.topDataView.frame = CGRectMake(0, _segmentedControl.bottom + dataViewTop, SCREEN_WIDTH, 160);
    __weak CustomerTbHeader * weaktopDataView = _topDataView;
    self.detailDataView.frame = CGRectMake(0, _topDataView.bottom, SCREEN_WIDTH, 85);
    self.stateView.frame = CGRectMake(0, _detailDataView.bottom, SCREEN_WIDTH, 44);
    [tbHeaderView addSubview:_segmentedControl];
    [tbHeaderView addSubview:_topDataView];
    [tbHeaderView addSubview:_detailDataView];
    [tbHeaderView addSubview:_stateView];
    [weakSelf.allCustomerCollectionView addSubview:tbHeaderView];
    _topDataView.CustomerTbHeaderMoreBlock = ^(BOOL isSelect) {
        if (isSelect) {
            weakSelf.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 10, 180, 25);
            weaktopDataView.frame = CGRectMake(0, weakSelf.segmentedControl.bottom + dataViewTop, SCREEN_WIDTH, 260);
            weakSelf.detailDataView.frame = CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, 85);
            weakSelf.stateView.frame = CGRectMake(0, weakSelf.detailDataView.bottom, SCREEN_WIDTH, 44);
            weakSelf.allCustomerCollectionView.scrollsToTop = YES;
            tbHeaderView.frame = CGRectMake(0, -(260 + 44 + 85 + totalH), SCREEN_WIDTH, 270 + 44 + 85 + totalH);
            weakSelf.allCustomerCollectionView.contentInset = UIEdgeInsetsMake((260 + 44 + 85 + totalH), 0, 0, 0);
            weakSelf.allCustomerCollectionView.contentOffset = CGPointMake(0, -(260 + 44 + 85 + totalH));
        }else{
            weakSelf.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 10, 180, 25);
            weaktopDataView.frame = CGRectMake(0, weakSelf.segmentedControl.bottom + dataViewTop, SCREEN_WIDTH, 160);
            weakSelf.detailDataView.frame = CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, 85);
            weakSelf.stateView.frame = CGRectMake(0, weakSelf.detailDataView.bottom, SCREEN_WIDTH, 44);
            weakSelf.allCustomerCollectionView.contentInset = UIEdgeInsetsMake((160 + 44 + 85 + totalH), 0, 0, 0);
            tbHeaderView.frame = CGRectMake(0, -(160 + 44 + 85 + totalH), SCREEN_WIDTH, 160 + 44 + 85 + totalH);
            weakSelf.allCustomerCollectionView.contentOffset = CGPointMake(0, -(160 + 44 + 85 + totalH ));
        }
        weakSelf.isUnfold = isSelect;
    };
    return tbHeaderView;
}
#pragma mark ------UITableViewDelegate------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_pageType == BookAnalyzePageTypeStaff) {
        LolHomeModel * homeModel = _homeListModel.list[section];
        return homeModel.pro?homeModel.pro.count:0;
    }
    return _homeListModel.list.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_pageType == BookAnalyzePageTypeStaff) {
        return _homeListModel.list.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kBookCommonCell = @"kBookCommonCell";
    static NSString * kBookCommonCell1 = @"kBookCommonCell1";
    if (_pageType == BookAnalyzePageTypeStaff) {
        BookCommonCell1 * bookCommonCell1 = [tableView dequeueReusableCellWithIdentifier:kBookCommonCell1];
        if (!bookCommonCell1) {
            bookCommonCell1 = loadNibName(@"BookCommonCell1");
        }
        [bookCommonCell1 updateBookCommonCell1Model:_homeListModel.list[indexPath.section].pro[indexPath.row]];
        return bookCommonCell1;
    }else{
        BookCommonCell * bookCommonCell = [tableView dequeueReusableCellWithIdentifier:kBookCommonCell];
        if (!bookCommonCell) {
            bookCommonCell = loadNibName(@"BookCommonCell");
        }
        BOOL isCJ = NO;
        if ([_selectLevel isEqualToString:@"cj"]) {
            isCJ = YES;
        }
        [bookCommonCell updateBookCommonCellModel:_homeListModel.list[indexPath.row] pageType:_cellType isCengJj:isCJ];
        return bookCommonCell;
    }
//    return bookCommonCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_pageType == BookAnalyzePageTypeStaff) {
        return 50.0f;
    }
    return 0.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_pageType == BookAnalyzePageTypeStaff) {
        BookTbSectionHeader * bookTbSectionHeader = loadNibName(@"BookTbSectionHeader");
        [bookTbSectionHeader updateBookTbSectionHeaderModel:_homeListModel.list[section]];
        return bookTbSectionHeader;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_pageType == BookAnalyzePageTypeStaff){
        return 68.0f;
    }
    return 105.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_pageType == BookAnalyzePageTypeStaff){
        return;
    }
    LolHomeModel * model = _homeListModel.list[indexPath.row];
    /** 1、列表为门店时跳转预约表*/
    if (_pageType == BookAnalyzePageTypeDJL || [_selectLevel isEqualToString:@"md"]) {
        BookChartHomeVC * next = [[BookChartHomeVC alloc] init];
        NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
        NSString * name = model.name;
        NSString * code = model.inId;
        NSString * num = [NSString stringWithFormat:@"%ld",model.num];
        [param setValue:name?name:@"" forKey:@"name"];
        [param setValue:code?code:@"" forKey:@"code"];
        [param setValue:num?num:@"" forKey:@"num"];
        next.storeParam = param;
        BookChartVC * charVC = [[BookChartVC alloc] init];
        NSMutableArray * VCs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [VCs addObject:next];
        charVC.storeParam = param;
        [VCs addObject:charVC];
        [self.navigationController setViewControllers:VCs animated:NO];
//        [self.navigationController pushViewController:next animated:NO];
    }else{/** 跳转下一级 */
        BookAnalyzeVC * analyzeVC = [[BookAnalyzeVC alloc] init];
        BookAnalyzePageType  pageType;
        if (model.main_role.integerValue == 1) {
            pageType = BookAnalyzePageTypeManagement;
        }else if(model.main_role.integerValue == 3){
            pageType = BookAnalyzePageTypeDJL;
        }else if (model.main_role.integerValue == 4 || model.main_role.integerValue == 5||model.main_role.integerValue == 6 || model.main_role.integerValue == 7){
            pageType = BookAnalyzePageTypeDZ;
        }else {
            pageType = BookAnalyzePageTypeStaff;
        }
        analyzeVC.framID = [NSString stringWithFormat:@"%ld",model.fram_id];
        analyzeVC.pageType = pageType;
        analyzeVC.INID = model.inId;
        [self.navigationController pushViewController:analyzeVC animated:NO];
    }
    
}
#pragma mark ------UICollectionViewDelegate------
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookAnalyzeCollectionCell * customerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookAllCustomerCell" forIndexPath:indexPath];
    [customerCell updateCellParam:_customerDataSource[indexPath.row]];
    return customerCell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return 10;
    return _customerDataSource.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookAnalyzeOneCustomerVC * next = [[BookAnalyzeOneCustomerVC alloc] init];
    next.userID = _customerDataSource[indexPath.row][@"id"];
    NSString * date = [_startTime substringWithRange:NSMakeRange(0, 7)];
    next.searchDate = date;
    [self.navigationController pushViewController:next animated:NO];
}
#pragma mark ------Action------
- (void)requestMoreData
{
    _isMore = YES;
    _currentPage ++;
    [self requestAllCustomersData];
    
}
- (void)refreshCollectionViewData
{
    _isMore = NO;
    _currentPage = 1;
    [self requestAllCustomersData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
    [_allCustomerCollectionView.mj_header endRefreshing];
    [_allCustomerCollectionView.mj_footer endRefreshing];
}

- (void)segementValueChane:(UISegmentedControl *)sc
{
    NSString * title = [sc titleForSegmentAtIndex:sc.selectedSegmentIndex];
    _selectLevel = _levelDic[title];
    if ([[sc titleForSegmentAtIndex:sc.selectedSegmentIndex] isEqualToString:@"顾客"]) {
        _allCustomerCollectionView.hidden = NO;
        [_allCustomerCollectionView addSubview:self.allCustomerCVHeaderView];
        [self refreshCollectionViewData];
    }else{
        _tbView.hidden = NO;
        _allCustomerCollectionView.hidden = YES;
        [self resetTbHeaderView];
        [self requestHomeTopData];
        if (!_isMonth) {
            [self requestHomeListData];
        }
    }
    
    BOOL isDJL = NO;
    if (_pageType == BookAnalyzePageTypeDJL) {
        isDJL = YES;
    }
    [_stateView updateBStateViewisShowRestByPageType:title isDJL:isDJL];
    [_topDataView updateCustomerTbHeaderStates];
}
#pragma mark ------网络请求------
///加载八筒数据
- (void)requestHomeTopData
{
    NSString * framID = _framID?_framID:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = @"";
    /** 如果是员工 account 取传参 INID */
    if (_pageType == BookAnalyzePageTypeStaff) {
        account = _INID;
        if (_INID.length <=0) {
            account = [NSString stringWithFormat:@"%@",infomodel.data.account];
        }
        
    }else{
        account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    }
    NSString * startTime = _startTime;
    NSString * endTime = _endTime;
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    /** 岗位id */
    [param setValue:framID?framID:@"" forKey:@"fram_id"];
    /** 账号 */
    [param setValue:account?account:@"" forKey:@"account"];
    /** 查询月份 查询区间开始 不传默认当月 格式 ： 2017-08-08 */
    [param setValue:startTime?startTime:@"" forKey:@"start"];
    /** 查询月份 查询区间结束 不传默认当月 格式 ： 2017-08-08 */
    [param setValue:endTime?endTime:@"" forKey:@"end"];
    [BookRequest requestCommonUrl:kBOOK_ANALYZE_TOP_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self organizeTopViewDataParam:resultDic];
        }else{}
    }];
}
/** 组织八筒数据模型 */
- (void)organizeTopViewDataParam:(NSDictionary *)param
{
    NSString * dyy = param[@"dyy"]?param[@"dyy"]:@"";
    NSString * yyy = param[@"yyy"]?param[@"yyy"]:@"";
    NSString * xgyy = param[@"xgyy"]?param[@"xgyy"]:@"";
    NSString * zxyy = param[@"zxyy"]?param[@"zxyy"]:@"";
    NSString * sjjd = param[@"sjjd"]?param[@"sjjd"]:@"";
    NSString * wasdd = param[@"wasdd"]?param[@"wasdd"]:@"";
    NSString * ghwdd = param[@"ghwdd"]?param[@"ghwdd"]:@"";
    NSString * ddl = [NSString stringWithFormat:@"%.2f", [param[@"ddl"]floatValue]];
    DateSubViewModel * model1 = [DateSubViewModel createModelIconName:@"styygl_danyuyue" textName:@"待预约" textValue:dyy isShow:NO];
    DateSubViewModel * model2 = [DateSubViewModel createModelIconName:@"styygl_yiyuyue" textName:@"已预约" textValue:yyy isShow:NO];
    DateSubViewModel * model3 = [DateSubViewModel createModelIconName:@"styygl_xiugaiyuyue" textName:@"修改预约" textValue:xgyy isShow:NO];
    DateSubViewModel * model4 = [DateSubViewModel createModelIconName:@"styygl_zhixingyuyue" textName:@"执行预约" textValue:zxyy isShow:NO];
    DateSubViewModel * model5 = [DateSubViewModel createModelIconName:@"styygl_shijijiedai" textName:@"实际接待" textValue:sjjd isShow:NO];
    DateSubViewModel * model6 = [DateSubViewModel createModelIconName:@"styygl_weianshidaodian" textName:@"未按时到店" textValue:wasdd isShow:NO];
    DateSubViewModel * model7 = [DateSubViewModel createModelIconName:@"styygl_guihuawaidaodian" textName:@"规划外到店" textValue:ghwdd isShow:NO];
    DateSubViewModel * model8 = [DateSubViewModel createModelIconName:@"styygl_daodianlv" textName:@"到店率（%）" textValue:ddl isShow:NO];
    [_topDataView updateCustomerTbHeaderModel:@[model1,model2,model3,model4,model5,model6,model7,model8]];
}
/** 获取日历数据 */
- (void)requestCalendarData
{
    NSString * framID = _framID?_framID:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = @"";
    /** 如果是员工 account 取传参 INID */
    if (_pageType == BookAnalyzePageTypeStaff) {
        account = _INID;
        if (_INID.length <=0) {
            account = [NSString stringWithFormat:@"%@",infomodel.data.account];
        }
        
    }else{
        account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    }
    NSString * startTime = _startTime;
//    NSString * endTime = _endTime;
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    /** 岗位id */
    [param setValue:framID?framID:@"" forKey:@"fram_id"];
    /** 账号 */
    [param setValue:account?account:@"" forKey:@"account"];

    if (_isMonth) {
        /** 查询月份 不传默认当月 格式 ： 可以是2017-08 或者 2017-08-08 */
        [param setValue:startTime?startTime:@"" forKey:@"date"];
    }else{
        /** 查询某天 不传默认当月 格式（2017-08-01） */
        [param setValue:_selectTime?_selectTime:@"" forKey:@"time"];
    }
    
    [BookRequest requestCommonUrl:kBOOK_ANALYZE_CALENDER_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            LolCalendarModelList *listModel  = [LolCalendarModelList yy_modelWithDictionary:resultDic];
            _lolCalendarModelList = listModel;
            [_calendar dealData:_lolCalendarModelList];
            [_analyzeDetailView updateBookAnalyzeDetailViewModel:_lolCalendarModelList isMonth:_isMonth isFront:_isFront];
            
        }else{}
    }];
}
/** 获取列表数据 */
- (void)requestHomeListData
{
    NSString * framID = _framID?_framID:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = @"";
    /** 如果是员工 account 取传参 INID */
    if (_pageType == BookAnalyzePageTypeStaff) {
        account = _INID;
        if (_INID.length <=0) {
            account = [NSString stringWithFormat:@"%@",infomodel.data.account];
        }

    }else{
        account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    }
//    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * level = _selectLevel;
    NSString * page = @"1";
    NSString * size = @"";
    NSString * time = _selectTime;
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    /** 岗位ID */
    [param setValue:framID?framID:@"" forKey:@"fram_id"];
    /** 账号 */
    [param setValue:account?account:@"" forKey:@"account"];
    /** 层级选择 */
    [param setValue:level?level:@"" forKey:@"level"];
    /** 分页页码 不传默认1 */
    [param setValue:page?page:@"1" forKey:@"page"];
    /** 分页大小 不传默认20 */
    [param setValue:size?size:@"" forKey:@"size"];
    /** 选择日期 */
    [param setValue:time?time:@"" forKey:@"time"];
    
    [BookRequest requestCommonUrl:kBOOK_ANALYZE_HOMELIST_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            LolHomeListModel *listModel  = [LolHomeListModel yy_modelWithDictionary:resultDic];
            _homeListModel = listModel;
            [_tbView reloadData];
        }else{}
    }];
}
/** 全部顾客数据 */
- (void)requestAllCustomersData
{
    NSString * framID = _framID?_framID:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = @"";
    /** 如果是员工 account 取传参 INID */
    if (_pageType == BookAnalyzePageTypeStaff) {
        account = _INID;
        if (_INID.length <=0) {
            account = [NSString stringWithFormat:@"%@",infomodel.data.account];
        }
        
    }else{
        account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    }
    NSString * level = @"gk";
    NSString * page = [NSString stringWithFormat:@"%ld",_currentPage];
    NSString * size = @"40";
    NSString * start = _startTime;
    NSString * end = _endTime;
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    /** 岗位ID */
    [param setValue:framID?framID:@"" forKey:@"fram_id"];
    /** 账号 */
    [param setValue:account?account:@"" forKey:@"account"];
    /** 层级选择 */
    [param setValue:level?level:@"" forKey:@"level"];
    /** 分页页码 不传默认1 */
    [param setValue:page?page:@"1" forKey:@"page"];
    /** 分页大小 不传默认20 */
    [param setValue:size?size:@"" forKey:@"size"];
    /** 时间段开始 */
    [param setValue:start?start:@"" forKey:@"start"];
    /** 时间段结束 */
    [param setValue:end?end:@"" forKey:@"end"];
    
    [BookRequest requestCommonUrl:kBOOK_ANALYZE_HOMEALLCUSTOMER_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_customerDataSource removeAllObjects];
            }
            [_customerDataSource addObjectsFromArray:resultDic[@"list"]];
            if ([resultDic[@"list"] count]==  0) {
                [_allCustomerCollectionView.mj_footer endRefreshingWithNoMoreData];
            }
             LolCalendarModelList *listModel  = [LolCalendarModelList yy_modelWithDictionary:resultDic];
            [_detailDataView updateBDetailDataViewModel:listModel isMonth:YES];
            [_allCustomerCollectionView reloadData];
        }else{}
    }];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {}

@end
