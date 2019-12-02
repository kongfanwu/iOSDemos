//
//  XMHCredentiaServiceOrderMdoel.h
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMHCredentiaOrderStateItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaServiceOrderMdoel : NSObject

/** 订单id */
@property (nonatomic, copy) NSString *ID;
/** 服务单号 */
@property (nonatomic, copy) NSString *ordernum;
/** 服务单状态  1待结算，2已结算，3已完成*/
@property (nonatomic, copy) NSString *zt;
/** 开单人账号 */
@property (nonatomic, copy) NSString *inper;
/** 服务单类型 0服务单，1销售服务单（体验制单）*/
@property (nonatomic, copy) NSString *type;
/** 开单时间 */
@property (nonatomic, copy) NSString *stime;
/** 顾客id */
@property (nonatomic, copy) NSString *user_id;
/** 服务业绩 */
@property (nonatomic, copy) NSString *z_price;
/** 结算时间 */
@property (nonatomic, copy) NSString *etime;
/** 状态名称 */
@property (nonatomic, copy) NSString *zt_name;
/** 开单类型 */
@property (nonatomic, copy) NSString *type_name;
/** 开单人 */
@property (nonatomic, copy) NSString *inper_name;
/** 顾客姓名 */
@property (nonatomic, copy) NSString *user_name;
/** 顾客手机号 */
@property (nonatomic, copy) NSString *mobile;
/** 是否有服务记录，1有，0没有（显示服务记录按钮） ================================2018.11.14 */
@property (nonatomic, copy) NSString *img;
/** 项目名称 */
@property (nonatomic, strong) NSArray <NSString *> *pro_list;
/** 产品名称 */
@property (nonatomic, strong) NSArray <NSString *> *goods_list;
/** 门店code */
@property (nonatomic, copy) NSString *store_code;

/**
 根据订单类型 订单状态 返回功能项集合
 */
- (NSArray <XMHCredentiaOrderStateItemModel *> *)itemsTitleFromType;

/**
 拼接项目名称
 
 @param model model
 @return 拼接后的字符串
 */
+ (NSString *)proNameStr:(XMHCredentiaServiceOrderMdoel *)model;

@end

NS_ASSUME_NONNULL_END
