//
//  MineRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/14.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MineRequest.h"
#import "Networking.h"
#import "BaseModel.h"
#import "MineTopModel.h"
#import "MineInformationModel.h"
@implementation MineRequest
+ (void)requestTopDataFramId:(NSString *)framId
                         uid:(NSString *)uid
                    joinCode:(NSString *)joinCode
                 resultBlock:(void(^)(MineTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MineRequest * request = [[MineRequest alloc] init];
    [request requestTopDataFramId:framId uid:uid joinCode:joinCode resultBlock:resultBlock];
}
- (void)requestTopDataFramId:(NSString *)framId
                         uid:(NSString *)uid
                    joinCode:(NSString *)joinCode
                 resultBlock:(void(^)(MineTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_topDataTask) {
        [_topDataTask cancel];
    }
    NSMutableDictionary *params = [@{@"fram_id":framId?framId:@"",@"id":uid?uid:@"",@"join_code":joinCode?joinCode:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/brief",SERVER_APP];
    _topDataTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MineTopModel * model = [MineTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestInformationId:(NSString *)uid resultBlock:(void(^)(MineInformationModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     MineRequest * request = [[MineRequest alloc] init];
    [request requestInformationId:uid resultBlock:resultBlock];
}
- (void)requestInformationId:(NSString *)uid resultBlock:(void(^)(MineInformationModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_informationTask) {
        [_informationTask cancel];
    }
    NSMutableDictionary *params = [@{@"id":uid?uid:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/datum",SERVER_APP];
    _informationTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MineInformationModel * model = [MineInformationModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestModifyPwdUid:(NSString *)uid
                     oldPwd:(NSString *)oldPwd
                     newPwd:(NSString *)newPwd
                resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MineRequest * request = [[MineRequest alloc] init];
    [request requestModifyPwdUid:uid oldPwd:oldPwd newPwd:newPwd resultBlock:resultBlock];
}
- (void)requestModifyPwdUid:(NSString *)uid
                     oldPwd:(NSString *)oldPwd
                     newPwd:(NSString *)newPwd
                resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_modifyPwdTask) {
        [_modifyPwdTask cancel];
    }
    NSMutableDictionary *params = [@{@"id":uid?uid:@"",@"old_pwd":oldPwd?oldPwd:@"",@"new_pwd":newPwd?newPwd:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/modifyPwd",SERVER_APP];
    _informationTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
            [MzzHud toastWithTitle:@"提示" message:@"密码修改成功"];
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
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
                        resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MineRequest * request = [[MineRequest alloc] init];
    [request requestModdfyInformationUid:uid headImg:headImg name:name sex:sex idCard:idCard birthday:birthday area:area address:address phone:phone code:code bankCard:bankCard bank:bank openBank:openBank cardholder:cardholder resultBlock:resultBlock];
}
- (void)requestModdfyInformationUid:(NSString *)uid
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
                        resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_modifyInformationTask) {
        [_modifyInformationTask cancel];
    }
    NSMutableDictionary *params = [@{@"id":uid?uid:@"",@"head_img":headImg?headImg:@"",@"name":name?name:@"",@"sex":sex?sex:@"",@"id_card":idCard?idCard:@"",@"birth_day":birthday?birthday:@"",@"area":area?area:@"",@"address":address?address:@"",@"phone":phone?phone:@"",@"code":code?code:@"",@"bank_card":bankCard?bankCard:@"",@"bank":bank?bank:@"",@"open_bank":openBank?openBank:@"",@"cardholder":cardholder?cardholder:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/modify",SERVER_APP];
    _modifyInformationTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
            [MzzHud toastWithTitle:@"提示" message:@"修改成功"];
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestModifyPhone:(NSString *)phone
                      code:(NSString *)code
                       uid:(NSString *)uid
               resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    [MineRequest requestModdfyInformationUid:uid headImg:nil name:nil sex:nil idCard:nil birthday:nil area:nil address:nil phone:phone code:code bankCard:nil bank:nil openBank:nil cardholder:nil resultBlock:resultBlock];
}
+ (void)requestCodePhone:(NSString *)phone
             resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MineRequest * request = [[MineRequest alloc] init];
    [request requestCodePhone:phone resultBlock:resultBlock];
}
- (void)requestCodePhone:(NSString *)phone
             resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    
    if (_modifyCodeTask) {
        [_modifyCodeTask cancel];
    }
    NSMutableDictionary *params = [@{@"phone":phone?phone:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/sendCode",SERVER_APP];
    _modifyCodeTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
+ (void)requestFeedbackParams:(NSMutableDictionary *)params
               resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MineRequest * request = [[MineRequest alloc] init];
    [request requestFeedbackParams:params resultBlock:resultBlock];
}
- (void)requestFeedbackParams:(NSMutableDictionary *)params
               resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_feedbackTask) {
        [_feedbackTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.feedback/add.html",SERVER_APP];
    _feedbackTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"提交失败，请检查网络重新提交"];
    }];
}

+ (void)requestInvitationCodeParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    MineRequest * request = [[MineRequest alloc] init];
    [request requestInvitationCodeParams:params resultBlock:resultBlock];
}

- (void)requestInvitationCodeParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_invitationodeTask) {
        [_invitationodeTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Join_enter/getInvite",SERVER_APP];
    _invitationodeTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
