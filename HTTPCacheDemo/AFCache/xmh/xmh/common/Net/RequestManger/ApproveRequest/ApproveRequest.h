//
//  ApproveRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseModel,LFreezeCustomerModel,LSponsorApproceModel,LApproveCommonModel,LJiangZengListModel,SPShowChangeInfo,RefundListModel,RefundInfoModel;
@interface ApproveRequest : NSObject
{
    NSURLSessionDataTask * _powerTask;
    NSURLSessionDataTask * _queryCustomerTask;
    NSURLSessionDataTask * _sponsorApproceTask;
    NSURLSessionDataTask * _approceSubmitTask;
    NSURLSessionDataTask * _sendCodeTask;
    NSURLSessionDataTask * _checkCodeTask;
    NSURLSessionDataTask * _sponsorClearCardTask;
    NSURLSessionDataTask * _clearCardSubmitTask;
    NSURLSessionDataTask * _uploadImgTask;
    NSURLSessionDataTask * _waitApproveTask;
    NSURLSessionDataTask * _completeApproveTask;
    NSURLSessionDataTask * _faQiApproveTask;
    NSURLSessionDataTask * _duplicateApproveTask;
    NSURLSessionDataTask * _jiangZengApproveTask;
    NSURLSessionDataTask * _guDingZhiDanApproveTask;
    NSURLSessionDataTask * _freeOrderTask;
    NSURLSessionDataTask * _setReadTask;
    NSURLSessionDataTask * _showChangeInfo;
    NSURLSessionDataTask * _tuiKuanTask;
    NSURLSessionDataTask * _refundInfoTask;
    NSURLSessionDataTask * _refundAlBackTask;
    NSURLSessionDataTask * _refundCommitTask;
}
/**
 * -------------------------------------------顾客冻结----------------------------------------------------------------------------
*/
/**
 * 获取是否有审批权限
 */
+ (void)requestPowerJoinCode:(NSString *)joinCode
                    functionRole:(NSArray *)functionRole
                    ptype:(NSString *)ptype
                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 搜索顾客接口
 */
+ (void)requestQueryCustomerFramId:(NSString *)framId
                            account:(NSString *)account
                            keyword:(NSString *)keyword
                            resultBlock:(void(^)(LFreezeCustomerModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 发起审批
 */
+ (void)requestSponsorApproceJoinCode:(NSString *)joincode
                              account:(NSString *)account
                               userId:(NSString *)userid
                               framId:(NSString *)framid
                        user_store_id:(NSString *)user_store_id
                          resultBlock:(void(^)(LSponsorApproceModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 提交审批
 */
+ (void)requestApproveSubmitJoinCode:(NSString *)joincode
                                code:(NSString *)code
                      approvalPerson:(NSString *)approvalPerson
                     duplicatePerson:(NSString *)duplicatePerson
                             account:(NSString *)account
                           accountId:(NSString *)accountId
                               cause:(NSString *)cause
                              userId:(NSString *)userId
                           remainder:(NSString *)remainder
                       user_store_id:(NSString *)user_store_id
                         resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * -------------------------------------------顾客清卡----------------------------------------------------------------------------
 */

/**
 * 发送短信验证码
 */
+ (void)requestSendCodeJoinCode:(NSString *)joincode
                       phone:(NSString *)phone
                       phType:(NSString *)phType
                       account:(NSString *)account
                       framId:(NSString *)framId
                       resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 验证短信验证码
 */
+ (void)requestCheckCodeJoinCode:(NSString *)joincode
                        phone:(NSString *)phone
                        phcode:(NSString *)code
                        resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 顾客清卡发起
 */
+ (void)requestSponsorClearCardJoinCode:(NSString *)joincode
                               phone:(NSString *)phone
                               account:(NSString *)account
                               framId:(NSString *)framId
                               resultBlock:(void(^)(LSponsorApproceModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 顾客清卡提交
 */
+ (void)requestClearCardSubmitJoinCode:(NSString *)joincode
                                  code:(NSString *)code
                        approvalPerson:(NSString *)approvalPerson
                       duplicatePerson:(NSString *)duplicatePerson
                             accountId:(NSString *)accountId
                                 cause:(NSString *)cause
                                userId:(NSString *)userId
                             remainder:(NSString *)remainder
                             presmoney:(NSString *)presmoney
                                freeze:(NSString *)freeze
                     timeCardRemainder:(NSString *)timeCardRemainder
                        goodsRemainder:(NSString *)goodsRemainder
                       ticketRemainder:(NSString *)ticketRemainder
                                 total:(NSString *)total
                                actual:(NSString *)actual
                             clearType:(NSString *)clearType
                                  imgs:(NSString *)imgs
                         user_store_id:(NSString *)user_store_id
                           resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 上传图片
 */
+ (void)requestUploadImg:(NSArray *)imgimgData resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * ---------------------------------------------------我的审批--------------------------------------------------------------------
 */

/**
 * 待审批列表
 */
+ (void)requestWaitApproveJoinCode:(NSString *)joincode
                          accountId:(NSString *)accountId
                          pageNum:(NSString *)pageNum
                          pageSize:(NSString *)pageSize
                          ptype:(NSString *)ptype
                          keyword:(NSString *)keyword
                          resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 我已审批的
 */
+ (void)requestCompleteApproveJoinCode:(NSString *)joincode
                              accountId:(NSString *)accountId
                              pageNum:(NSString *)pageNum
                              pageSize:(NSString *)pageSize
                              ptype:(NSString *)ptype
                              keyword:(NSString *)keyword
                              resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 我发起的
 */
+ (void)requestFaQiApproveJoinCode:(NSString *)joincode
                          accountId:(NSString *)accountId
                          pageNum:(NSString *)pageNum
                          pageSize:(NSString *)pageSize
                          ptype:(NSString *)ptype
                          keyword:(NSString *)keyword
                             state:(NSString *)state
                          resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 抄送我的
 */
+ (void)requestDuplicateApproveJoinCode:(NSString *)joincode
                               accountId:(NSString *)accountId
                               pageNum:(NSString *)pageNum
                               pageSize:(NSString *)pageSize
                               ptype:(NSString *)ptype
                               keyword:(NSString *)keyword
                               isAll:(NSString *)isAll
                               resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 奖赠审批发起
 */
+ (void)requestJiangZengApproveJoinCode:(NSString *)joinCode
                               framId:(NSString *)framId
                               resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 固定制单审批发起
 */
+ (void)requestGuDingZhiDanParams:(NSMutableDictionary *)params
                           resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 个性制单发起
 */
+ (void)requestFreeOrderApproveJoinCode:(NSString *)joinCode
                                 framId:(NSString *)framId
                            resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 已购置换发起
 */
+ (void)requestExchangeApproveJoinCode:(NSString *)joinCode
                                 framId:(NSString *)framId
                            resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 升卡续卡发起
 */
+ (void)requestRiseCardApproveJoinCode:(NSString *)joinCode
                                framId:(NSString *)framId
                           resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 修改待审批抄送我的阅读状态
 */
+ (void)requestSetReadParam:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/**
 * 完善资料审批查看
 */
+ (void)requestShowChangeInfoParam:(NSMutableDictionary *)param resultBlock:(void(^)(SPShowChangeInfo *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 *  退款审批返回所有购买商品购物车
 */
+ (void)requestClearCardAll:(NSMutableDictionary *)param resultBlock:(void(^)(RefundListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 *  退款审批返回所有购买商品 不许要选择
 */
+ (void)requestClearBackAll:(NSMutableDictionary *)param resultBlock:(void(^)(RefundListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 *  获取退款顾客信息
 */
+ (void)requestRefundCustomerInfo:(NSMutableDictionary *)param resultBlock:(void(^)(RefundInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 *  提交退款审批
 */
+ (void)requestCommitRefundParam:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end
