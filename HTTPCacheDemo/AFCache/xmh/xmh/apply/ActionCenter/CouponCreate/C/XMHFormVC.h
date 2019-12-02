//
//  XMHFormVC.h
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
#import "XMHCouponModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormVC : BaseCommonViewController
/** 优惠券model */
@property (nonatomic, strong) XMHCouponModel *couponModel;
/** 优惠券类型 default XMHActionCouponTypeXianJin */
@property (nonatomic) XMHActionCouponType couponType;
/** default YES */
@property (nonatomic) BOOL edit;
/** 优惠券创建类型 默认：XMHActionCreateTypeCreate */
@property (nonatomic) XMHActionCreateType createType;
@end

NS_ASSUME_NONNULL_END
