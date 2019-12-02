//
//  ApproveRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ApproveRequest.h"
#import "Networking.h"
#import "BaseModel.h"
#import "LFreezeCustomerModel.h"
#import "LSponsorApproceModel.h"
#import "LApproveCommonModel.h"
#import "LJiangZengListModel.h"
#import "SPShowChangeInfo.h"
#import "RefundListModel.h"
#import "RefundInfoModel.h"
@implementation ApproveRequest
+ (void)requestPowerJoinCode:(NSString *)joinCode
                functionRole:(NSArray *)functionRole
                       ptype:(NSString *)ptype
                 resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestPowerJoinCode:joinCode functionRole:functionRole ptype:ptype resultBlock:resultBlock];
}
-(void)requestPowerJoinCode:(NSString *)joinCode
                functionRole:(NSArray *)functionRole
                       ptype:(NSString *)ptype
                 resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_powerTask) {
        [_powerTask cancel];
    }
    NSMutableString * roleStr = [[NSMutableString alloc] init];
    for (int i = 0; i < functionRole.count; i ++) {
        [roleStr appendString:functionRole[i]];
        if (i == functionRole.count -1) {
            
        }else{
            [roleStr appendString:@","];
        }
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"framework_function_role":roleStr?roleStr:@"",@"ptype":ptype?ptype:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/getPower",SERVER_APP];
    _powerTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestQueryCustomerFramId:(NSString *)framId
                           account:(NSString *)account
                           keyword:(NSString *)keyword
                       resultBlock:(void(^)(LFreezeCustomerModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestQueryCustomerFramId:framId account:account keyword:keyword resultBlock:resultBlock];
    
}
- (void)requestQueryCustomerFramId:(NSString *)framId
                           account:(NSString *)account
                           keyword:(NSString *)keyword
                       resultBlock:(void(^)(LFreezeCustomerModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_powerTask) {
        [_powerTask cancel];
    }
    NSMutableDictionary *params = [@{@"fram_id":framId?framId:@"",@"account":account?account:@"",@"keyword":keyword?keyword:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/searchUser",SERVER_APP];
    _powerTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LFreezeCustomerModel * model = [LFreezeCustomerModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestSponsorApproceJoinCode:(NSString *)joincode
                              account:(NSString *)account
                               userId:(NSString *)userid
                               framId:(NSString *)framid
                        user_store_id:(NSString *)user_store_id
                          resultBlock:(void(^)(LSponsorApproceModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestSponsorApproceJoinCode:joincode account:account userId:userid framId:framid user_store_id:user_store_id resultBlock:resultBlock];
}
- (void)requestSponsorApproceJoinCode:(NSString *)joincode
                              account:(NSString *)account
                               userId:(NSString *)userid
                               framId:(NSString *)framid
                        user_store_id:(NSString *)user_store_id
                          resultBlock:(void(^)(LSponsorApproceModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_sponsorApproceTask) {
        [_sponsorApproceTask cancel];
    }
    NSMutableDictionary *params = [@{@"fram_id":framid?framid:@"",@"account":account?account:@"",@"user_id":userid?userid:@"",@"join_code":joincode?joincode:@"",@"user_store_id":user_store_id?user_store_id:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/congeal",SERVER_APP];
    _sponsorApproceTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LSponsorApproceModel * model = [LSponsorApproceModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
    
}

/**
 * 提交审批
 */
//+ (void)requestApproveSubmitJoinCode:(NSString *)joincode
//                                code:(NSString *)code
//                      approvalPerson:(NSString *)approvalPerson
//                     duplicatePerson:(NSString *)duplicatePerson
//                             account:(NSString *)account
//                           accountId:(NSString *)accountId
//                               cause:(NSString *)cause
//                              userId:(NSString *)userId
//                           remainder:(NSString *)remainder
//                       user_store_id:(NSString *)user_store_id
//                         resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

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
                         resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestApproveSubmitJoinCode:joincode code:code approvalPerson:approvalPerson duplicatePerson:duplicatePerson account:account accountId:accountId cause:cause userId:userId remainder:remainder user_store_id:user_store_id resultBlock:resultBlock];
}
//+ (void)requestApproveSubmitJoinCode:(NSString *)joincode
//                                code:(NSString *)code
//                      approvalPerson:(NSString *)approvalPerson
//                     duplicatePerson:(NSString *)duplicatePerson
//                             account:(NSString *)account
//                           accountId:(NSString *)accountId
//                               cause:(NSString *)cause
//                              userId:(NSString *)userId
//                           remainder:(NSString *)remainder
//                       user_store_id:(NSString *)user_store_id
//                         resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
//    ApproveRequest * request = [[ApproveRequest alloc] init];
//    [request requestApproveSubmitJoinCode:joincode code:code approvalPerson:approvalPerson duplicatePerson:duplicatePerson account:account accountId:accountId cause:cause userId:userId remainder:remainder user_store_id:user_store_id resultBlock:resultBlock];
//
//}
- (void)requestApproveSubmitJoinCode:(NSString *)joincode
                                code:(NSString *)code
                      approvalPerson:(NSString *)approvalPerson
                     duplicatePerson:(NSString *)duplicatePerson
                             account:(NSString *)account
                           accountId:(NSString *)accountId
                               cause:(NSString *)cause
                              userId:(NSString *)userId
                           remainder:(NSString *)remainder
                       user_store_id:(NSString *)user_store_id
                         resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_approceSubmitTask) {
        [_approceSubmitTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joincode?joincode:@"",@"code":code?code:@"",@"approvalPerson":approvalPerson?approvalPerson:@"",@"duplicatePerson":duplicatePerson?duplicatePerson:@"",@"account":account?account:@"",@"account_id":accountId?accountId:@"",@"cause":cause?cause:@"",@"user_id":userId?userId:@"",@"remainder":remainder?remainder:@"",@"user_store_id":user_store_id?user_store_id:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/postCongeal",SERVER_APP];
    _approceSubmitTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
    
    
}
//- (void)requestApproveSubmitJoinCode:(NSString *)joincode
//                                code:(NSString *)code
//                      approvalPerson:(NSString *)approvalPerson
//                     duplicatePerson:(NSString *)duplicatePerson
//                             account:(NSString *)account
//                           accountId:(NSString *)accountId
//                               cause:(NSString *)cause
//                              userId:(NSString *)userId
//                           remainder:(NSString *)remainder
//                       user_store_id:(NSString *)user_store_id
//                         resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
//    if (_approceSubmitTask) {
//        [_approceSubmitTask cancel];
//    }
//    NSMutableDictionary *params = [@{@"join_code":joincode?joincode:@"",@"code":code?code:@"",@"approvalPerson":approvalPerson?approvalPerson:@"",@"duplicatePerson":duplicatePerson?duplicatePerson:@"",@"account":account?account:@"",@"account_id":accountId?accountId:@"",@"cause":cause?cause:@"",@"user_id":userId?userId:@"",@"remainder":remainder?remainder:@"", @"user_store_id" : user_store_id} mutableCopy];
//    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/postCongeal",SERVER_APP];
//    _approceSubmitTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
//        if (info.code ==1) {
//            resultBlock(info,YES,nil);
//        }else{
//            [MzzHud toastWithTitle:@"提示" message:info.msg];
//        }
//    } fail:^(id  _Nullable errorresult) {
//        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
//        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
//    }];
//}
+ (void)requestSendCodeJoinCode:(NSString *)joincode
                          phone:(NSString *)phone
                         phType:(NSString *)phType
                        account:(NSString *)account
                         framId:(NSString *)framId
                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestSendCodeJoinCode:joincode phone:phone phType:phType account:account framId:framId resultBlock:resultBlock];
}
- (void)requestSendCodeJoinCode:(NSString *)joincode
                          phone:(NSString *)phone
                         phType:(NSString *)phType
                        account:(NSString *)account
                         framId:(NSString *)framId
                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_sendCodeTask) {
        [_sendCodeTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/sendCode",SERVER_APP];
    NSMutableDictionary * params = [@{@"join_code":joincode?joincode:@"",@"phone":phone?phone:@"",@"phType":phType?phType:@"",@"account":account?account:@"",@"fram_id":framId?framId:@""}mutableCopy];
    
    _sendCodeTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
            [MzzHud toastWithTitle:@"提示" message:result[@"data"]];
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestCheckCodeJoinCode:(NSString *)joincode
                           phone:(NSString *)phone
                          phcode:(NSString *)code
                     resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestCheckCodeJoinCode:joincode phone:phone phcode:code resultBlock:resultBlock];
}
- (void)requestCheckCodeJoinCode:(NSString *)joincode
                           phone:(NSString *)phone
                          phcode:(NSString *)code
                     resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_checkCodeTask) {
        [_checkCodeTask cancel];
    }
     NSString * url = [NSString stringWithFormat:@"%@v5.Approval/checkCode",SERVER_APP];
     NSMutableDictionary * params = [@{@"join_code":joincode?joincode:@"",@"phone":phone?phone:@"",@"phcode":code?code:@""}mutableCopy];
    
    _checkCodeTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
            [MzzHud toastWithTitle:@"提示" message:result[@"data"]];
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestSponsorClearCardJoinCode:(NSString *)joincode
                                  phone:(NSString *)phone
                                account:(NSString *)account
                                 framId:(NSString *)framId
                            resultBlock:(void(^)(LSponsorApproceModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestSponsorClearCardJoinCode:joincode phone:phone account:account framId:framId resultBlock:resultBlock];
}
- (void)requestSponsorClearCardJoinCode:(NSString *)joincode
                                  phone:(NSString *)phone
                                account:(NSString *)account
                                 framId:(NSString *)framId
                            resultBlock:(void(^)(LSponsorApproceModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_sponsorClearCardTask) {
        [_sponsorClearCardTask cancel];
    }
    NSMutableDictionary *params = [@{@"fram_id":framId?framId:@"",@"account":account?account:@"",@"phone":phone?phone:@"",@"join_code":joincode?joincode:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/clearCard",SERVER_APP];
    _sponsorClearCardTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LSponsorApproceModel * model = [LSponsorApproceModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
    
}
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
                           resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestClearCardSubmitJoinCode:joincode code:code approvalPerson:approvalPerson duplicatePerson:duplicatePerson accountId:accountId cause:cause userId:userId remainder:remainder presmoney:presmoney freeze:freeze timeCardRemainder:timeCardRemainder goodsRemainder:goodsRemainder ticketRemainder:ticketRemainder total:total actual:actual clearType:clearType imgs:imgs user_store_id:user_store_id resultBlock:resultBlock];
}
- (void)requestClearCardSubmitJoinCode:(NSString *)joincode
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
                           resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    NSMutableDictionary *params = [@{@"join_code":joincode?joincode:@"",@"code":code?code:@"",@"approvalPerson":approvalPerson?approvalPerson:@"",@"duplicatePerson":duplicatePerson?duplicatePerson:@"",@"account_id":accountId?accountId:@"",@"cause":cause?cause:@"",@"user_id":userId?userId:@"",@"remainder":remainder?remainder:@"",@"pres_money":presmoney?presmoney:@"",@"freeze":freeze?freeze:@"",@"timeCard_remainder":timeCardRemainder?timeCardRemainder:@"",@"goods_remainder":goodsRemainder?goodsRemainder:@"",@"ticket_remainder":ticketRemainder?ticketRemainder:@"",@"total":total?total:@"",@"actual":actual?actual:@"",@"clearType":clearType?clearType:@"",@"imgs":imgs?imgs:@"",@"user_store_id":user_store_id?user_store_id:@""}mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/postClearCard",SERVER_APP];
    if (_clearCardSubmitTask) {
        [_clearCardSubmitTask cancel];
    }
    _clearCardSubmitTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestUploadImg:(NSArray *)imgData resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestUploadImg:imgData resultBlock:resultBlock];
}
- (void)requestUploadImg:(NSArray *)imgData resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{

    NSMutableDictionary *params = [@{@"img":imgData?imgData:@""}mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/uploadImg",SERVER_APP];
    if (_uploadImgTask) {
        [_uploadImgTask cancel];
    }
    _uploadImgTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestWaitApproveJoinCode:(NSString *)joincode
                         accountId:(NSString *)accountId
                           pageNum:(NSString *)pageNum
                          pageSize:(NSString *)pageSize
                             ptype:(NSString *)ptype
                           keyword:(NSString *)keyword
                       resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestWaitApproveJoinCode:joincode accountId:accountId pageNum:pageNum pageSize:pageSize ptype:ptype keyword:keyword resultBlock:resultBlock];
}
- (void)requestWaitApproveJoinCode:(NSString *)joincode
                         accountId:(NSString *)accountId
                           pageNum:(NSString *)pageNum
                          pageSize:(NSString *)pageSize
                             ptype:(NSString *)ptype
                           keyword:(NSString *)keyword
                       resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_waitApproveTask) {
        [_waitApproveTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joincode?joincode:@"",@"account_id":accountId?accountId:@"",@"pageNumber":pageNum?pageNum:@"",@"pageSize":pageSize?pageSize:@"",@"ptype":ptype?ptype:@"",@"keyword":keyword?keyword:@""}mutableCopy];
       NSString * url = [NSString stringWithFormat:@"%@v5.Approval/getWait",SERVER_APP];
    _waitApproveTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LApproveCommonModel * model = [LApproveCommonModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
    
}
+ (void)requestCompleteApproveJoinCode:(NSString *)joincode
                             accountId:(NSString *)accountId
                               pageNum:(NSString *)pageNum
                              pageSize:(NSString *)pageSize
                                 ptype:(NSString *)ptype
                               keyword:(NSString *)keyword
                           resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestCompleteApproveJoinCode:joincode accountId:accountId pageNum:pageNum pageSize:pageSize ptype:ptype keyword:keyword resultBlock:resultBlock];
}
- (void)requestCompleteApproveJoinCode:(NSString *)joincode
                             accountId:(NSString *)accountId
                               pageNum:(NSString *)pageNum
                              pageSize:(NSString *)pageSize
                                 ptype:(NSString *)ptype
                               keyword:(NSString *)keyword
                           resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_completeApproveTask) {
        [_completeApproveTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joincode?joincode:@"",@"account_id":accountId?accountId:@"",@"pageNumber":pageNum?pageNum:@"",@"pageSize":pageSize?pageSize:@"",@"ptype":ptype?ptype:@"",@"keyword":keyword?keyword:@""}mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/getComplete",SERVER_APP];
    _completeApproveTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LApproveCommonModel * model = [LApproveCommonModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestFaQiApproveJoinCode:(NSString *)joincode
                         accountId:(NSString *)accountId
                           pageNum:(NSString *)pageNum
                          pageSize:(NSString *)pageSize
                             ptype:(NSString *)ptype
                           keyword:(NSString *)keyword
                             state:(NSString *)state
                       resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestFaQiApproveJoinCode:joincode accountId:accountId pageNum:pageNum pageSize:pageSize ptype:ptype keyword:keyword state:state resultBlock:resultBlock];
}
- (void)requestFaQiApproveJoinCode:(NSString *)joincode
                         accountId:(NSString *)accountId
                           pageNum:(NSString *)pageNum
                          pageSize:(NSString *)pageSize
                             ptype:(NSString *)ptype
                           keyword:(NSString *)keyword
                             state:(NSString *)state
                       resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_faQiApproveTask) {
        [_faQiApproveTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joincode?joincode:@"",@"account_id":accountId?accountId:@"",@"pageNumber":pageNum?pageNum:@"",@"pageSize":pageSize?pageSize:@"",@"ptype":ptype?ptype:@"",@"keyword":keyword?keyword:@"",@"state":state?state:@""}mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/getInitiator",SERVER_APP];
    _faQiApproveTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LApproveCommonModel * model = [LApproveCommonModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestDuplicateApproveJoinCode:(NSString *)joincode
                              accountId:(NSString *)accountId
                                pageNum:(NSString *)pageNum
                               pageSize:(NSString *)pageSize
                                  ptype:(NSString *)ptype
                                keyword:(NSString *)keyword
                                  isAll:(NSString *)isAll
                            resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestDuplicateApproveJoinCode:joincode accountId:accountId pageNum:pageNum pageSize:pageSize ptype:ptype keyword:keyword isAll:isAll resultBlock:resultBlock];
}
- (void)requestDuplicateApproveJoinCode:(NSString *)joincode
                              accountId:(NSString *)accountId
                                pageNum:(NSString *)pageNum
                               pageSize:(NSString *)pageSize
                                  ptype:(NSString *)ptype
                                keyword:(NSString *)keyword
                                  isAll:(NSString *)isAll
                            resultBlock:(void(^)(LApproveCommonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_duplicateApproveTask) {
        [_duplicateApproveTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joincode?joincode:@"",@"account_id":accountId?accountId:@"",@"pageNumber":pageNum?pageNum:@"",@"pageSize":pageSize?pageSize:@"",@"ptype":ptype?ptype:@"",@"keyword":keyword?keyword:@"",@"isAll":isAll?isAll:@""}mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/getDuplicate",SERVER_APP];
    _duplicateApproveTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LApproveCommonModel * model = [LApproveCommonModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestJiangZengApproveJoinCode:(NSString *)joinCode
                                 framId:(NSString *)framId
                            resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestJiangZengApproveJoinCode:joinCode framId:framId resultBlock:resultBlock];

}
- (void)requestJiangZengApproveJoinCode:(NSString *)joinCode
                                 framId:(NSString *)framId
                            resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_jiangZengApproveTask) {
        [_jiangZengApproveTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"fram_id":framId?framId:@""}mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/approval",SERVER_APP];
    _jiangZengApproveTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LJiangZengListModel * model = [LJiangZengListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestGuDingZhiDanParams:(NSMutableDictionary *)params resultBlock:(void (^)(BaseModel *, BOOL, NSDictionary *))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestGuDingZhiDanParams:params resultBlock:resultBlock];
}
- (void)requestGuDingZhiDanParams:(NSMutableDictionary *)params resultBlock:(void (^)(BaseModel *, BOOL, NSDictionary *))resultBlock{
    if (_guDingZhiDanApproveTask) {
        [_guDingZhiDanApproveTask cancel];
    }
    
    NSString * url = [NSString stringWithFormat:@"%@v5.sales_app/fixed_a",SERVER_APP];

    _guDingZhiDanApproveTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
          
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestFreeOrderApproveJoinCode:(NSString *)joinCode
                                 framId:(NSString *)framId
                            resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestFreeOrderApproveJoinCode:joinCode framId:framId resultBlock:resultBlock];
    
}
- (void)requestFreeOrderApproveJoinCode:(NSString *)joinCode
                                 framId:(NSString *)framId
                            resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_freeOrderTask) {
        [_freeOrderTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"fram_id":framId?framId:@""}mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/freeOrder",SERVER_APP];
    _freeOrderTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LJiangZengListModel * model = [LJiangZengListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestExchangeApproveJoinCode:(NSString *)joinCode
                                 framId:(NSString *)framId
                            resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestExchangeApproveJoinCode:joinCode framId:framId resultBlock:resultBlock];
    
}
- (void)requestExchangeApproveJoinCode:(NSString *)joinCode
                                 framId:(NSString *)framId
                            resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_freeOrderTask) {
        [_freeOrderTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"fram_id":framId?framId:@""}mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/exchange",SERVER_APP];
    _freeOrderTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LJiangZengListModel * model = [LJiangZengListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestRiseCardApproveJoinCode:(NSString *)joinCode
                                framId:(NSString *)framId
                           resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestRiseCardApproveJoinCode:joinCode framId:framId resultBlock:resultBlock];
    
}
- (void)requestRiseCardApproveJoinCode:(NSString *)joinCode
                                framId:(NSString *)framId
                           resultBlock:(void(^)(LJiangZengListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_freeOrderTask) {
        [_freeOrderTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"fram_id":framId?framId:@""}mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/riseCard",SERVER_APP];
    _freeOrderTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LJiangZengListModel * model = [LJiangZengListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestSetReadParam:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestSetReadParam:param resultBlock:resultBlock];
    
}
- (void)requestSetReadParam:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_setReadTask) {
        [_setReadTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/setRead",SERVER_APP];
    _setReadTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}


/**
 * 完善资料审批查看
 */
+ (void)requestShowChangeInfoParam:(NSMutableDictionary *)param resultBlock:(void(^)(SPShowChangeInfo *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestShowChangeInfoParam:param resultBlock:resultBlock];
}
- (void)requestShowChangeInfoParam:(NSMutableDictionary *)param resultBlock:(void(^)(SPShowChangeInfo *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_showChangeInfo) {
        [_showChangeInfo cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/showChangeInfo",SERVER_APP];
    _setReadTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SPShowChangeInfo *changeInfo = [SPShowChangeInfo yy_modelWithDictionary:info.data];
            resultBlock(changeInfo,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestClearCardAll:(NSMutableDictionary *)param resultBlock:(void(^)(RefundListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestClearCardAll:param resultBlock:resultBlock];
    
}
- (void)requestClearCardAll:(NSMutableDictionary *)param resultBlock:(void(^)(RefundListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_tuiKuanTask) {
        [_tuiKuanTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Clear_Card/getAll",SERVER_APP];
    _tuiKuanTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            RefundListModel *model = [RefundListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestClearBackAll:(NSMutableDictionary *)param resultBlock:(void(^)(RefundListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestClearBackAll:param resultBlock:resultBlock];
}
- (void)requestClearBackAll:(NSMutableDictionary *)param resultBlock:(void(^)(RefundListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_refundAlBackTask) {
        [_refundAlBackTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Clear_Card/backAll",SERVER_APP];
    _refundAlBackTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            RefundListModel *model = [RefundListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestRefundCustomerInfo:(NSMutableDictionary *)param resultBlock:(void(^)(RefundInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestRefundCustomerInfo:param resultBlock:resultBlock];
}
- (void)requestRefundCustomerInfo:(NSMutableDictionary *)param resultBlock:(void(^)(RefundInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_refundInfoTask) {
        [_refundInfoTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Clear_Card/clearCard",SERVER_APP];
    _refundInfoTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            RefundInfoModel *model = [RefundInfoModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestCommitRefundParam:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    ApproveRequest * request = [[ApproveRequest alloc] init];
    [request requestCommitRefundParam:param resultBlock:resultBlock];
    
}
- (void)requestCommitRefundParam:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_refundCommitTask) {
        [_refundCommitTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Clear_Card/postClearCard",SERVER_APP];
    _refundCommitTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
@end
