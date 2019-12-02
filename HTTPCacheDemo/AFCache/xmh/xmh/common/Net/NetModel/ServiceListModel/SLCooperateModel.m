//
//  SLCooperateModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/26.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SLCooperateModel.h"

@implementation SLCooperateModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SLCooperate class]};
}


@end


@implementation SLCooperate


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



