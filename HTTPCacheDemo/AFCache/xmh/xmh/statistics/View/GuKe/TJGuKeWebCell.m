//
//  TJGuKeWebCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJGuKeWebCell.h"
#import <WebKit/WebKit.h>
#import "TJGuKeListModel.h"
#import "YYModel.h"
@interface TJGuKeWebCell ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end
@implementation TJGuKeWebCell
{
     WKWebView * _webView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubView];
    }
    return self;
}
- (void)initSubView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, 0)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
//    _webView.scrollView.scrollEnabled = NO;
    _webView.backgroundColor = [UIColor cyanColor];
     [[_webView configuration].userContentController addScriptMessageHandler:self name:@"yejiListResult"];
    [self.contentView addSubview:_webView];
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD showGifImage];
    MzzLog(@"...................页面开始加载时调用11");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................当内容开始返回时调用11");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载完成之后调用11");
    NSString * jsStr = [NSString stringWithFormat:@"yejitongjilist('%@','%@','%@','%@','%@','%@','%@','%@')",_model.token,_model.oneClick,_model.twoClick,_model.twoListId,_model.inId,_model.joinCode,_model.startTime,_model.endTime];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
    [XMHProgressHUD dismiss];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载失败时调用11");
}
//wk被terminate时调用
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSData * jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        NSLog(@"解析失败");
    }

    TJGuKeListModel * model = [TJGuKeListModel yy_modelWithJSON:dic];
    if(_TJGuKeWebCellBlock){
        _TJGuKeWebCellBlock(model);
    }
//    if (_TJCardWebCellBlock) {
//        _TJGuKeWebCellBlock(model);
//    }
}
- (void)setModel:(StructureModel *)model
{
    _model = model;
    CGFloat height = 0;
    if (model.type ==1) {
        height = 320;
    }else if (model.type ==2){
        height = 280;
    }else if (model.type ==3){
        height = 360;
    }else if (model.type ==4){
        height = 320;
    }else{
        height = 690;
    }
    _webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.urlStr]]];
    
}
@end
