//
//  LanternRequest.h
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "LanternRecommedListModel.h"
#import "LanternHistoryPlanListModel.h"
#import "LanternPlanInfoListModel.h"
@class MzzTagDatas;

@interface LanternRequest : NSObject
{
    NSURLSessionDataTask * _recommendListTask;
    NSURLSessionDataTask * _historyPlanTask;
    NSURLSessionDataTask * _newMsgListTask;
    NSURLSessionDataTask * _planListTask;
    NSURLSessionDataTask * _AddmakePlanTask;
    NSURLSessionDataTask * _commonTask;
}
+ (void)requestRecommendData:(NSMutableDictionary *)param resultBlock:(void(^)(LanternRecommedListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestHistoryPlan:(NSMutableDictionary *)param resultBlock:(void(^)(LanternHistoryPlanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 *  生成销售计划首页
 */
+ (void)requestPlanData:(NSMutableDictionary *)params resultBlock:(void(^)(MzzTagDatas *lolCalendarModelList, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 *  添加修改计划
 */
+ (void)requestAddmakePlanData:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 *  生成计划首页
 */
+ (void)requestPlanInfoData:(NSMutableDictionary *)params resultBlock:(void(^)(LanternPlanInfoListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 *  生成计划首页
 */
+ (void)requestSaleGoodsData:(NSMutableDictionary *)params resultBlock:(void(^)(LanternPlanInfoListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end
