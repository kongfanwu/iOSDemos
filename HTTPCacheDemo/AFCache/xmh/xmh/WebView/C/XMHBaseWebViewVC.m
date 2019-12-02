//
//  XMHBaseWebViewVC.m
//  xmh
//
//  Created by KFW on 2019/4/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBaseWebViewVC.h"

@interface XMHBaseWebViewVC () 

@end

@implementation XMHBaseWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    
    UIView *backGroundTopView = [[UIView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 30)];
    self.backGroundTopView = backGroundTopView;
    backGroundTopView.backgroundColor =kBtn_Commen_Color;
    [self.view addSubview:backGroundTopView];
    
    [self.view addSubview:self.navView];
    [self createWebView];
    [self addScriptMessage];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 需要注意的是addScriptMessageHandler很容易引起循环引用.因此这里要记得移除handlers
//    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"getUserCalendar"];
}

- (LNavView *)navView
{
    WeakSelf
    if (!_navView) {
        _navView = loadNibName(@"LNavView");
        _navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, KNaviBarHeight);
        _navView.backgroundColor = kBtn_Commen_Color;//[UIColor clearColor];
        _navView.NavViewBackBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navView;
}

- (void)createWebView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(15, Heigh_Nav, SCREEN_WIDTH-30, SCREEN_HEIGHT - Heigh_Nav)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.layer.cornerRadius = 6;
    _webView.layer.masksToBounds = YES;
    
    [self.view addSubview:_webView];
}

#pragma mark - Public
/**
 注册js调用OC方法。viewWillDisappear: 记得移除
 */
- (void)addScriptMessage {
//    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"getUserCalendar"];
}

/**
 加载url
 */
- (void)loadUrl:(NSString *)url {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark - WKScriptMessageHandler

/**
 js调用OC代理方法
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    if ([message.name isEqualToString:@"getUserCalendar"]) {
//        NSLog(@"%@", message.body);
//    }
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
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载失败时调用");
}

//wk被terminate时调用
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    MzzLog(@"...................wk被terminate时调用");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
