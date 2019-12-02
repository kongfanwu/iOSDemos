//
//  SLServAppoModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SLServAppoModel.h"


@implementation SLServAppoModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"appo_pres" : [SLAppo_Pres class], @"appo_pro" : [SLAppo_Pro class]};
}


@end


@implementation SLAppo_Pres

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"pro_list" : [SLPro class]};
}


@end


@implementation SLPro


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation SLAppo_Pro


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



