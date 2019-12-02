//
//  XMHCouponPayInfoModel.h
//  xmh
//
//  Created by KFW on 2019/5/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 支付详情model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponPayInfoModel : NSObject
/** 1:激活可使用 2:不激活可使用  默认 2*/
@property (nonatomic, copy) NSString *status;
/** 价格 */
@property (nonatomic, copy) NSString *money;

/**
 拼接value描述
 */
- (NSString *)valueDes;

@end

NS_ASSUME_NONNULL_END
