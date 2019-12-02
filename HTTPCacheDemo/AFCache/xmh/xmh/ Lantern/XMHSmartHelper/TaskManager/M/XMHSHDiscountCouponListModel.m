//
//  XMHSHDiscountCouponListModel.m
//  xmh
//
//  Created by ald_ios on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSHDiscountCouponListModel.h"

@implementation XMHSHDiscountCouponListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [XMHSHDiscountCouponModel class] };
}
@end
@implementation XMHSHDiscountCouponModel
- (NSString *)typeName
{
    NSString * name= @"";
    if (_type == 3) {
        name = @"现金券";
    }else if (_type == 4){
        name = @"折扣券";
    }else if (_type == 5){
        name = @"礼品券";
    }
    return name;
}
@end
