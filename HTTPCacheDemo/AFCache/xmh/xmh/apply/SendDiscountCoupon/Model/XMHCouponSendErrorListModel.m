//
//  XMHCouponSendErrorListModel.m
//  xmh
//
//  Created by ald_ios on 2019/5/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponSendErrorListModel.h"

@implementation XMHCouponSendErrorListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [XMHCouponSendErrorModel class] };
}
@end
@implementation XMHCouponSendErrorModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}
@end
