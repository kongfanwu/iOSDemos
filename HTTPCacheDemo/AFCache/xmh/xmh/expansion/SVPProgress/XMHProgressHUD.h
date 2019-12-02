//
//  XMHProgressHUD.h
//  xmh
//
//  Created by ald_ios on 2019/5/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHProgressHUD : NSObject
/** 加载动画 */
+ (void)showGifImage;
/** 只展示文字 */
+ (void)showOnlyText:(NSString *)text;

/**
 只展示文字
 
 @param text text
 @param delay 延迟秒
 @param completion 消失回调
 */
+ (void)showOnlyText:(NSString *)text delay:(NSTimeInterval)delay completion:(void(^)(void))completion;

/** 取消 */
+ (void)dismiss;
@end

NS_ASSUME_NONNULL_END
