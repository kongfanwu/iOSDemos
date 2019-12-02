//
//  MzzUser_bill.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/18.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzUser_bill.h"


@implementation MzzUser_bill

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [MzzBillCardModel class]};
}


@end


@implementation MzzBillCardModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



