//
//  XMHReportFullView.h
//  xmh
//
//  Created by kfw on 2019/7/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 全屏报表

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHReportFullView : UIView

- (instancetype)initWithFrame:(CGRect)frame delegate:(__weak id <WKUIDelegate, WKNavigationDelegate>)delegate;

@property (nonatomic, strong) WKWebView *webView;

/**
 加载报表 url
 */
- (void)loadWebViewReportUrl:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
