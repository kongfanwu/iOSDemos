//
//  MzzCardsModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/2.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzCardsModel.h"

@implementation ESRootClass

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [MzzCardsModel class]};
}


@end

@implementation MzzCardsModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



