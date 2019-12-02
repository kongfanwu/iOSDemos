//
//  XMHActionCenterRequest.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHActionCenterRequest : NSObject
{
    NSURLSessionDataTask    *_couponListTask;
    NSURLSessionDataTask    *_stopTask;
    NSURLSessionDataTask    *_xiugaikuncunTask;
    NSURLSessionDataTask    *_commonTask;
    NSURLSessionDataTask    *_delectTask;
}

/**
 优惠券 列表

 @param params 请求参数
 @param resultBlock 优惠券列表数组
 */
- (void)requestCouponListParams:(NSMutableDictionary *)params
                         resultBlock:(void(^)(NSMutableArray *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/**
 优惠券 启用 停用

 @param params 请求参数
 @param resultBlock 返回结果
 */
- (void)requestCouponListPutInParams:(NSMutableDictionary *)params
                    resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 优惠券 修改库存
 
 @param params 请求参数
 @param resultBlock 返回结果
 */
- (void)requestCouponListStockParams:(NSMutableDictionary *)params
                         resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 优惠券 删除
 
 @param params 请求参数
 @param resultBlock 返回结果
 */
- (void)requestCouponListDelTicketParams:(NSMutableDictionary *)params
                         resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 优惠券 通用接口
 
 @param url 请求URL
 @param params 请求参数
 @param resultBlock 返回结果
 */
+ (void)requestCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


@end

NS_ASSUME_NONNULL_END
