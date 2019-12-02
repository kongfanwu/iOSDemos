//
//  BeautyGWCCommitVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyGWCCommitVC.h"
#import "choiseCustomerHeader.h"
#import "choiseCustomerHeader.h"
#import <WebKit/WebKit.h>
#import "ChuFangDetailViewController.h"
#import "BeautyFourDownView.h"
#import "BeautyChoiceJishi.h"
#import "ShareWorkInstance.h"
#import "BeautyProjectModel.h"
#import "BeautyDesignMethod.h"
#import "TimeTools.h"
#import "UserManager.h"
#import "BeautyChoiseJishiModel.h"
#import "ChufangGuihuaXiangMuView.h"
#import "BeautyRequest.h"
#import "BeautyCFDetailVC.h"
#import "CommonSubmitView.h"
#import "DateTools.h"
#import "BeautyGWCCommitTopView.h"
#import "PGDatePickManager.h"
#import "BeautyProgressView.h"
typedef NS_ENUM(NSUInteger, TimeType) {
    TimeTypeInterval = 0,
    TimeTypeWeek
};
@interface BeautyGWCCommitVC ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIScrollViewDelegate,PGDatePickerDelegate>{
    choiseCustomerHeader *_tbHeaderView;
    UIScrollView         *_scrollBg;
    WKWebView            *_webView;
    BeautyFourDownView   *_downView;
    BeautyChoiceJishi    *_beautyChoiceJishi;
    NSMutableArray       *_arrayXiangMu;//项目的数组
    NSMutableArray       *_arrayPoint;//打点的数组
    NSInteger             maxNum;//最大次数
    
    BeautyProjectModel *tempModel;
    NSDictionary *dic;
    NSString *_xingmuJsonstring;
    
    NSInteger             maxshichang;//最大时长
    NSString *_maxshichangstring;//最大时长
    NSString *_pointstring;//打点;
    
    NSInteger _xiangmuNum;//项目个数
    CGFloat _xiangmuJinE;//项目总金额
    
    NSMutableString *mutxiangmuStr;
    
    NSMutableString *mutdadianStr;
    NSMutableDictionary *_plan;
    NSMutableDictionary *_parmsDic;
//    NSString        *_timeStr;
    
    ChufangGuihuaXiangMuView *_chufangguihuaxiangmuView;
    
    NSInteger   _zhouqi;
    
    BeautyRequest *_createChufangRequest;
    
    UIButton*_changeBtnsender;
    
    BOOL _isFirst;
}
@property (nonatomic,strong)CommonSubmitView *commonSubmitView;
@property (nonatomic, copy)NSString * selectWeek;
@property (nonatomic, copy)NSString * timeStr;
/** h5 返回来的起始日期 */
@property (nonatomic, copy)NSString * startTime;
/** h5 返回来选择的日期 */
@property (nonatomic, copy)NSString * selectTime;
/** 间隔天数 */
@property (nonatomic, assign)NSInteger intervalDay;
/** 星期几 */
@property (nonatomic, assign)NSInteger intervalWeek;
/** 组织好的数字字符串 */
@property (nonatomic, copy)NSString * timeNumStr;
@property (nonatomic, strong)BeautyGWCCommitTopView * startTimeView;
@property (nonatomic, strong) UIDatePicker *datePicker;
/** 记录开始时间 */
@property (nonatomic, strong)NSString * selectStartTime;
@property (nonatomic, strong)BeautyProgressView * beautyProgressView;
@end

@implementation BeautyGWCCommitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _isFirst = YES;
    self.view.backgroundColor = kBackgroundColor;
    _arrayPoint = [[NSMutableArray alloc]init];
    NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
    _plan = [ShareWorkInstance shareInstance].plan;
    _parmsDic = [[NSMutableDictionary alloc]init];
    [_parmsDic setValue:_plan forKey:@"plan"];
    [_parmsDic setValue:[ShareWorkInstance shareInstance].join_code forKey:@"join_code"];
    [_parmsDic setValue:[ShareWorkInstance shareInstance].store_code forKey:@"store_code"];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    NSString    *dengluAccount = model.data.account;
    [_parmsDic setValue:token forKey:@"token"];
    [_parmsDic setValue:[NSString stringWithFormat:@"%@",@([ShareWorkInstance shareInstance].uid)] forKey:@"user_id"];//[ShareWorkInstance shareInstance].uid
    [_parmsDic setValue:[ShareWorkInstance shareInstance].symptom forKey:@"symptom"];
    [_parmsDic setValue:[ShareWorkInstance shareInstance].target forKey:@"target"];
    [_parmsDic setValue:dengluAccount forKey:@"inper"];
    
    
    _xiangmuNum = arr.count;
    
    _arrayXiangMu = [[NSMutableArray alloc]init];
    
    for (BeautyProjectModel *tempModel in arr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:tempModel.name forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(tempModel.num)] forKey:@"num"];
        [dic setValue:[NSString stringWithFormat:@"¥%.2f",tempModel.price] forKey:@"price"];
        [dic setValue:[NSString stringWithFormat:@"%@ 分钟",@(tempModel.shichang)] forKey:@"shichang"];
        
        [_arrayXiangMu addObject:dic];
        
        _xiangmuJinE+= tempModel.num * tempModel.price;
        
        if (tempModel.num > maxNum) {
            maxNum = tempModel.num;
        }
        
        if (tempModel.shichang > maxshichang) {
            maxshichang = tempModel.shichang;
            _maxshichangstring = [NSString stringWithFormat:@"%@",@(maxshichang)];
        }
    }
    _zhouqi = 1;
    //处理项目
    mutxiangmuStr = _arrayXiangMu.jsonData;
    //处理打点
    _arrayPoint = [[NSMutableArray alloc]init];
    
    _createChufangRequest = [[BeautyRequest alloc]init];
    
    [_parmsDic setValue:@"day" forKey:@"type"];
    
    [self creatNav];
    [self initSubviews];
}
- (CommonSubmitView *)commonSubmitView
{
    WeakSelf
    if (!_commonSubmitView) {
        _commonSubmitView = loadNibName(@"CommonSubmitView");
        [_commonSubmitView updateCommonSubmitViewTitle:@"生成处方"];
        _commonSubmitView.CommonSubmitViewBlock = ^{
            [weakSelf nextEvent];
        };
    }
    return _commonSubmitView;
}
- (BeautyGWCCommitTopView *)startTimeView
{
    WeakSelf
    if (!_startTimeView) {
        _startTimeView = loadNibName(@"BeautyGWCCommitTopView");
        _startTimeView.frame = CGRectMake(0, _chufangguihuaxiangmuView.bottom, SCREEN_WIDTH, 90);
        _startTimeView.BeautyGWCCommitTopViewBlock = ^{
            PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
            datePickManager.isShadeBackground = YES;
            datePickManager.headerViewBackgroundColor = [UIColor whiteColor];
            datePickManager.cancelButtonTextColor = kColorTheme;
            datePickManager.confirmButtonTextColor = kColorTheme;
            PGDatePicker *datePicker = datePickManager.datePicker;
            datePicker.datePickerMode =  PGDatePickerModeDate;
            datePicker.delegate = weakSelf;
            datePicker.textColorOfSelectedRow = [UIColor lightGrayColor];
            datePicker.lineBackgroundColor = kColorTheme;
            datePicker.rowHeight = 44;
            [weakSelf presentViewController:datePickManager animated:false completion:nil];
        };
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"YYYY/MM/dd"];
        NSString * showDate = [formatter1 stringFromDate:[NSDate date]];
        [_startTimeView updateBeautyGWCCommitTopViewTitle:showDate];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        _startTime = [formatter1 stringFromDate:[NSDate date]];
        _selectStartTime = _startTime;
        
    }
    return _startTimeView;
}
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents
{
    
    NSString * title = [NSString stringWithFormat:@"%ld/%ld/%ld",(long)dateComponents.year,(long)dateComponents.month,(long)dateComponents.day];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSDate * date = [formatter dateFromString:title];
    
    NSDate * currentDate = [NSDate date];
    NSString * currentDateStr = [formatter stringFromDate:currentDate];
    NSDate * endDate = [formatter dateFromString:currentDateStr];
    
    NSComparisonResult result = [date compare: endDate];
    if (result == NSOrderedAscending) {
        [XMHProgressHUD showOnlyText:@"处方开始时间不能小于当前时间"];
        return;
    }
    [_startTimeView updateTitle:title];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"YYYY-MM-dd"];
    _startTime = [formatter1 stringFromDate:date];
    [self refreshallSelectData];
    _selectStartTime = _startTime;
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"美丽定制" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.backgroundColor = kColorTheme;
    nav.lbTitle.textColor  =  [UIColor whiteColor];
    [nav.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nav.btnRight addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (BeautyProgressView *)beautyProgressView
{
    if (!_beautyProgressView) {
        _beautyProgressView = loadNibName(@"BeautyProgressView");
        _beautyProgressView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 100);
    }
    return _beautyProgressView;
}
- (void)initSubviews{
    _tbHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"choiseCustomerHeader" owner:nil options:nil] firstObject];
    _tbHeaderView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 90);
    [_tbHeaderView reFreshchoiseCustomerHeader:4];
//    [self.view addSubview:_tbHeaderView];
    
    [self.view addSubview:self.beautyProgressView];
    [_beautyProgressView updateBeautyProgressViewIndex:3];
    _scrollBg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Heigh_Nav+100, SCREEN_WIDTH, SCREEN_HEIGHT - (Heigh_Nav+100))];
    _scrollBg.backgroundColor = kBackgroundColor;
    _scrollBg.delegate = self;
    [self.view addSubview:_scrollBg];
    
    _chufangguihuaxiangmuView = [[[NSBundle mainBundle]loadNibNamed:@"ChufangGuihuaXiangMuView" owner:nil options:nil] firstObject];
    _chufangguihuaxiangmuView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [_chufangguihuaxiangmuView getChufangGuihuaXiangMuViewHeight]);
    [_scrollBg addSubview:_chufangguihuaxiangmuView];
    [_chufangguihuaxiangmuView freshTiem:_maxshichangstring];
    
    [_scrollBg addSubview:self.startTimeView];
    
    _webView= [[WKWebView alloc] initWithFrame:CGRectMake(0,_startTimeView.bottom, SCREEN_WIDTH,0)];
    [_scrollBg addSubview:_webView];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    NSString *urlStr = [NSString stringWithFormat:@"%@beauty/ios_dataTime.html",SERVER_H5];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"pitch_time"];
    
    _downView = [[[NSBundle mainBundle]loadNibNamed:@"BeautyFourDownView" owner:nil options:nil] firstObject];
    _downView.frame = CGRectMake(0,_webView.bottom, SCREEN_WIDTH, 267);
    [_downView reFreshBeautyFourDownViewXiangmu:_xiangmuNum daodianNum:maxNum zhouqi:_zhouqi jinge:_xiangmuJinE];
    [_downView.btn1 addTarget:self action:@selector(btn1Event:) forControlEvents:UIControlEventTouchUpInside];
    [_downView.btn2 addTarget:self action:@selector(btn2Event:) forControlEvents:UIControlEventTouchUpInside];
    [_downView.btn3 addTarget:self action:@selector(btn3Event:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollBg addSubview:_downView];
    
    self.commonSubmitView.frame = CGRectMake(0, _downView.bottom, SCREEN_WIDTH, 70);
    [_scrollBg addSubview:self.commonSubmitView];
    
    _scrollBg.contentSize = CGSizeMake(SCREEN_WIDTH,[_chufangguihuaxiangmuView getChufangGuihuaXiangMuViewHeight]+_downView.height + _commonSubmitView.height );
}
//按间隔
- (void)btn1Event:(UIButton*)sender{
    [self creatTopChoiceView];
    [_beautyChoiceJishi refreshBeautyChoiceJishiJiange];
    __block  BeautyFourDownView *_tempDown = _downView;
    
    __block  NSMutableArray *arrPointTemp = _arrayPoint;
    __block  WKWebView *_tempWebView = _webView;
    __block  NSMutableDictionary *tempparmsDic = _parmsDic;
    
    __block  BeautyFourDownView   *tempdownView = _downView;
    __block  NSInteger tempxiangmuNum = _xiangmuNum;//项目个数
    __block  CGFloat tempxiangmuJinE = _xiangmuJinE;//项目总金额
    __block  NSInteger tempmaxNum = maxNum;//最大次数
    __block  NSInteger tempzhouqi = _zhouqi;
    
    WeakSelf
    _beautyChoiceJishi.JiangeBlock = ^(NSString *jianGe) {
        weakSelf.intervalDay = jianGe.integerValue;
        weakSelf.timeNumStr = [weakSelf calculateDateFromStartTime:weakSelf.startTime type:TimeTypeInterval];
        [_tempDown reFreshBeautyFourDownViewJianGe:jianGe];
        [_tempDown reFreshCricle:sender];
        [arrPointTemp removeAllObjects];
        
        NSInteger value = [BeautyDesignMethod returnJiangeValue:jianGe];
        [tempparmsDic setValue:@"day" forKey:@"type"];
        NSInteger pointValue = 0;
        for (NSInteger i = 0; i< maxNum; i++) {
            pointValue = value * i;
            tempzhouqi = pointValue;
            [arrPointTemp addObject:[NSString stringWithFormat:@"%@",@(pointValue)]];
        }
        _zhouqi = tempzhouqi;
        [tempdownView reFreshBeautyFourDownViewXiangmu:tempxiangmuNum daodianNum:tempmaxNum zhouqi:tempzhouqi jinge:tempxiangmuJinE];
        [_tempWebView reload];
    };
}
//按星期
- (void)btn2Event:(UIButton*)sender{
    WeakSelf
    [self creatTopChoiceView];
    [_beautyChoiceJishi refreshBeautyChoiceJishiWeek];
    __block  BeautyFourDownView *_tempDown = _downView;
    __block  NSMutableArray *arrPointTemp = _arrayPoint;
    __block  WKWebView *_tempWebView = _webView;
    __block  NSMutableDictionary *tempparmsDic = _parmsDic;
    
    __block  BeautyFourDownView   *tempdownView = _downView;
    __block  NSInteger tempxiangmuNum = _xiangmuNum;//项目个数
    __block  CGFloat tempxiangmuJinE = _xiangmuJinE;//项目总金额
    __block  NSInteger tempmaxNum = maxNum;//最大次数
    __block  NSInteger tempzhouqi = _zhouqi;
    
    _beautyChoiceJishi.WeekBlock = ^(NSString *week) {
        weakSelf.selectWeek = week;
        
        weakSelf.timeNumStr = [weakSelf calculateDateFromStartTime:weakSelf.startTime type:TimeTypeWeek];
        [_tempDown reFreshBeautyFourDownViewWeek:week];
        [_tempDown reFreshCricle:sender];
        [tempparmsDic setValue:@"week" forKey:@"type"];
//        //选择的星期
        NSInteger choiseWeekValue = [BeautyDesignMethod returnWeekValue:week];
        //现在的星期
        NSString *currentWeekday = [TimeTools getWeekDayFromDate:weakSelf.timeStr];
        NSInteger currentWeekValue = [BeautyDesignMethod returnEnglishWeekValue:currentWeekday];

        NSInteger chazhi;
        if (currentWeekValue <= choiseWeekValue) {
            chazhi = choiseWeekValue - currentWeekValue;
        } else {
            chazhi = 7 - currentWeekValue + choiseWeekValue;
        }

        [arrPointTemp removeAllObjects];
        NSInteger pointValue = 0;
        NSInteger finalvalue = 0;

        for (NSInteger i = 0; i< maxNum; i++) {
            pointValue = chazhi + 7 * i +  4 ;
            finalvalue = pointValue;
            [arrPointTemp addObject:[NSString stringWithFormat:@"%@",@(pointValue)]];
        }
        tempzhouqi = finalvalue - chazhi;
        _zhouqi = tempzhouqi;
        [tempdownView reFreshBeautyFourDownViewXiangmu:tempxiangmuNum daodianNum:tempmaxNum zhouqi:tempzhouqi jinge:tempxiangmuJinE];
        [_tempWebView reload];
        
//        [weakSelf changeStartDate:_timeStr week:week];
        
    };
}
- (void)changeStartDate:(NSString *)startDate week:(NSString *)week
{
    NSInteger tempzhouqi = _zhouqi;
    [_downView reFreshBeautyFourDownViewWeek:week];
//    [_downView reFreshCricle:sender];
    [_parmsDic setValue:@"week" forKey:@"type"];
    //选择的星期
    NSInteger choiseWeekValue = [BeautyDesignMethod returnWeekValue:week];
    //现在的星期
    NSString *currentWeekday = [TimeTools getWeekDayFromDate:_timeStr];
    NSInteger currentWeekValue = [BeautyDesignMethod returnEnglishWeekValue:currentWeekday];
    
    NSInteger chazhi;
    if (currentWeekValue <= choiseWeekValue) {
        chazhi = choiseWeekValue - currentWeekValue;
    } else {
        chazhi = 7 - currentWeekValue + choiseWeekValue;
    }
    
    [_arrayPoint removeAllObjects];
    NSInteger pointValue = 0;
    NSInteger finalvalue = 0;
    
    for (NSInteger i = 0; i< maxNum; i++) {
        pointValue = chazhi + 7 * i  + 2;
        finalvalue = pointValue;
        [_arrayPoint addObject:[NSString stringWithFormat:@"%@",@(pointValue)]];
    }
    tempzhouqi = finalvalue - chazhi;
    _zhouqi = tempzhouqi;
    [_downView reFreshBeautyFourDownViewXiangmu:_xiangmuNum daodianNum:maxNum zhouqi:_zhouqi jinge:_xiangmuJinE];
    [_webView reload];
}
- (void)btn3Event:(UIButton*)sender{
    [self creatTopChoiceView];
    [_beautyChoiceJishi refreshBeautyChoiceJishi];
    __block  BeautyFourDownView *_tempDown = _downView;
    __block  NSMutableDictionary *tempparmsDic = _parmsDic;
    _beautyChoiceJishi.JishiBlock = ^(BeautyChoiseJishiList*jishimodel) {
        [tempparmsDic setValue:[NSString stringWithFormat:@"%@",jishimodel.account] forKey:@"jis"];
        [_tempDown reFreshBeautyFourDownViewJishi:jishimodel.name];
    };
}
- (void)creatTopChoiceView{
    if (!_beautyChoiceJishi) {
        _beautyChoiceJishi = [[[NSBundle mainBundle]loadNibNamed:@"BeautyChoiceJishi" owner:nil options:nil] firstObject];
        _beautyChoiceJishi.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:_beautyChoiceJishi];
    }else{
        _beautyChoiceJishi.hidden = !_beautyChoiceJishi.hidden;
    }
}
- (void)nextEvent{
    //组装json数据
    
    NSString *jsCheck = _parmsDic[@"jis"];
    if (!jsCheck) {
        [MzzHud toastWithTitle:@"" message:@"请选择技师"];
        return;
    }
    if (!_downView.text1.text || [_downView.text1.text isEqualToString:@""]) {
        [MzzHud toastWithTitle:@"" message:@"请选填写处方名称"];
        return;
    }
    NSArray *timeRetuenarr = [_timeStr componentsSeparatedByString:@","];
    NSMutableArray *timeafterarr = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i<timeRetuenarr.count; i++) {
        NSString *tempstr = timeRetuenarr[i];
        NSString *afterstr = [tempstr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate *beginDate=[formatter dateFromString:afterstr];
        long  beginTime=[beginDate timeIntervalSince1970]*1000;
        [timeafterarr addObject:[NSString stringWithFormat:@"%@",@(beginTime)]];
    }
    [_parmsDic setValue:timeafterarr forKey:@"time"];
    [_parmsDic setValue:_downView.text1.text forKey:@"name"];
    [_parmsDic setValue:[NSString stringWithFormat:@"%@",@(_zhouqi)] forKey:@"day"];
    
    NSString *jsonstr = _parmsDic.jsonData;
    
    if (_zhouqi < maxNum) {
        [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"亲，你选择的到店次数和规划次数不一致，请确认后重新点选" centerButtonTitle:@"我知道了" click:^(NSInteger index) {
            
        }]show];
        return;
    }
    WeakSelf
    _commonSubmitView.btnSubmit.enabled = NO;
    [_createChufangRequest requestCreateChufangBill:jsonstr resultBlock:^(id obj, BOOL isSuccess, NSDictionary *errorDic) {
         _commonSubmitView.btnSubmit.enabled = YES;
        if (isSuccess) {
            NSString * billNum = (NSString *)obj;
            NSString * storeCode = [ShareWorkInstance shareInstance].store_code;
            NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
            [param setValue:billNum forKey:@"ordernum"];
            [param setValue:storeCode forKey:@"store_code"];
            BeautyCFDetailVC * next = [[BeautyCFDetailVC alloc] init];
            next.makeCFBlock = ^{
                [weakSelf.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
            };
            next.from = 2;
            next.param = param;
            [self.navigationController pushViewController:next animated:NO];
        }
    }];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    _timeStr = message.body;
    NSString * callBackStr = [NSString stringWithFormat:@"%@",message.body];
    NSArray * timeArr = nil;
    if ([callBackStr containsString:@","]){
        timeArr =  [_timeStr componentsSeparatedByString:@","];
        _zhouqi = timeArr.count;
    }else{
        _zhouqi = 1;
    }
    /** 当日列选择的天数等于服务的次数时才计算天数 */
    if (timeArr.count == maxNum) {
        NSInteger days =  [DateTools differDaysFromStartDate:timeArr[0] toEndDate:timeArr.lastObject];
        [_downView reFreshBeautyFourDownViewXiangmu:_xiangmuNum daodianNum:maxNum zhouqi:days + 1 jinge:_xiangmuJinE];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"pitch_time"];
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD showGifImage];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    //传项目、最大时长、最大数
    
    NSString *js = [NSString stringWithFormat:@"beautyChufangCallJs('%@')",[NSString stringWithFormat:@"%@",@(maxNum)]];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        [XMHProgressHUD dismiss];
    }];
    //打点数组
//    mutdadianStr = _arrayPoint.jsonData;
    if (!_timeNumStr) {
       mutdadianStr = [[NSMutableString alloc] initWithString:@"0"];
    }else{
       mutdadianStr = [[NSMutableString alloc] initWithString:_timeNumStr];
    }
    
//    if (_arrayPoint.count>0) {
        NSString *jspoint = [NSString stringWithFormat:@"beautyChoiseTimeCallJs('%@','%@')",mutdadianStr,_startTime];
        [_webView evaluateJavaScript:jspoint completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            [XMHProgressHUD dismiss];
        }];
//    }
    
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id data, NSError * _Nullable error) {
        CGFloat height = [data floatValue];
        CGRect webFrame = webView.frame;
        webFrame.size.height = height;
        webView.frame = CGRectMake(0,_startTimeView.bottom, SCREEN_WIDTH,height);
        _downView.frame = CGRectMake(0,webView.bottom, SCREEN_WIDTH, 267);
        _commonSubmitView.frame = CGRectMake(0, _downView.bottom, SCREEN_WIDTH, 70);
        _scrollBg.contentSize = CGSizeMake(SCREEN_WIDTH,_commonSubmitView.bottom);
    }];
    
}
/** 计算时间间隔 并拼接为字符串传给h5 */
/** 格式为 “2，3，4”   时间已选择的起始时间为准作为被减数 得出相差的间隔数字拼接 */
- (NSString *)calculateDateFromStartTime:(NSString *)startTime type:(TimeType)type
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * currentDate = [dateFormatter stringFromDate:[NSDate date]];
    NSInteger start = [DateTools differDaysFromStartDate:currentDate toEndDate:startTime];
    NSMutableArray * numArr = [[NSMutableArray alloc] init];
    /** 间隔 */
    if (type == TimeTypeInterval) {
        [numArr addObject:@(start)];
        for (int i = 0; i < maxNum - 1; i ++) {
            start = start + _intervalDay;
            [numArr addObject:@(start)];
        }
        return numArr.jsonData;
    }
    if (type == TimeTypeWeek) {
        NSString * startWeek = [TimeTools getWeekDayFromDate:startTime];
        /** 起始日期是 几 */
        NSInteger startWeekValue = [BeautyDesignMethod returnWeekValue:startWeek];
        
        NSInteger  selectWeekValue = [BeautyDesignMethod returnWeekValue:_selectWeek];
        /** 第一个准确的数字 */
        NSInteger first = 0;
        NSInteger chazhi = [DateTools differDaysFromStartDate:currentDate toEndDate:startTime];
        /** 选择的起始日期 与当前日期的时间差值 */
        if (selectWeekValue < startWeekValue) {
            first = chazhi + 7 - startWeekValue + selectWeekValue;
        }else{
            first = chazhi + selectWeekValue - startWeekValue;
        }
        [numArr addObject:@(first)];
        for (int i = 0; i < maxNum - 1; i ++) {
            first = first + 7;
            [numArr addObject:@(first)];
        }
        return numArr.jsonData;
       
    }
    return @"";
}
//:TODO
- (void)refreshallSelectData
{
    if ([_selectStartTime isEqualToString:_startTime]) {
        return;
    }
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * currentDate = [dateFormatter stringFromDate:[NSDate date]];
    NSInteger start = [DateTools differDaysFromStartDate:currentDate toEndDate:_startTime];
    NSMutableArray * numArr = [[NSMutableArray alloc] init];
    [numArr addObject:@(start)];
    _timeNumStr = numArr.jsonData;
    [_downView reFreshBeautyFourDownViewXiangmu:_xiangmuNum daodianNum:maxNum zhouqi:1 jinge:_xiangmuJinE];
    [_downView reFreshBeautyFourDownViewJianGe:@""];
    [_downView reFreshBeautyFourDownViewWeek:@""];
    [_downView reFreshCricle:nil];
    [_webView reload];
    
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
