 //
//  BeautyRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/12.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyRequest.h"
#import "Networking.h"
@implementation BeautyRequest
- (void)requestZhangDanMingxi:(NSString*)user_id
                    Join_code:(NSString *)join_code
                  resultBlock:(void(^)(ZhangDanMingXiModel *zhangDanMingXiModel,
                                       BOOL isSuccess,
                                       NSDictionary *errorDic))resultBlock{
    if (_zhangDanMingXiTask) {
        [_zhangDanMingXiTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Meilidingzhi/user_info",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"user_id":user_id?user_id:@"",
                                       @"join_code":join_code?join_code:@""} mutableCopy];
    
    _zhangDanMingXiTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            ZhangDanMingXiModel *zhangDanMingXiModel = [ZhangDanMingXiModel yy_modelWithDictionary:info.data];
            resultBlock(zhangDanMingXiModel,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

- (void)requestGuKeChuFang:(NSString*)user_id
               resultBlock:(void(^)(GuKeChuFangList *guKeChuFangList,
                                    BOOL isSuccess,
                                    NSDictionary *errorDic))resultBlock{
    if (_guKeChuFangTask) {
        [_guKeChuFangTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Meilidingzhi/user_pres",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"user_id":user_id?user_id:@""} mutableCopy];
    
    _guKeChuFangTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            GuKeChuFangList *guKeChuFangList = [GuKeChuFangList yy_modelWithDictionary:info.data];
            resultBlock(guKeChuFangList,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

- (void)requestLiaoChengXiangMu:(NSString*)user_id
                      join_code:(NSString *)join_code
                    resultBlock:(void(^)(LiaoChengXiangMuList *liaoChengXiangMuList,
                                         BOOL isSuccess,
                                         NSDictionary *errorDic))resultBlock{
    if (_liaoChengXiangMuTask) {
        [_liaoChengXiangMuTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Meilidingzhi/pro",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"user_id":user_id?user_id:@"",
                                       @"join_code":join_code?join_code:@""} mutableCopy];
    
    _liaoChengXiangMuTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"beautyXiangMu"];
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            LiaoChengXiangMuList *liaoChengXiangMuList = [LiaoChengXiangMuList yy_modelWithDictionary:info.data];
            resultBlock(liaoChengXiangMuList,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
- (void)requestGukeList:(NSInteger)page
                      Q:(NSString *)q
            resultBlock:(void(^)(choiceCustomerModel *uchoiceCustomerModel,
                                 BOOL isSuccess,
                                 NSDictionary *errorDic))resultBlock{
    if (_GukeListTask) {
        [_GukeListTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.serach_user/index",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"page":[NSString stringWithFormat:@"%ld",page],
                                       @"q":q?q:@""} mutableCopy];

    _GukeListTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            choiceCustomerModel *uchoiceCustomerModel = [choiceCustomerModel yy_modelWithDictionary:info.data];
            resultBlock(uchoiceCustomerModel,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

- (void)requestBeautyGuiHuaiZhiXing:(NSString *)join_code
                           oneClick:(NSString *)oneClick
                           twoClick:(NSString *)twoClick
                          twoListId:(NSString *)twoListId
                               inId:(NSString *)inId
                          startTime:(NSString *)startTime
                            endTime:(NSString *)endTime
                        resultBlock:(void(^)(BeautyGuihuaModel *model,
                                             BOOL isSuccess,
                                             NSDictionary *errorDic))resultBlock{
    
    if (_BeautyGuiHuaZhiXingTask) {
        [_BeautyGuiHuaZhiXingTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Meilidingzhi/planning",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"join_code":join_code?join_code:@"",
                                       @"oneClick":oneClick?oneClick:@"",
                                       @"twoClick":twoClick?twoClick:@"",
                                       @"twoListId":twoListId?twoListId:@"",
                                       @"inId":inId?inId:@"",
                                       @"startTime":startTime?startTime:@"",
                                       @"endTime":endTime?endTime:@""} mutableCopy];
    
    _BeautyGuiHuaZhiXingTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            BeautyGuihuaModel *model = [BeautyGuihuaModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
- (void)requestBeautyShiJiZhiXing:(NSString *)join_code
                         oneClick:(NSString *)oneClick
                         twoClick:(NSString *)twoClick
                        twoListId:(NSString *)twoListId
                             inId:(NSString *)inId
                        startTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                      resultBlock:(void(^)(BeautyShijiModel *model,
                                           BOOL isSuccess,
                                           NSDictionary *errorDic))resultBlock{
    
    if (_BeautyShiJiZhiXingTask) {
        [_BeautyShiJiZhiXingTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Meilidingzhi/execute",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"join_code":join_code?join_code:@"",
                                       @"oneClick":oneClick?oneClick:@"",
                                       @"twoClick":twoClick?twoClick:@"",
                                       @"twoListId":twoListId?twoListId:@"",
                                       @"inId":inId?inId:@"",
                                       @"startTime":startTime?startTime:@"",
                                       @"endTime":endTime?endTime:@""} mutableCopy];
    
    _BeautyShiJiZhiXingTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            BeautyShijiModel *model = [BeautyShijiModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

- (void)requestBeautyHomeGetList:(NSString *)join_code
                        oneClick:(NSString *)oneClick
                        twoClick:(NSString *)twoClick
                       twoListId:(NSString *)twoListId
                            inId:(NSString *)inId
                       startTime:(NSString *)startTime
                         endTime:(NSString *)endTime
                            page:(NSInteger)page
                         keyword:(NSString *)keyword
                     resultBlock:(void(^)(BeautyHomeListModel *model,
                                          BOOL isSuccess,
                                          NSDictionary *errorDic))resultBlock{
    if (_HomeGetListTask) {
        [_HomeGetListTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Meilidingzhi/getList",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"join_code":join_code?join_code:@"",
                                       @"oneClick":oneClick?oneClick:@"",
                                       @"twoClick":twoClick?twoClick:@"",
                                       @"twoListId":twoListId?twoListId:@"",
                                       @"inId":inId?inId:@"",
                                       @"startTime":startTime?startTime:@"",
                                       @"endTime":endTime?endTime:@"",
                                       @"page":@(page),
                                       @"keyword":keyword?keyword:@""
                                       } mutableCopy];
    
    _HomeGetListTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel *info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            NSDictionary *dic = info.data[@"list"];
            BeautyHomeListModel *model = [BeautyHomeListModel yy_modelWithDictionary:dic];
            resultBlock(model,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
- (void)requestBeautyChoiseJishi:(NSString *)store_code
                     resultBlock:(void(^)(BeautyChoiseJishiModel *model,
                                          BOOL isSuccess,
                                          NSDictionary *errorDic))resultBlock{
    if (_ChoiseJishiTask) {
        [_ChoiseJishiTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Meilidingzhi/jis",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"store_code":store_code?store_code:@""} mutableCopy];
    _ChoiseJishiTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BeautyChoiseJishiModel *info = [BeautyChoiseJishiModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            resultBlock(info,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

- (void)requestBeautyCard:(NSString *)join_code
                  user_id:(NSString *)user_id
              resultBlock:(void(^)(BeautyCardModel *model,
                                   BOOL isSuccess,
                                   NSDictionary *errorDic))resultBlock{
    if (_BeautyCardTask) {
        [_BeautyCardTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Meilidingzhi/card",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"join_code":join_code?join_code:@"",
                                       @"user_id":user_id?user_id:@""} mutableCopy];
    _BeautyCardTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"beautyTiKa"];
        BeautyCardModel *model = [BeautyCardModel yy_modelWithDictionary:result];
        if (model.code == 1) {
            resultBlock(model,YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":model.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
- (void)requestCreateChufangBill:(NSString *)result
                     resultBlock:(void(^)(id obj,
                                          BOOL isSuccess,
                                          NSDictionary *errorDic))resultBlock{
    if (_CreateChufangBillTask) {
        [_CreateChufangBillTask cancel];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@v5.Meilidingzhi/pres_save",SERVER_APP];
    //@"http://192.168.1.107/v5.Meilidingzhi/pres_save" ;
    NSMutableDictionary *parmsDic = [@{@"result":result?result:@""} mutableCopy];
    _CreateChufangBillTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSString *codestr = [NSString stringWithFormat:@"%@",dic[@"code"]];
        if ([codestr intValue]  == 1) {
            resultBlock(dic[@"data"],YES,nil);
        } else {
            resultBlock(nil,NO,nil);
            [MzzHud toastWithTitle:@"温馨提示" message:dic[@"msg"]];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
/**
 *处方删除接口
 */
- (void)requestChuFangDelordernum:(NSString *)ordernum
                       store_code:(NSString *)store_code
                      resultBlock:(void(^)(id obj,
                                           BOOL isSuccess,
                                           NSDictionary *errorDic))resultBlock{
    if (_ChuFangDelTask) {
        [_ChuFangDelTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Meilidingzhi/pres_del",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"ordernum":ordernum?ordernum:@"",@"store_code":store_code?store_code:@""} mutableCopy];
    _ChuFangDelTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSString *codestr = [NSString stringWithFormat:@"%@",dic[@"code"]];
        if ([codestr intValue]  == 1) {
            resultBlock(dic[@"data"],YES,nil);
        } else {
            [MzzHud toastWithTitle:@"提示" message:dic[@"msg"]];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

- (void)requestChuFangJieShuordernum:(NSString *)ordernum
                          store_code:(NSString *)store_code
                         resultBlock:(void(^)(id obj,
                                              BOOL isSuccess,
                                              NSDictionary *errorDic))resultBlock{
    if (_ChuFangJieShuTask) {
        [_ChuFangJieShuTask cancel];
    }
    NSString *url = [NSString stringWithFormat:@"%@v5.Meilidingzhi/pres_end",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"ordernum":ordernum?ordernum:@"",@"store_code":store_code?store_code:@""} mutableCopy];
    _ChuFangJieShuTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSString *codestr = [NSString stringWithFormat:@"%@",dic[@"code"]];
        if ([codestr intValue]  == 1) {
            resultBlock(dic[@"data"],YES,nil);
        } else {
            resultBlock(nil,NO,@{@"error":dic[@"msg"]});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
@end
