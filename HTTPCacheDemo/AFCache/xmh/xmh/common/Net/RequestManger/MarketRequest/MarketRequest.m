//
//  MarketRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/30.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MarketRequest.h"
#import "Networking.h"
#import "MStoreListModel.h"
#import "MWareListModel.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
@implementation MarketRequest
+ (void)requestStoreFramId:(NSString *)frame
               resultBlock:(void(^)(MStoreListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MarketRequest * request = [[MarketRequest alloc] init];
    [request requestStoreFramId:frame resultBlock:resultBlock];
}
- (void)requestStoreFramId:(NSString *)frame
               resultBlock:(void(^)(MStoreListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_storeTask) {
        [_storeTask cancel];
    }
    NSMutableDictionary *params = [@{@"fram_id":frame?frame:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/getStore",SERVER_APP];
    _storeTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MStoreListModel  * model = [MStoreListModel yy_modelWithDictionary:info.data];
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
 * 营销应用商品
 */
+ (void)requestWareType:(NSString *)type
              storeCode:(NSString *)storeCode
            resultBlock:(void(^)(MWareListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MarketRequest * request = [[MarketRequest alloc] init];
    [request requestWareType:type storeCode:storeCode resultBlock:resultBlock];
}
- (void)requestWareType:(NSString *)type
              storeCode:(NSString *)storeCode
            resultBlock:(void(^)(MWareListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_wareTask) {
        [_wareTask cancel];
    }
    NSMutableDictionary *params = [@{@"type":type?type:@"",@"store_code":storeCode?storeCode:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/ware",SERVER_APP];
    _wareTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MWareListModel  * model = [MWareListModel yy_modelWithDictionary:info.data];
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
 * 二维码
 */
+ (void)requestQRcodeType:(NSString *)type
                storeCode:(NSString *)storeCode
                     code:(NSString *)code
              resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MarketRequest * request = [[MarketRequest alloc] init];
    [request requestQRcodeType:type storeCode:storeCode code:code resultBlock:resultBlock];
}
- (void)requestQRcodeType:(NSString *)type
                storeCode:(NSString *)storeCode
                     code:(NSString *)code
              resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_qCodeTask) {
        [_qCodeTask cancel];
    }
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = infomodel.data.account;
    NSMutableDictionary *params = [@{@"type":type?type:@"",@"store_code":storeCode?storeCode:@"",@"code":code?code:@"",@"account":account?account:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Bdframe/img_make",SERVER_APP];
    _qCodeTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
