//
//  SACourseModeList.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SACourseModeList.h"

@implementation SACourseModeList
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SACourseMode class]};
}
@end

@implementation SACourseMode
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"range" : [SARangeModel class]};
}
@end


@implementation SARangeModel

@end
