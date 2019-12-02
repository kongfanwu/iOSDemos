//
//  XMHCouponRequest.h
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Networking.h"
#import "MzzHud.h"
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponRequest : NSObject

/**
 优惠券 获取商家所有门店
 */
+ (void)requestStoresParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 优惠券 获取商家顾客等级
 */
+ (void)requestGradeParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 优惠券 获取商家项目、产品
 */
+ (void)requestGoodsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 优惠券 添加 修改 读取
 */
+ (void)requestCouponEditParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

@end

NS_ASSUME_NONNULL_END
