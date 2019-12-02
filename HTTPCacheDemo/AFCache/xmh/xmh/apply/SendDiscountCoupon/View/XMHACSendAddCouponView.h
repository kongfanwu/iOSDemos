//
//  XMHACSendAddCouponView.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHACSendAddCouponView : UIView
@property (weak, nonatomic) IBOutlet UIButton *addCouponBtn;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoLabLeftLayout;

/** 添加顾客优惠券点击回调 */
@property (nonatomic, copy) void (^sendAddCouponViewBlock)();
@end

NS_ASSUME_NONNULL_END
