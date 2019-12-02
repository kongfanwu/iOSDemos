//
//  XMHVCTools.h
//  xmh
//
//  Created by ald_ios on 2019/5/16.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHVCTools : NSObject
/** 通过控制器Name判断压栈内是否含有控制器 */
+ (BOOL)isHaveVCByName:(NSString *)vcName;
/** 获得当前的控制器 */
+ (UIViewController *)getCurrentViewController;
@end

NS_ASSUME_NONNULL_END
