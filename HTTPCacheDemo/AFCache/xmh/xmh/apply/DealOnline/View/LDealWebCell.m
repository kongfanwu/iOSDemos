//
//  LDealWebCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LDealWebCell.h"
#import <WebKit/WebKit.h>
#import "LolUserInfoModel.h"
#import "UserManager.h"
@interface LDealWebCell ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end
@implementation LDealWebCell
{
    WKWebView * _webView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)initSubViews{
    [self createWebView];
    
}
- (void)createWebView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 850)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = NO;
    _webView.backgroundColor = [UIColor cyanColor];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@online/chart.html",SERVER_H5]]]];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"getWebH"];
    [self addSubview:_webView];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
//    if ([message.body isKindOfClass:[NSNumber class]]) {
//
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"HEIGHT" object:[NSString stringWithFormat:@"%@",message.body]];
//    MzzLog(@"class..........%@",[message.body class])
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
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * token = infomodel.data.token;
    MzzLog(@"...................页面加载完成之后调用");
    NSString * jsStr = [NSString stringWithFormat:@"beautyHomeCallJs('%@','%@','%@','%@','%@','%@','%@','%@','%@')",token,_model.joinCode,_model.oneClick,_model.twoClick,_model.twoListId,_model.thirdClick,_model.forthClick,_model.start,_model.end];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
    
    [_webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HEIGHT" object:heightStr];
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
- (void)setModel:(COrganizeModel *)model
{
    _model = model;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@online/chart.html",SERVER_H5]]]];
}
@end
