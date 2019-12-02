//
//  SPSearchStoreUserModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/1.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SPSearchStoreUserModel.h"

@implementation SPSearchStoreUserModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SPStoreUserModel class]};
}


@end


@implementation SPStoreUserModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



