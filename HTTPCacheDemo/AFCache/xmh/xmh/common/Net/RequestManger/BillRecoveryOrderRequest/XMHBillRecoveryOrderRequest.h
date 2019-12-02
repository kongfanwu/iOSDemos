//
//  XMHBillRecoveryOrderRequest.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHBillRecoveryOrderRequest : NSObject


/**
 回收置换-左侧菜单栏

 @param params @[@"type":@"2"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoverySidebarParams:(NSMutableDictionary *)params
                resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/**
 回收置换-项目列表

 @param params @[@"user_id":@"用户id"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryProContentParams:(NSMutableDictionary *)params
                             resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 回收置换-票券列表
 
 @param params @[@"user_id":@"用户id"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryTicketContentParams:(NSMutableDictionary *)params
                                resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 回收置换-产品列表
 
 @param params @[@"user_id":@"用户id"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryGoodsContentParams:(NSMutableDictionary *)params
                                   resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 回收置换-储值卡列表
 
 @param params @[@"user_id":@"用户id"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryCardContentParams:(NSMutableDictionary *)params
                                  resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 回收置换-时间卡列表
 
 @param params @[@"user_id":@"用户id"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryTimeContentParams:(NSMutableDictionary *)params
                                 resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 回收置换-任选卡列表
 
 @param params @[@"user_id":@"用户id"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryOptionalCardContentParams:(NSMutableDictionary *)params
                                 resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 回收置换-确认回收
 
 @param params
 @[@"store_code":@"顾客所属门店code",
 @"heji":@"回收的金额",
 @"user_id":@"顾客的user_id",
 @"inper":@"开单人account",
 @"cart->y_award":@"回收的内容",
 @"content":@"备注信息"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryCommitParams:(NSMutableDictionary *)params
                                         resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end

NS_ASSUME_NONNULL_END
