//
//  XMHShoppingCartManager.h
//  xmh
//
//  Created by KFW on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 购物车管理者

#import <Foundation/Foundation.h>
@class XMHShoppingCartBaseModel;
@class SaleModel;

// 通知key, 增、删、重新计算价格，都会触发通知
UIKIT_EXTERN NSString * _Nullable const kXMHShoppingCartUpdateNotification;
// 将要从购物车移除商品
UIKIT_EXTERN NSString * _Nullable const kXMHShoppingCartWillRemoveNotification;

NS_ASSUME_NONNULL_BEGIN

@interface XMHShoppingCartManager : NSObject

+ (instancetype)sharedInstance;

/** 数据源 */
@property (nonatomic, strong, readonly) NSMutableArray *dataArray;
/** 优惠后价格 */
@property (nonatomic) CGFloat allPrice;
/** 原价格 */
@property (nonatomic) CGFloat originPrice;
/** 提卡金额。体验卡商品总金额，包括项目 产品 */
@property (nonatomic) CGFloat tiKaPrice;
/** 购物车中优惠券 */
@property (nonatomic, strong, readonly) NSMutableArray *ticketArray;

/**
 添加购物车商品model
 如果重复添加会失败，但会更新价格。也可主动性的更新价格 updatePrice
 
 @param model 特指4种类型。项目 SLS_Pro 产品 SLGoodModel 体验服务-项目 SLPro_ListM 体验服务-产品 SLGoods_ListM
 */
- (void)addModel:(id)model;

/**
 移除商品
 
 @param model 特指4种类型。项目 SLS_Pro 产品 SLGoodModel 体验服务-项目 SLPro_ListM 体验服务-产品 SLGoods_ListM
 */
- (void)deleteModel:(id)model;

/**
 移除所有
 */
- (void)clear;

/**
 计算价格.计算完会发送通知
 */
- (void)computePrice;

/**
 返回最大可购买数量
 根据shoppingCartBaseModel code。获取购物车相同code 商品model。 selectCount 累加。 减去累加后的商品数量。返回最大可购买数量
 
 @param shoppingCartBaseModel 要购买商品model
 @return 返回最大可购买数量 NSIntegerMax：不存在最大购买数量 0:购买数量超过了最大购买量
 */
- (NSInteger)maxNumShoppingCartBaseModel:(XMHShoppingCartBaseModel *)shoppingCartBaseModel;


/**
 返回最大可购买数量(回收置换有可能剩余数量为0的情况,增加方法)
 根据shoppingCartBaseModel code。获取购物车相同code 商品model。 selectCount 累加。 减去累加后的商品数量。返回最大可购买数量
 
 @param shoppingCartBaseModel 要购买商品model
 @return 返回最大可购买数量
 */
- (NSInteger)maxNumShoppingCartBillRecoverBaseModel:(XMHShoppingCartBaseModel *)shoppingCartBaseModel;


/**
 返回回收的金额 单价*数量 数量为0还有剩余金额时,点击回收金额回收
 根据shoppingCartBaseModel code。获取购物车相同code 商品model
 
 @param shoppingCartBaseModel 要购买商品model
 @return 返回回收的金额
 */
- (CGFloat)recoverPriceShoppingCartBaseModel:(XMHShoppingCartBaseModel *)shoppingCartBaseModel;


/**
 返回已选的优惠券,用于过滤

 @param saleModel SaleModel description
 @return 返回已选的优惠券数组
 */
- (NSMutableArray *)selectedTicketArrsBaseModel:(SaleModel *)saleModel;

@end

NS_ASSUME_NONNULL_END
