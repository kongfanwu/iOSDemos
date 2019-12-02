//
//  BeautyCFReportWriteVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFReportWriteVC.h"
#import <WebKit/WebKit.h>
#import "BeautyCFDetailVC.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "BeautyCFDetailVC.h"
#import "BeautyRequest.h"
@interface BeautyCFReportWriteVC ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong)WKWebView * webView;
@end

@implementation BeautyCFReportWriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"填写处方报告" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.webView];
}
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        NSString *urlStr = [NSString stringWithFormat:@"%@beauty/report_bj.html",SERVER_H5];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"chufangReporterConfrimBack"];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"chufangReporterJumpBack"];
    }
    return _webView;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString * callbackstr = message.body;
    /** 确认提交后跳转到处方详情 */
    if ([callbackstr isEqualToString:@"OK"]) {
        if (_from == 1) {/** 来自详情的时候 直接返回处方列表 */
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
        }else{/** 来自处方列表的结束处方按钮 返回处方列表 */
            [self.navigationController popViewControllerAnimated:NO];
        }
    }else{
        [XMHProgressHUD showOnlyText:callbackstr];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"chufangReporterConfrimBack"];
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
