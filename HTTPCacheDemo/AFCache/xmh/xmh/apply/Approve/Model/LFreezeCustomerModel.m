//
//  LFreezeCustomerModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LFreezeCustomerModel.h"
@implementation LFreezeCustomerModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [LFreezeModel class] };
}
@end
@implementation LFreezeModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"u_id":@"id"};
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
