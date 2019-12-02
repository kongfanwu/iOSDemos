//
//  XMHShoppingCartBaseModel.h
//  xmh
//
//  Created by KFW on 2019/4/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 购物车基类model

#import <Foundation/Foundation.h>
@class SATicketModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHShoppingCartBaseModel : NSObject

/** 产品、项目、各种卡 code
 *  注意：继承此类的子类。要设置此字段。
 */
/** 唯一id = ID + code */
@property (nonatomic, copy) NSString *id_code;
@property (nonatomic, copy) NSString *code;
/** 产品、项目、各种卡 ID */
@property (nonatomic, copy) NSString *ID;
/** 购物唯一id  = 产品code + 产品ID + 时间戳 */
@property (nonatomic, copy) NSString *shoppingId;
/** 默认购买数量 默认值 1 */
@property (nonatomic, assign) NSInteger defaultNum;
/** 购买数量 默认 defaultNum */
@property (nonatomic) NSInteger selectCount;
/** 剩余数量 */
@property (nonatomic, assign) NSInteger num;
/** 剩余数量 变动值*/
@property (nonatomic, assign) NSInteger numUpdate;
/** 特惠卡code */
@property (nonatomic, copy) NSString *course_code;

/** 创建订单类型 */
@property (nonatomic) XMHCreateOrderType createOrderType;
/** 服务类型 */
@property (nonatomic) XMHServiceOrderType type;

/**
 更新购物唯一id。使用场景：如想加入到购物车，先做mutableCopy操作，在调用 updateShoppingId 更新 shoppingId 属性。
 子类重写
 */
- (void)updateShoppingId;

/**
 重置model
 */
- (void)reset;

/**
 剩余金额.回收置换
 */
- (CGFloat)computeShengyuPrice;


+ (NSDictionary *)modelCustomPropertyMapper;
/**
 是否全部回收
 */
@property (nonatomic,assign) NSInteger allRe;
@end

NS_ASSUME_NONNULL_END
