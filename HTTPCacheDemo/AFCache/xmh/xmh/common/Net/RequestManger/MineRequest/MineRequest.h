//
//  MineRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/14.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseModel,MineTopModel,MineInformationModel;
@interface MineRequest : NSObject
{
    NSURLSessionDataTask * _topDataTask;
    NSURLSessionDataTask * _informationTask;
    NSURLSessionDataTask * _modifyPwdTask;
    NSURLSessionDataTask * _modifyInformationTask;
    NSURLSessionDataTask * _modifyCodeTask;
    NSURLSessionDataTask * _feedbackTask;
    NSURLSessionDataTask * _invitationodeTask;
}
/**
 * 我的顶部数据
 */
+ (void)requestTopDataFramId:(NSString *)framId
                         uid:(NSString *)uid
                    joinCode:(NSString *)joinCode
                          resultBlock:(void(^)(MineTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 我的资料
 */
+ (void)requestInformationId:(NSString *)uid
                 resultBlock:(void(^)(MineInformationModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 修改密码
 */
+ (void)requestModifyPwdUid:(NSString *)uid
                     oldPwd:(NSString *)oldPwd
                     newPwd:(NSString *)newPwd
                resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 资料修改
 */
+ (void)requestModdfyInformationUid:(NSString *)uid
                            headImg:(NSString *)headImg
                               name:(NSString *)name
                                sex:(NSString *)sex
                             idCard:(NSString *)idCard
                           birthday:(NSString *)birthday
                               area:(NSString *)area
                            address:(NSString *)address
                              phone:(NSString *)phone
                               code:(NSString *)code
                           bankCard:(NSString *)bankCard
                               bank:(NSString *)bank
                           openBank:(NSString *)openBank
                         cardholder:(NSString *)cardholder
                        resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 修改手机号
 */
+ (void)requestModifyPhone:(NSString *)phone
                      code:(NSString *)code
                       uid:(NSString *)uid
               resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 获取验证码
 */
+ (void)requestCodePhone:(NSString *)phone
             resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 意见反馈
 */
+ (void)requestFeedbackParams:(NSMutableDictionary *)params
               resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/** 获取邀请码 */
+ (void)requestInvitationCodeParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end
