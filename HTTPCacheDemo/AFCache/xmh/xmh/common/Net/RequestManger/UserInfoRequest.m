//
//  UserInfoRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/28.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "UserInfoRequest.h"
#import "Networking.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "BaseModel.h"

@implementation UserInfoRequest
+ (void)requestLoginAccount:(NSString*)account
                   Password:(NSString *)password
                resultBlock:(void(^)(LolUserInfoModel *longinModel,
                                     BOOL isSuccess,
                                     NSDictionary *errorDic))resultBlock{
    UserInfoRequest * request = [[UserInfoRequest alloc] init];
    [request requestLoginAccount:account Password:password resultBlock:resultBlock];
}
- (void)requestLoginAccount:(NSString*)account
                   Password:(NSString *)password
                resultBlock:(void(^)(LolUserInfoModel *longinModel,
                                     BOOL isSuccess,
                                     NSDictionary *errorDic))resultBlock{
    if (_loginTask) {
        [_loginTask cancel];
    }
    NSString *deviceTokenStr = [YFKeychainTool readKeychainValue:kAPP_DEVICETOKEN];
    NSString *url = [NSString stringWithFormat:@"%@v5.login/index",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"account":account?account:@"",
                                       @"password":password?password:@"",@"device_token":deviceTokenStr?deviceTokenStr:@""} mutableCopy];
    
    _loginTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        LolUserInfoModel *loginModel = [LolUserInfoModel yy_modelWithDictionary:result];
        if (loginModel.code == 1) {
            [UserManager setObjectUserDefaults:loginModel key:userLogInInfo];
            //保存账号密码
            [YFKeychainTool saveKeychainValue:account key:@"userName"];
            [YFKeychainTool saveKeychainValue:password key:@"password"];
            //存上
            NSString *_pinpaistr = [UserManager getObjectUserDefaults:@"pinPaiStrkey"];
            LolUserInfoModel *model = [UserManager getObjectUserDefaults:userLogInInfo];
            [ShareWorkInstance shareInstance].uid = model.data.ID;
            [ShareWorkInstance shareInstance].share_data = model.data;
            for (Join_Code *join_code in model.data.join_code) {
                if ([join_code.name isEqualToString:_pinpaistr]) {
                    [ShareWorkInstance shareInstance].share_join_code = join_code;
                    [ShareWorkInstance shareInstance].join_code = join_code.code;
                    break;
                }
            }
            if (![ShareWorkInstance shareInstance].share_join_code) {
//                if (model.data.join_code.count <=0) {
//                    return ;
//                }
                Join_Code *join_code = model.data.join_code[0];
                [ShareWorkInstance shareInstance].share_join_code = join_code;
                [ShareWorkInstance shareInstance].join_code = join_code.code;
            }
            MzzLog(@"account---------%@",model.data.account);
            MzzLog(@"jconCode---------%@",[ShareWorkInstance shareInstance].join_code);
            resultBlock(loginModel,YES,nil);
        } else {
            [MzzHud toastWithTitle:@"提示" message:loginModel.msg complete:^{
                //清空账号密码及数据
                [YFKeychainTool deleteKeychainValue:@"userName"];
                [YFKeychainTool deleteKeychainValue:@"password"];
                [UserManager setObjectUserDefaults:nil key:userLogInInfo];
            }];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

/**
 *登录组织列表
 */
- (void)requestZhuzhi:(NSInteger)fram_name_id
              Fram_id:(NSInteger)fram_id
                   ID:(NSString *)idStr
          resultBlock:(void(^)(ZhuzhiModel *zhuzhiModel,
                               BOOL isSuccess,
                               NSDictionary *errorDic))resultBlock{
    if (_zhuzhiTask) {
        [_zhuzhiTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Framework_name/get_frame",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"fram_name_id":[NSString stringWithFormat:@"%@",@(fram_name_id)],
                                       @"fram_id":fram_id?@(fram_id):@"",
                                       @"id":idStr?idStr:@""
                                       } mutableCopy];
    
    _zhuzhiTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        ZhuzhiModel *zhuzhiModel = [ZhuzhiModel yy_modelWithDictionary:result];
        if (zhuzhiModel.code == 1) {
            resultBlock(zhuzhiModel,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":zhuzhiModel.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
/**
 * 商品组织架构列表
 */
+ (void)requestZuZhiGoodsListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(ZhuzhiModel *zhuzhiModel,
                                                                                         BOOL isSuccess,
                                                                                         NSDictionary *errorDic))resultBlock{
    UserInfoRequest * request = [[UserInfoRequest alloc] init];
    [request requestZuZhiGoodsListDataParam:param resultBlock:resultBlock];
}
- (void)requestZuZhiGoodsListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(ZhuzhiModel *zhuzhiModel,
                                                                                         BOOL isSuccess,
                                                                                         NSDictionary *errorDic))resultBlock{
    if (_goodsListTask) {
        [_goodsListTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Framework_name/get_frame",SERVER_APP];
    _goodsListTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        ZhuzhiModel *zhuzhiModel = [ZhuzhiModel yy_modelWithDictionary:result];
        if (zhuzhiModel.code == 1) {
            resultBlock(zhuzhiModel,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":zhuzhiModel.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
+ (void)requestSendCodePhone:(NSString *)phone resultBlock:(void(^)(BaseModel *model,
                                                                    BOOL isSuccess,
                                                                    NSDictionary *errorDic))resultBlock{
    UserInfoRequest * request = [[UserInfoRequest alloc] init];
    [request requestSendCodePhone:phone resultBlock:resultBlock];
}
- (void)requestSendCodePhone:(NSString *)phone resultBlock:(void(^)(BaseModel *model,
                                                                    BOOL isSuccess,
                                                                    NSDictionary *errorDic))resultBlock{
    if (_sendCodeTask) {
        [_sendCodeTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.login/sendCode",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"phone":phone?phone:@""} mutableCopy];
    
    _sendCodeTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            resultBlock(info,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
/**
 * 验证码校验
 */
+ (void)requestCheckPhone:(NSString *)phone
                     code:(NSString *)code
                fastLogin:(NSString *)fastLogin
              resultBlock:(void(^)(LolUserInfoModel *model,BOOL isSuccess,NSDictionary *errorDic))resultBlock{
    UserInfoRequest * request = [[UserInfoRequest alloc] init];
    [request requestCheckPhone:phone code:code fastLogin:fastLogin resultBlock:resultBlock];
}
- (void)requestCheckPhone:(NSString *)phone
                     code:(NSString *)code
                fastLogin:(NSString *)fastLogin
              resultBlock:(void(^)(LolUserInfoModel *model,BOOL isSuccess,NSDictionary *errorDic))resultBlock{
    if (_checkCodeTask) {
        [_checkCodeTask cancel];
    }
    NSString *deviceTokenStr = [YFKeychainTool readKeychainValue:kAPP_DEVICETOKEN];
    NSData *deviceToken =[deviceTokenStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@v5.login/checkCode",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"phone":phone?phone:@"",@"code":code?code:@"",@"fast_login":fastLogin?fastLogin:@"",@"device_token":deviceToken?deviceToken:@""} mutableCopy];
    
    _checkCodeTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
         LolUserInfoModel *loginModel = [LolUserInfoModel yy_modelWithDictionary:result];
        if (loginModel.code == 1) {
            [UserManager setObjectUserDefaults:loginModel key:userLogInInfo];
            
            //存上
            NSString *_pinpaistr = [UserManager getObjectUserDefaults:@"pinPaiStrkey"];
            LolUserInfoModel *model = [UserManager getObjectUserDefaults:userLogInInfo];
            [ShareWorkInstance shareInstance].uid = model.data.ID;
            for (Join_Code *join_code in model.data.join_code) {
                if ([join_code.name isEqualToString:_pinpaistr]) {
                    [ShareWorkInstance shareInstance].share_join_code = join_code;
                    [ShareWorkInstance shareInstance].join_code = join_code.code;
                    break;
                }
            }
            if (![ShareWorkInstance shareInstance].share_join_code) {
                Join_Code *join_code = model.data.join_code[0];
                [ShareWorkInstance shareInstance].share_join_code = join_code;
                [ShareWorkInstance shareInstance].join_code = join_code.code;
            }
            
            resultBlock(loginModel,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":loginModel.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
/**
 * 退出登录
 */
+ (void)requestLoginOutresultBlock:(void(^)(BaseModel *model,BOOL isSuccess,NSDictionary *errorDic))resultBlock{
    UserInfoRequest * request = [[UserInfoRequest alloc] init];
    [request requestLoginOutresultBlock:resultBlock];
}
/**
 * 退出登录
 */
- (void)requestLoginOutresultBlock:(void(^)(BaseModel *model,BOOL isSuccess,NSDictionary *errorDic))resultBlock{
    if (_loginOutTask) {
        [_loginOutTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.login/logout",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{} mutableCopy];
    _loginOutTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            resultBlock(info,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
@end
