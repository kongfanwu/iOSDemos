//
//  CustomerGradeDetailVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerGradeDetailVC.h"
#import <WebKit/WebKit.h>
#import "UserManager.h"
#import "ShareWorkInstance.h"
@interface CustomerGradeDetailVC ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong)WKWebView * webView;
@end

@implementation CustomerGradeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorE;
    [self initSubViews];
}

- (void)initSubViews
{
    [self.navView setNavViewTitle:@"等级详情" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.webView];
    
}
-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@statistics/vipGradeDetail.html",SERVER_H5]]]];
    }
    return _webView;
}
#pragma mark ------WKWebView------
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD showGifImage];
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD dismiss];
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * framId = _framId?_framId:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * jsStr = [NSString stringWithFormat:@"CustomerGradeDetailCallIOS('%@','%@','%@')",joinCode,infomodel.data.token,framId];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................页面加载失败时调用");
}
@end
