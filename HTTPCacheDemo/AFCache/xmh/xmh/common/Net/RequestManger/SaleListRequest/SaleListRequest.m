//
//  SaleListRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SaleListRequest.h"
#import "Networking.h"
#import "SASaleListModel.h"
#import "SALeftModelList.h"
#import "SACourseModeList.h"
#import "SATicketListModel.h"
#import "SASalesInfoModel.h"
#import "SABalanceModel.h"
#import "SAStoredCardListModel.h"
#import "SAFQListModel.h"
#import "SANewDingDanListModel.h"
#import "SATongJiModel.h"
#import "SAFuWuXiaoShouListModel.h"
#import "SAZhiHuanPorListModel.h"
#import "SAAccountModel.h"
#import "SADepositListModel.h"
#import "SAZhiHuanListModel.h"
#import "SATuiKuanListModel.h"
#import "LOrderYejiListModel.h"
#import "SellProTicketListModel.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "XMHOrderListSaleModel.h"
#import "XMHBossOrderListModel.h"
#import "XMHSeverCertificateModel.h"
#import "XMHOrderListSeverModel.h"
#import "XMHCredentiaSalesOrderMdoel.h"
#import "XMHCredentiaServiceOrderMdoel.h"
@implementation SaleListRequest
+ (void)requestgetBasicStoredSearchId:(NSString *)searchId
                               userId:(NSString *)userId
                               proNum:(NSString *)proNum
                                 type:(NSString *)type
                             joinCode:(NSString *)joinCode
                           storedCode:(NSString *)storedCode
                          resultBlock:(void(^)(ZheKouModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestgetBasicStoredSearchId:searchId userId:userId proNum:proNum type:type joinCode:joinCode storedCode:storedCode resultBlock:resultBlock];
    
}
- (void)requestgetBasicStoredSearchId:(NSString *)searchId
                               userId:(NSString *)userId
                               proNum:(NSString *)proNum
                                 type:(NSString *)type
                             joinCode:(NSString *)joinCode
                           storedCode:(NSString *)storedCode
                          resultBlock:(void(^)(ZheKouModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_guDingKaiDanZheKou) {
        [_guDingKaiDanZheKou cancel];
    }
    NSMutableDictionary *params = [@{@"search_id":searchId?searchId:@"",@"user_id":userId?userId:@"",@"pro_num":proNum?proNum:@"",@"type":type?type:@"",@"join_code":joinCode?joinCode:@"",@"stored_code":storedCode?storedCode:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/get_basic_stored",SERVER_APP];
    _guDingKaiDanZheKou = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        ZheKouModel  * info = [ZheKouModel yy_modelWithDictionary:result];
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

+ (void)requestSaleListJoinCode:(NSString *)joinCode
                     store_code:(NSString *)store_code
                           type:(NSString *)type
                        user_id:(NSInteger)user_id
                    resultBlock:(void(^)(SASaleListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestSaleListJoinCode:joinCode store_code:store_code type:type user_id:user_id resultBlock:resultBlock];
}
- (void)requestSaleListJoinCode:(NSString *)joinCode
                     store_code:(NSString *)store_code
                           type:(NSString *)type
                        user_id:(NSInteger)user_id
                    resultBlock:(void(^)(SASaleListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_saleListTask) {
        [_saleListTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"store_code":store_code?store_code:@"",@"type":type?type:@"",@"user_id":@(user_id)} mutableCopy];
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
+ (void)requestLeftJoinCode:(NSString *)joinCode
                       type:(NSString *)type
                resultBlock:(void(^)(SALeftModelList *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestLeftJoinCode:joinCode type:type resultBlock:resultBlock];
}
- (void)requestLeftJoinCode:(NSString *)joinCode
                       type:(NSString *)type
                resultBlock:(void(^)(SALeftModelList *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_get_leftTask) {
        [_get_leftTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"type":type?type:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/get_left",SERVER_APP];
    _get_leftTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SALeftModelList * model = [SALeftModelList yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestBasicCourseCode:(NSString *)code
                      joinCode:(NSString *)joinCode
                      resultBlock:(void(^)(SACourseModeList *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestBasicCourseCode:code joinCode:joinCode resultBlock:resultBlock];
}
- (void)requestBasicCourseCode:(NSString *)code
                      joinCode:(NSString *)joinCode
                   resultBlock:(void(^)(SACourseModeList *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_basic_courseTask) {
        [_basic_courseTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"code":code?code:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/get_basic_course",SERVER_APP];
    _basic_courseTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SACourseModeList * model = [SACourseModeList yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestSubmitCartParams:(NSMutableDictionary *)params
                      resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestSubmitCartParams:params resultBlock:resultBlock];
    
}
- (void)requestSubmitCartParams:(NSMutableDictionary *)params
                      resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_add_seles_aTask) {
        [_add_seles_aTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/add_seles_a",SERVER_APP];
    _add_seles_aTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg complete:^{
                resultBlock(nil,NO,@{@"error":info.msg});
            }];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestKuaiSubmitCartParams:(NSMutableDictionary *)params
                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestKuaiSubmitCartParams:params resultBlock:resultBlock];
    
}
- (void)requestKuaiSubmitCartParams:(NSMutableDictionary *)params
                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_add_seles_aTask) {
        [_add_seles_aTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/sales_reverse_order_fill",SERVER_APP];
    _add_seles_aTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg complete:^{
                resultBlock(nil,NO,@{@"error":info.msg});
            }];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestSubmitParams:(NSMutableDictionary *)params
                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestSubmitParams:params resultBlock:resultBlock];
    
}
- (void)requestSubmitParams:(NSMutableDictionary *)params
                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_nixiangTask) {
        [_nixiangTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/reverseOrder",SERVER_APP];
    _add_seles_aTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg complete:^{
                resultBlock(nil,NO,@{@"error":info.msg});
            }];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestBasicTicketSearchId:(NSString *)serachId
                            userId:(NSString *)userId
                              type:(NSString *)type
                          joinCode:(NSString *)joinCode
                              code:(NSString *)code
                       resultBlock:(void(^)(SATicketListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestBasicTicketSearchId:serachId userId:userId type:type joinCode:joinCode code:(NSString *)code resultBlock:resultBlock];
    
}
+ (void)requestSellProTicketSearchId:(NSString *)serachId
                              userId:(NSString *)userId
                                type:(NSString *)type
                            joinCode:(NSString *)joinCode
                                code:(NSString *)code
                              framID:(NSString *)framID
                         resultBlock:(void(^)(SellProTicketListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestSellProTicketSearchId:serachId userId:userId type:type joinCode:joinCode code:code framID:framID resultBlock:resultBlock];
}
- (void)requestBasicTicketSearchId:(NSString *)serachId
                            userId:(NSString *)userId
                              type:(NSString *)type
                          joinCode:(NSString *)joinCode
                              code:(NSString *)code
                       resultBlock:(void(^)(SATicketListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_baseTicketTask) {
        [_baseTicketTask cancel];
    }
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSMutableDictionary *params = [@{@"search_id":serachId?serachId:@"",@"user_id":userId?userId:@"",@"type":type?type:@"",@"join_code":joinCode?joinCode:@"",@"code":code?code:@"",@"fram_id":framId?framId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/get_basic_ticket",SERVER_APP];
    
//    NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"DiYongQuanJIaShu"];

    _baseTicketTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SATicketListModel * model = [SATicketListModel  yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
- (void)requestSellProTicketSearchId:(NSString *)serachId
                            userId:(NSString *)userId
                              type:(NSString *)type
                            joinCode:(NSString *)joinCode
                                code:(NSString *)code
                              framID:(NSString *)framID
                       resultBlock:(void(^)(SellProTicketListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_sellProTicketTask) {
        [_sellProTicketTask cancel];
    }
    NSMutableDictionary *params = [@{@"user_id":userId?userId:@"",@"join_code":joinCode?joinCode:@"",@"code":code?code:@"",@"fram_id":framID?framID:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/get_ticket",SERVER_APP];
    _baseTicketTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SellProTicketListModel * model = [SellProTicketListModel  yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestSalesInfoOrderNum:(NSString *)orderNum
                     resultBlock:(void(^)(SASalesInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestSalesInfoOrderNum:orderNum resultBlock:resultBlock];
    
}
- (void)requestSalesInfoOrderNum:(NSString *)orderNum
                     resultBlock:(void(^)(SASalesInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_salesInfoTask) {
        [_salesInfoTask cancel];
    }
    NSMutableDictionary *params = [@{@"ordernum":orderNum?orderNum:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/salesInfo",SERVER_APP];
    _salesInfoTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SASalesInfoModel * model = [SASalesInfoModel  yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
    
+ (void)requestUserBalanceUserId:(NSString *)userId
                     resultBlock:(void(^)(SABalanceModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestUserBalanceUserId:userId resultBlock:resultBlock];
}

- (void)requestUserBalanceUserId:(NSString *)userId
                     resultBlock:(void(^)(SABalanceModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_userBalanceTask) {
        [_userBalanceTask cancel];
    }
    NSMutableDictionary *params = [@{@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/userBalance",SERVER_APP];
    _userBalanceTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        SABalanceModel  * info = [SABalanceModel yy_modelWithDictionary:result];
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
+ (void)requestDelSalesId:(NSString *)Id resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     SaleListRequest * request = [[SaleListRequest alloc] init];
    [request  requestDelSalesId:Id resultBlock:resultBlock];
}
- (void)requestDelSalesId:(NSString *)Id resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    
    if (_delSalesTask) {
        [_delSalesTask cancel];
    }
    NSMutableDictionary *params = [@{@"sales_id":Id?Id:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/DelSales",SERVER_APP];
    _delSalesTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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

+ (void)requestDelSalesOrdernum:(NSString *)orderNum withJoinCode:(NSString *)joinCode resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request  requestDelSalesOrdernum:orderNum withJoinCode:joinCode  resultBlock:resultBlock];
}
- (void)requestDelSalesOrdernum:(NSString *)orderNum withJoinCode:(NSString *)joinCode resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    
    if (_delSalesOrderTask) {
        [_delSalesOrderTask cancel];
    }
    NSMutableDictionary *params = [@{@"ordernum":orderNum?orderNum:@"",@"join_code":joinCode?joinCode:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/sales_reverse_order_del",SERVER_APP];
    _delSalesTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
+ (void)requestStoredCardListUserId:(NSString *)userId resultBlock:(void(^)(SAStoredCardListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestStoredCardListUserId:userId resultBlock:resultBlock];
}
- (void)requestStoredCardListUserId:(NSString *)userId resultBlock:(void(^)(SAStoredCardListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_stored_card_listTask) {
        [_stored_card_listTask cancel];
    }
    NSMutableDictionary *params = [@{@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/stored_card_list",SERVER_APP];
    _stored_card_listTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SAStoredCardListModel * model = [SAStoredCardListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestFQZDorderNum:(NSString *)orderNum resultBlock:(void(^)(SAFQListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestFQZDorderNum:orderNum resultBlock:resultBlock];
}
- (void)requestFQZDorderNum:(NSString *)orderNum resultBlock:(void(^)(SAFQListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_stored_card_listTask) {
        [_stored_card_listTask cancel];
    }
    NSMutableDictionary *params = [@{@"ordernum":orderNum?orderNum:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/get_fq_zd",SERVER_APP];
    _stored_card_listTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SAFQListModel * model = [SAFQListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestSubmitUPFQAmount:(NSString *)amount
                       orderNum:(NSString *)orderNum
                         hkdate:(NSString *)hkdate
                        payType:(NSString *)payType
                       dingjing:(NSString *)dingjing
                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestSubmitUPFQAmount:amount orderNum:orderNum hkdate:hkdate payType:payType dingjing:dingjing resultBlock:resultBlock];
}
- (void)requestSubmitUPFQAmount:(NSString *)amount
                       orderNum:(NSString *)orderNum
                         hkdate:(NSString *)hkdate
                        payType:(NSString *)payType
                       dingjing:(NSString *)dingjing
                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_fenqihuankuantijiaoTask) {
        [_fenqihuankuantijiaoTask cancel];
    }
    NSMutableDictionary *params = [@{@"amount":amount?amount:@"",@"ordernum":orderNum?orderNum:@"",@"hk_date":hkdate?hkdate:@"",@"pay_type":payType?payType:@"",@"dingjing":dingjing?dingjing:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/up_fq",SERVER_APP];
    _fenqihuankuantijiaoTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
+ (void)requestAllPayOrderNum:(NSString *)orderNum
                       hkdate:(NSString *)hkdate
                      payType:(NSString *)payType
                  resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestAllPayOrderNum:orderNum hkdate:hkdate payType:payType resultBlock:resultBlock];
}
- (void)requestAllPayOrderNum:(NSString *)orderNum
                       hkdate:(NSString *)hkdate
                      payType:(NSString *)payType
                  resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_quanehuankuanTask) {
        [_quanehuankuanTask cancel];
    }
    NSMutableDictionary *params = [@{@"ordernum":orderNum?orderNum:@"",@"hk_date":hkdate?hkdate:@"",@"pay_type":payType?payType:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/add_seles_f",SERVER_APP];
    _quanehuankuanTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
+ (void)requestNewDingDanListPage:(NSString *)page
                        orderType:(NSString *)orderType
                         oneClick:(NSString *)oneClick
                         twoClick:(NSString *)twoClick
                        twoListId:(NSString *)twoListId
                         joinCode:(NSString *)joinCode
                        startTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                           userId:(NSString *)usrId
                                q:(NSString *)q
                             inId:(NSString *)inId
                      resultBlock:(void(^)(SANewDingDanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestNewDingDanListPage:page orderType:orderType oneClick:oneClick twoClick:twoClick twoListId:twoListId joinCode:joinCode startTime:startTime endTime:endTime userId:usrId q:q inId:inId resultBlock:resultBlock];
}
- (void)requestNewDingDanListPage:(NSString *)page
                        orderType:(NSString *)orderType
                         oneClick:(NSString *)oneClick
                         twoClick:(NSString *)twoClick
                        twoListId:(NSString *)twoListId
                         joinCode:(NSString *)joinCode
                        startTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                           userId:(NSString *)usrId
                                q:(NSString *)q
                             inId:(NSString *)inId
                      resultBlock:(void(^)(SANewDingDanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_new_dingdan_listTask) {
        [_new_dingdan_listTask cancel];
    }
    NSMutableDictionary *params = [@{@"page":page?page:@"",@"order_type":orderType?orderType:@"",@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"join_code":joinCode?joinCode:@"",@"startTime":startTime?startTime:@"",@"endTime":endTime?endTime:@"",@"user_id":usrId?usrId:@"",@"q":q?q:@"",@"inId":inId?inId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/new_dingdan_list",SERVER_APP];
    _new_dingdan_listTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SANewDingDanListModel * model = [SANewDingDanListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestDingDanTongJiOneClick:(NSString *)oneClick
                            twoClick:(NSString *)twoClick
                           twoListId:(NSString *)twoListId
                            joinCode:(NSString *)joinCode
                           startTime:(NSString *)startTime
                             endTime:(NSString *)endTime
                              userId:(NSString *)userId
                                inId:(NSString *)inId
                         resultBlock:(void(^)(SATongJiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestDingDanTongJiOneClick:oneClick twoClick:twoClick twoListId:twoListId joinCode:joinCode startTime:startTime endTime:endTime userId:userId inId:inId resultBlock:resultBlock];
}
- (void)requestDingDanTongJiOneClick:(NSString *)oneClick
                            twoClick:(NSString *)twoClick
                           twoListId:(NSString *)twoListId
                            joinCode:(NSString *)joinCode
                           startTime:(NSString *)startTime
                             endTime:(NSString *)endTime
                              userId:(NSString *)userId
                                inId:(NSString *)inId
                         resultBlock:(void(^)(SATongJiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_dingDanTongJiTask) {
        [_dingDanTongJiTask cancel];
    }
    NSMutableDictionary *params = [@{@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"join_code":joinCode?joinCode:@"",@"startTime":startTime?startTime:@"",@"endTime":endTime?endTime:@"",@"inId":inId?inId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/dingdan_tongji",SERVER_APP];
    _dingDanTongJiTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SATongJiModel * model = [SATongJiModel yy_modelWithDictionary:info.data];
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
 * 服务单和销售服务单7块统计和2个扇形图
 */
+ (void)requestFuWuandXiaoShouFuWuJoinCode:(NSString *)joinCode
                                  oneClick:(NSString *)oneClick
                                  twoClick:(NSString *)twoClick
                                 twoListId:(NSString *)twoListId
                                 startTime:(NSString *)startTime
                                   endTime:(NSString *)endTime
                                      inId:(NSString *)inId
                                    framId:(NSString *)framid
                               resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestFuWuandXiaoShouFuWuJoinCode:joinCode oneClick:oneClick twoClick:twoClick twoListId:twoListId startTime:startTime endTime:endTime inId:inId framId:framid resultBlock:resultBlock];
}

- (void)requestFuWuandXiaoShouFuWuJoinCode:(NSString *)joinCode
                                  oneClick:(NSString *)oneClick
                                  twoClick:(NSString *)twoClick
                                 twoListId:(NSString *)twoListId
                                 startTime:(NSString *)startTime
                                   endTime:(NSString *)endTime
                                      inId:(NSString *)inId
                                    framId:(NSString *)framid
                               resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_FuWuandXiaoShouFuWuTask) {
        [_FuWuandXiaoShouFuWuTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",
                                     @"oneClick":oneClick?oneClick:@"",
                                     @"twoClick":twoClick?twoClick:@"",
                                     @"twoListId":twoListId?twoListId:@"",
                                     @"startTime":startTime?startTime:@"",
                                     @"endTime":endTime?endTime:@"",
                                     @"inId":inId?inId:@"",
                                     @"fram_id":framid?framid:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/get_statistical",SERVER_APP];
    _FuWuandXiaoShouFuWuTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
 * 销售单-升卡续卡-获取用户购买的项目
 */
+ (void)requestShengKaXuKaProuser_id:(NSString *)user_id
                           join_code:(NSString *)join_code
                         resultBlock:(void(^)(ShengKaXuKaProModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestShengKaXuKaProuser_id:user_id join_code:join_code resultBlock:resultBlock];
}
- (void)requestShengKaXuKaProuser_id:(NSString *)user_id
                           join_code:(NSString *)join_code
                         resultBlock:(void(^)(ShengKaXuKaProModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    
    if (_ShengKaXuKaProTask) {
        [_ShengKaXuKaProTask cancel];
    }
    NSMutableDictionary *params = [@{@"user_id":user_id?user_id:@"",@"join_code":join_code?join_code:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.upgrade/get_pro_pro",SERVER_APP];
    
//    NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"SkxkProPro"];
    _ShengKaXuKaProTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        ShengKaXuKaProModel  * info = [ShengKaXuKaProModel yy_modelWithDictionary:result];
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
 * 销售单-升卡续卡-获取用户购买的任选卡
 */
+ (void)requestShengKaXuKaRenXuanKauser_id:(NSString *)user_id
                                 join_code:(NSString *)join_code
                               resultBlock:(void(^)(ShengKaXuKaRenXuanKa *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestShengKaXuKaRenXuanKauser_id:user_id join_code:join_code resultBlock:resultBlock];
}

- (void)requestShengKaXuKaRenXuanKauser_id:(NSString *)user_id
                                 join_code:(NSString *)join_code
                               resultBlock:(void(^)(ShengKaXuKaRenXuanKa *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_ShengKaXuKaRenXuanKaTask) {
        [_ShengKaXuKaRenXuanKaTask cancel];
    }
    NSMutableDictionary *params = [@{@"user_id":user_id?user_id:@"",@"join_code":join_code?join_code:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.upgrade/get_num_num",SERVER_APP];
//    NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"Skxknumnum"];
    _ShengKaXuKaRenXuanKaTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        ShengKaXuKaRenXuanKa  * info = [ShengKaXuKaRenXuanKa yy_modelWithDictionary:result];
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
 * 销售单-升卡续卡-获取用户购买的会员卡
 */
+ (void)requestShengKaXuKaChuZhiKauser_id:(NSString *)user_id
                                join_code:(NSString *)join_code
                              resultBlock:(void(^)(ShengKaXuKaChuZhiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestShengKaXuKaChuZhiKauser_id:user_id join_code:join_code resultBlock:resultBlock];
}

- (void)requestShengKaXuKaChuZhiKauser_id:(NSString *)user_id
                                join_code:(NSString *)join_code
                              resultBlock:(void(^)(ShengKaXuKaChuZhiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_ShengKaXuKaChuZhiKaTask) {
        [_ShengKaXuKaChuZhiKaTask cancel];
    }
    NSMutableDictionary *params = [@{@"user_id":user_id?user_id:@"",@"join_code":join_code?join_code:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.upgrade/get_card_card",SERVER_APP];
    _ShengKaXuKaChuZhiKaTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        ShengKaXuKaChuZhiModel  * info = [ShengKaXuKaChuZhiModel yy_modelWithDictionary:result];
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
 * 销售单-升卡续卡-获取用户购买的项时间卡
 */
+ (void)requestShengKaXuKaShiJiankauser_id:(NSString *)user_id
                                 join_code:(NSString *)join_code
                               resultBlock:(void(^)(ShengKaXuKaShiJianModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestShengKaXuKaShiJiankauser_id:user_id join_code:join_code resultBlock:resultBlock];
}

- (void)requestShengKaXuKaShiJiankauser_id:(NSString *)user_id
                                join_code:(NSString *)join_code
                              resultBlock:(void(^)(ShengKaXuKaShiJianModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_ShengKaXuKaShiJianKaTask) {
        [_ShengKaXuKaShiJianKaTask cancel];
    }
    NSMutableDictionary *params = [@{@"user_id":user_id?user_id:@"",@"join_code":join_code?join_code:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.upgrade/get_time_time",SERVER_APP];
//    NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"Skxktimetime"];
    _ShengKaXuKaShiJianKaTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        ShengKaXuKaShiJianModel  * info = [ShengKaXuKaShiJianModel yy_modelWithDictionary:result];
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
 * 销售单-升卡续卡-获取用户可升的会员卡
 */
+ (void)requestShengKaXuKaKeShengHuiYuanuser_id:(NSString *)user_id
                                      join_code:(NSString *)join_code
                                           code:(NSString *)code
                                    resultBlock:(void(^)(ShengKaXuKaKeShengHuiYuanKa *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestShengKaXuKaKeShengHuiYuanuser_id:user_id join_code:join_code code:(NSString *)code resultBlock:resultBlock];
}

- (void)requestShengKaXuKaKeShengHuiYuanuser_id:(NSString *)user_id
                                 join_code:(NSString *)join_code
                                      code:(NSString *)code
                               resultBlock:(void(^)(ShengKaXuKaKeShengHuiYuanKa *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_ShengKaXuKaKeShengHuiYuanTask) {
        [_ShengKaXuKaKeShengHuiYuanTask cancel];
    }
    NSMutableDictionary *params = [@{@"user_id":user_id?user_id:@"",@"join_code":join_code?join_code:@"",@"code":code?code:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.upgrade/SelectStoredCard",SERVER_APP];
    _ShengKaXuKaKeShengHuiYuanTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        ShengKaXuKaKeShengHuiYuanKa  * info = [ShengKaXuKaKeShengHuiYuanKa yy_modelWithDictionary:result];
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
////
/**
 * 销售单-升卡续卡-提交审批
 */
+ (void)requestCommitShenpi:(NSMutableDictionary *)params
                resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestCommitShenpi:params resultBlock:resultBlock];
}

- (void)requestCommitShenpi:(NSMutableDictionary *)params
                resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_commitShenpiTask) {
        [_commitShenpiTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.upgrade/commit",SERVER_APP];
    _commitShenpiTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg complete:^{
                resultBlock(nil,NO,@{@"error":info.msg});
            }];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}



/**
 * 服务单销售单首页列表
 */
+ (void)requestFuWuandXiaoShouListJoinCode:(NSString *)joinCode
                                  oneClick:(NSString *)oneClick
                                  twoClick:(NSString *)twoClick
                                 twoListId:(NSString *)twoListId
                                 startDate:(NSString *)startDate
                                   endDate:(NSString *)endDate
                                      inId:(NSString *)inId
                                    framId:(NSString *)framid
                                        zt:(NSString *)zt
                                      page:(NSString *)page
                               resultBlock:(void(^)(SAFuWuXiaoShouListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestFuWuandXiaoShouListJoinCode:joinCode oneClick:oneClick twoClick:twoClick twoListId:twoListId startDate:startDate endDate:endDate inId:inId framId:framid zt:zt page:page resultBlock:resultBlock];
}
- (void)requestFuWuandXiaoShouListJoinCode:(NSString *)joinCode
                                  oneClick:(NSString *)oneClick
                                  twoClick:(NSString *)twoClick
                                 twoListId:(NSString *)twoListId
                                 startDate:(NSString *)startDate
                                   endDate:(NSString *)endDate
                                      inId:(NSString *)inId
                                    framId:(NSString *)framid
                                        zt:(NSString *)zt
                                      page:(NSString *)page
                               resultBlock:(void(^)(SAFuWuXiaoShouListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_fuwuDanXiaoShouDanListTask) {
        [_fuwuDanXiaoShouDanListTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",
                                     @"oneClick":oneClick?oneClick:@"",
                                     @"twoClick":twoClick?twoClick:@"",
                                     @"twoListId":twoListId?twoListId:@"",
                                     @"start_date":startDate?startDate:@"",
                                     @"end_date":endDate?endDate:@"",
                                     @"inId":inId?inId:@"",
                                     @"fram_id":framid?framid:@"",@"zt":zt?zt:@"",@"page":page?page:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.serv/get_list",SERVER_APP];
    _fuwuDanXiaoShouDanListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
             SAFuWuXiaoShouListModel  * model = [SAFuWuXiaoShouListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestProJoinCode:(NSString *)joinCode
                    userId:(NSString *)userId
               resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestProJoinCode:joinCode userId:userId resultBlock:resultBlock];
}
- (void)requestProJoinCode:(NSString *)joinCode
                    userId:(NSString *)userId
               resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_fuwuDanXiaoShouDanListTask) {
        [_fuwuDanXiaoShouDanListTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_pro_pro",SERVER_APP];
    _fuwuDanXiaoShouDanListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"propro"];
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SAZhiHuanPorListModel  * model = [SAZhiHuanPorListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestRenXuanCardJoinCode:(NSString *)joinCode
                            userId:(NSString *)userId
                       resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestRenXuanCardJoinCode:joinCode userId:userId resultBlock:resultBlock];
}
- (void)requestRenXuanCardJoinCode:(NSString *)joinCode
                            userId:(NSString *)userId
                       resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_renXuanCardTask) {
        [_renXuanCardTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_num_num",SERVER_APP];
    _renXuanCardTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"numnum"];
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SAZhiHuanPorListModel  * model = [SAZhiHuanPorListModel yy_modelWithDictionary:info.data];
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
 * 获取时间卡
 */
+ (void)requestTimeCardJoinCode:(NSString *)joinCode
                         userId:(NSString *)userId
                    resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestTimeCardJoinCode:joinCode userId:userId resultBlock:resultBlock];
}
- (void)requestTimeCardJoinCode:(NSString *)joinCode
                         userId:(NSString *)userId
                    resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_timeCardTask) {
        [_timeCardTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_time_time",SERVER_APP];
    _timeCardTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"timetime"];
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SAZhiHuanPorListModel  * model = [SAZhiHuanPorListModel yy_modelWithDictionary:info.data];
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
 * 获取疗程卡
 */
+ (void)requestLiaoChengCardJoinCode:(NSString *)joinCode
                              userId:(NSString *)userId
                         resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestLiaoChengCardJoinCode:joinCode userId:userId resultBlock:resultBlock];
}
- (void)requestLiaoChengCardJoinCode:(NSString *)joinCode
                              userId:(NSString *)userId
                         resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_liaoChengCardTask) {
        [_liaoChengCardTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_course_course",SERVER_APP];
    _liaoChengCardTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SAZhiHuanPorListModel  * model = [SAZhiHuanPorListModel yy_modelWithDictionary:info.data];
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
 * 获取会员卡
 */
+ (void)requestHuiYuanJoinCode:(NSString *)joinCode
                            userId:(NSString *)userId
                       resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestHuiYuanJoinCode:joinCode userId:userId resultBlock:resultBlock];
}
- (void)requestHuiYuanJoinCode:(NSString *)joinCode
                            userId:(NSString *)userId
                       resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_huiYuanCardTask) {
        [_huiYuanCardTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_card_card",SERVER_APP];
    _huiYuanCardTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SAZhiHuanPorListModel  * model = [SAZhiHuanPorListModel yy_modelWithDictionary:info.data];
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
 * 获取会员卡
 */
+ (void)requestGoodsJoinCode:(NSString *)joinCode
                  userId:(NSString *)userId
             resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestGoodsJoinCode:joinCode userId:userId resultBlock:resultBlock];
}
- (void)requestGoodsJoinCode:(NSString *)joinCode
                  userId:(NSString *)userId
             resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_goodsTask) {
        [_goodsTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_goods_goods",SERVER_APP];
    _goodsTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"goods_goods"];
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SAZhiHuanPorListModel  * model = [SAZhiHuanPorListModel yy_modelWithDictionary:info.data];
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
 * 获取账户
 */
+ (void)requestGoodsAccountUserId:(NSString *)userId
                      resultBlock:(void(^)(SAAccountModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestGoodsAccountUserId:userId resultBlock:resultBlock];
}
- (void)requestGoodsAccountUserId:(NSString *)userId
                      resultBlock:(void(^)(SAAccountModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_accountTask) {
        [_accountTask cancel];
    }
    NSMutableDictionary *params = [@{@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/get_user_bank",SERVER_APP];
    _accountTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        SAAccountModel  * info = [SAAccountModel yy_modelWithDictionary:result];
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
 * 获取票券
 */
+ (void)requestZhiHuanPiaoQuanUserId:(NSString *)userId
                            JoinCode:(NSString *)joinCode
                         resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestZhiHuanPiaoQuanUserId:userId JoinCode:joinCode resultBlock:resultBlock];
}
- (void)requestZhiHuanPiaoQuanUserId:(NSString *)userId
                            JoinCode:(NSString *)joinCode
                         resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_zhiHuanPiaoQuanTask) {
        [_zhiHuanPiaoQuanTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_ticket_ticket",SERVER_APP];
    _zhiHuanPiaoQuanTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"ticketticket"];
         BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SAZhiHuanPorListModel  * model = [SAZhiHuanPorListModel yy_modelWithDictionary:info.data];
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
 * 获取储值卡
 */
+ (void)requestZhiHuanChuZhiUserId:(NSString *)userId JoinCode:(NSString *)joinCode resultBlock:(void (^)(SAZhiHuanPorListModel *, BOOL, NSDictionary *))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestZhiHuanChuZhiUserId:userId JoinCode:joinCode resultBlock:resultBlock];
}
- (void)requestZhiHuanChuZhiUserId:(NSString *)userId
                            JoinCode:(NSString *)joinCode
                         resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_zhiHuanChuZhiTask) {
        [_zhiHuanChuZhiTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_card_card",SERVER_APP];
    _zhiHuanPiaoQuanTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        //        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"ticketticket"];
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SAZhiHuanPorListModel  * model = [SAZhiHuanPorListModel yy_modelWithDictionary:info.data];
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
 * 已购置换提交结算
 */
+ (void)requestZhiHuanParams:(NSMutableDictionary *)params
                 resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestZhiHuanParams:params resultBlock:resultBlock];
}
- (void)requestZhiHuanParams:(NSMutableDictionary *)params
                 resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_zhihuanCommitTask) {
        [_zhihuanCommitTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/commit",SERVER_APP];
    _zhihuanCommitTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg complete:^{
                resultBlock(nil,NO,@{@"error":info.msg});
            }];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
/**
 * 获取定金订单
 */
+ (void)requestDepositJoinCode:(NSString *)joinCode
                        userId:(NSString *)userId
                   resultBlock:(void(^)(SADepositListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestDepositJoinCode:joinCode userId:userId resultBlock:resultBlock];
}
- (void)requestDepositJoinCode:(NSString *)joinCode
                        userId:(NSString *)userId
                   resultBlock:(void(^)(SADepositListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_depositTask) {
        [_depositTask cancel];
    }
    NSMutableDictionary *params = [@{@"join_code":joinCode?joinCode:@"",@"user_id":userId?userId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/deposit",SERVER_APP];
    _depositTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        NSDictionary *pDic = [LocalTxtToJsonDic txtToJsonDicWithLocalTxtName:@"deposit"];

        SADepositListModel  * info = [SADepositListModel yy_modelWithDictionary:result];
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
 * 置换详情获取商品列表
 */
+ (void)requestZhiHuanDetailOrderNum:(NSString *)orderNum
                         resultBlock:(void(^)(SAZhiHuanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestZhiHuanDetailOrderNum:orderNum resultBlock:resultBlock];
}
- (void)requestZhiHuanDetailOrderNum:(NSString *)orderNum
                         resultBlock:(void(^)(SAZhiHuanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_depositTask) {
        [_depositTask cancel];
    }
    NSMutableDictionary *params = [@{@"ordernum":orderNum?orderNum:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.exchange/get_fq_zd",SERVER_APP];
    _depositTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SAZhiHuanListModel  * model = [SAZhiHuanListModel yy_modelWithDictionary:info.data];
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
 * 退款金额
 */
+ (void)requestTuiKuanParam:(NSMutableDictionary *)param resultBlock:(void(^)(SATuiKuanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestTuiKuanParam:param resultBlock:resultBlock];
}

- (void)requestTuiKuanParam:(NSMutableDictionary *)param resultBlock:(void(^)(SATuiKuanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_tuiKuanTask) {
        [_tuiKuanTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.sales/tuikuan_list",SERVER_APP];
    _depositTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SATuiKuanListModel  * model = [SATuiKuanListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestSaleYeJiListParam:(NSMutableDictionary *)param resultBlock:(void(^)(LOrderYejiListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestSaleYeJiListParam:param resultBlock:resultBlock];
}
- (void)requestSaleYeJiListParam:(NSMutableDictionary *)param resultBlock:(void(^)(LOrderYejiListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_saleyejiTask) {
        [_saleyejiTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.sales_new/yeji_list",SERVER_APP];
    _saleyejiTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LOrderYejiListModel  * model = [LOrderYejiListModel yy_modelWithDictionary:info.data];
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
 * 个性制单审批
 */
+ (void)requestGeXingZhiDanParam:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestGeXingZhiDanParam:param resultBlock:resultBlock];
}
- (void)requestGeXingZhiDanParam:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_gexingzhidanTask) {
        [_gexingzhidanTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.card_div/saveCard",SERVER_APP];
    _gexingzhidanTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg complete:^{
                resultBlock(nil,NO,@{@"error":info.msg});
            }];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

#pragma mark -- 新的订单管理

+ (void)requestBossOrderListFram_id:(NSInteger)fram_id
                          startTime:(NSString *)startTime
                            endTime:(NSString *)endTime
                          join_code:(NSString *)join_code
                               inId:(NSString *)inId
                               page:(NSInteger)page
                         searchText:(NSString *)searchText
                        resultBlock:(void(^)(NSMutableArray *modelArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
     SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestBossOrderListFram_id:fram_id startTime:startTime endTime:endTime join_code:join_code inId:inId page:page searchText:searchText resultBlock:resultBlock];
}

- (void)requestBossOrderListFram_id:(NSInteger)fram_id
                          startTime:(NSString *)startTime
                            endTime:(NSString *)endTime
                          join_code:(NSString *)join_code
                               inId:(NSString *)inId
                               page:(NSInteger)page
                         searchText:(NSString *)searchText
                        resultBlock:(void(^)(NSMutableArray *modelArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_new_dingdan_listTask) {
        [_new_dingdan_listTask cancel];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *token = model.data.token;
    
    [params setValue:token?token:@"" forKey:@"token"];
    [params setValue:fram_id?[NSString stringWithFormat:@"%ld",fram_id]:@"" forKey:@"fram_id"];
    [params setValue:startTime?startTime:@"" forKey:@"startTime"];
    [params setValue:endTime?endTime:@"" forKey:@"endTime"];
    [params setValue:join_code?join_code:@"" forKey:@"join_code"];
    [params setValue:inId?inId:@"" forKey:@"inId"];
    [params setValue:[NSNumber numberWithInt:(int)page] forKey:@"page"];
    [params setValue:searchText?searchText:@"" forKey:@"q"];
    
    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/managers_list",SERVER_APP];
    _new_dingdan_listTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            XMHBossOrderListModel * model = [XMHBossOrderListModel yy_modelWithDictionary:info.data];
            resultBlock(model.list,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestOrderListSaleFram_id:(NSInteger)fram_id
               startTime:(NSString *)startTime
                 endTime:(NSString *)endTime
               join_code:(NSString *)join_code
                    inId:(NSString *)inId
              order_type:(NSInteger)order_type
                    page:(NSInteger)page
              searchText:(NSString *)searchText
             resultBlock:(void(^)(NSArray *modelArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestOrderListSaleFram_id:fram_id startTime:startTime endTime:endTime join_code:join_code inId:inId order_type:order_type page:page searchText:searchText resultBlock:resultBlock];
}

- (void)requestOrderListSaleFram_id:(NSInteger)fram_id
               startTime:(NSString *)startTime
                 endTime:(NSString *)endTime
               join_code:(NSString *)join_code
                    inId:(NSString *)inId
              order_type:(NSInteger)order_type
                    page:(NSInteger)page
              searchText:(NSString *)searchText
             resultBlock:(void(^)(NSArray *modelArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_new_dingdan_listTask) {
        [_new_dingdan_listTask cancel];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *token = model.data.token;
    [params setValue:token forKey:@"token"];
    [params setValue:[NSString stringWithFormat:@"%ld",fram_id] forKey:@"fram_id"];
    [params setValue:startTime forKey:@"startTime"];
    [params setValue:endTime forKey:@"endTime"];
    [params setValue:join_code forKey:@"join_code"];
    [params setValue:inId forKey:@"inId"];
    [params setValue:[NSNumber numberWithInteger:order_type] forKey:@"order_type"];
    [params setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [params setValue:searchText?searchText:@"" forKey:@"q"];
    
    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/sales_list",SERVER_APP];
    _new_dingdan_listTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[XMHCredentiaSalesOrderMdoel class] json:info.data[@"list"]];
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
 订单一级页列表数据 服务凭证
 
 @param fram_id 登录人岗位id (必选)
 @param startTime 查询开始时间 (必选)
 @param endTime 查询结束时间 (必选)
 @param join_code 商家编码
 @param inId 登录人账号 (必选)
 @param zt 列表状态： 0全部，1待结算，2已结算，3已完成 (必选)
 @param page 分页，1开始 (必选)
 @param searchText 搜索关键字
 @param resultBlock N/Y
 */
+ (void)requestOrderListSeverFram_id:(NSInteger)fram_id
                           startTime:(NSString *)startTime
                             endTime:(NSString *)endTime
                           join_code:(NSString *)join_code
                                inId:(NSString *)inId
                                  zt:(NSInteger)zt
                                page:(NSInteger)page
                          searchText:(NSString *)searchText
                         resultBlock:(void(^)(NSArray *modelArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestOrderListSeverFram_id:fram_id startTime:startTime endTime:endTime join_code:join_code inId:inId zt:zt page:page searchText:searchText resultBlock:resultBlock];
}

- (void)requestOrderListSeverFram_id:(NSInteger)fram_id
                           startTime:(NSString *)startTime
                             endTime:(NSString *)endTime
                           join_code:(NSString *)join_code
                                inId:(NSString *)inId
                                  zt:(NSInteger)zt
                                page:(NSInteger)page
                          searchText:(NSString *)searchText
                         resultBlock:(void(^)(NSArray *modelArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
{
    if (_new_dingdan_listTask) {
        [_new_dingdan_listTask cancel];
    }
    kXmHValidString(inId);
    kXmHValidString(endTime);
    kXmHValidString(startTime);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *token = model.data.token;
    [params setValue:token forKey:@"token"];
    [params setValue:[NSString stringWithFormat:@"%ld",fram_id] forKey:@"fram_id"];
    [params setValue:startTime forKey:@"startTime"];
    [params setValue:endTime forKey:@"endTime"];
    [params setValue:join_code forKey:@"join_code"];
    [params setValue:inId forKey:@"inId"];
    [params setValue:@(zt) forKey:@"zt"];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:searchText?searchText:@"" forKey:@"q"];
    
    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/serv_list",SERVER_APP];
    _new_dingdan_listTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            
            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[XMHCredentiaServiceOrderMdoel class] json:info.data[@"list"]];
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
 * 订单管理 统计八块 销售凭证
 */
+ (void)requestOrderStatisticalSaleFram_id:(NSInteger)fram_id
                             startTime:(NSString *)startTime
                               endTime:(NSString *)endTime
                             join_code:(NSString *)join_code
                                  inId:(NSString *)inId
                           resultBlock:(void(^)(SATongJiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestOrderStatisticalSaleFram_id:fram_id startTime:startTime endTime:endTime join_code:join_code inId:inId resultBlock:resultBlock];
}
- (void)requestOrderStatisticalSaleFram_id:(NSInteger)fram_id
                             startTime:(NSString *)startTime
                               endTime:(NSString *)endTime
                             join_code:(NSString *)join_code
                                  inId:(NSString *)inId
                           resultBlock:(void(^)(SATongJiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_dingDanTongJiTask) {
        [_dingDanTongJiTask cancel];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *token = model.data.token;
    [params setValue:token?token:@"" forKey:@"token"];
    [params setValue:fram_id?[NSString stringWithFormat:@"%ld",fram_id]:@"" forKey:@"fram_id"];
    [params setValue:startTime?startTime:@"" forKey:@"startTime"];
    [params setValue:endTime?endTime:@"" forKey:@"endTime"];
    [params setValue:join_code?join_code:@"" forKey:@"join_code"];
    [params setValue:inId?inId:@"" forKey:@"inId"];
    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/sales_tongji",SERVER_APP];
    _dingDanTongJiTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            SATongJiModel * model = [SATongJiModel yy_modelWithDictionary:info.data];
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
 * 订单管理 统计八块 服务凭证
 */
+ (void)requestOrderStatisticalSeverFram_id:(NSInteger)fram_id
                                  startTime:(NSString *)startTime
                                    endTime:(NSString *)endTime
                                  join_code:(NSString *)join_code
                                       inId:(NSString *)inId
                                resultBlock:(void(^)(XMHSeverCertificateModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    SaleListRequest * request = [[SaleListRequest alloc] init];
    [request requestOrderStatisticalSeverFram_id:fram_id startTime:startTime endTime:endTime join_code:join_code inId:inId resultBlock:resultBlock];
}

- (void)requestOrderStatisticalSeverFram_id:(NSInteger)fram_id
                                  startTime:(NSString *)startTime
                                    endTime:(NSString *)endTime
                                  join_code:(NSString *)join_code
                                       inId:(NSString *)inId
                                resultBlock:(void(^)(XMHSeverCertificateModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_dingDanTongJiTask) {
        [_dingDanTongJiTask cancel];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *token = model.data.token;
    [params setValue:token?token:@"" forKey:@"token"];
    [params setValue:fram_id?[NSString stringWithFormat:@"%ld",fram_id]:@"" forKey:@"fram_id"];
    [params setValue:startTime?startTime:@"" forKey:@"startTime"];
    [params setValue:endTime?endTime:@"" forKey:@"endTime"];
    [params setValue:join_code?join_code:@"" forKey:@"join_code"];
    [params setValue:inId?inId:@"" forKey:@"inId"];
    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/serv_tongji",SERVER_APP];
    _dingDanTongJiTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            XMHSeverCertificateModel * model = [XMHSeverCertificateModel yy_modelWithDictionary:info.data];
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
