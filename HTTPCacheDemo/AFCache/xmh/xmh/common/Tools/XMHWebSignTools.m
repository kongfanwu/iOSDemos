//
//  XMHWebSignTools.m
//  xmh
//
//  Created by ald_ios on 2019/5/29.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHWebSignTools.h"

@implementation XMHWebSignTools
+ (void)loadWebViewJs:(WKWebView *)webView
{
    NSString *jsStr = [NSString stringWithFormat:@"localStorage.setItem('kAPP_PRIVATEKEY', '%@')", kAPP_PRIVATEKEY];
    [webView evaluateJavaScript:jsStr completionHandler:nil];
}
@end
