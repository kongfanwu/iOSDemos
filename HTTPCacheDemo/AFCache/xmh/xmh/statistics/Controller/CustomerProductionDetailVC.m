//
//  CustomerProductionDetailVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerProductionDetailVC.h"
#import <WebKit/WebKit.h>
#import "ShareWorkInstance.h"
#import "UserManager.h"
@interface CustomerProductionDetailVC ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong)WKWebView * webView;
@end

@implementation CustomerProductionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"产值结构详情" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.webView];
}
-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@statistics/chanzhiDetail.html",SERVER_H5]]]];
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
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * jsStr = [NSString stringWithFormat:@"CustomerProductionTopCallIOS('%@','%@','%@','%@','%@')",infomodel.data.token,framId,joinCode,_startTime,_endTime];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................页面加载失败时调用");
}
@end
