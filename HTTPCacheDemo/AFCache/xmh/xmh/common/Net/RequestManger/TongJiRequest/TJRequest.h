//
//  TJRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "WorkModel.h"
#import "TJYeJiListModel.h"
@class TJTopModel,TJYeJiListModel,XiaoHaoTopModel,FuZhaiTopModel,TJGuKeTopModel,TJCardTopModel,TJCardListModel,TJGuKeListModel,TJBBTopModel,TJBBListModel,TJCustomerTopModel,TJCustomerListModel,TJStoreListModel,TJStaffDetailModel,CustomerGradeListModel,TJGradeListModel,TJCustomerActiveTopModel,TJCustomerActiveListModel,TJCustomerActiveDetailModel,TJExpendTopModel,TJExpendListModel,TJCashListModel,TJCashTopModel,CustomerRetainTopModel,CustomerRetainListModel;
@interface TJRequest : NSObject
{
     NSURLSessionDataTask * _topTask;
     NSURLSessionDataTask * _listTask;
     NSURLSessionDataTask * _fuZhaiTopTask;
     NSURLSessionDataTask * _xiaoHaoTopTask;
     NSURLSessionDataTask * _guKeTopTask;
     NSURLSessionDataTask * _guKeListTask;
     NSURLSessionDataTask * _cardTopTask;
     NSURLSessionDataTask * _cardSearchTask;
     NSURLSessionDataTask * _bbTopTask;
     NSURLSessionDataTask * _bbListTask;
     NSURLSessionDataTask * _customerTopTask;
     NSURLSessionDataTask * _customerListTask;
     NSURLSessionDataTask * _customerStoreTask;
     NSURLSessionDataTask * _staffDetailTask;
     NSURLSessionDataTask * _customerGradeListTask;
     NSURLSessionDataTask * _customerGradeTask;
     NSURLSessionDataTask * _customerActiveTopTask;
     NSURLSessionDataTask * _customerActiveListTask;
     NSURLSessionDataTask * _customerActiveDetailTask;
     NSURLSessionDataTask * _expendTopTask;
     NSURLSessionDataTask * _expendListTask;
     NSURLSessionDataTask * _cashTopTask;
     NSURLSessionDataTask * _cashListTask;
     NSURLSessionDataTask * _customerRetainListTask;
     NSURLSessionDataTask * _customerRetainTopTask;
     NSURLSessionDataTask * _commonTask;
}
/**
 * 业绩统计头部数据
 */
+ (void)requestYejiTopOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                   resultBlock:(void(^)(TJTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 业绩统计列表数据
 */
//+ (void)requestYejiTopOneClick:(NSString *)oneClick
//                      twoClick:(NSString *)twoClick
//                     twoListId:(NSString *)twoListId
//                          inId:(NSString *)inId
//                      joinCode:(NSString *)joinCode
//                     startTime:(NSString *)startTime
//                       endTime:(NSString *)endTime
//                          type:(NSString *)type
//                   resultBlock:(void(^)(TJYeJiListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 负债 头部5块数据
 */
+ (void)requestFuZhaiTopOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                     resultBlock:(void(^)(FuZhaiTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 消耗头部数据
 */
+ (void)requestXiaoHaoTopOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                   resultBlock:(void(^)(XiaoHaoTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 顾客统计头部数据
 */
+ (void)requestGukeTopOneClick:(NSString *)oneClick
                         twoClick:(NSString *)twoClick
                        twoListId:(NSString *)twoListId
                             inId:(NSString *)inId
                         joinCode:(NSString *)joinCode
                        startTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                      resultBlock:(void(^)(TJGuKeTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 顾客统计列表数据
 */
+ (void)requestGukeListOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                        endTime:(NSString *)endTime
                       cardType:(NSString *)cardType
                      orderType:(NSString *)orderType
                   resultBlock:(void(^)(TJGuKeListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 卡项统计头部数据
 */
+ (void)requestCardTopOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                   resultBlock:(void(^)(TJCardTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 卡项搜索
 */
+ (void)requestCardSearchOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                             q:(NSString *)q
                   resultBlock:(void(^)(TJCardListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 卡项搜索
 */
+ (void)requestCardListOneClick:(NSString *)oneClick
                         twoClick:(NSString *)twoClick
                        twoListId:(NSString *)twoListId
                             inId:(NSString *)inId
                         joinCode:(NSString *)joinCode
                        startTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                             sort:(NSString *)sort
                       categoryId:(NSString *)categoryId
                      resultBlock:(void(^)(TJCardListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 业绩报表八筒
 */
+ (void)requestTJBBTopDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJBBTopModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock;
/**
 * 业绩报表列表数据
 */
+ (void)requestTJBBListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJBBListModel *model,
                                                                                   BOOL isSuccess,
                                                                                   NSDictionary *errorDic))resultBlock;
/**
 * 员工报表八筒
 */
+ (void)requestTJCustomerTopDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerTopModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock;
/**
 * 员工报表列表数据
 */
+ (void)requestTJCustomerListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerListModel *model,
                                                                                   BOOL isSuccess,
                                                                                   NSDictionary *errorDic))resultBlock;
/**
 * 员工报表列表门店数据
 */
+ (void)requestTJCustomerStoreDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJStoreListModel *model,
                                                                                         BOOL isSuccess,
                                                                                         NSDictionary *errorDic))resultBlock;
/**
 * 员工详情数据
 */
+ (void)requestTJStaffDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJStaffDetailModel *model,
                                                                                          BOOL isSuccess,
                                                                                          NSDictionary *errorDic))resultBlock;

/**
 * 顾客等级列表
 */
+ (void)requestTJCustomerGradeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(CustomerGradeListModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock;
/**
 * 顾客等级列表
 */
+ (void)requestTJGradeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJGradeListModel *model,
                                                                                          BOOL isSuccess,
                                                                                          NSDictionary *errorDic))resultBlock;

/**
 * 顾客活跃八筒
 */
+ (void)requestTJCustomerActiveTopeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerActiveTopModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock;

/**
 * 顾客活跃列表
 */
+ (void)requestTJCustomerActiveListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerActiveListModel *model,
                                                                                               BOOL isSuccess,
                                                                                               NSDictionary *errorDic))resultBlock;
/**
 * 顾客活跃 详情
 */
+ (void)requestTJCustomerActiveDetailDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerActiveDetailModel *model,
                                                                                               BOOL isSuccess,
                                                                                               NSDictionary *errorDic))resultBlock;

/**
 * 消耗报表
 */
+ (void)requestTJExpendTopeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJExpendTopModel *model,
                                                                                               BOOL isSuccess,
                                                                                               NSDictionary *errorDic))resultBlock;
/**
 * 消耗报表 列表数据
 */
+ (void)requestTJExpendListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJExpendListModel *model,
                                                                                       BOOL isSuccess,
                                                                                       NSDictionary *errorDic))resultBlock;

/**
 * 收银报表 头部
 */
+ (void)requestTJCashTopeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCashTopModel *model,
                                                                                       BOOL isSuccess,
                                                                                       NSDictionary *errorDic))resultBlock;
/**
 * 收银报表 列表数据
 */
+ (void)requestTJCashListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCashListModel *model,
                                                                                       BOOL isSuccess,
                                                                                       NSDictionary *errorDic))resultBlock;
/**
 * 顾客保有报表 列表数据
 */
+ (void)requestTJCustomerRetainListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(CustomerRetainListModel *model,
                                                                                     BOOL isSuccess,
                                                                                     NSDictionary *errorDic))resultBlock;
/**
 * 顾客保有报表 头部
 */
+ (void)requestTJCustomerRetainTopDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(CustomerRetainTopModel *model,
                                                                                               BOOL isSuccess,
                                                                                               NSDictionary *errorDic))resultBlock;
+ (void)requestTJDataCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end
