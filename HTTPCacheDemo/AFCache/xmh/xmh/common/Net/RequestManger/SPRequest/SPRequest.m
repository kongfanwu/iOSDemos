//
//  SPRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/29.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SPRequest.h"
#import "Networking.h"
#import "BaseModel.h"
#import "MzzHud.h"
#import "SPGetNumModel.h"
#import "SPSearchUserModel.h"
#import "SPCongealModel.h"
#import "SPGetStoreModel.h"
#import "SPSearchStoreUserModel.h"
#import "SPChangeStoreModel.h"
#import "SPGetTdPersonModel.h"
#import "SPGetStoresModel.h"
@implementation SPRequest
- (void)requestGetNumParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetNumModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_getNumTask) {
        [_getNumTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/getNum",SERVER_APP];
    _getNumTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SPGetNumModel *model = [SPGetNumModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestGetNumParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetNumModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SPRequest *request = [[self alloc] init];
    [request requestGetNumParams:params resultBlock:resultBlock];
}


- (void)requestSearchUserParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPSearchUserModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_searchUserTask) {
        [_searchUserTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/searchUser",SERVER_APP];
    _searchUserTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SPSearchUserModel *model = [SPSearchUserModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestSearchUserParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPSearchUserModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SPRequest *request = [[self alloc] init];
    [request requestSearchUserParams:params resultBlock:resultBlock];
}

- (void)requestCongealUserParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPCongealModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_congealTask) {
        [_congealTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/congeal",SERVER_APP];
    _congealTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SPCongealModel *model = [SPCongealModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestCongealUserParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPCongealModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SPRequest *request = [[self alloc] init];
    [request requestCongealUserParams:params resultBlock:resultBlock];
}

- (void)requestGetStoreParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetStoreModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_getStoreTask) {
        [_getStoreTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/getStore",SERVER_APP];
    _getStoreTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SPGetStoreModel *model = [SPGetStoreModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestGetStoreParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetStoreModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SPRequest *request = [[self alloc] init];
    [request requestGetStoreParams:params resultBlock:resultBlock];
}

- (void)requestSearchStoreUserParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPSearchStoreUserModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_searchStoreTask) {
        [_searchStoreTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/searchStoreUser",SERVER_APP];
    _searchStoreTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SPSearchStoreUserModel *model = [SPSearchStoreUserModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestSearchStoreUserParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPSearchStoreUserModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SPRequest *request = [[self alloc] init];
    [request requestSearchStoreUserParams:params resultBlock:resultBlock];
}


- (void)requestChangeStoreParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPChangeStoreModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_changeStoreTask) {
        [_changeStoreTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/changeStore",SERVER_APP];
    _changeStoreTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SPChangeStoreModel *model = [SPChangeStoreModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestChangeStoreParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPChangeStoreModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SPRequest *request = [[self alloc] init];
    [request requestChangeStoreParams:params resultBlock:resultBlock];
}

- (void)requestgetTdPersonParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetTdPersonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_getTdPersonTask) {
        [_getTdPersonTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/getTdPerson",SERVER_APP];
    _getTdPersonTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SPGetTdPersonModel *model = [SPGetTdPersonModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestgetTdPersonParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetTdPersonModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SPRequest *request = [[self alloc] init];
    [request requestgetTdPersonParams:params resultBlock:resultBlock];
}


- (void)requestgetStoresParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetStoresModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_getStoresTask) {
        [_getStoresTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/getStores",SERVER_APP];
    _getStoresTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SPGetStoresModel *model = [SPGetStoresModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestgetStoresParams:(NSMutableDictionary *)params resultBlock:(void(^)(SPGetStoresModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SPRequest *request = [[self alloc] init];
    [request requestgetStoresParams:params resultBlock:resultBlock];
}

- (void)requestPostChangeStoreParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_postChangeStoreTask) {
        [_postChangeStoreTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/postChangeStore",SERVER_APP];
    _postChangeStoreTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        resultBlock(info,YES,nil);
        
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestPostChangeStoreParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SPRequest *request = [[self alloc] init];
    [request requestPostChangeStoreParams:params resultBlock:resultBlock];
}
@end
