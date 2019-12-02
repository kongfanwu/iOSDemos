//
//  LanternCustomerDetailVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/29.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternCustomerDetailVC.h"
#import <WebKit/WebKit.h>
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
@interface LanternCustomerDetailVC ()
<
WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler
>
@property (nonatomic, strong)WKWebView * detailWebView;
@end

@implementation LanternCustomerDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = kColorTheme;
    [self.view addSubview:self.detailWebView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[_detailWebView configuration].userContentController  removeScriptMessageHandlerForName:@"LanternGoBack"];
}

-(WKWebView *)detailWebView
{
    if (!_detailWebView) {
        _detailWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _detailWebView.UIDelegate = self;
        _detailWebView.navigationDelegate = self;
        [[_detailWebView configuration].userContentController addScriptMessageHandler:self name:@"LanternGoBack"];
        if (@available(iOS 11.0, *)) {
            _detailWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        [_detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@intelligence/index2.html",SERVER_H5]]]];
    }
    return _detailWebView;
}
#pragma mark ------WKWebView------
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * token = infomodel.data.token;
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    NSString * jsStr = [NSString stringWithFormat:@"LanternCallIos('%@','%@','%@')",joinCode,_lanternRecommedModel.user_id,token];
    [XMHWebSignTools loadWebViewJs:webView];
    [_detailWebView evaluateJavaScript:jsStr completionHandler:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................页面加载失败时调用");
}
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"LanternGoBack"]) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}
@end
