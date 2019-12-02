//
//  LolGuKeCalender.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolGuKeCalender.h"
#import <WebKit/WebKit.h>
#import "YYModel.h"
#import "LolGuKeStateModelList.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
@interface LolGuKeCalender ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end
@implementation LolGuKeCalender{
    WKWebView * _webView;
    NSString * _id;
    NSString * _date;
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
- (void)setInID:(NSString *)inid date:(NSString *)date ;
{
    _id = inid;
    _date = date;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beauty/yuyue_time.html",SERVER_H5]]]];
}
- (void)createWebView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 451)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = NO;
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.199:8020/xmh_5.0/beauty/yuyue_time.html"]]];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"getUserCalendar"];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"GuKeCalenderReload"];
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
        }];
        [self addSubview:_webView];
    }
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"GuKeCalenderReload"]) {
        _date = message.body;
        if (_LolGuKeCalenderDataChangeBlock) {
            _LolGuKeCalenderDataChangeBlock(_date);
        }
        [_webView reload];
    }
    NSLog(@".......%@",[message.body class]); //数据过来为字典
    NSDictionary * dict = (NSDictionary *)message.body;
    LolGuKeStateModelList * model = [LolGuKeStateModelList yy_modelWithDictionary:dict];
    if (_LolGuKeCalenderBlock) {
        _LolGuKeCalenderBlock(model);
    }
    
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................页面开始加载时调用");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................当内容开始返回时调用");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................页面加载完成之后调用");
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * token = infomodel.data.token;
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;;
    NSString * jsStr = [NSString stringWithFormat:@"callIos('%@','%@','%@','%@')",_id,joinCode,token,_date];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................页面加载失败时调用");
}
//wk被terminate时调用
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}
@end
