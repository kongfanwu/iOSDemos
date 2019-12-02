//
//  XMHServiceOrderDetailWebViewVC.m
//  xmh
//
//  Created by KFW on 2019/4/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderDetailWebViewVC.h"

@implementation XMHServiceOrderDetailWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView setNavViewTitle:@"服务单详情" backBtnShow:YES];
    
    [self loadUrl:[NSString stringWithFormat:@"%@serv/details.html",SERVER_H5]];
//    [self loadUrl:[NSString stringWithFormat:@"%@serv/detailsNew.html",SERVER_H5]];
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 需要注意的是addScriptMessageHandler很容易引起循环引用.因此这里要记得移除handlers
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"getUserCalendar"];
}

#pragma mark - 重写

/**
 注册js调用OC方法。viewWillDisappear: 记得移除
 */
- (void)addScriptMessage {
    [super addScriptMessage];
     [[self.webView configuration].userContentController addScriptMessageHandler:self name:@"getUserCalendar"];
}

#pragma mark - WKScriptMessageHandler

/**
 js调用OC代理方法
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"getUserCalendar"]) {
        NSLog(@"---%@", message.body);
    }
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载完成之后调用");
    //1. token  2.ordernum 3. function_id
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *token = model.data.token;
    NSString * function_id = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.function_id];
    NSString * jsStr = [NSString stringWithFormat:@"fuwudanDeatai('%@','%@','%@')",token,_ordernum,function_id];
    [XMHWebSignTools loadWebViewJs:webView];
    [self.webView evaluateJavaScript:jsStr completionHandler:nil];
}

@end
