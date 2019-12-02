//
//  LanternRequest.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternRequest.h"
#import "Networking.h"
#import "MzzTags.h"
@implementation LanternRequest
+ (void)requestRecommendData:(NSMutableDictionary *)param resultBlock:(void(^)(LanternRecommedListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    LanternRequest * request = [[LanternRequest alloc] init];
    [request requestRecommendData:param resultBlock:resultBlock];
}
- (void)requestRecommendData:(NSMutableDictionary *)param resultBlock:(void(^)(LanternRecommedListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_recommendListTask) {
        [_recommendListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Recommend/index",SERVER_APP];
    _recommendListTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LanternRecommedListModel * model =  [LanternRecommedListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestHistoryPlan:(NSMutableDictionary *)param resultBlock:(void(^)(LanternHistoryPlanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    LanternRequest * request = [[LanternRequest alloc] init];
    [request requestHistoryPlan:param resultBlock:resultBlock];
}
- (void)requestHistoryPlan:(NSMutableDictionary *)param resultBlock:(void(^)(LanternHistoryPlanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_historyPlanTask) {
        [_historyPlanTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Recommend/historyPlan",SERVER_APP];
    _historyPlanTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LanternHistoryPlanListModel * model =  [LanternHistoryPlanListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

- (void)requestPlanData:(NSMutableDictionary *)params resultBlock:(void(^)(MzzTagDatas *lolCalendarModelList, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    
    if (_planListTask) {
        [_planListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Recommend/setPlanInfo",SERVER_APP];
    _historyPlanTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzTagDatas *listModel  = [MzzTagDatas yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestPlanData:(NSMutableDictionary *)params resultBlock:(void(^)(MzzTagDatas *projectModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    LanternRequest *request = [[LanternRequest alloc] init];
    [request requestPlanData:params resultBlock:resultBlock];
}



+ (void)requestAddmakePlanData:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    LanternRequest *request = [[LanternRequest alloc] init];
    [request requestAddmakePlanData:params resultBlock:resultBlock];
}

- (void)requestAddmakePlanData:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_AddmakePlanTask) {
        [_AddmakePlanTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Recommend/makePlan",SERVER_APP];
    _AddmakePlanTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
+ (void)requestPlanInfoData:(NSMutableDictionary *)params resultBlock:(void(^)(LanternPlanInfoListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
     LanternRequest *request = [[LanternRequest alloc] init];
    [request requestPlanInfoData:params resultBlock:resultBlock];
}
- (void)requestPlanInfoData:(NSMutableDictionary *)params resultBlock:(void(^)(LanternPlanInfoListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    
    if (_planListTask) {
        [_planListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Recommend/setPlanInfo",SERVER_APP];
    _historyPlanTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LanternPlanInfoListModel *listModel  = [LanternPlanInfoListModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    LanternRequest *request = [[LanternRequest alloc] init];
    [request requestCommonUrl:url Param:params resultBlock:resultBlock];
}
- (void)requestCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_commonTask) {
        [_commonTask cancel];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",SERVER_COUNT,url];
    _commonTask = [Networking requestWithURL:urlStr params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info.data,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/*
 *  生成计划首页
 */
+ (void)requestSaleGoodsData:(NSMutableDictionary *)params resultBlock:(void(^)(LanternPlanInfoListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{}
@end
