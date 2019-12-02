//
//  BeautyCFReportVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFReportVC.h"
#import <WebKit/WebKit.h>
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "BeautyCFDetailUserInfoView.h"
#import "BeautyCFReportWriteVC.h"
#import "BeautyCustomersVC.h"
#import "BeautyRequest.h"
@interface BeautyCFReportVC ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong)WKWebView * webView;
@property (nonatomic, strong)BeautyCFDetailUserInfoView *userInfoView;
@end

@implementation BeautyCFReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;
    [self initSubViews];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"处方报告" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.userInfoView];
    [self.view addSubview:self.webView];
    [_userInfoView updateViewParam:_param];
}
- (BeautyCFDetailUserInfoView *)userInfoView
{
    if (!_userInfoView) {
        _userInfoView = loadNibName(@"BeautyCFDetailUserInfoView");
        _userInfoView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 100);
    }
    return _userInfoView;
}
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _userInfoView.bottom + 10, SCREEN_WIDTH, SCREEN_HEIGHT - _userInfoView.bottom - 10)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",SERVER_H5,kBEAUTY_CFREPORT_URL];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    }
    return _webView;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
   
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //传token,项目编号
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * token = model.data.token;
    NSString *js = [NSString stringWithFormat:@"ChufangDetailCallJs('%@','%@')",token,_param[@"ordernum"]];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
}
@end
