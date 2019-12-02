//
//  XMHACSendView.h
//  xmh
//
//  Created by ald_ios on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHACSendView : UIView
/** 发放优惠券按钮点击回调 */
@property (nonatomic, copy) void (^XMHACSendViewBlock)();
@end

NS_ASSUME_NONNULL_END
