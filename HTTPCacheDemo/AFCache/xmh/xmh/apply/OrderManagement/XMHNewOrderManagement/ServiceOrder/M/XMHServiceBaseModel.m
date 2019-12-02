//
//  XMHServiceBaseModel.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceBaseModel.h"

@implementation XMHServiceBaseModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.is_end = NO;
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id",
             @"serviceType" : @[@"serviceType", @"type"] };
}

//+ (NSDictionary *)modelCustomPropertyMapper {
//    NSMutableDictionary *dic = NSMutableDictionary.new;
//    if ([super respondsToSelector:@selector(modelCustomPropertyMapper)]) {
//        [dic addEntriesFromDictionary:[super modelCustomPropertyMapper]];
//    }
//    [dic addEntriesFromDictionary:@{@"ID" : @"id",
//                                    @"serviceType" : @[@"serviceType", @"type"] }];
//    return dic;
//}


/**
 计算总价格
 单价 * 购买数量 - 礼品卷（如果有）
 */
- (CGFloat)computeTotalPrice {
    return 0;
}

/**
 重置绑定的技师 购买数量
 selectCount 属性
 */
- (void)reset {
    [self.jiShiList removeAllObjects];
}

- (NSMutableArray *)jiShiList {
    if (_jiShiList) return _jiShiList;
    _jiShiList = NSMutableArray.new;
    return _jiShiList;
}

/**
 服务类型转字符串
 
 @return 服务类型描述
 */
- (NSString *)stringFromType {
    // 服务端返回的类型判断
    if (!IsEmpty(_serviceType)) {
        return [self stringFromServiceType];
    }
    // 本地处理的类型
    switch (self.type) {
        case XMHServiceOrderTypeChuFang: {
            return @"处方服务";
            break;
        }
        case XMHServiceOrderTypeProject: {
            return @"项目服务";
            break;
        }
        case XMHServiceOrderTypeGoods: {
            return @"产品服务";
            break;
        }
        case XMHServiceOrderTypeTiKaStordeCar:
        case XMHServiceOrderTypeTiKaNumCar:
        case XMHServiceOrderTypeTiKaTimeCar:
            return @"提卡服务";
            break;
        default:
            return @"";
            break;
    }
    return @"";
}

- (NSString *)stringFromServiceType {
    //pres 项目类型数据来源:appo_pro预约项目，appo_pres预约处方，pres处方，stored_card储值卡，card_num任选卡，card_time时间卡,card_course疗程卡,rec_pro购买项目，rec_goods购买产品，pro项目,goods产品，course_exper疗程卡里的体验礼包 新增 appo_goods 预约产品
    NSString *type = nil;
    if ([_serviceType isEqualToString:@"appo_pro"]) {
        type = @"预约项目";
    } else if ([_serviceType isEqualToString:@"appo_pres"]) {
        type = @"预约处方";
    } else if ([_serviceType isEqualToString:@"pres"]) {
        type = @"处方";
    } else if ([_serviceType isEqualToString:@"stored_card"]) {
        type = @"储值卡";
    } else if ([_serviceType isEqualToString:@"card_num"]) {
        type = @"任选卡";
    } else if ([_serviceType isEqualToString:@"card_time"]) {
        type = @"时间卡";
    } else if ([_serviceType isEqualToString:@"card_course"]) {
        type = @"疗程卡";
    } else if ([_serviceType isEqualToString:@"rec_pro"]) {
        type = @"购买项目";
    } else if ([_serviceType isEqualToString:@"rec_goods"]) {
        type = @"购买产品";
    } else if ([_serviceType isEqualToString:@"pro"]) {
        type = @"项目";
    } else if ([_serviceType isEqualToString:@"goods"]) {
        type = @"产品";
    } else if ([_serviceType isEqualToString:@"course_exper"]) {
        type = @"体验礼包";
    } else if ([_serviceType isEqualToString:@"appo_goods"]) {
        type = @"预约产品";
    }
    return type;
}

@end
