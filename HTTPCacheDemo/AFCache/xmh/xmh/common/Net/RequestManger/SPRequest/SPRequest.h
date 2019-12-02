//
//  SPRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/29.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPGetNumModel,SPSearchUserModel,SPCongealModel,SPGetStoreModel,SPSearchStoreUserModel,SPChangeStoreModel,SPGetTdPersonModel,SPGetStoresModel,BaseModel;
@interface SPRequest : NSObject
{
    NSURLSessionDataTask    *_getNumTask;
    NSURLSessionDataTask    *_searchUserTask;
    NSURLSessionDataTask    *_congealTask;
    NSURLSessionDataTask    *_getStoreTask;
    NSURLSessionDataTask    *_searchStoreTask;
    NSURLSessionDataTask    *_changeStoreTask;
    NSURLSessionDataTask    *_getTdPersonTask;
    NSURLSessionDataTask    *_getStoresTask;
    NSURLSessionDataTask    *_postChangeStoreTask;
}
/*
 * 获得待我、抄送审批的未读数量
 */
+ (void)requestGetNumParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetNumModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

//获得某人发起的审批记录

/*
 * 搜索顾客
 */
+ (void)requestSearchUserParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPSearchUserModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 会员冻结发起审批
 */
+ (void)requestCongealUserParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPCongealModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 获得管理的门店
 */
+ (void)requestGetStoreParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetStoreModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 按门店搜索顾客
 */
+ (void)requestSearchStoreUserParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPSearchStoreUserModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 顾客调店发起页面
 */
+ (void)requestChangeStoreParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPChangeStoreModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 顾客调店获得审批人和抄送人
 */
+ (void)requestgetTdPersonParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetTdPersonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 调出门店获得这个商家所有的门店
 */
+ (void)requestgetStoresParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetStoresModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 顾客调店审批提交
 */
+ (void)requestPostChangeStoreParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

@end
