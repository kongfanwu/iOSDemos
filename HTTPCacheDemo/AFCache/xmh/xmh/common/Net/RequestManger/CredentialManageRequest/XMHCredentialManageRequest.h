//
//  XMHCredentialManageRequest.h
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Networking.h"
#import "MzzHud.h"
#import "BaseModel.h"

#import "XMHCredentiaItemModel.h"
#import "XMHShopModel.h"
#import "XMHCredentiaSalesOrderMdoel.h"
#import "XMHCredentiaServiceOrderMdoel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentialManageRequest : NSObject
/**
 服务八统
 */
+ (void)requestServiceTongJiParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 销售八统
 */
+ (void)requestSalesTongJiParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 销售 服务 八统
 */
+ (void)requestSalesServiceTongJiParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSArray <XMHCredentiaItemModel *> *salesModelArray, NSArray <XMHCredentiaItemModel *> *serviceModelArray, BOOL isSuccess))resultBlock;

/**
 门店列表 列表管理层
 */
+ (void)requestManagersListParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSArray <XMHShopModel *> *modelArray, BOOL isSuccess))resultBlock;

/**
 订单管理 - 获取销售列表
 */
+ (void)requestSaleListParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSArray <XMHCredentiaSalesOrderMdoel *> *modelArray, BOOL isSuccess))resultBlock;

/**
 订单管理 - 获取服务列表
 */
+ (void)requestServiceListParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSArray <XMHCredentiaServiceOrderMdoel *> *modelArray, BOOL isSuccess))resultBlock;

/**
 八统---销售业绩列表
 */
+ (void)requestSalesYeJiListParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock;

/**
 配合消费
 */
+ (void)requestSalesCooperateParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock;

/**
 配合耗卡
 */
+ (void)requestServiceCooperateParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock;

/**
 八统---退款金额列表
 */
+ (void)requestSalesTuiKuanLiatParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock;

@end

NS_ASSUME_NONNULL_END
