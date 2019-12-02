//
//  FWDWebCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FWDWebCell.h"
#import <WebKit/WebKit.h>
@interface FWDWebCell ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end
@implementation FWDWebCell
{
     WKWebView * _webView;
     UIView * _line;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createWebView];
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}
- (void)createWebView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 200)];
    _webView.layer.cornerRadius = 6;
    _webView.layer.masksToBounds = YES;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"getUserCalendar"];
    [self addSubview:_webView];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面开始加载时调用");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................当内容开始返回时调用");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载完成之后调用");
        NSString * jsStr = [NSString stringWithFormat:@"fuwudanList('%@')",_params];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
    
    [_webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
        _webView.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, heightStr.floatValue);
        _webView.layer.cornerRadius = 6;
        _webView.layer.masksToBounds = YES;
         _line.frame = CGRectMake(0, _webView.bottom + 10, SCREEN_WIDTH-30, 10);
        [[NSNotificationCenter defaultCenter] postNotificationName:Fwd_Cell0Height object:heightStr];
    }];
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载失败时调用");
}
//wk被terminate时调用
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}
- (void)setParams:(NSString *)params
{
    _params = params;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@serv/android_qd.html",SERVER_H5]]]];
}
@end
