//
//  ApplicationInViewController.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/10/19.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "ApplicationInViewController.h"
#import <WebKit/WebKit.h>
#import "RolesTools.h"

@interface ApplicationInViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
{
    WKWebView * _webView;

}
@end

@implementation ApplicationInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNav];
    [self initWithSubView];
}
- (void)creatNav
{
    customNav * nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"商家入驻" withleftTitleStr:nil withleftImageStr:@"stgkgl_fanhui" withRightBtnImag:nil withRightBtnTitle:nil];
    nav.lineImageView.hidden = YES;
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)back {
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)initWithSubView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav , SCREEN_WIDTH, SCREEN_HEIGHT-Heigh_Nav)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@enter/formIndex.html",SERVER_H5]]]];
   [[_webView configuration].userContentController addScriptMessageHandler:self name:@"goBack"];
    [self.view addSubview:_webView];
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD showGifImage];
    MzzLog(@"...................页面开始加载时调用11");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................当内容开始返回时调用11");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载完成之后调用11");
    
    [XMHProgressHUD dismiss];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载失败时调用11");
}
//wk被terminate时调用
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"goBack"]) {
        [self back];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
