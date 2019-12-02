//
//  GuangGaoVC.m
//  xmh
//
//  Created by ald_ios on 2018/10/25.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GuangGaoVC.h"
#import "WorkGreetListModel.h"
#import <WebKit/WebKit.h>
@interface GuangGaoVC ()
<WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler
>
@property (nonatomic, strong)WKWebView * webView;
@end

@implementation GuangGaoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.webView];
}
-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = NO;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.url]]];
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"Back"];
    }
    return _webView;
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
    if ([message.name isEqualToString:@"Back"]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
@end
