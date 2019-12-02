//
//  ZFRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZFUserListModel,BaseModel,LSADaiFenPeiModel,LAllocationDetaiModel;
@interface ZFRequest : NSObject
{    
    NSURLSessionDataTask    *_userlistTask;
    NSURLSessionDataTask    *_yijianfenpeiTask;
    NSURLSessionDataTask    *_distriTask;
    NSURLSessionDataTask    *_daiFenPeiTask;
    NSURLSessionDataTask    *_allocationDetailTask;
}

/*
 * 智能分配-全部顾客
 */
+ (void)requestUserListParams:(NSMutableDictionary *)params resultBlock:(void(^)(ZFUserListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 全部顾客-按钮
 */
+ (void)requestYiJianFenPeiParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 全部顾客-一键分配
 */
+ (void)requestDistriParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 待分配
 */
+ (void)requerstDaiFenPeiFramId:(NSString *)framId
                           level:(NSString *)level
                           type:(NSString *)type
                           page:(NSString *)page
                       pageSize:(NSString *)pageSize
                       joinCode:(NSString *)joinCode
                              q:(NSString *)q
                           resultBlock:(void(^)(LSADaiFenPeiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestAllocationDetailUserId:(NSString *)userid
                               jis:(NSString *)jis
                               joincode:(NSString *)joincode
                               resultBlock:(void(^)(LAllocationDetaiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end
