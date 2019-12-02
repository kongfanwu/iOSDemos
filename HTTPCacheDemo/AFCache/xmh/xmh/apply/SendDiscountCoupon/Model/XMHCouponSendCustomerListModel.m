//
//  XMHCouponSendCustomerListModel.m
//  xmh
//
//  Created by ald_ios on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponSendCustomerListModel.h"

@implementation XMHCouponSendCustomerListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [XMHCouponSendCustomerModel class] };
}
@end
@implementation XMHCouponSendCustomerModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"activityid":@"id"};
}
/** 重写方法判断是否确实是同一顾客 */
- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[XMHCouponSendCustomerModel class]]) {
        return NO;
    }
    return [self isEqualToPerson:(XMHCouponSendCustomerModel *)object];
}
- (BOOL)isEqualToPerson:(XMHCouponSendCustomerModel *)customer {
    if (!customer) {
        return NO;
    }
    BOOL bIsEqualNames = (!self.name && !customer.name) || [self.name isEqualToString:customer.name];
    BOOL bIsEqualID = self.user_id == customer.user_id;
    
    return bIsEqualNames && bIsEqualID;
}
@end
