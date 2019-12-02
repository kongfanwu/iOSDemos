//
//  UserInfoRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/28.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "YYModel.h"
#import "LolUserInfoModel.h"
#import "ZhuzhiModel.h"

@interface UserInfoRequest : NSObject{
    NSURLSessionDataTask    *_loginTask;
    NSURLSessionDataTask    *_zhuzhiTask;
    NSURLSessionDataTask    *_sendCodeTask;
    NSURLSessionDataTask    *_checkCodeTask;
    NSURLSessionDataTask    *_loginOutTask;
    NSURLSessionDataTask    *_goodsListTask;
}
/**
 *登录请求
*/
+ (void)requestLoginAccount:(NSString*)account
                   Password:(NSString *)password
                resultBlock:(void(^)(LolUserInfoModel *longinModel,
                                     BOOL isSuccess,
                                     NSDictionary *errorDic))resultBlock;

- (void)requestLoginAccount:(NSString*)account
                   Password:(NSString *)password
                resultBlock:(void(^)(LolUserInfoModel *longinModel,
                                     BOOL isSuccess,
                                     NSDictionary *errorDic))resultBlock;

/**
 *登录组织列表
 */
- (void)requestZhuzhi:(NSInteger)fram_name_id
              Fram_id:(NSInteger)fram_id
                   ID:(NSString *)idStr
          resultBlock:(void(^)(ZhuzhiModel *zhuzhiModel,
                               BOOL isSuccess,
                               NSDictionary *errorDic))resultBlock;
/**
 *发送验证码
 */
+ (void)requestSendCodePhone:(NSString *)phone
                 resultBlock:(void(^)(BaseModel *model,BOOL isSuccess,NSDictionary *errorDic))resultBlock;
/**
 * 验证码校验
 */
+ (void)requestCheckPhone:(NSString *)phone
                     code:(NSString *)code
                fastLogin:(NSString *)fastLogin
              resultBlock:(void(^)(LolUserInfoModel *model,BOOL isSuccess,NSDictionary *errorDic))resultBlock;
/**
 * 退出登录
 */
+ (void)requestLoginOutresultBlock:(void(^)(BaseModel *model,BOOL isSuccess,NSDictionary *errorDic))resultBlock;
/**
 * 商品组织架构列表
 */
+ (void)requestZuZhiGoodsListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(ZhuzhiModel *zhuzhiModel,
                                                                                         BOOL isSuccess,
                                                                                         NSDictionary *errorDic))resultBlock;
@end
