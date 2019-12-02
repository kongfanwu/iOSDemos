//
//  WorkRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/17.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "WorkModel.h"
#import "MzzDaiYuYueModel.h"
#import "MzzDaiShenPiModel.h"
#import "MzzDaiFuWuModel.h"
#import "MzzDaiGenJinModel.h"
#import "MzzWorkListModel.h"
#import "MzzWordManagerModel.h"
#import "WorkGreetListModel.h"
@interface WorkRequest : NSObject
{
    NSURLSessionDataTask * _jinRiTask;
    NSURLSessionDataTask * _daogouTask;
    NSURLSessionDataTask * _daiyuyueTask;
    NSURLSessionDataTask * _daishenpiTask;
    NSURLSessionDataTask * _daifuwuTask;
    NSURLSessionDataTask * _daigenjinTask;
    NSURLSessionDataTask * _workListTask;
    NSURLSessionDataTask * _workList;
    NSURLSessionDataTask * _greetList;
    NSURLSessionDataTask * _guanggaoList;
    NSURLSessionDataTask * _joinCodeStateTask;

}

/**
 * 会工作头部数据接口
 */
+ (void)requestWorkHeard:(NSString *)joinCode
                     framId:(NSString *)framId
                    account:(NSString *)account
                resultBlock:(void(^)(WorkModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 会工作导购
 */
+ (void)requestWorkJoinCode:(NSString *)joinCode
                 functionId:(NSString *)functionId
                     framId:(NSString *)framId
                        uid:(NSString *)uid
                       time:(NSString *)time
                    account:(NSString *)account
                resultBlock:(void(^)(WorkModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 待预约
 */
+ (void)requestDaiYuYueWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiYuYueModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 待审批
 */
+ (void)requestDaiShenPiWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiShenPiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 待服务
 */
+ (void)requestDaiFuWuWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiFuWuModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 待跟进
 */
+ (void)requestDaiGenJinWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiGenJinModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 今日，本月，本季度
 */
+ (void)requestJinRiWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzWordManagerModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 列表全部
 */
+ (void)requestWorkListWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzWorkListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 引导页 图片获取
 */
+ (void)requestWorkGreetParams:(NSMutableDictionary *)params resultBlock:(void(^)(WorkGreetListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 广告 图片获取
 */
+ (void)requestWorkGuangGaoParams:(NSMutableDictionary *)params resultBlock:(void(^)(WorkGreetListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 商家品牌是否冻结
 */
+ (void)requestJoinStateParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end
