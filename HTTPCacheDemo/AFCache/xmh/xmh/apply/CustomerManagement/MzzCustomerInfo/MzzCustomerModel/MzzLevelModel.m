//
//  MzzLevelModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/15.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzLevelModel.h"

@implementation LevelData

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"group_list" : [MzzCustomerLevelModel class]};
}


@end


@implementation MzzCustomerLevelModel


@end



