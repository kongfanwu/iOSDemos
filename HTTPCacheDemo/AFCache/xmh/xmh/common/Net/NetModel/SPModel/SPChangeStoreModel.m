//
//  SPChangeStoreModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SPChangeStoreModel.h"

@implementation SPChangeStoreModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"user" : [SPStoreUserModel class]};
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}
@end
