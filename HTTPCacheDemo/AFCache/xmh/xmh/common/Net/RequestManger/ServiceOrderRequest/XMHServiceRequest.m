//
//  XMHServiceRequest.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceRequest.h"
#import "Networking.h"
#import "MzzHud.h"
#import "SASaleListModel.h"
@implementation XMHServiceRequest

/**
 服务单-处方服务选择
 */
+ (void)requestChuFangParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.serv/pres",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
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
 服务单-提卡服务选择
 */
+ (void)requestTiCardParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.serv/ti_card",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
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
 服务单-产品服务选择
 */
+ (void)requestGoodsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.serv/goods",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
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
 服务单-项目服务选择
 */
+ (void)requestProjectParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.serv/pro",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
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
 获取服务制单列表数据

 @param userId 顾客id
 */
+ (void)requestServiceListWithUserId:(NSString *)userId resultBlock:(void(^)(BOOL isSuccess, BaseModel *chuFangModel, BaseModel *tiKaModel, BaseModel *goodsModel, BaseModel *projectModel))resultBlock {
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"user_id"] = userId;
    // 处方
    [self requestChuFangParams:params resultBlock:^(BaseModel *chuFangModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (!isSuccess) {
            if (resultBlock) resultBlock(NO, nil, nil, nil, nil);
            return;
        }
        // 提卡
        [self requestTiCardParams:params resultBlock:^(BaseModel *tiKaModel, BOOL isSuccess, NSDictionary *errorDic) {
            if (!isSuccess) {
                if (resultBlock) resultBlock(NO, nil, nil, nil, nil);
                return;
            }
            // 商品
            [self requestGoodsParams:params resultBlock:^(BaseModel *goodsModel, BOOL isSuccess, NSDictionary *errorDic) {
                if (!isSuccess) {
                    if (resultBlock) resultBlock(NO, nil, nil, nil, nil);
                    return;
                }
                // 项目
                [self requestProjectParams:params resultBlock:^(BaseModel *projectModel, BOOL isSuccess, NSDictionary *errorDic) {
                    if (!isSuccess) {
                        if (resultBlock) resultBlock(NO, nil, nil, nil, nil);
                        return;
                    }
                    if (resultBlock) resultBlock(YES, chuFangModel, tiKaModel, goodsModel, projectModel);
                }];
            }];
        }];
    }];
}
+ (void)requestSeverListNumParams:(NSMutableDictionary *)params
                      resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    NSString *url = [NSString stringWithFormat:@"%@v5.serv_1/serv_list_num",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
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
