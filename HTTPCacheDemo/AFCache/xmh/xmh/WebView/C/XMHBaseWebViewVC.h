//
//  XMHBaseWebViewVC.h
//  xmh
//
//  Created by KFW on 2019/4/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//
/* OC调用jS 示例
 //1. token  2.ordernum 3. function_id
 LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
 NSString *token = model.data.token;
 NSString * function_id = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.function_id];
 NSString * jsStr = [NSString stringWithFormat:@"fuwudanDeatai('%@','%@','%@')",token,_ordernum,function_id];
 [_webView evaluateJavaScript:jsStr completionHandler:nil];
 */

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "LNavView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHBaseWebViewVC : UIViewController <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

/** <##> */
@property (nonatomic, strong) UIView *backGroundTopView;
/** <##> */
@property (nonatomic, strong) LNavView *navView;
/** <##> */
@property (nonatomic, strong) WKWebView *webView;

/**
 加载url
 */
- (void)loadUrl:(NSString *)url;

/**
 注册js调用OC方法。viewWillDisappear: 记得移除
 */
- (void)addScriptMessage;

@end

NS_ASSUME_NONNULL_END
