//
//  XMHCouponView.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 优惠券按钮 / 购买内容选择按钮*/
NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponView : UIView
@property (nonatomic, copy) NSString *coupon;//优惠券数量
@property (nonatomic, copy) NSString *content;//购买内容选择
@property (nonatomic, copy)void(^didCouponTickt)();// 跳转到优惠券列表/购买内容选择列表

/**
 设置text

 @param coupon 优惠券名称
 @param hiddenBgView 是否隐藏红包背景
 */
- (void)setCoupon:(NSString *)coupon hiddenBgView:(BOOL)hiddenBgView;

@end

NS_ASSUME_NONNULL_END
