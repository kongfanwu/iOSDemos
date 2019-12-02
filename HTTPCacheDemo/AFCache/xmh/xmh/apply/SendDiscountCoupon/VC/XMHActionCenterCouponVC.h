//
//  XMHActionCenterCouponVC.h
//  xmh
//
//  Created by ald_ios on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN
static NSString * kCash = @"cash";
static NSString * kDiscount = @"discount";
static NSString * kGift = @"gift";
@interface XMHActionCenterCouponVC : BaseCommonViewController
@property (nonatomic, strong)NSMutableDictionary * selectResultDic;
@property (nonatomic, copy) void(^XMHActionCenterCouponVCBlock)(NSMutableDictionary * selectCouponDic);
@end

NS_ASSUME_NONNULL_END
