//
//  XMHCouponRequest.m
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponRequest.h"

@implementation XMHCouponRequest

+ (void)requestUrl:(NSString *)url params:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
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
 优惠券 获取商家所有门店
 */
+ (void)requestStoresParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.Ticket_coupon/get_stores",SERVER_APP];
    [self requestUrl:url params:params resultBlock:resultBlock];
}

/**
 优惠券 获取商家顾客等级
 */
+ (void)requestGradeParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.Ticket_coupon/get_grade",SERVER_APP];
    [self requestUrl:url params:params resultBlock:resultBlock];
}

/**
 优惠券 获取商家项目、产品
 */
+ (void)requestGoodsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.Ticket_coupon/get_goods",SERVER_APP];
    [self requestUrl:url params:params resultBlock:resultBlock];
}

/**
 优惠券 添加 修改 读取
 */
+ (void)requestCouponEditParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.Ticket_coupon/edit",SERVER_APP];
    [self requestUrl:url params:params resultBlock:resultBlock];
}

@end
