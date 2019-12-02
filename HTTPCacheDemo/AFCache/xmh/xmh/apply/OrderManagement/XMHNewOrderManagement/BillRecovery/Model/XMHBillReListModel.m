//
//  XMHBillReProListModel.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBillReListModel.h"
#import "XMHShoppingCartManager.h"

@implementation XMHBillReListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [XMHBillReProModel class]};
    
}
@end

@implementation XMHBillReGoodsListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [XMHBillReGoodsModel class]};
    
}
@end

@implementation XMHBillReCardListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [XMHBillReCardModel class]};
    
}
@end

@implementation XMHBillReTimeListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [XMHBillReTimeModel class]};
    
}
@end

@implementation XMHBillReNumCardListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [XMHBillReNumCardModel class]};
    
}
@end

@implementation XMHBillReTicketListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [XMHBillReTicketModel class]};
    
}

@end

/**-------       model类            -------------------------------**/
@implementation XMHBillReProModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id",@"num":@"nums",@"ID":@"id"};
}

- (instancetype)init
{
    self = [super init];
    if (self) {//默认次数
        self.recoverType = XMHBillRecoverTypePro;
    }
    return self;
}

/**
 计算总价格
 单价 * 购买数量
 */
- (CGFloat)computeTotalPrice {
    // 总价格
    CGFloat allPrice = 0;
   
    allPrice = [self.price floatValue] * self.selectCount;
    
    return allPrice;
}
- (CGFloat)computeShengyuPrice{

    CGFloat allPrice = 0;
    
    allPrice = [self.money floatValue] - [XMHShoppingCartManager.sharedInstance recoverPriceShoppingCartBaseModel:self];
    if (allPrice <= 0) {
        allPrice = 0;
    }
    
    return allPrice;
}
- (void)reset {
    [super reset];
}
@end

@implementation XMHBillReGoodsModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id",@"num":@"nums",@"ID":@"id"};
}
- (instancetype)init
{
    self = [super init];
    if (self) {//默认次数
        self.recoverType = XMHBillRecoverTypeGoods;
    }
    return self;
}

/**
 计算总价格
 单价 * 购买数量
 */
- (CGFloat)computeTotalPrice {
//    // 总价格
    CGFloat allPrice = 0;

    if ([self.inputPrice floatValue] > [self.price floatValue] ||
        [self.inputPrice floatValue] < [self.price floatValue] ) {  //即不相等的情况
        
    }
    return allPrice;

}
- (CGFloat)computeShengyuPrice{
    CGFloat allPrice = 0;
    allPrice = [self.money floatValue] - [XMHShoppingCartManager.sharedInstance recoverPriceShoppingCartBaseModel:self];
    if (allPrice <= 0) {
        allPrice = 0;
    }
    return allPrice;
}

- (void)reset {
    [super reset];
   
}
@end

// 储值卡
@implementation XMHBillReCardModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"num":@"nums",@"ID":@"user_card_id"};
}
- (instancetype)init
{
    self = [super init];
    if (self) {//默认次数
        self.nums = [NSString stringWithFormat:@"1"];
        self.recoverType = XMHBillRecoverTypeStordeCar;
        self.inputPrice = self.money;
    }
    return self;
}
/**
 计算总价格
 */
- (CGFloat)computeTotalPrice
{
    return [self.inputPrice floatValue];
}
- (CGFloat)computeShengyuPrice
{
    if ([self.money floatValue] != 0) {
        return [self.money floatValue] - [XMHShoppingCartManager.sharedInstance recoverPriceShoppingCartBaseModel:self];
    }else{
        return [self.money floatValue];
    }
}
- (void)reset {
    [super reset];
    self.cartNum = 0;
}

@end

//任选l卡
@implementation XMHBillReNumCardModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id",@"num":@"nums",@"ID":@"id"};
}
- (instancetype)init
{
    self = [super init];
    if (self) {//默认次数
        
        self.recoverType = XMHBillRecoverTypeNumCar;
        self.allRecover = 0;

    }
    return self;
}
/**
计算总价格
单价 * 购买数量
*/
- (CGFloat)computeTotalPrice {
    // 总价格
    CGFloat allPrice = 0;
   
    allPrice = [self.price floatValue] * self.selectCount;
    
    return allPrice;
}

- (CGFloat)computeShengyuPrice{
    CGFloat allPrice = 0;
    allPrice = [self.money floatValue] - [XMHShoppingCartManager.sharedInstance recoverPriceShoppingCartBaseModel:self];

    return allPrice;
}

- (void)reset {
    [super reset];
    self.cartNum = 0;
}
@end

// 时间卡
@implementation XMHBillReTimeModel

- (instancetype)init
{
    self = [super init];
    if (self) {//默认次数
        self.nums = [NSString stringWithFormat:@"1"];
        self.recoverType = XMHBillRecoverTypeTimeCar;
        self.inputPrice = self.price;
        self.num = [self.nums integerValue];
    }
    return self;
}
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id",@"num":@"nums",@"ID":@"id"};
}
/**
 计算总价格
 */
- (CGFloat)computeTotalPrice
{
      return [self.inputPrice floatValue];
}


/**
 计算剩余金额

 @return 剩余金额 = 总剩余金额- 回收金额
 */
- (CGFloat)computeShengyuPrice
{
    return [self.price floatValue] - [XMHShoppingCartManager.sharedInstance recoverPriceShoppingCartBaseModel:self];

}

- (void)reset {
    [super reset];
}

@end

@implementation XMHBillReTicketModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id",@"num":@"nums",@"ID":@"id"};
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.recoverType = XMHBillRecoverTypeTicket;
    }
    return self;
}
/**
 计算总价格
 单价 * 购买数量
 */
- (CGFloat)computeTotalPrice {
    // 总价格
    CGFloat allPrice = [self.price floatValue] * self.selectCount;
    return allPrice;
}
- (CGFloat)computeShengyuPrice{
    CGFloat allPrice = 0;
    allPrice = [self.money floatValue] - [XMHShoppingCartManager.sharedInstance recoverPriceShoppingCartBaseModel:self];
    return allPrice;
}
- (void)reset {
    [super reset];
    self.recoverPrice = 0;
    self.cartNum  =0;
    self.inputPrice = @"";
}
@end


