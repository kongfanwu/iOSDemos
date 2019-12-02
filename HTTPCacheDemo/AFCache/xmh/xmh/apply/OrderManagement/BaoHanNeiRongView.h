//
//  BaoHanNeiRongView.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/16.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface BaoHanNeiRongView : UIView<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

-(void)freshBaoHanNeiRongViewCode:(NSString *)code Num:(NSString *)num sjCode:(NSString *)sjcode token:(NSString *)token name:(NSString *)name;
-(void)freshBaoHanNeiRongViewSecondjsonText:(NSString *)text;
@property (nonatomic, copy) void (^BaoHanNeiRongViewBuanbiBlock)(NSString *baohanStr);
@end
