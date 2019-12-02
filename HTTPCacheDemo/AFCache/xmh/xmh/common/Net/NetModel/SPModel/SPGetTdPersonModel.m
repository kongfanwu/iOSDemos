//
//  SPGetTdPersonModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SPGetTdPersonModel.h"



@implementation SPGetTdPersonModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"approvalPerson" : [SPPersonModel class], @"duplicatePerson" : [SPPersonModel class]};
}


@end


@implementation SPPersonModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end






