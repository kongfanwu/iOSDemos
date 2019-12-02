//
//  XMHServiceRequest.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceRequest : NSObject

/**
 获取服务制单列表数据
 
 @param userId 顾客id
 */
+ (void)requestServiceListWithUserId:(NSString *)userId resultBlock:(void(^)(BOOL isSuccess, BaseModel *chuFangModel, BaseModel *tiKaModel, BaseModel *goodsModel, BaseModel *projectModel))resultBlock;

/**
 服务列表数
 
 @param params params
 @param resultBlock result
 */
+ (void)requestSeverListNumParams:(NSMutableDictionary *)params
                      resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end

NS_ASSUME_NONNULL_END
