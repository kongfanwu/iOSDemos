//
//  XMHReportFullView.m
//  xmh
//
//  Created by kfw on 2019/7/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHReportFullView.h"
@interface XMHReportFullView()
/** <##> */
@property (nonatomic, weak) id <WKUIDelegate, WKNavigationDelegate> delegate;
//@property (nonatomic, strong) WKWebView *webView;
@end

@implementation XMHReportFullView

- (instancetype)initWithFrame:(CGRect)frame delegate:(__weak id <WKUIDelegate, WKNavigationDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.delegate = delegate;
//        [self createWebView];
    }
    return self;
}

- (void)createWebView {
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(kSafeAreaBottom, 0, self.width - kSafeAreaBottom - kSafeAreaTop, self.height)];
    _webView.UIDelegate = self.delegate;
    _webView.navigationDelegate = self.delegate;
    _webView.scrollView.scrollEnabled = YES;
    [self addSubview:_webView];
}

/**
 加载报表 url
 */
- (void)loadWebViewReportUrl:(NSURL *)url {
     [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)setWebView:(WKWebView *)webView
{
    if (_webView) return;
    _webView = webView;
    _webView.frame = CGRectMake(kSafeAreaBottom, 0, self.height - kSafeAreaBottom - kSafeAreaTop, self.width);
    [self addSubview:_webView];
}
@end
