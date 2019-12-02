//
//  XMHCouponSendHomeListModel.m
//  xmh
//
//  Created by ald_ios on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponSendHomeListModel.h"

@implementation XMHCouponSendHomeListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [XMHCouponSendHomeModel class] };
}
@end
@implementation XMHCouponSendHomeModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"activityid":@"id"};
}
@end
