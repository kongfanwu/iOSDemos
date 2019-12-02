//
//  SASaleListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SASaleListModel.h"
@implementation SASaleListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SaleModel class]};
}
@end


@implementation SaleModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id",@"ID":@"id",@"cardType":@"type"};
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self.cardType isEqualToString:@"skxk"]) {
            self.inputPrice = self.money; 
        }else if ([self.cardType isEqualToString:@"pro"]){
            self.courseIndex = 0;
            self.coursePriceArr = [NSMutableArray array];
            self.courseNumArr = [NSMutableArray array];
            // 疗程次数
            //单次零售价
            NSMutableArray *courseNumArr = [NSMutableArray array];
            [courseNumArr safeAddObject:self.price_list.pro_11.num];
            //疗程成交价
            NSArray *arrNum = [self.price_list.pro_21.num componentsSeparatedByString:@","];
            [courseNumArr safeAddObjectsFromArray:arrNum];
            self.courseNumArr = courseNumArr;
            //单次零售价
            NSMutableArray *coursePriceArr = [NSMutableArray array];
            [coursePriceArr safeAddObject:self.price_list.pro_11.price];
            //疗程成交价
            NSArray *lingShouArr = [self.price_list.pro_21.price componentsSeparatedByString:@","];
            [coursePriceArr safeAddObjectsFromArray:lingShouArr];
            self.coursePriceArr = coursePriceArr;

            self.inputPrice = [self.coursePriceArr safeObjectAtIndex:0];
        }else if ([self.cardType isEqualToString:@"goods"]){
            self.inputPrice = self.price_list.pro_11.price;
        }else if ([self.cardType isEqualToString:@"card_course"]){//特惠卡
             self.inputPrice = self.price_list.pro_11.price;
        }else if ([self.cardType isEqualToString:@"card_num"]){//任选卡
            
        }else if ([self.cardType isEqualToString:@"stored_card"]){//储值卡
             self.inputPrice = self.price_list.pro_10.price;
        }else if ([self.cardType isEqualToString:@"card_time"]){//时间卡
            self.inputPrice = self.price_list.pro_11.price;
        }else if ([self.cardType isEqualToString:@"ticket"]){//票券
            self.inputPrice = self.price_list.pro_11.price;
        }
    }
    return self;
}

/**
 计算总价格
 */
- (CGFloat)computeTotalPrice
{
    CGFloat allPrice = 0;
    
    if ([self.cardType isEqualToString:@"skxk"]) {
         allPrice =  [self.inputPrice floatValue] ;
    }else if ([self.cardType isEqualToString:@"pro"]){
         allPrice =  [self computeZhekouTotalPrice];
    }else if ([self.cardType isEqualToString:@"goods"]){
        allPrice =  [self computeZhekouTotalPrice];
    }else if ([self.cardType isEqualToString:@"card_course"]){//特惠卡
       allPrice =  [self.inputPrice floatValue] * self.selectCount;
    }else if ([self.cardType isEqualToString:@"card_num"]){//任选卡
        allPrice =  [self.inputPrice floatValue] * self.selectCount;
    }else if ([self.cardType isEqualToString:@"stored_card"]){//储值卡
       allPrice =  [self.inputPrice floatValue] * self.selectCount;
    }else if ([self.cardType isEqualToString:@"card_time"]){//时间卡
        allPrice =  [self.inputPrice floatValue] * self.selectCount;
    }else if ([self.cardType isEqualToString:@"ticket"]){//票券
        allPrice =  [self.inputPrice floatValue] * self.selectCount;
    }
    
    return allPrice;
}


/**
 计算选择优惠券后的价格
 */
- (CGFloat)computeZhekouTotalPrice
{
    CGFloat allPrice = 0;
    // 总价计算
    CGFloat totalPrice = [self.inputPrice floatValue] * self.selectCount;
    
    if (self.staicketModel.selected && self.staicketModel){
        // 第三种情况:有优惠券 总价= num * 优惠券价格 优惠券分三种
        if (self.staicketModel.type == 1) {
            
            totalPrice = totalPrice - [self.staicketModel.money floatValue];
            if (totalPrice < 0) {
                totalPrice = 0;
            }
        }else if (self.staicketModel.type == 3){
            
            if(totalPrice >= [self.staicketModel.fulfill floatValue]){
                totalPrice = totalPrice - [self.staicketModel.price floatValue];
                if (totalPrice < 0) {
                    totalPrice = 0;
                }
            }
        }else if (self.staicketModel.type == 4){
            
            CGFloat tempDi = 0.0f; /** 抵用券的钱 */
            tempDi = totalPrice * (1 - [self.staicketModel.discount floatValue] / 10);
            if ((tempDi >= self.staicketModel.fulfill.floatValue) && (self.staicketModel.fulfill.floatValue > 0)) {
                tempDi = self.staicketModel.fulfill.floatValue;
            }
            totalPrice = totalPrice - tempDi;
            if (totalPrice<0) {
                totalPrice = 0;
            }
        }
        
    }
    allPrice = allPrice + totalPrice;
    return allPrice;
}
/**
 重置model
 */
- (void)reset
{
    [super reset];
    self.sastoreCardModel = nil;
    self.staicketModel = nil;
}

@end

@implementation PriceListModel

@end
@implementation SaleSubModel

@end
