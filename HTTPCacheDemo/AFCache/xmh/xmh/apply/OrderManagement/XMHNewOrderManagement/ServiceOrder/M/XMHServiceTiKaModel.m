//
//  XMHServiceTiKaModel.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceTiKaModel.h"

@implementation XMHServiceTiKaModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pro_list" : [XMHServiceProjectModel class],
             @"goods_list" : [XMHServiceGoodsModel class],
             @"stored_cardList" : [XMHStoredCard class],
             @"card_numList" : [XMHNumCard class],
             @"card_timeList" : [XMHTimeCard class],
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"stored_cardList"  : @"stored_card",
             @"card_numList"  : @"card_num",
             @"card_timeList"  : @"card_time"};
}

@end

// 储值卡
@implementation XMHStoredCard
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pro_list" : [XMHServiceProjectModel class],
             @"goods_list" : [XMHServiceGoodsModel class],
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    NSMutableDictionary *dic = NSMutableDictionary.new;
    if ([super respondsToSelector:@selector(modelCustomPropertyMapper)]) {
        [dic addEntriesFromDictionary:[super modelCustomPropertyMapper]];
    }
    [dic addEntriesFromDictionary:@{@"code" : @"stored_code",}];
    return dic;
}

@end

// 任选卡
@implementation XMHNumCard
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pro_list" : [XMHServiceProjectModel class],
             @"goods_list" : [XMHServiceGoodsModel class],
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    NSMutableDictionary *dic = NSMutableDictionary.new;
    if ([super respondsToSelector:@selector(modelCustomPropertyMapper)]) {
        [dic addEntriesFromDictionary:[super modelCustomPropertyMapper]];
    }
    [dic addEntriesFromDictionary:@{@"code" : @"card_num_code",}];
    return dic;
}
@end

// 时间卡
@implementation XMHTimeCard
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pro_list" : [XMHServiceProjectModel class],
             @"goods_list" : [XMHServiceGoodsModel class],
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    NSMutableDictionary *dic = NSMutableDictionary.new;
    if ([super respondsToSelector:@selector(modelCustomPropertyMapper)]) {
        [dic addEntriesFromDictionary:[super modelCustomPropertyMapper]];
    }
    [dic addEntriesFromDictionary:@{@"code" : @"card_time_code",}];
    return dic;
}
@end
