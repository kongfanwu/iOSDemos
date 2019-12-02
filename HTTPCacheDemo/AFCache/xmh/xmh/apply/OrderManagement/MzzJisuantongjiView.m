//
//  MzzJisuantongjiView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzJisuantongjiView.h"
#import <WebKit/WebKit.h>
@interface MzzJisuantongjiView() <WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>
@property (nonatomic , strong) WKWebView *web;
@property (nonatomic , copy) NSString *js;
@end

@implementation MzzJisuantongjiView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        _web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height )];
        _web.navigationDelegate = self;
        _web.UIDelegate = self;
        _web.backgroundColor = [UIColor whiteColor];
        [[_web configuration].userContentController addScriptMessageHandler:self name:@"jisuantongji"];
        [self addSubview:_web];
    }
    return self;
}
- (void)setWebHeight:(void (^)(CGFloat))webHeight{
    _webHeight = webHeight;
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _web.width = frame.size.width;
    _web.height = frame.size.height;
}
- (void)setupRequestUrl:(NSString *)url andEvaluateJavaScript:(NSString *)js{
    _js = js;
    [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD showGifImage];
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
 
    [XMHWebSignTools loadWebViewJs:webView];
    [_web evaluateJavaScript:_js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id data, NSError * _Nullable error) {
            CGFloat height = [data floatValue];
            if (self.webHeight) {
                self.webHeight(height);
            }
             [XMHProgressHUD dismiss];
        }];
    }];
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
}
@end
