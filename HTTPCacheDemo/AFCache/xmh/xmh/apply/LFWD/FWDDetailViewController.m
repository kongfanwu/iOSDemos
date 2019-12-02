//
//  FWDDetailViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FWDDetailViewController.h"
#import <WebKit/WebKit.h>
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "BookBillHomeVC.h"
@interface FWDDetailViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end

@implementation FWDDetailViewController
{
     WKWebView * _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self initSubViews];
}
- (void)initSubViews
{
    [self creatNav];
    [self createWebView];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav+30) withTitleStr:@"服务单详情" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lineImageView.hidden = YES;
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)pop
{
    if (self.popViewControllerBlock) {
        self.popViewControllerBlock(self);
        return;
    }
    if (!_comeFrom) {
        [self.navigationController popViewControllerAnimated:NO];
        return;
    }
    if ([_comeFrom isEqualToString:@"MLDZ"] || [_comeFrom isEqualToString:@"DDGL"]) {
        [self.navigationController popViewControllerAnimated:NO];
    }else{
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
    }
    
}
- (void)createWebView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(15, Heigh_Nav, SCREEN_WIDTH-30, SCREEN_HEIGHT - Heigh_Nav)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
//    _webView.backgroundColor = [UIColor cyanColor];
    _webView.layer.cornerRadius = 6;
    _webView.layer.masksToBounds = YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@serv/detailsNew.html",SERVER_H5]]]];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"getUserCalendar"];
    [self.view addSubview:_webView];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
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
    //1. token  2.ordernum 3. function_id
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *token = model.data.token;
    NSString * function_id = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.function_id];
    NSString * jsStr = [NSString stringWithFormat:@"fuwudanDeatai('%@','%@','%@')",token,_ordernum,function_id];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
//    [_webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
//        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"HEIGHT" object:heightStr];
//    }];
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
