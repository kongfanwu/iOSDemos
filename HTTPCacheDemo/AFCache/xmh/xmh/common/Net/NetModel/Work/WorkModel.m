//
//  WorkModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/20.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "WorkModel.h"

@implementation WorkModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [WorkUserModel class],@"top":[WorkTopModel class],@"today":[WorkTodayModel class]};
}
@end

@implementation WorkHeardManagerModel

@end

@implementation WorkUserModel

@end

@implementation WorkTopModel

@end

@implementation WorkTodayModel

@end

