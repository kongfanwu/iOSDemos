//
//  SLGoodListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SLGoodListModel.h"

@implementation SLGoodListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SLGoodModel class]};
}


@end


@implementation SLGoodModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    self.inputPrice = self.r_price;
    return YES;
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id", @"code" : @"goods_code"};
}

/**
 计算总价格
 单价 * 购买数量 - 礼品卷（如果有）
 */
- (CGFloat)computeTotalPrice {
    // 总价格
    CGFloat allPrice = [self computeOriginPrice];
    // model 如果有礼品卷
    if ([self.ticketModel use]) {
        // 总价减去礼品卷一个商品价格
        allPrice -= [self.inputPrice floatValue];
    }
    return allPrice;
}

/**
 计算总原价格
 单价 * 购买数量
 */
- (CGFloat)computeOriginPrice {
    CGFloat allPrice = [self.inputPrice floatValue] * self.selectCount;
    return allPrice;
}

@end



