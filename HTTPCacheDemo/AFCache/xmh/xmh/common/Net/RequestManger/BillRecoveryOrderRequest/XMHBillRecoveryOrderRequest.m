//
//  XMHBillRecoveryOrderRequest.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBillRecoveryOrderRequest.h"
#import "Networking.h"
#import "BaseModel.h"
#import "XMHBillRecoveryListModel.h"
#import "XMHBillReListModel.h"
@interface XMHBillRecoveryOrderRequest ()
{
    NSURLSessionDataTask * _billSidebarTask;
    NSURLSessionDataTask * _billProTask;
    NSURLSessionDataTask * _billTicketTask;
    NSURLSessionDataTask * _billGoodsTask;
    NSURLSessionDataTask * _billTimeTask;
    NSURLSessionDataTask * _billNumCardTask;
    NSURLSessionDataTask * _billCardTask;
    NSURLSessionDataTask * _billCommitTask;
}
@end

@implementation XMHBillRecoveryOrderRequest

+ (void)requestBillRecoverySidebarParams:(NSMutableDictionary *)params
                       resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHBillRecoveryOrderRequest *request = [XMHBillRecoveryOrderRequest new];
    [request requestBillRecoverySidebarParams:params resultBlock:resultBlock];
}
- (void)requestBillRecoverySidebarParams:(NSMutableDictionary *)params
                       resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_billSidebarTask) {
        [_billSidebarTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.sales_new/getLeft.html",SERVER_APP];
    _billSidebarTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            XMHBillRecoveryListModel * model = [XMHBillRecoveryListModel yy_modelWithDictionary:info.data];
            resultBlock(model.list,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestBillRecoveryProContentParams:(NSMutableDictionary *)params
                             resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHBillRecoveryOrderRequest *request = [XMHBillRecoveryOrderRequest new];
    [request requestBillRecoveryProContentParams:params resultBlock:resultBlock];
}

- (void)requestBillRecoveryProContentParams:(NSMutableDictionary *)params
                             resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_billProTask) {
        [_billProTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_pro_pro",SERVER_APP];
    _billProTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            XMHBillReListModel * model = [XMHBillReListModel yy_modelWithDictionary:info.data];
            NSMutableArray *resultArr = [NSMutableArray array];
            resultArr = model.list;
            resultBlock(resultArr,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 回收置换-票券列表
 
 @param params @[@"user_id":@"用户id"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryTicketContentParams:(NSMutableDictionary *)params
                                   resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHBillRecoveryOrderRequest *request = [XMHBillRecoveryOrderRequest new];
    [request requestBillRecoveryTicketContentParams:params resultBlock:resultBlock];
    
}

- (void)requestBillRecoveryTicketContentParams:(NSMutableDictionary *)params
                                   resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_billTicketTask) {
        [_billTicketTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_ticket_ticket",SERVER_APP];
    _billTicketTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            XMHBillReTicketListModel * model = [XMHBillReTicketListModel yy_modelWithDictionary:info.data];
            resultBlock(model.list,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 回收置换-产品列表
 
 @param params @[@"user_id":@"用户id"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryGoodsContentParams:(NSMutableDictionary *)params
                                  resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHBillRecoveryOrderRequest *request = [XMHBillRecoveryOrderRequest new];
    [request requestBillRecoveryGoodsContentParams:params resultBlock:resultBlock];
}

- (void)requestBillRecoveryGoodsContentParams:(NSMutableDictionary *)params
                                  resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    //
    if (_billGoodsTask) {
        [_billGoodsTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_goods_goods",SERVER_APP];
    _billGoodsTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            XMHBillReGoodsListModel * model = [XMHBillReGoodsListModel yy_modelWithDictionary:info.data];
            resultBlock(model.list,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 回收置换-储值卡列表
 
 @param params @[@"user_id":@"用户id"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryCardContentParams:(NSMutableDictionary *)params
                                 resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHBillRecoveryOrderRequest *request = [XMHBillRecoveryOrderRequest new];
    [request requestBillRecoveryCardContentParams:params resultBlock:resultBlock];
}

- (void)requestBillRecoveryCardContentParams:(NSMutableDictionary *)params
                                 resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_billCardTask) {
        [_billCardTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_card_card",SERVER_APP];
    _billCardTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            XMHBillReCardListModel * model = [XMHBillReCardListModel yy_modelWithDictionary:info.data];
            resultBlock(model.list,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 回收置换-时间卡列表
 
 @param params @[@"user_id":@"用户id"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryTimeContentParams:(NSMutableDictionary *)params
                                 resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHBillRecoveryOrderRequest *request = [XMHBillRecoveryOrderRequest new];
    [request requestBillRecoveryTimeContentParams:params resultBlock:resultBlock];
}


- (void)requestBillRecoveryTimeContentParams:(NSMutableDictionary *)params
                                 resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_billTimeTask) {
        [_billTimeTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_time_time",SERVER_APP];
    _billTimeTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            XMHBillReTimeListModel * model = [XMHBillReTimeListModel yy_modelWithDictionary:info.data];
            resultBlock(model.list,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 回收置换-任选卡列表
 
 @param params @[@"user_id":@"用户id"]
 @param resultBlock 返回数据
 */
+ (void)requestBillRecoveryOptionalCardContentParams:(NSMutableDictionary *)params
                                         resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHBillRecoveryOrderRequest *request = [XMHBillRecoveryOrderRequest new];
    [request requestBillRecoveryOptionalCardContentParams:params resultBlock:resultBlock];
}

- (void)requestBillRecoveryOptionalCardContentParams:(NSMutableDictionary *)params
                                         resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_billNumCardTask) {
        [_billNumCardTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_num_num",SERVER_APP];
    _billNumCardTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            XMHBillReNumCardListModel * model = [XMHBillReNumCardListModel yy_modelWithDictionary:info.data];
            resultBlock(model.list,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestBillRecoveryCommitParams:(NSMutableDictionary *)params
                            resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHBillRecoveryOrderRequest *request = [XMHBillRecoveryOrderRequest new];
    [request requestBillRecoveryCommitParams:params resultBlock:resultBlock];
}
- (void)requestBillRecoveryCommitParams:(NSMutableDictionary *)params
                            resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_billCommitTask) {
        [_billCommitTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.sales_new/postExchange.html",SERVER_APP];
    _billCommitTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
@end
