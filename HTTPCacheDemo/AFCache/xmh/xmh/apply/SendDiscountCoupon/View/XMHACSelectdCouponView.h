//
//  XMHACSelectdCouponView.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHACSelectdCouponView : UIView
/** 已添加优惠券点击回调 */
@property (nonatomic, copy) void (^selectdCouponViewBlock)();
- (void)updateView:(NSInteger)num;
@end

NS_ASSUME_NONNULL_END
