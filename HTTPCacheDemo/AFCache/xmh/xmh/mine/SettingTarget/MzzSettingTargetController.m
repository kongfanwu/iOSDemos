//
//  MzzSettingTargetController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzSettingTargetController.h"
#import <WebKit/WebKit.h>
#import "UserManager.h"
#import "ShareWorkInstance.h"

@interface MzzSettingTargetController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property(nonatomic ,strong)WKWebView *web;
@property (nonatomic,copy)NSString *MBSZ_DAOGOU;
@property (nonatomic,copy)NSString *MBSZ_DIANJINGLIGUANLICENG;
@property (nonatomic,copy)NSString *MBSZ_JISHUDIANZHANG;
@property (nonatomic,copy)NSString *MBSZ_SHOUHOUMEIRONGSHI;
@property (nonatomic,copy)NSString *MBSZ_SHOUZHONGMEIRONGSHI;
@property (nonatomic,copy)NSString *MBSZ_SHOUQIANMEIRONGSHI;
@property (nonatomic,copy)NSString *MBSZ_SHOUQIANDIANZHANG;
@property (nonatomic,copy)NSString *MBSZ_XIAOSHOUDIANZHANG;

@property (nonatomic ,assign)NSInteger framework_function_main_role;
@property (nonatomic ,copy)NSString *uid;
@property (nonatomic ,copy)NSString *joinCode;
@property (nonatomic ,copy)NSString *functionId;
@property (nonatomic ,copy)NSString *account;
@property (nonatomic ,copy)NSString *framId;
@property (nonatomic ,copy)NSString *token;
@property (nonatomic ,copy)NSString *time;
@end

@implementation MzzSettingTargetController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNav];
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _uid = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    _time = @"meishenmeluanyong";
    _joinCode = [ShareWorkInstance shareInstance].join_code;
    _functionId = [NSString stringWithFormat:@"%ld",infomodel.data.join_code[0].function_id];
    _account = infomodel.data.account;
    _framId = [NSString stringWithFormat:@"%ld",infomodel.data.join_code[0].fram_id];
    _token = infomodel.data.token;
    _framework_function_main_role = infomodel.data.join_code[0].framework_function_main_role;
    
    //目标设置H5 导购
    _MBSZ_DAOGOU =  [SERVER_H5 stringByAppendingString:@"/target/index.html"];
    //目标设置H5 店经理管理层
    _MBSZ_DIANJINGLIGUANLICENG =  [SERVER_H5 stringByAppendingString:@"/target/target_dianjingli_yj.html"];
    //目标设置H5 技术店长
    _MBSZ_JISHUDIANZHANG =  [SERVER_H5 stringByAppendingString:@"/target/target_jsdz_xh.html"];
    //目标设置H5 售后美容师
    _MBSZ_SHOUHOUMEIRONGSHI =  [SERVER_H5 stringByAppendingString:@"/target/target_shmrs_yj.html"];
    //目标设置H5 售中美容师
    _MBSZ_SHOUZHONGMEIRONGSHI =  [SERVER_H5 stringByAppendingString:@"/target/target_szmrs_yj.html"];
    //目标设置H5 售前美容师
    _MBSZ_SHOUQIANMEIRONGSHI =  [SERVER_H5 stringByAppendingString:@"/target/target_sqmrs_yj.html"];
    //目标设置H5 售前店长
    _MBSZ_SHOUQIANDIANZHANG =  [SERVER_H5 stringByAppendingString:@"/target/target_sqdz_yeji.html"];
    //目标设置H5 销售店长
    _MBSZ_XIAOSHOUDIANZHANG =  [SERVER_H5 stringByAppendingString:@"/target/target_xsdz_yeji.html"];
    [self creatWebView];
}
- (void)creatWebView{
  
    _web = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_StatusBar, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _web.backgroundColor = [UIColor whiteColor];
    _web.UIDelegate = self;
    _web.navigationDelegate = self;
     [[_web configuration].userContentController addScriptMessageHandler:self name:@"pop"];
    [self.view addSubview:_web];
    
    switch (_framework_function_main_role) {
        case 1:
              [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_MBSZ_DIANJINGLIGUANLICENG]]];
            break;
        case 4:
            [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_MBSZ_JISHUDIANZHANG]]];
            break;
        case 5:
            [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_MBSZ_XIAOSHOUDIANZHANG]]];
            break;
        case 6:
            [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_MBSZ_SHOUQIANDIANZHANG]]];
            break;
        case 8:
            [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_MBSZ_SHOUHOUMEIRONGSHI]]];
            break;
        case 9:
            [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_MBSZ_SHOUQIANMEIRONGSHI]]];
            break;
        case 10:
            [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_MBSZ_SHOUZHONGMEIRONGSHI]]];
            break;
        case 11:
            [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_MBSZ_DAOGOU]]];
            break;
        default:
            break;
    }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatNav
{
    customNav * nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withTitleStr:@"目标设置" withleftTitleStr:nil withleftImageStr:@"back" withRightBtnImag:nil withRightBtnTitle:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *js = [NSString stringWithFormat:@"smartAllocation('%@','%@','%@','%@','%@','%@','%@')",_token,_joinCode,_functionId,_framId,_uid,_time,_account];
    [XMHWebSignTools loadWebViewJs:webView];
    [_web evaluateJavaScript:js completionHandler:nil];
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
//wk被terminate时调用
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
