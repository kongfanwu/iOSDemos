//
//  LApproveCommonModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LApproveCommonModel.h"

@implementation LApproveCommonModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [LApproveDetailModel class] };
}
@end

@implementation LApproveDetailModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"u_id":@"id"};
}
@end
@implementation LApproveUserModel

@end
