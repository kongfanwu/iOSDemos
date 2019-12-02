//
//  XMHActionCenterRequest.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHActionCenterRequest.h"
#import "Networking.h"
#import "BaseModel.h"
#import "XMHCouponListModel.h"
@implementation XMHActionCenterRequest
/**
 优惠券 列表
 
 @param params 请求参数
 @param resultBlock 优惠券列表数组
 */
- (void)requestCouponListParams:(NSMutableDictionary *)params
                    resultBlock:(void(^)(NSMutableArray *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_couponListTask) {
        [_couponListTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Ticket_coupon/getList",SERVER_APP];
   
    _couponListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            XMHCouponListModel *model = [XMHCouponListModel yy_modelWithDictionary:info.data];
            resultBlock(model.list,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 优惠券 启用 停用
 
 @param params 请求参数
 @param resultBlock 返回结果
 */
- (void)requestCouponListPutInParams:(NSMutableDictionary *)params
                         resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_stopTask) {
        [_stopTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Ticket_coupon/putIn",SERVER_APP];
    
    _stopTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            resultBlock(result,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 优惠券 修改库存
 
 @param params 请求参数
 @param resultBlock 返回结果
 */
- (void)requestCouponListStockParams:(NSMutableDictionary *)params
                         resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_xiugaikuncunTask) {
        [_xiugaikuncunTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Ticket_coupon/modify_stock",SERVER_APP];
    
    _xiugaikuncunTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            resultBlock(result,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
    
}
/**
 优惠券 删除
 
 @param params 请求参数
 @param resultBlock 返回结果
 */
- (void)requestCouponListDelTicketParams:(NSMutableDictionary *)params
                             resultBlock:(void(^)(NSDictionary *result, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    
    if (_delectTask) {
        [_delectTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Ticket_coupon/delTicket",SERVER_APP];
    
    _delectTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            resultBlock(result,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
    
}
/**
 优惠券 通用接口
 
 @param url 请求URL
 @param params 请求参数
 @param resultBlock 返回结果
 */
+ (void)requestCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHActionCenterRequest *request = [[XMHActionCenterRequest alloc] init];
    [request requestCommonUrl:url Param:params resultBlock:resultBlock];
}
- (void)requestCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_commonTask) {
        [_commonTask cancel];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",SERVER_APP,url];
    _commonTask = [Networking requestWithURL:urlStr params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info.data,YES,nil);
        }else{
//            resultBlock(info.data,NO,nil);
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
@end
