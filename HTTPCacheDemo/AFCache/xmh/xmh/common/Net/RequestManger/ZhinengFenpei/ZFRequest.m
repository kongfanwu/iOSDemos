//
//  ZFRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ZFRequest.h"
#import "Networking.h"
#import "BaseModel.h"
#import "MzzHud.h"
#import "ZFUserListModel.h"
#import "LSADaiFenPeiModel.h"
#import "LAllocationDetaiModel.h"
@implementation ZFRequest
- (void)requestUserListParams:(NSMutableDictionary *)params resultBlock:(void(^)(ZFUserListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_userlistTask) {
        [_userlistTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Zhinengfenpei/user_list",SERVER_APP];
    _userlistTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            ZFUserListModel *model = [ZFUserListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestUserListParams:(NSMutableDictionary *)params resultBlock:(void(^)(ZFUserListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ZFRequest *request = [[self alloc] init];
    [request requestUserListParams:params resultBlock:resultBlock];
}

- (void)requestYiJianFenPeiParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_yijianfenpeiTask) {
        [_yijianfenpeiTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Zhinengfenpei/distri",SERVER_APP];
    _yijianfenpeiTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
          resultBlock(info,YES,nil);
        
        }else{
        
        }
        [MzzHud toastWithTitle:@"提示" message:result[@"msg"]];
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestYiJianFenPeiParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ZFRequest *request = [[self alloc] init];
    [request requestYiJianFenPeiParams:params resultBlock:resultBlock];
}

- (void)requestDistriParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_distriTask) {
        [_distriTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Zhinengfenpei/button",SERVER_APP];
    _distriTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            resultBlock(info,YES,nil);
//            [MzzHud toastWithTitle:@"提示" message:@"成功"];
        }
        
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestDistriParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ZFRequest *request = [[self alloc] init];
    [request requestDistriParams:params resultBlock:resultBlock];
}
+ (void)requerstDaiFenPeiFramId:(NSString *)framId
                          level:(NSString *)level
                           type:(NSString *)type
                           page:(NSString *)page
                       pageSize:(NSString *)pageSize
                       joinCode:(NSString *)joinCode
                              q:(NSString *)q
                    resultBlock:(void(^)(LSADaiFenPeiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ZFRequest *request = [[self alloc] init];
    [request requerstDaiFenPeiFramId:framId level:level type:type page:page pageSize:pageSize joinCode:joinCode q:q resultBlock:resultBlock];
}
- (void)requerstDaiFenPeiFramId:(NSString *)framId
                          level:(NSString *)level
                           type:(NSString *)type
                           page:(NSString *)page
                       pageSize:(NSString *)pageSize
                       joinCode:(NSString *)joinCode
                              q:(NSString *)q
                    resultBlock:(void(^)(LSADaiFenPeiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_daiFenPeiTask) {
        [_daiFenPeiTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Zhinengfenpei/fenp_list",SERVER_APP];
    NSMutableDictionary * params = [@{@"fram_id":framId?framId:@"",@"level":level?level:@"",@"type":type?type:@"",@"page":page?page:@"",@"pageSize":pageSize?pageSize:@"5",@"join_code":joinCode?joinCode:@"",@"q":q?q:@""} mutableCopy];
    _daiFenPeiTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            LSADaiFenPeiModel *model = [LSADaiFenPeiModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestAllocationDetailUserId:(NSString *)userid
                                  jis:(NSString *)jis
                             joincode:(NSString *)joincode
                          resultBlock:(void(^)(LAllocationDetaiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    ZFRequest *request = [[self alloc] init];
    [request requestAllocationDetailUserId:userid jis:jis joincode:joincode resultBlock:resultBlock];
}
- (void)requestAllocationDetailUserId:(NSString *)userid
                                  jis:(NSString *)jis
                             joincode:(NSString *)joincode
                          resultBlock:(void(^)(LAllocationDetaiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_allocationDetailTask) {
        [_allocationDetailTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Zhinengfenpei/pf_info",SERVER_APP];
    NSMutableDictionary * params = [@{@"user_id":userid?userid:@"",@"jis":jis?jis:@"",@"join_code":joincode?joincode:@""} mutableCopy];
    _allocationDetailTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            LAllocationDetaiModel *model = [LAllocationDetaiModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
    
    
}
@end
