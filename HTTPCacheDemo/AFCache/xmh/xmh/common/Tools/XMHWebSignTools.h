//
//  XMHWebSignTools.h
//  xmh
//
//  Created by ald_ios on 2019/5/29.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  WebView 获取密钥

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface XMHWebSignTools : NSObject
+ (void)loadWebViewJs:(WKWebView *)webView;
@end

NS_ASSUME_NONNULL_END
