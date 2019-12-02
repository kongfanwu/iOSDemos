//
//  OnLineRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@class OHomeListModel,OTopModel,OOrderListModel,ExpressListModel,ZhuzhiModel,ZhuzhiData,OnFramListModel;
@interface OnLineRequest : NSObject
{
    NSURLSessionDataTask * _listTask;
    NSURLSessionDataTask * _topTask;
    NSURLSessionDataTask * _orderListTask;
    NSURLSessionDataTask * _deliverTask;
    NSURLSessionDataTask * _expressTask;
    NSURLSessionDataTask * _OnlineFrameTask;
}
/**
 *  门店商品列表
 */
+ (void)requestListJoinCode:(NSString *)joinCode
                   oneClick:(NSString *)oneClick
                   twoClick:(NSString *)twoClick
                  twoListId:(NSString *)twoListId
                   thrClick:(NSString *)thrClick
                   fouClick:(NSString *)fouClick
                      start:(NSString *)start
                        end:(NSString *)end
                      param:(NSString *)param
                       page:(NSString *)page
                resultBlock:(void(^)(OHomeListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 *  线上交易顶部数据
 */
+ (void)requestTopDataJoinCode:(NSString *)joinCode
                      oneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                      thrClick:(NSString *)thrClick
                      fouClick:(NSString *)fouClick
                         start:(NSString *)start
                           end:(NSString *)end
                   resultBlock:(void(^)(OTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 *  线上交易订单列表
 */
+ (void)requestOrderListJoinCode:(NSString *)joinCode
                        oneClick:(NSString *)oneClick
                        twoClick:(NSString *)twoClick
                       twoListId:(NSString *)twoListId
                        thrClick:(NSString *)thrClick
                        fouClick:(NSString *)fouClick
                           start:(NSString *)start
                             end:(NSString *)end
                            Type:(NSString *)type
                          parame:(NSString *)parame
                            page:(NSString *)page
                     resultBlock:(void(^)(OOrderListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 *  订单发货
 */
+ (void)requestDeliverOrderNum:(NSString *)orderNum
                          type:(NSString *)type
                       express:(NSString *)express 
                        expnum:(NSString *)expnum
                   resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 *  快递种类
 */
+ (void)requestExpressResultBlock:(void(^)(ExpressListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 *  线上交易组织架构
 */
+ (void)requestOnlineFrameId:(NSString *)framId
                 resultBlock:(void(^)(OnFramListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end
