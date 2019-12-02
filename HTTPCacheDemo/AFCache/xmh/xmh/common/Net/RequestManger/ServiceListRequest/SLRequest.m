//
//  SLRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SLRequest.h"
#import "Networking.h"
#import "BaseModel.h"
#import "MzzHud.h"
#import "SLSearchListModel.h"
#import "SLPresModel.h"
#import "SLServPro.h"
#import "SLServAppoModel.h"
#import "SLGoodsModel.h"
#import "SLTi_CardModel.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"
#import "MLJishiSearchModel.h"
#import "SLSearchManagerModel.h"
#import "SLOrderNumModel.h"
#import "SLServInfoModel.h"
#import "SLCooperateModel.h"
#import "SLGetListModel.h"

@implementation SLRequest
- (void)requestSearchCustomerParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLSearchListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_searchTask) {
        [_searchTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/serach_user",SERVER_APP];
    _searchTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLSearchListModel *model = [SLSearchListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestSearchCustomerParams:(NSMutableDictionary *)params resultBlock:(void(^)( SLSearchListModel*model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestSearchCustomerParams:params resultBlock:resultBlock];
}

- (void)requestServApppParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLServAppoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_servAppo) {
        [_servAppo cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/appo",SERVER_APP];
    _servAppo = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"yuyueFuwuSource"];
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLServAppoModel *model = [SLServAppoModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}


+ (void)requestServApppParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLServAppoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestServApppParams:params resultBlock:resultBlock];
}

- (void)requestPresParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLPresModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_presTask) {
        [_presTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/pres",SERVER_APP];
    _presTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLPresModel *model = [SLPresModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestPresParams:(NSMutableDictionary *)params resultBlock:(void(^)( SLPresModel*model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestPresParams:params resultBlock:resultBlock];
}


- (void)requestServProParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLServPro *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_proTask) {
        [_proTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/pro",SERVER_APP];
    _proTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLServPro *model = [SLServPro yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestServProParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLServPro *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
      SLRequest *request = [[self alloc] init];
      [request requestServProParams:params resultBlock:resultBlock];
}


- (void)requestServGoodsParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLGoodsModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_goodsTask) {
        [_goodsTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/goods",SERVER_APP];
    _goodsTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"ServerProduct"];
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLGoodsModel *model = [SLGoodsModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestServGoodsParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLGoodsModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestServGoodsParams:params resultBlock:resultBlock];
}
- (void)requesTtiCardParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLTi_CardModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_tiCardTask) {
        [_tiCardTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/ti_card",SERVER_APP];
    _tiCardTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"ServeTiKa"];
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLTi_CardModel *model = [SLTi_CardModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requesTtiCardParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLTi_CardModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requesTtiCardParams:params resultBlock:resultBlock];
}

- (void)requesSProParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLS_ProModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_sProTask) {
        [_sProTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/s_pro",SERVER_APP];
    _sProTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
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

+ (void)requesSProParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLS_ProModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requesSProParams:params resultBlock:resultBlock];
}


- (void)requesSGoodParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLGoodListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_sGoodTask) {
        [_sGoodTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/s_goods",SERVER_APP];
    _sGoodTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
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

+ (void)requesSGoodParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLGoodListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requesSGoodParams:params resultBlock:resultBlock];
}

- (void)requesCourseExperParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLSCourseExper *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_sCourseTask) {
        [_sCourseTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/s_course_exper",SERVER_APP];
    _sCourseTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"SellTiYanSource"];
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
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

+ (void)requesCourseExperParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLSCourseExper *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requesCourseExperParams:params resultBlock:resultBlock];
}


- (void)requesSearchJisParams:(NSMutableDictionary *)params resultBlock:(void(^)(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_jishiSearchTask) {
        [_jishiSearchTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/serach_jis",SERVER_APP];
    _jishiSearchTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MLJishiSearchModel *model = [MLJishiSearchModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requesSearchJisParams:(NSMutableDictionary *)params resultBlock:(void(^)(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requesSearchJisParams:params resultBlock:resultBlock];
}


- (void)requesSearchManagerParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLSearchManagerModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_managerSearchTask) {
        [_managerSearchTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/serach_manager",SERVER_APP];
    _managerSearchTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLSearchManagerModel *model = [SLSearchManagerModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requesSearchManagerParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLSearchManagerModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requesSearchManagerParams:params resultBlock:resultBlock];
}


- (void)commitParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLOrderNumModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_commitTask) {
        [_commitTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/submit",SERVER_APP];
    _commitTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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

+ (void)commitParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLOrderNumModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request commitParams:params resultBlock:resultBlock];
}

- (void)requestServInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLServInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_servInfoTask) {
        [_servInfoTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/serv_info",SERVER_APP];
    _servInfoTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLServInfoModel *model = [SLServInfoModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestServInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLServInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestServInfoParams:params resultBlock:resultBlock];
}



- (void)requestServDelParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_servDelTask) {
        [_servDelTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/serv_del",SERVER_APP];
    _servDelTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        resultBlock(info,YES,nil);
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestServDelParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestServDelParams:params resultBlock:resultBlock];
}

- (void)requestSerImgParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_servImgTask) {
        [_servImgTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/serv_img",SERVER_APP];
    _servImgTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            resultBlock(info,YES,nil);
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestSerImgParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestSerImgParams:params resultBlock:resultBlock];
}

- (void)requestSerSettlementParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_servSettlementTask) {
        [_servSettlementTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/serv_settlement",SERVER_APP];
    _servSettlementTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if(info.code == 1){
            resultBlock(info,YES,nil);
        }
        
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestSerSettlementParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestSerSettlementParams:params resultBlock:resultBlock];
}




- (void)requestSerRetroactiveParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_retroactiveTask) {
        [_retroactiveTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/serv_retroactive",SERVER_APP];
    _retroactiveTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        resultBlock(info,YES,nil);
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestSerRetroactiveParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestSerRetroactiveParams:params resultBlock:resultBlock];
}

- (void)requestCooperateParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLCooperateModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_cooperateTask) {
        [_cooperateTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/serv_cooperate",SERVER_APP];
    _cooperateTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLCooperateModel *model = [SLCooperateModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestCooperateParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLCooperateModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestCooperateParams:params resultBlock:resultBlock];
}
+ (void)requestCooperateSaleParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLCooperateModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestCooperateSaleParams:params resultBlock:resultBlock];
}
- (void)requestCooperateSaleParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLCooperateModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_cooperateTask) {
        [_cooperateTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/cooperate",SERVER_APP];
    _cooperateTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLCooperateModel *model = [SLCooperateModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
- (void)requestGetListParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLGetListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_getListTask) {
        [_getListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/get_list",SERVER_APP];
    _getListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SLGetListModel *model = [SLGetListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestGetListParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLGetListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SLRequest *request = [[self alloc] init];
    [request requestGetListParams:params resultBlock:resultBlock];
}

+ (void)requesSearchOtherJisParams:(NSMutableDictionary *)params resultBlock:(void(^)(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock {}
@end
