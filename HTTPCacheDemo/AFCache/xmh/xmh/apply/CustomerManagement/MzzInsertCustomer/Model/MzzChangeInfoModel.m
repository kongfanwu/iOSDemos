//
//  MzzChangeInfoModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzChangeInfoModel.h"

@implementation MzzChangeInfoModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"approvalPerson" : [MzzApprovalpersonNew class]};
}


@end


@implementation MzzApprovalpersonNew


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



