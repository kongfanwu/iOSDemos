//
//  XMHExperienceOrderRequest.m
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHExperienceOrderRequest.h"
#import "Networking.h"
#import "UserManager.h"
#import "BaseModel.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"
#import "ShareWorkInstance.h"
#import "XMHTicketModel.h"
#import "SLOrderNumModel.h"

@implementation XMHExperienceOrderRequest

/**
 获取项目服务
 */
+ (void)requestProjectUserId:(NSString *)userId resultBlock:(void(^)(SLS_ProModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    XMHExperienceOrderRequest *request = XMHExperienceOrderRequest.new;
    [request requestProjectUserId:userId resultBlock:resultBlock];
}

- (void)requestProjectUserId:(NSString *)userId resultBlock:(void(^)(SLS_ProModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    if (_projectTask) {
        [_projectTask cancel];
    }
//    LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary *params = NSMutableDictionary.new;
//    [params setValue:[NSString stringWithFormat:@"%@",@(userModel.data.ID)] forKey:@"user_id"];
    params[@"user_id"] = userId;
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/s_pro",SERVER_APP];
    _projectTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLS_ProModel *model = [SLS_ProModel yy_modelWithDictionary:info.data];
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
 获取产品服务
 */
+ (void)requestGoodsUserId:(NSString *)userId resultBlock:(void(^)(SLGoodListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    XMHExperienceOrderRequest *request = XMHExperienceOrderRequest.new;
    [request requestGoodsUserId:userId resultBlock:resultBlock];
}

- (void)requestGoodsUserId:(NSString *)userId resultBlock:(void(^)(SLGoodListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    if (_goodsTask) {
        [_goodsTask cancel];
    }
//    LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary *params = NSMutableDictionary.new;
//    [params setValue:[NSString stringWithFormat:@"%@",@(userModel.data.ID)] forKey:@"user_id"];
    params[@"user_id"] = userId;
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/s_goods",SERVER_APP];
    _goodsTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLGoodListModel *model = [SLGoodListModel yy_modelWithDictionary:info.data];
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
 获取体验服务
 */
+ (void)requestCourseUserId:(NSString *)userId resultBlock:(void(^)(SLSCourseExper *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    XMHExperienceOrderRequest *request = XMHExperienceOrderRequest.new;
    [request requestCourseUserId:userId resultBlock:resultBlock];
}

- (void)requestCourseUserId:(NSString *)userId resultBlock:(void(^)(SLSCourseExper *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {
    if (_experTask) {
        [_experTask cancel];
    }
//    LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary *params = NSMutableDictionary.new;
//    [params setValue:[NSString stringWithFormat:@"%@",@(userModel.data.ID)] forKey:@"user_id"];
    params[@"user_id"] = userId;
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/s_course_exper",SERVER_APP];
    _experTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLSCourseExper *model = [SLSCourseExper yy_modelWithDictionary:info.data];
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
 获取项目服务，产品服务， 体验服务数据
 */
+ (void)requestProjectGoodsCourseUserId:(NSString *)userId resultBlock:(void(^)(BOOL isSuccess, SLS_ProModel *projectModel, SLGoodListModel *goodModel, SLSCourseExper *experienceModel))block {
    [XMHExperienceOrderRequest requestProjectUserId:userId resultBlock:^(SLS_ProModel * _Nonnull projectModel, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (!isSuccess) {
            if (block) block(NO, nil, nil, nil);
            return;
        }
        [XMHExperienceOrderRequest requestGoodsUserId:userId resultBlock:^(SLGoodListModel * _Nonnull goodModel, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
            if (!isSuccess) {
                if (block) block(NO, nil, nil, nil);
                return;
            }
            [XMHExperienceOrderRequest requestCourseUserId:userId resultBlock:^(SLSCourseExper * _Nonnull experienceModel, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                if (!isSuccess) {
                    if (block) block(NO, nil, nil, nil);
                    return;
                }
                if (block) block(YES, projectModel, goodModel, experienceModel);
            }];
        }];
    }];
}

/**
 销售服务单获取礼品券
 */
+ (void)requestSellProTicketParam:(NSMutableDictionary *)params resultBlock:(void(^)(NSArray <XMHTicketModel *>*modelArray, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHExperienceOrderRequest *request = XMHExperienceOrderRequest.new;
    [request requestSellProTicketParam:params resultBlock:resultBlock];
}

- (void)requestSellProTicketParam:(NSMutableDictionary *)params resultBlock:(void(^)(NSArray <XMHTicketModel *>*modelArray, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_baseTicketTask) {
        [_baseTicketTask cancel];
    }

    NSString * url = [NSString stringWithFormat:@"%@v5.serv/get_ticket",SERVER_APP];
    _baseTicketTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[XMHTicketModel class] json:info.data[@"list"]];
            resultBlock(modelArray,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/**
 服务制单和体验制单开单
 */
+ (void)requestCreateOrderParam:(NSMutableDictionary *)params resultBlock:(void(^)(SLOrderNumModel *orderNumModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHExperienceOrderRequest *request = XMHExperienceOrderRequest.new;
    [request requestCreateOrderParam:params resultBlock:resultBlock];
}

- (void)requestCreateOrderParam:(NSMutableDictionary *)params resultBlock:(void(^)(SLOrderNumModel *orderNumModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_createOrderTask) {
        [_createOrderTask cancel];
    }
    
    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/submit",SERVER_APP];
    _createOrderTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLOrderNumModel *model = [SLOrderNumModel yy_modelWithDictionary:info.data];
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
 服务单和销售服务单详情页
 */
+ (void)requestServInfoParam:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHExperienceOrderRequest *request = XMHExperienceOrderRequest.new;
    [request requestServInfoParam:params resultBlock:resultBlock];
}

- (void)requestServInfoParam:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_servInfoTask) {
        [_servInfoTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/serv_info",SERVER_APP];
    _createOrderTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
 补齐业绩
 */
+ (void)requestRepairParam:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    XMHExperienceOrderRequest *request = XMHExperienceOrderRequest.new;
    [request requestRepairParam:params resultBlock:resultBlock];
}

- (void)requestRepairParam:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_repairTask) {
        [_repairTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/serv_repair",SERVER_APP];
    _createOrderTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
 固定开单-详情页
 */
+ (void)requestSalesInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.sales/salesInfo",SERVER_APP];
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
 绑定技师-服务制单，销售制单，体验制单，技师开完单绑定技师
 */
+ (void)requestBangJisParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess))resultBlock {
    NSString *url = [NSString stringWithFormat:@"%@v5.serv_1/bang_jis",SERVER_APP];
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
