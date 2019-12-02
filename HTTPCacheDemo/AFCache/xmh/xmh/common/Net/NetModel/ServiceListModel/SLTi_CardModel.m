//
//  SLTi_CardModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SLTi_CardModel.h"


@implementation SLTi_CardModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"stored_card" : [SLStored_Card class], @"card_num" : [SLCard_Num class], @"card_time" : [SLCard_Time class]};
}


@end


@implementation SLStored_Card

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"pro_list" : [SLPro_List class], @"goods_list" : [SLGoods_List class]};
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation SLPro_List


@end


@implementation SLGoods_List


@end


@implementation SLCard_Num

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"pro_list" : [SLPro_List class], @"goods_list" : [SLGoods_List class]};
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end





@implementation SLCard_Time

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"pro_list" : [SLPro_List class], @"goods_list" : [SLGoods_List class]};
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end






