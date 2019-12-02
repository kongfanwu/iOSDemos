//
//  SLS_ProModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SLS_ProModel.h"



@implementation SLS_ProModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SLS_Pro class]};
}


@end


@implementation SLS_Pro

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    self.inputPrice = self.r_price;
    return YES;
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id", @"code" : @"pro_code"};
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



