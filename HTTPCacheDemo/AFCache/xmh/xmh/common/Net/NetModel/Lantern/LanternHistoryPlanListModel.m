//
//  lanternHistoryPlanListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternHistoryPlanListModel.h"

@implementation LanternHistoryPlanListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [LanternHistoryPlanModel class]};
}
@end
@implementation LanternHistoryPlanModel

@end
