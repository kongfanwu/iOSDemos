//
//  SLGoodsModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SLGoodsModel.h"



@implementation SLGoodsModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SLGood class]};
}


@end


@implementation SLGood


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



