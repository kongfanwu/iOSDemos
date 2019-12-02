//
//  MzzUser_salesModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzUser_salesModel.h"

@implementation MzzUser_salesModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"ticket" : [MzzTicketModel class], @"card_time" : [MzzCard_TimeModel class], @"card_num" : [MzzCard_NumModel class], @"goods" : [MzzGoodsModel class], @"stored_card" : [MzzStored_CardModel class], @"pro" : [MzzProModel class], @"bank" : [MzzBankModel class],@"ticket_coupon" : [MzzTicketCouponModel class]};
}


@end


@implementation MzzBankModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation MzzTicketModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation MzzCard_TimeModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation MzzCard_NumModel


@end


@implementation MzzGoodsModel


@end


@implementation MzzStored_CardModel


@end


@implementation MzzProModel


@end


@implementation MzzTicketCouponModel


@end

