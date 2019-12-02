//
//  LSmartAllocationStandardController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/2.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LSmartAllocationStandardController.h"
#import <WebKit/WebKit.h>
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
@interface LSmartAllocationStandardController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation LSmartAllocationStandardController
{
    WKWebView * _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"指标说明" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.lineImageView.hidden = YES;
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
     [self createWebView];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)createWebView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@fenpei/index.html",SERVER_H5]]]];
//    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"getUserCalendar"];
    [self.view addSubview:_webView];
}
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
//{
//}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD showGifImage];
    MzzLog(@"...................页面开始加载时调用");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................当内容开始返回时调用");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载完成之后调用");
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * token = infomodel.data.token;
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    NSString * jsStr = [NSString stringWithFormat:@"smartAllocation('%@','%@')",token,joinCode];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
    
    [XMHProgressHUD dismiss];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载失败时调用");
}
//wk被terminate时调用
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}

@end
