//
//  BeautyDesignFourthViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/8.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyDesignFourthViewController.h"
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

@interface BeautyDesignFourthViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIScrollViewDelegate>{
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
    NSString        *_timeStr;
    
    ChufangGuihuaXiangMuView *_chufangguihuaxiangmuView;
    
    NSInteger   _zhouqi;
    
    BeautyRequest *_createChufangRequest;
    
    UIButton*_changeBtnsender;
}

@end

@implementation BeautyDesignFourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        [dic setValue:[NSString stringWithFormat:@"¥%.1f",tempModel.price] forKey:@"price"];
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
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"美丽定制" withleftImageStr:@"stgkgl_fanhui" withRightStr:@"生成处方"];
    nav.backgroundColor = kColorTheme;
    nav.lbTitle.textColor  =  [UIColor whiteColor];
    [nav.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nav.btnRight addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)initSubviews{
    _tbHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"choiseCustomerHeader" owner:nil options:nil] firstObject];
    _tbHeaderView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 90);
    [_tbHeaderView reFreshchoiseCustomerHeader:4];
    [self.view addSubview:_tbHeaderView];
    
    _scrollBg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Heigh_Nav+90, SCREEN_WIDTH, SCREEN_HEIGHT - (Heigh_Nav+90))];
    _scrollBg.backgroundColor = kBackgroundColor;
    _scrollBg.delegate = self;
    [self.view addSubview:_scrollBg];
    
    _chufangguihuaxiangmuView = [[[NSBundle mainBundle]loadNibNamed:@"ChufangGuihuaXiangMuView" owner:nil options:nil] firstObject];
    _chufangguihuaxiangmuView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [_chufangguihuaxiangmuView getChufangGuihuaXiangMuViewHeight]);
    [_scrollBg addSubview:_chufangguihuaxiangmuView];
    [_chufangguihuaxiangmuView freshTiem:_maxshichangstring];
    
    _webView= [[WKWebView alloc] initWithFrame:CGRectMake(0,_chufangguihuaxiangmuView.bottom, SCREEN_WIDTH,0)];
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
    
    _scrollBg.contentSize = CGSizeMake(SCREEN_WIDTH,[_chufangguihuaxiangmuView getChufangGuihuaXiangMuViewHeight]+_downView.height);
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
    _beautyChoiceJishi.JiangeBlock = ^(NSString *jianGe) {
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
        [_tempDown reFreshBeautyFourDownViewWeek:week];
        [_tempDown reFreshCricle:sender];
        [tempparmsDic setValue:@"week" forKey:@"type"];
        //选择的星期
        NSInteger choiseWeekValue = [BeautyDesignMethod returnWeekValue:week];
        //现在的星期
        NSString *currentWeekday = [TimeTools getCurrentWeekday];
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
            pointValue = chazhi + 7 * i;
            finalvalue = pointValue;
            [arrPointTemp addObject:[NSString stringWithFormat:@"%@",@(pointValue)]];
        }
        tempzhouqi = finalvalue - chazhi;
        _zhouqi = tempzhouqi;
        [tempdownView reFreshBeautyFourDownViewXiangmu:tempxiangmuNum daodianNum:tempmaxNum zhouqi:tempzhouqi jinge:tempxiangmuJinE];
        [_tempWebView reload];
    };
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
    
    [_createChufangRequest requestCreateChufangBill:jsonstr resultBlock:^(id obj, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            NSString * billNum = (NSString *)obj;
            ChuFangDetailViewController *vc = [[ChuFangDetailViewController alloc]init];
            LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
            NSString    *token = model.data.token;
            vc.billNum = billNum;
            vc.token = token;
            [self.navigationController pushViewController:vc animated:NO];
        }
    }];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    _timeStr = message.body;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    mutdadianStr = _arrayPoint.jsonData;
    if (_arrayPoint.count>0) {
        NSString *jspoint = [NSString stringWithFormat:@"beautyChoiseTimeCallJs('%@')",mutdadianStr];
        [XMHWebSignTools loadWebViewJs:webView];
        [_webView evaluateJavaScript:jspoint completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            [XMHProgressHUD dismiss];
        }];
    }
    
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id data, NSError * _Nullable error) {
        CGFloat height = [data floatValue];
        CGRect webFrame = webView.frame;
        webFrame.size.height = height;
        webView.frame = CGRectMake(0,_chufangguihuaxiangmuView.bottom, SCREEN_WIDTH,height);
        _downView.frame = CGRectMake(0,webView.bottom, SCREEN_WIDTH, 267);
        _scrollBg.contentSize = CGSizeMake(SCREEN_WIDTH,_downView.bottom);
    }];
    
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
