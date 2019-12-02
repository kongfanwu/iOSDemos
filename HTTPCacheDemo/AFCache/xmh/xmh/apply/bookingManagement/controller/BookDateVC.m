//
//  BookDateVC.m
//  xmh
//
//  Created by ald_ios on 2018/10/23.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookDateVC.h"
#import <WebKit/WebKit.h>
@interface BookDateVC ()
<
WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler
>
@property (nonatomic, strong)WKWebView * calenderWebView;

@end

@implementation BookDateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setNavViewTitle:@"请选择预约日期" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:self.calenderWebView];
    
}
-(WKWebView *)calenderWebView
{
    if (!_calenderWebView) {
        _calenderWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
        _calenderWebView.UIDelegate = self;
        _calenderWebView.navigationDelegate = self;
        [[_calenderWebView configuration].userContentController addScriptMessageHandler:self name:@"yuyueSelectDate"];
        [_calenderWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@yuyue/datePicker.html",SERVER_H5]]]];
    }
    return _calenderWebView;
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
    NSString * jsStr = [NSString stringWithFormat:@"iosgetdate('%@')",_selectDate];
    [XMHWebSignTools loadWebViewJs:webView];
    [_calenderWebView evaluateJavaScript:jsStr completionHandler:nil];

//    [_calenderWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        
//    }];
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
    if ([message.name isEqualToString:@"yuyueSelectDate"]) {
        NSString * selectDate = message.body;
        /** 时间为空 不传参 */
        if (selectDate.length == 0) {
            return;
        }
        _selectDate = selectDate;
        if (_BookDateVCBlock) {
            _BookDateVCBlock(selectDate);
        }
        [self.navigationController popViewControllerAnimated:NO];
    }
}
@end
