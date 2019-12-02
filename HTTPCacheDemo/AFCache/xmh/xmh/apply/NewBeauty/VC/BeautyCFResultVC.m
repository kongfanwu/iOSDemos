//
//  BeautyCFResultVC.m
//  xmh
//
//  Created by ald_ios on 2019/5/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFResultVC.h"
#import <WebKit/WebKit.h>
#import "LolUserInfoModel.h"
#import "UserManager.h"
@interface BeautyCFResultVC ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong)WKWebView * webView;
@end

@implementation BeautyCFResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navView setNavViewTitle:@"执行效果查看" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
   [self.view addSubview:self.webView];
    
}
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",SERVER_H5,kBEAUTY_CFREPORTERESULT_URL];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    }
    return _webView;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //传token,项目编号
//    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
//    NSString * token = model.data.token;
    NSString *js = [NSString stringWithFormat:@"ChufangDetailChuFangZhiXingBiaocallJs('%@')",_callStr];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {

    }];
}
@end
