//
//  LanternPlanInfoListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/29.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternPlanInfoListModel.h"

@implementation LanternPlanInfoListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [LanternPlanInfoModel class]};
}
@end

@implementation LanternPlanInfoModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"pro" : [LanternPlanProModel class]};
}
@end
@implementation LanternPlanProModel

@end
