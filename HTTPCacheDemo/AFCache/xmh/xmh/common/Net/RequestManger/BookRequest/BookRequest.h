//
//  BookRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YiYuYueListModel,DaiYuYueModel,DaiYuYueListModel,CustomerMessageModel,CustomerBookProjectModel,HomePageHeadModel,LolCalendarModelList,LolHomeListModel,LolSearchCustomerModelList,LolDetailModel,LolGuKeListModel,LolGuKeStateModelList,BookJisTimeList;
@interface BookRequest : NSObject{
    NSURLSessionDataTask    *_yiYuYueTask;
    NSURLSessionDataTask    *_daiYuYueTask;
    NSURLSessionDataTask    *_customerMessageTask;
    NSURLSessionDataTask    *_customerBookProjectTask;
    NSURLSessionDataTask    *_homePageHeadTask;
    NSURLSessionDataTask    *_homePageCalendarTask;
    NSURLSessionDataTask    *_homeListTask;
    NSURLSessionDataTask    *_SearchCustomerTask;
    NSURLSessionDataTask    *_submitTask;
    NSURLSessionDataTask    *_detailTask;
    NSURLSessionDataTask    *_homeGuKeBookCountTask;
    NSURLSessionDataTask    *_gukeStateTask;
    NSURLSessionDataTask    *_jisTimeTask;
    NSURLSessionDataTask    *_commonTask;
}
/**
 * 已预约
 */
+ (void)requestYiYuYueParams:(NSMutableDictionary *)params resultBlock:(void(^)(YiYuYueListModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
- (void)requestYiYuYueParams:(NSMutableDictionary *)params resultBlock:(void(^)(YiYuYueListModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 待预约
 */
+ (void)requestDaiYuYueParams:(NSMutableDictionary *)params resultBlock:(void(^)(DaiYuYueListModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
- (void)requestDaiYuYueParams:(NSMutableDictionary *)params resultBlock:(void(^)(DaiYuYueListModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 顾客基本信息
 */
+ (void)requestCustomerMessageParams:(NSMutableDictionary *)params resultBlock:(void(^)(CustomerMessageModel *customerMessageModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
- (void)requestCustomerMessageParams:(NSMutableDictionary *)params resultBlock:(void(^)(CustomerMessageModel *customerMessageModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 顾客预约项目和时间接口
 */

+ (void)requestCustomerBookProjectParams:(NSMutableDictionary *)params resultBlock:(void(^)(CustomerBookProjectModel *projectModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
- (void)requestCustomerBookProjectParams:(NSMutableDictionary *)params resultBlock:(void(^)(CustomerBookProjectModel *projectModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 预约管理顶部统计数据
 */
+ (void)requestHomePageHeadParams:(NSMutableDictionary *)params resultBlock:(void(^)(HomePageHeadModel *homePageHeadModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
- (void)requestHomePageHead:(NSString *)join_code
                         oneClick:(NSString *)oneClick
                         twoClick:(NSString *)twoClick
                        twoListId:(NSString *)twoListId
                             inId:(NSString *)inId
                        startTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                      resultBlock:(void(^)(HomePageHeadModel *homePageHeadModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 *  预约管理首页日历数据请求
 */
+ (void)requestHomePageCalendarParams:(NSMutableDictionary *)params resultBlock:(void(^)(LolCalendarModelList *lolCalendarModelList, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
- (void)requestHomePageCalendar:(NSString *)join_code
                       oneClick:(NSString *)oneClick
                       twoClick:(NSString *)twoClick
                      twoListId:(NSString *)twoListId
                           inId:(NSString *)inId
                      date:(NSString *)date
                        time:(NSString *)time
                    resultBlock:(void(^)(LolCalendarModelList *lolCalendarModelList, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 首页统计列表数据请求
 */
+ (void)requestHomePageListParams:(NSMutableDictionary *)params
                resultBlock:(void(^)(LolHomeListModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
- (void)requestHomePageList:(NSString *)join_code
               oneClick:(NSString *)oneClick
               twoClick:(NSString *)twoClick
              twoListId:(NSString *)twoListId
                   inId:(NSString *)inId
              startTime:(NSString *)startTime
                endTime:(NSString *)endTime
            resultBlock:(void(^)(LolHomeListModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 详情页提交请求
 */
+ (void)requestSubmitParams:(NSMutableDictionary *)params resultBlock:(void(^)(BOOL isSuccess, NSDictionary * errorDic))resultBlock;
- (void)requestSubmitParams:(NSMutableDictionary *)params resultBlock:(void(^)(BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 详情页顾客预约项目请求
 */
+ (void)requestDetailParams:(NSMutableDictionary *)params resultBlock:(void(^)(LolDetailModel *detailModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
- (void)requestDetailParams:(NSMutableDictionary *)params resultBlock:(void(^)(LolDetailModel *detailModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 所有顾客 预约信息
 */
+ (void)requestHomePageGuKeBookCountParams:(NSMutableDictionary *)params resultBlock:(void(^)(LolGuKeListModel *guKeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
- (void)requestHomePageGuKeBookCount:(NSString *)join_code
                            oneClick:(NSString *)oneClick
                            twoClick:(NSString *)twoClick
                           twoListId:(NSString *)twoListId
                                page:(NSString *)page
                                date:(NSString *)date inID:(NSString *)inId resultBlock:(void(^)(LolGuKeListModel *guKeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 单个顾客列表
 */
+ (void)requestOneGukeListParam:(NSMutableDictionary *)param resultBlock:(void(^)(LolGuKeStateModelList *guKeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 服务技师时间
 */
+ (void)requestJisTimeParam:(NSMutableDictionary *)param resultBlock:(void(^)(BookJisTimeList *timeList, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/** 处方详情 */
+ (void)requestCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

@end
