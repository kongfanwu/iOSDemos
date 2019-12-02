//
//  XMHCouponListModel.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponListModel.h"
#import "XMHCouponModel.h"
@implementation XMHCouponListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [XMHCouponModel class] };
}
@end
