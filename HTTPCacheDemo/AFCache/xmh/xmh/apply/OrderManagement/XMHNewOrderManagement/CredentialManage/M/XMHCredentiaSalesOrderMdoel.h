//
//  XMHCredentiaSalesOrderMdoel.h
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMHCredentiaOrderStateItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaSalesOrderMdoel : NSObject
/** 订单id */
@property (nonatomic, copy) NSString *ID;
/** 销售单编码 */
@property (nonatomic, copy) NSString *ordernum;
/** 开单时间 */
@property (nonatomic, copy) NSString *insert_time;
/** 订单类型描述 */
@property (nonatomic, copy) NSString *type_name;
/** 订单类型 制单类型： "1" => "固定制单", "2" => "已购置换", "3" => "个性制单", "4" => "升卡续卡", "5" => "快速开单"*/
@property (nonatomic, copy) NSString *type;
/** 订单状态描述 */
@property (nonatomic, copy) NSString *order_type_name;
/** 订单状态 1=>'待付款',10=>'已收款',5=>'未付清','6'=>'已完成'*/
@property (nonatomic, copy) NSString *order_type;
/** 开单人 */
@property (nonatomic, copy) NSString *saler;
/** 顾客姓名 */
@property (nonatomic, copy) NSString *user_name;
/** 顾客手机号 */
@property (nonatomic, copy) NSString *user_mobile;
/** 应付金额 */
@property (nonatomic, copy) NSString *heji;
/** 实付金额 */
@property (nonatomic, copy) NSString *amount;
/** 支付时间 */
@property (nonatomic, copy) NSString *pay_time;
/** 门店code */
@property (nonatomic, copy) NSString *store_code;
/** 顾客id */
@property (nonatomic, copy) NSString *user_id;
/** 开单人账号 */
@property (nonatomic, copy) NSString *inper;

@property (nonatomic, assign)NSInteger uid;
/** 回收账单 回收金额 */
@property (nonatomic, copy) NSString *huishou_amount;
/** 分享url */
@property (nonatomic, copy) NSString *share_url;
/** 是否是分享订单 默认 NO */
@property (nonatomic) BOOL share;

/**
 根据订单类型 订单状态 返回功能项集合
 */
- (NSArray <XMHCredentiaOrderStateItemModel *> *)itemsTitleFromType;

/**
    新的type类型描述
 */
- (NSString *)newTypeName;

@end

NS_ASSUME_NONNULL_END
