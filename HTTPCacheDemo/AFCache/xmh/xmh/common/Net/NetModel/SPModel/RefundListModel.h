//
//  RefundListModel.h
//  xmh
//
//  Created by ald_ios on 2018/11/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RefundModel;
@interface RefundListModel : NSObject
/** 项目*/
@property (nonatomic, copy) NSArray <RefundModel *> *pro;
/** 产品 */
@property (nonatomic, copy) NSArray <RefundModel *> *goods;
/** 任选卡 */
@property (nonatomic, copy) NSArray <RefundModel *> *card_num;
/** 时间卡 */
@property (nonatomic, copy) NSArray <RefundModel *> *card_time;
/** 票券 */
@property (nonatomic, copy) NSArray <RefundModel *> *ticket;
/** 账户 */
@property (nonatomic, copy) NSArray <RefundModel *> *bank;
/** 储值卡 */
@property (nonatomic, copy) NSArray <RefundModel *> *stored_card;
/** 定金订单 */
@property (nonatomic, copy) NSArray <RefundModel *> *sales;
@property (nonatomic, copy) NSArray <RefundModel *> *list;
@property (nonatomic, copy) NSString *nums;
/** 没有业绩补齐的服务单和销售单的数量 */
@property (nonatomic) BOOL yeji;
@end

@interface RefundModel : NSObject
/** 商品的编码 */
@property (nonatomic, copy) NSString *code;
/** 剩余金额 */
@property (nonatomic, copy) NSString *money;
/** 单价 */
@property (nonatomic, copy) NSString *price;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 购买的商品id */
@property (nonatomic, copy) NSString *did;
/** 商品类型 */
@property (nonatomic, copy) NSString *type;
/** 剩余的次数 */
@property (nonatomic, copy) NSString *num;
/** 截止日期 */
@property (nonatomic, copy) NSString *end_time;
/** 消耗金额 */
@property (nonatomic, copy) NSString *xiaohao;
/** 冻结金额 回收金额 一个字段 */
@property (nonatomic, copy) NSString *tk_amount;
/** 定金订单编号 */
@property (nonatomic, copy) NSString *ordernum;
/** 应付金额 */
@property (nonatomic, copy) NSString *heji;
/** 实付金额 */
@property (nonatomic, copy) NSString *amount;
/** 开单时间 */
@property (nonatomic, copy) NSString *insert_time;
/** 开单人 */
@property (nonatomic, copy) NSString *inper;
/** 开单类型 */
@property (nonatomic, copy) NSString *order_type;
/** 有效期 */
@property (nonatomic, copy) NSString *expiry;
/** 是否展开 */
@property (nonatomic, assign)BOOL showed;
/** 提交单个总价 */
@property (nonatomic, copy) NSString *paramValue;
/** 实退金额 */
@property (nonatomic, copy) NSString *actualValue;
/** 剩余次数 */
@property (nonatomic, copy) NSString *quitNum;
/** 剩余金额 */
@property (nonatomic, copy) NSString *shengyuValue;
@end
