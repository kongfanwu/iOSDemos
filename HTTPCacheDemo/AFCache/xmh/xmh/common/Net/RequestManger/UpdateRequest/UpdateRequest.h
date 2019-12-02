//
//  UpdateRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/8/7.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "Networking.h"
@interface UpdateRequest : NSObject
{
    NSURLSessionDataTask * _updateTask;
}
/**
 *  获取是否更新
 */
+ (void)requestVersionParam:(NSMutableDictionary *)param resultBlock:(void(^)(NSDictionary *dataDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end
