//
//  WorkRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/17.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "WorkRequest.h"
#import "Networking.h"
@implementation WorkRequest

+ (void)requestWorkHeard:(NSString *)joinCode
                  framId:(NSString *)framId
                 account:(NSString *)account
             resultBlock:(void(^)(WorkModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    WorkRequest * request = [[WorkRequest alloc] init];
    [request requestWorkHeard:joinCode framId:framId account:account resultBlock:resultBlock];
}
-(void)requestWorkHeard:(NSString *)joinCode
                    framId:(NSString *)framId
                   account:(NSString *)account
               resultBlock:(void(^)(WorkModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_jinRiTask) {
        [_jinRiTask cancel];
    }
    NSMutableDictionary *params = [@{@"fram_id":framId?framId:@"",@"join_code":joinCode?joinCode:@"",@"account":account?account:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/getRole",SERVER_APP];
    _jinRiTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            WorkModel  * model = [WorkModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestWorkJoinCode:(NSString *)joinCode
                 functionId:(NSString *)functionId
                     framId:(NSString *)framId
                        uid:(NSString *)uid
                       time:(NSString *)time
                    account:(NSString *)account
                resultBlock:(void(^)(WorkModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    WorkRequest * request = [[WorkRequest alloc] init];
    [request requestWorkJoinCode:joinCode functionId:functionId framId:framId uid:uid time:time account:account resultBlock:resultBlock];
}
- (void)requestWorkJoinCode:(NSString *)joinCode
                 functionId:(NSString *)functionId
                     framId:(NSString *)framId
                        uid:(NSString *)uid
                       time:(NSString *)time
                    account:(NSString *)account
                resultBlock:(void(^)(WorkModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_daogouTask) {
        [_daogouTask cancel];
    }
    NSMutableDictionary *params = [@{@"fram_id":framId?framId:@"",@"id":uid?uid:@"",@"join_code":joinCode?joinCode:@"",@"function_id":functionId?functionId:@"",@"time":time?time:@"",@"account":account?account:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/work",SERVER_APP];
    _daogouTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            WorkModel  * model = [WorkModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestDaiYuYueWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiYuYueModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    WorkRequest * request = [[WorkRequest alloc] init];
    [request requestDaiYuYueWithParams:params resultBlock:resultBlock];
    
}

- (void)requestDaiYuYueWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiYuYueModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_daiyuyueTask) {
        [_daiyuyueTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/workList_dyy",SERVER_APP];
    _daiyuyueTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        MzzDaiYuYueModel  * model = [MzzDaiYuYueModel yy_modelWithDictionary:result];
        if (model.code ==1) {
             resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:model.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestDaiShenPiWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiShenPiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    WorkRequest * request = [[WorkRequest alloc] init];
    [request requestDaiShenPiWithParams:params resultBlock:resultBlock];
    
}

- (void)requestDaiShenPiWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiShenPiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_daishenpiTask) {
        [_daishenpiTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/workList_dsp",SERVER_APP];
    _daishenpiTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        MzzDaiShenPiModel  * model = [MzzDaiShenPiModel yy_modelWithDictionary:result];
        if (model.code ==1) {
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:model.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestDaiFuWuWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiFuWuModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    WorkRequest * request = [[WorkRequest alloc] init];
    [request requestDaiFuWuWithParams:params resultBlock:resultBlock];
    
}

- (void)requestDaiFuWuWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiFuWuModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_daifuwuTask) {
        [_daifuwuTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/workList_dfw",SERVER_APP];
    _daifuwuTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        MzzDaiFuWuModel  * model = [MzzDaiFuWuModel yy_modelWithDictionary:result];
        if (model.code ==1) {
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:model.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestDaiGenJinWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiGenJinModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    WorkRequest * request = [[WorkRequest alloc] init];
    [request requestDaiGenJinWithParams:params resultBlock:resultBlock];
    
}
- (void)requestDaiGenJinWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDaiGenJinModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_daigenjinTask) {
        [_daigenjinTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/workList_dgj",SERVER_APP];
    _daigenjinTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        MzzDaiGenJinModel  * model = [MzzDaiGenJinModel yy_modelWithDictionary:result];
        if (model.code ==1) {
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:model.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+(void)requestJinRiWithParams:(NSMutableDictionary *)params resultBlock:(void (^)(MzzWordManagerModel *, BOOL, NSDictionary *))resultBlock
{
    WorkRequest * request = [[WorkRequest alloc] init];
    [request requestManagerWithParams:params resultBlock:resultBlock];
}
#pragma mark ---------会工作list列表数据--------------
- (void)requestManagerWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzWordManagerModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_workList) {
        [_workList cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/getRankings",SERVER_APP];
    _workList = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzWordManagerModel  * model = [MzzWordManagerModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestWorkListWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzWorkListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    WorkRequest * request = [[WorkRequest alloc] init];
    [request requestWorkListWithParams:params resultBlock:resultBlock];
    
}

- (void)requestWorkListWithParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzWorkListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_daigenjinTask) {
        [_daigenjinTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/workList_list",SERVER_APP];
    _daigenjinTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        MzzWorkListModel  * model = [MzzWorkListModel yy_modelWithDictionary:result];
        if (model.code ==1) {
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:model.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestWorkGreetParams:(NSMutableDictionary *)params resultBlock:(void(^)(WorkGreetListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    WorkRequest * request = [[WorkRequest alloc] init];
    [request requestWorkGreetParams:params resultBlock:resultBlock];
}
- (void)requestWorkGreetParams:(NSMutableDictionary *)params resultBlock:(void(^)(WorkGreetListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_greetList) {
        [_greetList cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Welcome_page/getPage",SERVER_APP];
    _greetList = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * model = [BaseModel yy_modelWithDictionary:result];
        if (model.code ==1) {
            WorkGreetListModel * greetModel = [WorkGreetListModel yy_modelWithDictionary:model.data];
            resultBlock(greetModel,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:model.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestWorkGuangGaoParams:(NSMutableDictionary *)params resultBlock:(void(^)(WorkGreetListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    WorkRequest * request = [[WorkRequest alloc] init];
    [request requestWorkGuangGaoParams:params resultBlock:resultBlock];
}
- (void)requestWorkGuangGaoParams:(NSMutableDictionary *)params resultBlock:(void(^)(WorkGreetListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_guanggaoList) {
        [_guanggaoList cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Welcome_page/getStart",SERVER_APP];
    _guanggaoList = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * model = [BaseModel yy_modelWithDictionary:result];
        if (model.code ==1) {
            WorkGreetListModel * greetModel = [WorkGreetListModel yy_modelWithDictionary:model.data];
            resultBlock(greetModel,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:model.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestJoinStateParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    WorkRequest * request = [[WorkRequest alloc] init];
    [request requestJoinStateParams:params resultBlock:resultBlock];
}
- (void)requestJoinStateParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_joinCodeStateTask) {
        [_joinCodeStateTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/getJoinState",SERVER_APP];
    _joinCodeStateTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * model = [BaseModel yy_modelWithDictionary:result];
        if (model.code ==1) {
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:model.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
@end
