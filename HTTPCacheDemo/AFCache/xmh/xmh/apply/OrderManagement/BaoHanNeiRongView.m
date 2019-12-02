//
//  BaoHanNeiRongView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/16.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaoHanNeiRongView.h"

@implementation BaoHanNeiRongView{
    WKWebView *_webView;
    
    NSString *_code;
    NSString *_num;
    NSString *_sjcode;
    NSString *_token;
    NSString *_name;
    UIView *_bg;
    NSString *_jsontext;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initsubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)initsubViews{
    _bg = [[UIView alloc]initWithFrame:self.frame];
    _bg.backgroundColor = [UIColor whiteColor];
//    _bg.alpha = 0.6;
    [self addSubview:_bg];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight,SCREEN_WIDTH, SCREEN_HEIGHT - KNaviBarHeight)];
    [self addSubview:_webView];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"BaoHanNeiRongViewcallback"];
    
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"BaoHanNeiRongViewGuanbi"];
}
-(void)freshBaoHanNeiRongViewCode:(NSString *)code Num:(NSString *)num sjCode:(NSString *)sjcode token:(NSString *)token name:(NSString *)name{
    _code = code;
    _num = num;
    _sjcode = sjcode;
    _token = token;
    _name = name;
    NSString *urlStr = [NSString stringWithFormat:@"%@sales/dialog.html",SERVER_H5];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString * callbackstr = message.body;
    NSLog(@"%@",callbackstr);
    if ([callbackstr containsString:@"guanbi"]) {
        [self removeFromSuperview];
        
    }else if ([callbackstr hasPrefix:@"{"]) {
        if (_BaoHanNeiRongViewBuanbiBlock) {
            _BaoHanNeiRongViewBuanbiBlock(callbackstr);
        }
    }
}
-(void)freshBaoHanNeiRongViewSecondjsonText:(NSString *)text{
    _jsontext = text;
    [_webView reload];
//    NSString *urlStr = [NSString stringWithFormat:@"%@sales/dialog.html",SERVER_H5];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"BaoHanNeiRongViewcallback"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //传token,项目编号
        NSString *js = [NSString stringWithFormat:@"BaoHanNeiRongViewcallJs('%@','%@','%@','%@','%@')",_code,_sjcode,_num,_token,_name];
    [XMHWebSignTools loadWebViewJs:webView];
        [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSString *secondjs = [NSString stringWithFormat:@"BaoHanNeiRongViewSecondcallJs('%@')",_jsontext];
            [_webView evaluateJavaScript:secondjs completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                
            }];
        }];    
}

@end
