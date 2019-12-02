//
//  XMHVipDiscountView.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 会员优惠view */
NS_ASSUME_NONNULL_BEGIN

@interface XMHVipDiscountView : UIView
@property (nonatomic, copy)NSString *discount;// 折扣

@property (nonatomic, copy)void(^vipDiscountBlock)();
@end

NS_ASSUME_NONNULL_END
