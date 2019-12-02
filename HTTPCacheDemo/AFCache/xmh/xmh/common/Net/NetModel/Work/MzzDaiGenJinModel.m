//
//  MzzDaiGenJinModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzDaiGenJinModel.h"

@implementation MzzDaiGenJinModel


@end

@implementation MzzDaiGenJin

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"kqwh" : [MzzKqwh class], @"sqgk" : [MzzSqgk class], @"kfgk" : [MzzKfgk class]};
}


@end


@implementation MzzKqwh


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation MzzSqgk


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation MzzKfgk


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



