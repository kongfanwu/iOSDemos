//
//  SLSearchManagerModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SLSearchManagerModel.h"

@implementation SLSearchManagerModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SLManagerModel class]};
}


@end


@implementation SLManagerModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



