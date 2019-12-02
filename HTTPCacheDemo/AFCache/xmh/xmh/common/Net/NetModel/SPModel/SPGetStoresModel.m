//
//  SPGetStoresModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SPGetStoresModel.h"


@implementation SPGetStoresModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SPStoresModel class]};
}


@end


@implementation SPStoresModel


@end



