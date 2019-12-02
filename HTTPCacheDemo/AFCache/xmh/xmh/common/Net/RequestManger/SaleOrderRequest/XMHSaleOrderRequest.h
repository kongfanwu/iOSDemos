//
//  XMHSaleOrderRequest.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SASaleListModel;
@class BaseModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSaleOrderRequest : NSObject

/**
 销售制单 项目列表

 @param params @[@"store_code":@"门店编码",
 @"user_id":@"用户id",
 @"type":@"类型 pro项目,goods产品,card_course特惠卡,card_num任选卡,card_time时间卡,stored_card储值卡, ticket票券"]
 @param resultBlock 列表数据
 */
+ (void)requestSaleOrderContentParams:(NSMutableDictionary *)params
                                resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/**
 销售制单 会员优惠列表

 @param params @[]
 @param resultBlock 会员优惠列表
 */
+ (void)requestSaleOrderVipDiscountParams:(NSMutableDictionary *)params
                          resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/**
  销售制单 单个卡项可用优惠卷列表

 @param params @[]
 @param resultBlock 优惠券列表
 */
+ (void)requestSaleOrderVipTicketParams:(NSMutableDictionary *)params
                              resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 奖赠内容
 */
+ (void)requestAwardContentStore_code:(NSString *)store_code type:(NSString *)type  user_id:(NSInteger)user_id resultBlock:(void(^)(SASaleListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 提交订单
 */
+ (void)summitSaleOrderParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary *dic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 固定开单 详情页
 */
+ (void)requestSalesInfoOrderNum:(NSString *)orderNum
                     resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock;



/**
 逆向开单补齐业绩提交

 @param params @[]
 @param resultBlock resultArr
 */
+ (void)requestbuYeJiMuSubmmitParams:(NSMutableDictionary *)params
                            resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 逆向开单补齐项目提交
 */

+ (void)requestniXiangBuXiangMuSubmitCartParams:(NSMutableDictionary *)params
                                    resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/**
 销售单列表数

 @param params params
 @param resultBlock result
 */
+ (void)requestSalesListNumParams:(NSMutableDictionary *)params
                      resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
  获取弹框权限
 
 @param params params
 @param resultBlock result
 */
+ (void)requestSalesListAccessAlertParams:(NSMutableDictionary *)params
                      resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end



NS_ASSUME_NONNULL_END
