//
//  MarketRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/30.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@class TJTopModel,MStoreListModel,MWareListModel;
@interface MarketRequest : NSObject
{
    NSURLSessionDataTask * _storeTask;
    NSURLSessionDataTask * _wareTask;
    NSURLSessionDataTask * _qCodeTask;
}
/**
 * 营销应用查询门店
 */
+ (void)requestStoreFramId:(NSString *)frame
               resultBlock:(void(^)(MStoreListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 营销应用商品
 */
+ (void)requestWareType:(NSString *)type
              storeCode:(NSString *)storeCode
            resultBlock:(void(^)(MWareListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 二维码
 */
+ (void)requestQRcodeType:(NSString *)type
              storeCode:(NSString *)storeCode
                   code:(NSString *)code
            resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end
