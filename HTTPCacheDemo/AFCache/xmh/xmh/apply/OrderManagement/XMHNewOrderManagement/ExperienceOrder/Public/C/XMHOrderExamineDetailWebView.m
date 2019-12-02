//
//  XMHOrderExamineDetailWebView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOrderExamineDetailWebView.h"
#import <WebKit/WebKit.h>
#import "customNav.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"

@interface XMHOrderExamineDetailWebView ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) customNav *navView;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *js;
@end

@implementation XMHOrderExamineDetailWebView

- (instancetype)initTitle:(NSString *)title webUrl:(NSString *)url js:(NSString *)js;
{
    self = [super init];
    if (self) {
        self.url = url;
        self.titleStr = title;
        self.js = js;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.navView];
    UIView *backGroundTopView = [[UIView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 30)];
    backGroundTopView.backgroundColor =kBtn_Commen_Color;
    [self.view addSubview:backGroundTopView];
    [self.view addSubview:self.webView];
    [self.webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

#pragma mark -- WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [XMHProgressHUD showGifImage];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [XMHProgressHUD dismiss];
    NSString *js =self.js;
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:js completionHandler:nil];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
  
}
#pragma mark -- layz
-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, Heigh_Nav, SCREEN_WIDTH-20, SCREEN_HEIGHT - Heigh_Nav )];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.layer.cornerRadius = 3;
//        [[_webView configuration].userContentController addScriptMessageHandler:self name:self.addScriptMessageName];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"SaleServiecDetailCallback"];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"goindex"];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"godetails"];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"goBackList"];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"ReverseClick"];
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
        }];
    }
    return _webView;
}

-(customNav *)navView
{
    if (!_navView) {
        _navView = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:self.titleStr withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
        _navView.lbTitle.textColor = [UIColor whiteColor];
        _navView.backgroundColor = kBtn_Commen_Color;
        _navView.lineImageView.hidden = YES;
        [_navView.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navView;
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
