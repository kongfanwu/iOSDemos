//
//  XMHExperienceOrderRequest.h
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLS_ProModel, SLGoodListModel, SLSCourseExper, XMHTicketModel, BaseModel, SLOrderNumModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHExperienceOrderRequest : NSObject
{
    NSURLSessionDataTask *_projectTask;
    NSURLSessionDataTask *_goodsTask;
    NSURLSessionDataTask *_experTask;
    NSURLSessionDataTask *_baseTicketTask;
    NSURLSessionDataTask *_createOrderTask;
    NSURLSessionDataTask *_repairTask;
    NSURLSessionDataTask *_servInfoTask;
}

/**
 获取项目服务
 */
+ (void)requestProjectUserId:(NSString *)userId resultBlock:(void(^)(SLS_ProModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 获取产品服务
 */
+ (void)requestGoodsUserId:(NSString *)userId resultBlock:(void(^)(SLGoodListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 获取体验服务
 */
+ (void)requestCourseUserId:(NSString *)userId resultBlock:(void(^)(SLSCourseExper *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 获取项目服务，产品服务， 体验服务数据
 */
+ (void)requestProjectGoodsCourseUserId:(NSString *)userId resultBlock:(void(^)(BOOL isSuccess, SLS_ProModel *projectModel, SLGoodListModel *goodModel, SLSCourseExper *experienceModel))block;

/**
 销售服务单获取礼品券
 */
+ (void)requestSellProTicketParam:(NSMutableDictionary *)params resultBlock:(void(^)(NSArray <XMHTicketModel *>*modelArray, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 服务制单和体验制单开单
 */
+ (void)requestCreateOrderParam:(NSMutableDictionary *)params resultBlock:(void(^)(SLOrderNumModel *orderNumModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 服务单和销售服务单详情页
 */
+ (void)requestServInfoParam:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 补齐业绩
 */
+ (void)requestRepairParam:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 固定开单-详情页
 */
+ (void)requestSalesInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock;

/**
 绑定技师-服务制单，销售制单，体验制单，技师开完单绑定技师
 */
+ (void)requestBangJisParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock;
@end

NS_ASSUME_NONNULL_END
