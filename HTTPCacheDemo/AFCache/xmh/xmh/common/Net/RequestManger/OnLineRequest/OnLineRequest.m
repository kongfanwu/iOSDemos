//
//  OnLineRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OnLineRequest.h"
#import "Networking.h"
#import "OHomeListModel.h"
#import "OTopModel.h"
#import "OOrderListModel.h"
#import "ExpressListModel.h"
#import "ZhuzhiModel.h"
#import "OnFramListModel.h"
@implementation OnLineRequest
+ (void)requestListJoinCode:(NSString *)joinCode
                   oneClick:(NSString *)oneClick
                   twoClick:(NSString *)twoClick
                  twoListId:(NSString *)twoListId
                   thrClick:(NSString *)thrClick
                   fouClick:(NSString *)fouClick
                      start:(NSString *)start
                        end:(NSString *)end
                      param:(NSString *)param
                       page:(NSString *)page
                resultBlock:(void(^)(OHomeListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    OnLineRequest * request = [[OnLineRequest alloc] init];
    [request requestListJoinCode:joinCode oneClick:oneClick twoClick:twoClick twoListId:twoListId thrClick:thrClick fouClick:fouClick start:start end:end param:param page:page resultBlock:resultBlock];
}
- (void)requestListJoinCode:(NSString *)joinCode oneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId thrClick:(NSString *)thrClick fouClick:(NSString *)fouClick start:(NSString *)start end:(NSString *)end param:(NSString *)param page:(NSString *)page resultBlock:(void(^)(OHomeListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_listTask) {
        [_listTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"thrClick":thrClick?thrClick:@"-1",@"fouClick":fouClick?fouClick:@"-1",@"start":start?start:@"",@"end":end?end:@"",@"param":param?param:@"",@"page":page?page:@"0"} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Online/get_list",SERVER_APP];
    _listTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            OHomeListModel  * model = [OHomeListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTopDataJoinCode:(NSString *)joinCode
                      oneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                      thrClick:(NSString *)thrClick
                      fouClick:(NSString *)fouClick
                         start:(NSString *)start
                           end:(NSString *)end
                   resultBlock:(void(^)(OTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    OnLineRequest * request = [[OnLineRequest alloc] init];
    [request requestTopDataJoinCode:joinCode oneClick:oneClick twoClick:twoClick twoListId:twoListId thrClick:thrClick fouClick:fouClick start:start end:end resultBlock:resultBlock];
}
- (void)requestTopDataJoinCode:(NSString *)joinCode
                      oneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                      thrClick:(NSString *)thrClick
                      fouClick:(NSString *)fouClick
                         start:(NSString *)start
                           end:(NSString *)end
                   resultBlock:(void(^)(OTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_topTask) {
        [_topTask cancel];
    }
    NSMutableDictionary *params =[@{@"join_code":joinCode?joinCode:@"",@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"thrClick":thrClick?thrClick:@"-1",@"fouClick":fouClick?fouClick:@"-1",@"start":start?start:@"",@"end":end?end:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Online/top_data",SERVER_APP];
    _topTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            OTopModel  * model = [OTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestOrderListJoinCode:(NSString *)joinCode
                        oneClick:(NSString *)oneClick
                        twoClick:(NSString *)twoClick
                       twoListId:(NSString *)twoListId
                        thrClick:(NSString *)thrClick
                        fouClick:(NSString *)fouClick
                           start:(NSString *)start
                             end:(NSString *)end
                            Type:(NSString *)type
                          parame:(NSString *)parame
                            page:(NSString *)page
                     resultBlock:(void(^)(OOrderListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     OnLineRequest * request = [[OnLineRequest alloc] init];
    [request requestOrderListJoinCode:joinCode oneClick:oneClick twoClick:twoClick twoListId:twoListId thrClick:thrClick fouClick:fouClick start:start end:end Type:type parame:parame page:page resultBlock:resultBlock];
}
- (void)requestOrderListJoinCode:(NSString *)joinCode
                        oneClick:(NSString *)oneClick
                        twoClick:(NSString *)twoClick
                       twoListId:(NSString *)twoListId
                        thrClick:(NSString *)thrClick
                        fouClick:(NSString *)fouClick
                           start:(NSString *)start
                             end:(NSString *)end
                            Type:(NSString *)type
                          parame:(NSString *)parame
                            page:(NSString *)page
                     resultBlock:(void(^)(OOrderListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_orderListTask) {
        [_orderListTask cancel];
    }
    NSMutableDictionary *params =[@{@"join_code":joinCode?joinCode:@"",@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"thrClick":thrClick?thrClick:@"-1",@"fouClick":fouClick?fouClick:@"-1",@"start":start?start:@"",@"end":end?end:@"",@"type":type?type:@"",@"param":parame?parame:@"",@"page":page?page:@"0"} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Online/order_list",SERVER_APP];
    _orderListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            OOrderListModel  * model = [OOrderListModel yy_modelWithDictionary:info.data];
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
 *  订单发货
 */
+ (void)requestDeliverOrderNum:(NSString *)orderNum
                          type:(NSString *)type
                       express:(NSString *)express
                        expnum:(NSString *)expnum
                   resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     OnLineRequest * request = [[OnLineRequest alloc] init];
    [request requestDeliverOrderNum:orderNum type:type express:express expnum:express resultBlock:resultBlock];
}

- (void)requestDeliverOrderNum:(NSString *)orderNum
                          type:(NSString *)type
                       express:(NSString *)express
                        expnum:(NSString *)expnum
                   resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_deliverTask) {
        [_deliverTask cancel];
    }
    NSMutableDictionary *params = [@{@"ordernum":orderNum?orderNum:@"",@"type":type?type:@"",@"express":express?express:@"",@"expnum":expnum?expnum:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Online/deliver",SERVER_APP];
    _deliverTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
 *  快递种类
 */
+ (void)requestExpressResultBlock:(void(^)(ExpressListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    OnLineRequest * request = [[OnLineRequest alloc] init];
    [request requestExpressResultBlock:resultBlock];
}
- (void)requestExpressResultBlock:(void(^)(ExpressListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_expressTask) {
        [_expressTask cancel];
    }
    NSMutableDictionary *params = [@{} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Online/express",SERVER_APP];
    _deliverTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            ExpressListModel  * model = [ExpressListModel yy_modelWithDictionary:info.data];
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
 *  线上交易组织架构
 */
+ (void)requestOnlineFrameId:(NSString *)framId
                 resultBlock:(void(^)(OnFramListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    OnLineRequest * request = [[OnLineRequest alloc] init];
    [request requestOnlineFrameId:framId resultBlock:resultBlock];
}
- (void)requestOnlineFrameId:(NSString *)framId
                 resultBlock:(void(^)(OnFramListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_OnlineFrameTask) {
        [_OnlineFrameTask cancel];
    }
    NSMutableDictionary *params = [@{@"fram_id":framId?framId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Online/online_frame",SERVER_APP];
    _deliverTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            OnFramListModel  * model = [OnFramListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
@end
