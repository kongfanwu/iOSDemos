//
//  SPCongealModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/29.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SPCongealModel.h"

@implementation SPCongealModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"duplicatePerson" : [SPCongealPersonModel class]};
}


@end





@implementation SPCongealPersonModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



