//
//  XMHCouponModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

/*
 
 参数名    必选    类型    说明
 token account account_id
 */

#import <Foundation/Foundation.h>
#import "XMHCouponListStateItemModel.h"
#import "XMHCouponPayInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
/**
 现金券(面值)  fulfill - price   如果 fulfill 是0的时候 只展示 price
 
 折扣券(面值)  discount 折
 
 usable_type 等于 1 的时候  有效期 ：start_time - end_time
 
 usable_type 等于 2 的时候  有效期 ：领取 delay 后生效，有效期 duration 天
 */
@interface XMHCouponModel : NSObject
/** 优惠券id */
@property (nonatomic, copy)NSString *uid;
/** 优惠券名称 */
@property (nonatomic, copy)NSString *name;
/** 分享标题 【分享用】 */
@property (nonatomic, copy)NSString *share_title;
/** 品牌简称 【分享用】 */
@property (nonatomic, copy)NSString *brand;
/** 商户logo 【分享用】 */
@property (nonatomic, copy)NSString *shop_logo;
/** 链接 【分享用】 */
@property (nonatomic, copy)NSString *pic;
/** 类型 3:现金券 4：折扣券 5：礼品券 */
@property (nonatomic, copy)NSString *type;
/** 状态 1：未审核:2：审核不通过 3：未投放 4:已投放 5:已过期】 */
@property (nonatomic, copy)NSString *status;
/** 折扣 折扣券：面额】 */
@property (nonatomic, copy)NSString *discount;
/** 金额 现金券：面额 */
@property (nonatomic, copy)NSString *price;
/** 限制金额 现金券：最低消费， 折扣券：最多折扣 */
@property (nonatomic, copy)NSString *fulfill;
/** 有效期类型 1:固定时间 2：延迟天数 */
@property (nonatomic, copy)NSString *usable_type;
/** 有效期开始时间 */
@property (nonatomic, copy)NSString *start_time;
/** 有效期结束时间 */
@property (nonatomic, copy)NSString *end_time;
/** 有效期 */
@property (nonatomic, copy)NSString *duration;
/** 多少天后生效 */
@property (nonatomic, copy)NSString *delay;
/** 添加时间 */
@property (nonatomic, copy)NSString *insert_time;
/** 剩余数量 */
@property (nonatomic, copy)NSString *remain_num;

/** 库存数量 */
@property (nonatomic, copy) NSString *store_num;

/** 默认0：读取 ， 1：保存 */
@property (nonatomic, copy) NSString *isSave;
/** 商家 */
@property (nonatomic, copy) NSString *join_code;
/** 门店 */
@property (nonatomic, copy) NSString *store_codes;
/** 券副标题 */
@property (nonatomic, copy) NSString *sub_title;
/** 使用说明 */
@property (nonatomic, copy) NSString *description;
/** 客服电话 */
@property (nonatomic, copy) NSString *conatact_tel;
/** 限制类型(1:可转赠/可自己使用 2：不可转赠/可自己使用 3: 可转赠//初始领取人不可使用) */
@property (nonatomic, copy) NSString *limit_type;
/** 发放限制 */
@property (nonatomic, copy) NSString *purview;
/** 下线原因 */
@property (nonatomic, copy) NSString *reason;
/** 规则 */
@property (nonatomic, copy) NSString *rules;
/** 是否选择 */
@property (nonatomic, assign)BOOL selected;

/** 会员等级 */
@property (nonatomic, copy) NSString *vipLevel;
/** 订单商品 */
@property (nonatomic, copy) NSString *orderGoods;
/** 使用渠道 */
@property (nonatomic, copy) NSString *platform;
/** 支付使用 */
@property (nonatomic, copy) NSString *pay;
/** 支付详情 */
@property (nonatomic, strong) XMHCouponPayInfoModel *payModel;

/** 其他数据 */
//@property (nonatomic, strong) NSArray *storeDataArray;
@property (nonatomic, strong) NSArray *vipDataArray;
@property (nonatomic, strong) NSArray *orderDataArray;
@property (nonatomic, strong) NSArray *platformDataArray;
@property (nonatomic, strong) NSArray *payDataArray;

/** ----------智能助手添加字段-----------*/
/** 赠送张数 */
@property (nonatomic, copy) NSString *fa_num;
/** 使用张数 */
@property (nonatomic, copy) NSString *zhi_num;
@property (nonatomic, assign) NSInteger is_limit_store;

/**-----------end---------------------*/

/**
 优惠券类型转枚举
 */
- (XMHActionCouponType)couponType;


/**
 根据 投放状态 返回功能项集合
 */
- (NSArray <XMHCouponListStateItemModel *> *)itemsTitleFromType;


/**
 根据 优惠券type 返回优惠券类型
 */
- (NSString *)couponName;

/**
 根据 优惠券status 返回状态
 */
- (NSString *)couponStatus;

/**
 根据 优惠券有效期类型 返回有效期
 */
- (NSString *)couponUseableType;
/**
 根据 优惠券类型 返回面额
 */
- (NSString *)couponDenomination;

/**
 寻找规则下的类型
 
 @param type 0 会员等级 1 订单商品 2 使用渠道 5 支付使用
 @param rules 服务返回的
 @return 类型dic
 */
+ (NSDictionary *)getRulesType:(NSInteger)type rules:(NSArray *)rules;
@end

NS_ASSUME_NONNULL_END
