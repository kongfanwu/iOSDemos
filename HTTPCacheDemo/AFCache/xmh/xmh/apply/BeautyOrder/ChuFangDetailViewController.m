//
//  ChuFangDetailViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/12.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ChuFangDetailViewController.h"
#import <WebKit/WebKit.h>
#import "ChufangDetailTopView.h"
#import "ChuFangReporterViewController.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "BeautyOrderViewController.h"
#import "ChoiseCustomerViewController.h"
#import "BeautyRequest.h"
#import "ShareWorkInstance.h"
#import "ReportBJController.h"
#import "TheOneCustomerViewController.h"
#import "FWDDetailViewController.h"
#import "BookRequest.h"
@interface ChuFangDetailViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>{
    WKWebView *_webView;
    ChufangDetailTopView *_topView;
    NSString *name;
    NSString *img;
    NSString *num1;
    NSString *num;
    
    customNav *nav;
    
    NSDictionary * _resultDic;
    
}

@end

@implementation ChuFangDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNav];
    [self initSubviews];
    Join_Code * joinCode = [ShareWorkInstance shareInstance].share_join_code;
    NSString *roleStr = [NSString stringWithFormat:@"%ld",joinCode.framework_function_main_role];
    NSArray * canRoleStrs = @[@"4",@"5",@"6",@"8",@"9",@"10"];
    BOOL isShow = NO;
    if ([canRoleStrs containsObject:roleStr]) {
        isShow = YES;
    }
    _topView.btn1.hidden = _topView.btn2.hidden = !isShow;
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_billNum forKey:@"ordernum"];
    [BookRequest requestCommonUrl:kBREAUTY_CHUFANG_DETAIL_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [_topView freshChufangDetailTopView:resultDic[@"user_name"] img:resultDic[@"img"] num:resultDic[@"num"] num1:resultDic[@"num1"] zt:resultDic[@"zt"]];
    }];
}
- (void)creatNav{
     nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"处方详情" withleftImageStr:@"stgkgl_fanhui" withRightStr:@"处方报告"];
    [nav.btnRight addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.btnRight.hidden = YES;
    [self.view addSubview:nav];
}
- (void)initSubviews{
    _topView = [[[NSBundle mainBundle]loadNibNamed:@"ChufangDetailTopView" owner:nil options:nil] firstObject];
    _topView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 107);
    [self.view addSubview:_topView];
    [_topView.btn1 addTarget:self action:@selector(btn1Event) forControlEvents:UIControlEventTouchUpInside];
    
    if (_num1byPass == 0) {
        [_topView.btn2 addTarget:self action:@selector(btn2Event) forControlEvents:UIControlEventTouchUpInside];
        [nav.btnLet addTarget:self action:@selector(pop_toRoot) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        switch ([_zt integerValue]) {
            case 1://进行中
            {
                [_topView.btn2 addTarget:self action:@selector(ChuFangOverEvent) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 2://已终止
            {
            }
                break;
            case 3://已完成
            {
            }
                break;
            default:{
                [_topView.btn2 addTarget:self action:@selector(btn2Event) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
        }
    }
    
    [_topView freshChufangDetailTopView2:_zt num1:_num1byPass];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _topView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _topView.bottom)];
    [self.view addSubview:_webView];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    
    if (_isToChuFangZhiXingBiao) {
        NSString *urlStr = [NSString stringWithFormat:@"%@beauty/result.html",SERVER_H5];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    } else {
        NSString *urlStr = [NSString stringWithFormat:@"%@beauty/particulars.html",SERVER_H5];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    }
}
- (void)pop_toRoot{
    if (_isComeFromMsg) {
        [self.navigationController popViewControllerAnimated:NO];
        return;
    }
        BOOL isFind = NO;
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if (!isFind) {
            if ([temp isKindOfClass:[BeautyOrderViewController class]]) {
                [self.navigationController popToViewController:temp animated:NO];
                isFind = YES;
                break;
            }
        }
    }
}
- (void)freeshView{
    if (_isToChuFangZhiXingBiao) {
        _topView.hidden = YES;
        _webView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav);
    }else{
        _topView.hidden = NO;
    }
}
- (void)ChuFangOverEvent{
    WeakSelf;
    [[[MzzHud alloc]initWithTitle:@"温馨提醒" message:@"您确定您要将此处方作废吗？\n此操作将不可恢复，请谨慎操作！" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
        if (index == 1) {
            [weakSelf chufangOverRequest];
        }
    }]show];
}
- (void)chufangOverRequest{
    [[BeautyRequest alloc] requestChuFangJieShuordernum:_billNum store_code:[ShareWorkInstance shareInstance].store_code resultBlock:^(id obj, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self toReportExit];
        }
    }];
}
- (void)toReportExit{
    ReportBJController *VC = [[ReportBJController alloc]init];
    VC.ordernum = _billNum;
    LolUserInfoModel *usermodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    VC.token = usermodel.data.token;
    VC.ReportBJControllerPopBlock = ^{
        [self backHome];
    };
    [self.navigationController pushViewController:VC animated:NO];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"ChufangDetailChuFangZhiXingBiaocallback"];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"chufangcallback"];
     [[_webView configuration].userContentController addScriptMessageHandler:self name:@"iosjumpFwd"];
    [self freeshView];
}

- (void)freshNavRightBtn{
    if (([_zt isEqualToString:@"2"]||[_zt isEqualToString:@"3"])) {
        nav.btnRight.hidden = NO;
    } else {
        nav.btnRight.hidden = YES;
        _webView.frame = CGRectMake(0, _topView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _topView.bottom);
    }
}

- (void)btn1Event{
    [self backHome];
}
- (void)btn2Event{
    WeakSelf;
    [[[MzzHud alloc]initWithTitle:@"温馨提醒" message:@"您确定您要将此处方作废吗？\n此操作将不可恢复，请谨慎操作！" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
        if (index == 1) {
            [weakSelf delChuangRequest];
        }
    }]show];
}
- (void)delChuangRequest{
    [[BeautyRequest alloc] requestChuFangDelordernum:_billNum store_code:[ShareWorkInstance shareInstance].store_code resultBlock:^(id obj, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            if (_isComeFromMsg) {
                [self.navigationController popViewControllerAnimated:NO];
            }
            [self backHome];
        }
    }];
}
- (void)backHome{
    if (_isComeFromMsg) {
        TheOneCustomerViewController * one = [[TheOneCustomerViewController alloc] init];
        one.uid = _userId;
        one.join_code = [ShareWorkInstance shareInstance].join_code;;
        [self.navigationController pushViewController:one animated:NO];
        //                isFind = YES;
        if (_ChuFangDetailViewControllerBlock) {
            _ChuFangDetailViewControllerBlock();
        }
        return;
    }
    for (UIViewController *temp in self.navigationController.viewControllers) {
//        if (!isFind) {
            if ([temp isKindOfClass:[TheOneCustomerViewController class]]) {
                [self.navigationController popToViewController:temp animated:NO];
//                isFind = YES;
                if (_ChuFangDetailViewControllerBlock) {
                    _ChuFangDetailViewControllerBlock();
                }
                break;
            }
        }
//    }
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString * callbackstr = message.body;
    if ([callbackstr hasPrefix:@"{"]) {
        _zhixingbiaoStr = callbackstr;
        ChuFangDetailViewController *vc = [[ChuFangDetailViewController alloc]init];
        vc.billNum = _billNum;
        vc.token = _token;
        vc.isToChuFangZhiXingBiao = YES;
        vc.zhixingbiaoStr = _zhixingbiaoStr;
        [self.navigationController pushViewController:vc animated:NO];
    } else {
        NSArray *retuenarr = [callbackstr componentsSeparatedByString:@","];
        if (retuenarr.count>0) {
            _zt = retuenarr[0];
        }
        if (retuenarr.count>1) {
            name = retuenarr[1];
        }
        if (retuenarr.count>2) {
            img = retuenarr[2];
        }
        if (retuenarr.count>3) {
            num = retuenarr[3];
        }
        if (retuenarr.count>4) {
            num1 = retuenarr[4];
        }
        [_topView freshChufangDetailTopView:name img:img num:num num1:num1 zt:_zt];
        [self freshNavRightBtn];
    }
    if ([message.name isEqualToString:@"iosjumpFwd"]) {
        FWDDetailViewController * next = [[FWDDetailViewController alloc] init];
        next.ordernum = message.body;
        next.comeFrom = @"MLDZ";
        [self.navigationController pushViewController:next animated:NO];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
        [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"ChufangDetailChuFangZhiXingBiaocallback"];
        [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"chufangcallback"];
        [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"iosjumpFwd"];
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD showGifImage];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //传token,项目编号
    
    if (_isToChuFangZhiXingBiao) {
        NSString *js = [NSString stringWithFormat:@"ChufangDetailChuFangZhiXingBiaocallJs('%@')",_zhixingbiaoStr];
        [XMHWebSignTools loadWebViewJs:webView];
        [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            [XMHProgressHUD dismiss];
        }];
    } else {
        NSString *js = [NSString stringWithFormat:@"ChufangDetailCallJs('%@','%@')",_token,_billNum];
        [XMHWebSignTools loadWebViewJs:webView];
        [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            [XMHProgressHUD dismiss];
        }];
    }
    
}
- (void)nextEvent{
    ChuFangReporterViewController *VC = [[ChuFangReporterViewController alloc]init];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    VC.billNum = _billNum;
    VC.token = token;
    VC.name = name;
    VC.img = img;
    VC.num = num;
    VC.num1 = num1;
    [self.navigationController pushViewController:VC animated:NO];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
