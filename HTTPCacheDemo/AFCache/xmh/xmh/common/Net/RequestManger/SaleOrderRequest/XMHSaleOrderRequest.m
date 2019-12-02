//
//  XMHSaleOrderRequest.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSaleOrderRequest.h"
#import "Networking.h"
#import "BaseModel.h"
#import "SASaleListModel.h"
#import "ShareWorkInstance.h"
#import "LolUserInfoModel.h"
@interface XMHSaleOrderRequest()
{
     NSURLSessionDataTask * _proTask;
     NSURLSessionDataTask * _baseDiscountTask;
     NSURLSessionDataTask * _baseTicketTask;
     NSURLSessionDataTask * _saleListTask;
     NSURLSessionDataTask * _summitTask;
     NSURLSessionDataTask * _gudingTask;
     NSURLSessionDataTask * _buXiangMuTask;
     NSURLSessionDataTask * _yeJiTask;
     NSURLSessionDataTask * _shumuTask;
    NSURLSessionDataTask * _tankuangTask;
}
@end

@implementation XMHSaleOrderRequest
/**
 销售制单 列表
 
 @param params @[@"store_code":@"门店编码",
 @"user_id":@"用户id",
 @"type":@"类型 pro项目,goods产品,card_course特惠卡,card_num任选卡,card_time时间卡,stored_card储值卡, ticket票券"]
 @param resultBlock 列表数据
 */
+ (void)requestSaleOrderContentParams:(NSMutableDictionary *)params
                             resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHSaleOrderRequest *request = [XMHSaleOrderRequest new];
    [request requestSaleOrderContentParams:params resultBlock:resultBlock];
}
- (void)requestSaleOrderContentParams:(NSMutableDictionary *)params
                             resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_proTask) {
        [_proTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.sales_new/salesList",SERVER_APP];
    _proTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SASaleListModel * model = [SASaleListModel yy_modelWithDictionary:info.data];
            resultBlock([model.list mutableCopy],YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 销售制单 会员优惠列表
 
 @param params @[]
 @param resultBlock 会员优惠列表
 */
+ (void)requestSaleOrderVipDiscountParams:(NSMutableDictionary *)params
                              resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHSaleOrderRequest *request = [XMHSaleOrderRequest new];
    [request requestSaleOrderVipDiscountParams:params resultBlock:resultBlock];
}


- (void)requestSaleOrderVipDiscountParams:(NSMutableDictionary *)params
                              resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_baseDiscountTask) {
        [_baseDiscountTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/get_basic_stored",SERVER_APP];
    _baseDiscountTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        ZheKouModel  * info = [ZheKouModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock([info.data.stored_card mutableCopy],YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 销售制单 单个卡项可用优惠卷列表
 
 @param params @[]
 @param resultBlock 优惠券列表
 */
+ (void)requestSaleOrderVipTicketParams:(NSMutableDictionary *)params
                            resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHSaleOrderRequest *request = [XMHSaleOrderRequest new];
    [request requestSaleOrderVipTicketParams:params resultBlock:resultBlock];
}
- (void)requestSaleOrderVipTicketParams:(NSMutableDictionary *)params
                            resultBlock:(void(^)(NSMutableArray *resultArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_baseTicketTask) {
        [_baseTicketTask cancel];
    }
  
    Join_Code *join_Code =  [ShareWorkInstance shareInstance].share_join_code;
    NSInteger fram_id = join_Code.fram_id;
    [params setObject:@(fram_id) forKey:@"fram_id"];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/get_basic_ticket",SERVER_APP];
    _baseTicketTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SATicketListModel * model = [SATicketListModel  yy_modelWithDictionary:info.data];
            resultBlock([model.ticket mutableCopy],YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 * 奖赠内容
 */
+ (void)requestAwardContentStore_code:(NSString *)store_code type:(NSString *)type  user_id:(NSInteger)user_id resultBlock:(void(^)(SASaleListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHSaleOrderRequest *request = [XMHSaleOrderRequest new];
    [request requestAwardContentStore_code:store_code type:type user_id:user_id resultBlock:resultBlock];
}
- (void)requestAwardContentStore_code:(NSString *)store_code type:(NSString *)type  user_id:(NSInteger)user_id resultBlock:(void(^)(SASaleListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    
    if (_saleListTask) {
        [_saleListTask cancel];
    }
    NSMutableDictionary *params = [@{@"store_code":store_code?store_code:@"",@"type":type?type:@"",@"user_id":@(user_id)} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/sales_list",SERVER_APP];
    _saleListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SASaleListModel * model = [SASaleListModel yy_modelWithDictionary:info.data];
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
 * 提交订单
 */
+ (void)summitSaleOrderParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary *dic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
{
    XMHSaleOrderRequest *request = [XMHSaleOrderRequest new];
    [request summitSaleOrderParams:params resultBlock:resultBlock];
}
- (void) summitSaleOrderParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary *dic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_summitTask) {
        [_summitTask cancel];
    }
  
    NSString * url = [NSString stringWithFormat:@"%@v5.sales_new/addSales",SERVER_APP];
    _saleListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
//            SASaleListModel * model = [SASaleListModel yy_modelWithDictionary:info.data];
            NSDictionary *dic = result[@"data"];
//            NSString *ordernum = [dic safeObjectForKey:@"ordernum"];
            resultBlock(dic,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 * 固定开单 详情页
 */
+ (void)requestSalesInfoOrderNum:(NSString *)orderNum
                     resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHSaleOrderRequest *request = [XMHSaleOrderRequest new];
    [request requestSalesInfoOrderNum:orderNum resultBlock:resultBlock];
}

- (void)requestSalesInfoOrderNum:(NSString *)orderNum
                     resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_gudingTask) {
        [_gudingTask cancel];
    }
   
    NSMutableDictionary *params = [@{@"ordernum":orderNum?orderNum:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/salesInfo",SERVER_APP];
    _gudingTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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

+ (void)requestbuYeJiMuSubmmitParams:(NSMutableDictionary *)params
                          resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHSaleOrderRequest *request = [XMHSaleOrderRequest new];
    [request requestbuYeJiMuSubmmitParams:params resultBlock:resultBlock];
}

- (void)requestbuYeJiMuSubmmitParams:(NSMutableDictionary *)params
                          resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_yeJiTask) {
        [_yeJiTask cancel];
    }
    
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/afterAchievementSplit",SERVER_APP];
    _yeJiTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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

/**
 * 逆向开单补齐项目提交
 */

+ (void)requestniXiangBuXiangMuSubmitCartParams:(NSMutableDictionary *)params
                                    resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHSaleOrderRequest *request = [XMHSaleOrderRequest new];
    [request requestniXiangBuXiangMuSubmitCartParams:params resultBlock:resultBlock];
}

- (void)requestniXiangBuXiangMuSubmitCartParams:(NSMutableDictionary *)params
                                    resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_buXiangMuTask) {
        [_buXiangMuTask cancel];
    }
    
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/fillReverseOrder",SERVER_APP];
    _buXiangMuTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
/**
 销售单列表数
 
 @param params params
 @param resultBlock result
 */
+ (void)requestSalesListNumParams:(NSMutableDictionary *)params
                      resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHSaleOrderRequest *request = [XMHSaleOrderRequest new];
    [request requestSalesListNumParams:params resultBlock:resultBlock];
}

- (void)requestSalesListNumParams:(NSMutableDictionary *)params
                      resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_shumuTask) {
        [_shumuTask cancel];
    }
    
    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/sales_list_num",SERVER_APP];
    _shumuTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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

+ (void)requestSalesListAccessAlertParams:(NSMutableDictionary *)params
                              resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHSaleOrderRequest *request = [XMHSaleOrderRequest new];
    [request requestSalesListAccessAlertParams:params resultBlock:resultBlock];
}

/**
 获取弹框权限
 
 @param params params
 @param resultBlock result
 */
- (void)requestSalesListAccessAlertParams:(NSMutableDictionary *)params
                              resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_tankuangTask) {
        [_tankuangTask cancel];
    }
    
    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/tan",SERVER_APP];
    _tankuangTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
