//
//  XMHCredentialManageRequest.m
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentialManageRequest.h"

@implementation XMHCredentialManageRequest

/**
 服务八统
 */
+ (void)requestServiceTongJiParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.serv_1/serv_tongji",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        if (resultBlock) resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 销售八统
 */
+ (void)requestSalesTongJiParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.serv_1/sales_tongji",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        if (resultBlock) resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 销售 服务 八统
 */
+ (void)requestSalesServiceTongJiParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSArray <XMHCredentiaItemModel *> *salesModelArray, NSArray <XMHCredentiaItemModel *> *serviceModelArray, BOOL isSuccess))resultBlock {
    [self requestSalesTongJiParams:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (!isSuccess) {
            if (resultBlock) resultBlock(nil, nil, NO);
            return;
        }
        
        NSMutableArray *salesModelArray = NSMutableArray.new;
        NSArray *yuanlist = [XMHCredentiaItemModel salesTongJiArray];
        for (NSDictionary *item in yuanlist) {
            XMHCredentiaItemModel *itemModel = XMHCredentiaItemModel.new;
            itemModel.serviceKey = item[@"key"];
            itemModel.title = item[@"name"];
            itemModel.imageName = item[@"imageName"];
            itemModel.count = [NSString stringWithFormat:@"%@", model.data[itemModel.serviceKey]];
            itemModel.type = [((NSNumber *)item[@"arrow"]) integerValue];
            [salesModelArray addObject:itemModel];
        }
        
        [self requestServiceTongJiParams:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
            if (!isSuccess) {
                if (resultBlock) resultBlock(nil, nil, NO);
                return;
            }
            
            NSMutableArray *serviceModelArray = NSMutableArray.new;
            NSArray *yuanlist = [XMHCredentiaItemModel serviceTongJiArray];
            for (NSDictionary *item in yuanlist) {
                XMHCredentiaItemModel *itemModel = XMHCredentiaItemModel.new;
                itemModel.serviceKey = item[@"key"];
                itemModel.title = item[@"name"];
                itemModel.imageName = item[@"imageName"];
                itemModel.count = [NSString stringWithFormat:@"%@", model.data[itemModel.serviceKey]];
                itemModel.type = [((NSNumber *)item[@"arrow"]) integerValue];
                [serviceModelArray addObject:itemModel];
            }
            
            if (resultBlock) resultBlock(salesModelArray, serviceModelArray, YES);
        }];
    }];
}

/**
 门店列表 列表管理层
 */
+ (void)requestManagersListParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSArray <XMHShopModel *> *modelArray, BOOL isSuccess))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.serv_1/managers_list",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[XMHShopModel class] json:info.data[@"list"]];
            if (resultBlock) resultBlock(modelArray,YES);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        if (resultBlock) resultBlock(nil,NO);
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 订单管理 - 获取销售列表
 */
+ (void)requestSaleListParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSArray <XMHCredentiaSalesOrderMdoel *> *modelArray, BOOL isSuccess))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.serv_1/sales_list",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[XMHCredentiaSalesOrderMdoel class] json:info.data[@"list"]];
            if (resultBlock) resultBlock(modelArray,YES);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        if (resultBlock) resultBlock(nil,NO);
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 订单管理 - 获取服务列表
 */
+ (void)requestServiceListParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSArray <XMHCredentiaServiceOrderMdoel *> *modelArray, BOOL isSuccess))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.serv_1/serv_list",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[XMHCredentiaServiceOrderMdoel class] json:info.data[@"list"]];
            if (resultBlock) resultBlock(modelArray,YES);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        if (resultBlock) resultBlock(nil,NO);
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 八统---销售业绩列表
 */
+ (void)requestSalesYeJiListParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.sales_new/yeji_list",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            if (resultBlock) resultBlock(info,YES);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        if (resultBlock) resultBlock(nil,NO);
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 配合消费
 */
+ (void)requestSalesCooperateParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.sales/cooperate",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            if (resultBlock) resultBlock(info,YES);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        if (resultBlock) resultBlock(nil,NO);
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 配合耗卡
 */
+ (void)requestServiceCooperateParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.serv/serv_cooperate",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            if (resultBlock) resultBlock(info,YES);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        if (resultBlock) resultBlock(nil,NO);
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 八统---退款金额列表
 */
+ (void)requestSalesTuiKuanLiatParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.sales_new/tuikuan_list",SERVER_APP];
    [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            if (resultBlock) resultBlock(info,YES);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        if (resultBlock) resultBlock(nil,NO);
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

@end
