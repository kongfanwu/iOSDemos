//
//  ReportBJController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ReportBJController.h"
#import <WebKit/WebKit.h>
@interface ReportBJController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>{
    WKWebView *_webView;
    customNav *_nav;
}

@end

@implementation ReportBJController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNav];
    [self initSubviews];
}
- (void)creatNav{
    _nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"处方报告" withleftImageStr:@"back" withRightStr:nil];
    [_nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}
- (void)initSubviews{
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _nav.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _nav.bottom)];
    [self.view addSubview:_webView];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@beauty/report_bj.html",SERVER_H5];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"chufangReporterJumpBack"];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"chufangReporterConfrimBack"];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString * callbackstr = message.body;
    if ([callbackstr isEqualToString:@"OK"]) {
        [self pop];
    }
}
- (void)pop{
    if (_ReportBJControllerPopBlock) {
        _ReportBJControllerPopBlock();
    }
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"chufangReporterJumpBack"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"chufangReporterConfrimBack"];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //传token,项目编号
        NSString *js = [NSString stringWithFormat:@"ChufangDetailCallJs('%@','%@')",_token,_ordernum];
    [XMHWebSignTools loadWebViewJs:webView];
        [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            
        }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
