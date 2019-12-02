//
//  TJRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJRequest.h"
#import "Networking.h"
#import "TJTopModel.h"
#import "TJYeJiListModel.h"
#import "XiaoHaoTopModel.h"
#import "FuZhaiTopModel.h"
#import "TJGuKeTopModel.h"
#import "TJCardTopModel.h"
#import "TJCardListModel.h"
#import "TJGuKeListModel.h"
#import "TJBBTopModel.h"
#import "TJBBListModel.h"
#import "TJCustomerTopModel.h"
#import "TJCustomerListModel.h"
#import "TJStoreListModel.h"
#import "TJStaffDetailModel.h"
#import "CustomerGradeListModel.h"
#import "TJGradeListModel.h"
#import "TJCustomerActiveTopModel.h"
#import "TJCustomerActiveListModel.h"
#import "TJCustomerActiveDetailModel.h"
#import "TJExpendTopModel.h"
#import "TJExpendListModel.h"
#import "TJCashTopModel.h"
#import "TJCashListModel.h"
#import "CustomerRetainListModel.h"
#import "CustomerRetainTopModel.h"
@implementation TJRequest
+ (void)requestYejiTopOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                   resultBlock:(void(^)(TJTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestYejiTopOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId joinCode:joinCode startTime:startTime endTime:endTime resultBlock:resultBlock];
}
- (void)requestYejiTopOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                   resultBlock:(void(^)(TJTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_topTask) {
        [_topTask cancel];
    }
    NSMutableDictionary *params = [@{@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"inId":inId?inId:@"",@"join_code":joinCode?joinCode:@"",@"startTime":startTime?startTime:@"",@"endTime":endTime?endTime:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Statistical/performance_index",SERVER_APP];
    _topTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJTopModel  * model = [TJTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
//+ (void)requestYejiTopOneClick:(NSString *)oneClick
//                      twoClick:(NSString *)twoClick
//                     twoListId:(NSString *)twoListId
//                          inId:(NSString *)inId
//                      joinCode:(NSString *)joinCode
//                     startTime:(NSString *)startTime
//                       endTime:(NSString *)endTime
//                          type:(NSString *)type
//                   resultBlock:(void(^)(TJYeJiListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
//    TJRequest * request = [[TJRequest alloc] init];
//    [request requestYejiTopOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId joinCode:joinCode startTime:startTime endTime:endTime type:type resultBlock:resultBlock];
//}
//- (void)requestYejiTopOneClick:(NSString *)oneClick
//                      twoClick:(NSString *)twoClick
//                     twoListId:(NSString *)twoListId
//                          inId:(NSString *)inId
//                      joinCode:(NSString *)joinCode
//                     startTime:(NSString *)startTime
//                       endTime:(NSString *)endTime
//                          type:(NSString *)type
//                   resultBlock:(void(^)(TJYeJiListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
//    if (_listTask) {
//        [_listTask cancel];
//    }
//    NSMutableDictionary *params = [@{@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"inId":inId?inId:@"",@"join_code":joinCode?joinCode:@"",@"startTime":startTime?startTime:@"",@"endTime":endTime?endTime:@"",@"type":type?type:@""} mutableCopy];
//    NSString * url = [NSString stringWithFormat:@"%@v5.Statistical/performance",SERVER_APP];
//    _listTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
//        TJYeJiListModel  * info = [TJYeJiListModel yy_modelWithDictionary:result];
//        if (info.code ==1) {
//            resultBlock(info,YES,nil);
//        }else{
//            [MzzHud toastWithTitle:@"提示" message:info.msg];
//        }
//    } fail:^(id  _Nullable errorresult) {
//        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
//        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
//    }];
//}
+ (void)requestFuZhaiTopOneClick:(NSString *)oneClick
                        twoClick:(NSString *)twoClick
                       twoListId:(NSString *)twoListId
                            inId:(NSString *)inId
                        joinCode:(NSString *)joinCode
                       startTime:(NSString *)startTime
                         endTime:(NSString *)endTime
                     resultBlock:(void(^)(FuZhaiTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestFuZhaiTopOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId joinCode:joinCode startTime:startTime endTime:endTime resultBlock:resultBlock];
}
- (void)requestFuZhaiTopOneClick:(NSString *)oneClick
                        twoClick:(NSString *)twoClick
                       twoListId:(NSString *)twoListId
                            inId:(NSString *)inId
                        joinCode:(NSString *)joinCode
                       startTime:(NSString *)startTime
                         endTime:(NSString *)endTime
                     resultBlock:(void(^)(FuZhaiTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_fuZhaiTopTask) {
        [_fuZhaiTopTask cancel];
    }
    NSMutableDictionary *params = [@{@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"inId":inId?inId:@"",@"join_code":joinCode?joinCode:@"",@"startTime":startTime?startTime:@"",@"endTime":endTime?endTime:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.tongji/fuzhai",SERVER_APP];
    _fuZhaiTopTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            FuZhaiTopModel  * model = [FuZhaiTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestXiaoHaoTopOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                   resultBlock:(void(^)(XiaoHaoTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestXiaoHaoTopOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId joinCode:joinCode startTime:startTime endTime:endTime resultBlock:resultBlock];
}
- (void)requestXiaoHaoTopOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                   resultBlock:(void(^)(XiaoHaoTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_xiaoHaoTopTask) {
        [_xiaoHaoTopTask cancel];
    }
    NSMutableDictionary *params = [@{@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"inId":inId?inId:@"",@"join_code":joinCode?joinCode:@"",@"startTime":startTime?startTime:@"",@"endTime":endTime?endTime:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Statistical/consumption_index",SERVER_APP];
    _xiaoHaoTopTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            XiaoHaoTopModel  * model = [XiaoHaoTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestGukeTopOneClick:(NSString *)oneClick
                         twoClick:(NSString *)twoClick
                        twoListId:(NSString *)twoListId
                             inId:(NSString *)inId
                         joinCode:(NSString *)joinCode
                        startTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                      resultBlock:(void(^)(TJGuKeTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestGukeTopOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId joinCode:joinCode startTime:startTime endTime:endTime resultBlock:resultBlock];
}
- (void)requestGukeTopOneClick:(NSString *)oneClick
                         twoClick:(NSString *)twoClick
                        twoListId:(NSString *)twoListId
                             inId:(NSString *)inId
                         joinCode:(NSString *)joinCode
                        startTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                      resultBlock:(void(^)(TJGuKeTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_guKeTopTask) {
        [_guKeTopTask cancel];
    }
    NSMutableDictionary *params = [@{@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"inId":inId?inId:@"",@"join_code":joinCode?joinCode:@"",@"startTime":startTime?startTime:@"",@"endTime":endTime?endTime:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.tongji/guke_first",SERVER_APP];
    _guKeTopTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJGuKeTopModel  * model = [TJGuKeTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestGukeListOneClick:(NSString *)oneClick
                       twoClick:(NSString *)twoClick
                      twoListId:(NSString *)twoListId
                           inId:(NSString *)inId
                       joinCode:(NSString *)joinCode
                      startTime:(NSString *)startTime
                        endTime:(NSString *)endTime
                       cardType:(NSString *)cardType
                      orderType:(NSString *)orderType
                    resultBlock:(void(^)(TJGuKeListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestGukeListOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId joinCode:joinCode startTime:startTime endTime:endTime cardType:cardType orderType:orderType  resultBlock:resultBlock];
}
- (void)requestGukeListOneClick:(NSString *)oneClick
                       twoClick:(NSString *)twoClick
                      twoListId:(NSString *)twoListId
                           inId:(NSString *)inId
                       joinCode:(NSString *)joinCode
                      startTime:(NSString *)startTime
                        endTime:(NSString *)endTime
                       cardType:(NSString *)cardType
                      orderType:(NSString *)orderType
                    resultBlock:(void(^)(TJGuKeListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_guKeListTask) {
        [_guKeListTask cancel];
    }
    NSMutableDictionary *params = [@{@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"inId":inId?inId:@"",@"join_code":joinCode?joinCode:@"",@"startTime":startTime?startTime:@"",@"endTime":endTime?endTime:@"",@"card_type":cardType?cardType:@"",@"orderby_type":orderType?orderType:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.tongji/guke_pic_list",SERVER_APP];
    _guKeListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJGuKeListModel  * model = [TJGuKeListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestCardTopOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                   resultBlock:(void(^)(TJCardTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestCardTopOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId joinCode:joinCode startTime:startTime endTime:endTime resultBlock:resultBlock];
}
- (void)requestCardTopOneClick:(NSString *)oneClick
                      twoClick:(NSString *)twoClick
                     twoListId:(NSString *)twoListId
                          inId:(NSString *)inId
                      joinCode:(NSString *)joinCode
                     startTime:(NSString *)startTime
                       endTime:(NSString *)endTime
                   resultBlock:(void(^)(TJCardTopModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_cardTopTask) {
        [_cardTopTask cancel];
    }
    NSMutableDictionary *params = [@{@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"inId":inId?inId:@"",@"join_code":joinCode?joinCode:@"",@"startTime":startTime?startTime:@"",@"endTime":endTime?endTime:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Statistical/card_index",SERVER_APP];
    _cardTopTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJCardTopModel  * model = [TJCardTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestCardSearchOneClick:(NSString *)oneClick
                         twoClick:(NSString *)twoClick
                        twoListId:(NSString *)twoListId
                             inId:(NSString *)inId
                         joinCode:(NSString *)joinCode
                        startTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                                q:(NSString *)q
                      resultBlock:(void(^)(TJCardListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestCardSearchOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId joinCode:joinCode startTime:startTime endTime:endTime q:q resultBlock:resultBlock];
}
- (void)requestCardSearchOneClick:(NSString *)oneClick
                         twoClick:(NSString *)twoClick
                        twoListId:(NSString *)twoListId
                             inId:(NSString *)inId
                         joinCode:(NSString *)joinCode
                        startTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                                q:(NSString *)q
                      resultBlock:(void(^)(TJCardListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_cardSearchTask) {
        [_cardSearchTask cancel];
    }
    NSMutableDictionary *params = [@{@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"inId":inId?inId:@"",@"join_code":joinCode?joinCode:@"",@"startTime":startTime?startTime:@"",@"endTime":endTime?endTime:@"",@"q":q?q:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Statistical/card_search",SERVER_APP];
    _cardSearchTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJCardListModel  * model = [TJCardListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestCardListOneClick:(NSString *)oneClick
                       twoClick:(NSString *)twoClick
                      twoListId:(NSString *)twoListId
                           inId:(NSString *)inId
                       joinCode:(NSString *)joinCode
                      startTime:(NSString *)startTime
                        endTime:(NSString *)endTime
                           sort:(NSString *)sort
                     categoryId:(NSString *)categoryId
                    resultBlock:(void(^)(TJCardListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestCardListOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId joinCode:joinCode startTime:startTime endTime:endTime sort:sort categoryId:categoryId resultBlock:resultBlock];
}
- (void)requestCardListOneClick:(NSString *)oneClick
                       twoClick:(NSString *)twoClick
                      twoListId:(NSString *)twoListId
                           inId:(NSString *)inId
                       joinCode:(NSString *)joinCode
                      startTime:(NSString *)startTime
                        endTime:(NSString *)endTime
                           sort:(NSString *)sort
                     categoryId:(NSString *)categoryId
                    resultBlock:(void(^)(TJCardListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_cardSearchTask) {
        [_cardSearchTask cancel];
    }
    NSMutableDictionary *params = [@{@"oneClick":oneClick?oneClick:@"",@"twoClick":twoClick?twoClick:@"",@"twoListId":twoListId?twoListId:@"",@"inId":inId?inId:@"",@"join_code":joinCode?joinCode:@"",@"startTime":startTime?startTime:@"",@"endTime":endTime?endTime:@"",@"sort":sort?sort:@"",@"category_id":categoryId?categoryId:@""} mutableCopy];
    NSString * url = [NSString stringWithFormat:@"%@v5.Statistical/card_list",SERVER_APP];
    _cardSearchTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJCardListModel  * model = [TJCardListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJBBTopDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJBBTopModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJBBTopDataParam:param resultBlock:resultBlock];
    
}
- (void)requestTJBBTopDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJBBTopModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock
{
    if (_bbTopTask) {
        [_bbTopTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@achievement/get_index",SERVER_COUNT];
    _bbTopTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJBBTopModel  * model = [TJBBTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJBBListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJBBListModel *model,
                                                                                   BOOL isSuccess,
                                                                                   NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJBBListDataParam:param resultBlock:resultBlock];
}
- (void)requestTJBBListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJBBListModel *model,
                                                                                   BOOL isSuccess,
                                                                                   NSDictionary *errorDic))resultBlock
{
    if (_bbListTask) {
        [_bbListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@achievement/getAll",SERVER_COUNT];
    _bbListTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJBBListModel  * model = [TJBBListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJCustomerTopDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerTopModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJCustomerTopDataParam:param resultBlock:resultBlock];
    
}
- (void)requestTJCustomerTopDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerTopModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock
{
    if (_customerTopTask) {
        [_customerTopTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/employees_index",SERVER_COUNT];
    _customerTopTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJCustomerTopModel  * model = [TJCustomerTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJCustomerListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerListModel *model,
                                                                                         BOOL isSuccess,
                                                                                         NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJCustomerListDataParam:param resultBlock:resultBlock];
}
- (void)requestTJCustomerListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerListModel *model,
                                                                                         BOOL isSuccess,
                                                                                         NSDictionary *errorDic))resultBlock
{
    if (_customerListTask) {
        [_customerListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/employees_list",SERVER_COUNT];
    _customerListTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJCustomerListModel  * model = [TJCustomerListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJCustomerStoreDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJStoreListModel *model,
                                                                                          BOOL isSuccess,
                                                                                          NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJCustomerStoreDataParam:param resultBlock:resultBlock];
}
- (void)requestTJCustomerStoreDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJStoreListModel *model,
                                                                                          BOOL isSuccess,
                                                                                          NSDictionary *errorDic))resultBlock
{
    if (_customerStoreTask) {
        [_customerStoreTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@achievement/stores_list",SERVER_COUNT];
    _customerStoreTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJStoreListModel  * model = [TJStoreListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJStaffDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJStaffDetailModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJStaffDataParam:param resultBlock:resultBlock];
}
- (void)requestTJStaffDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJStaffDetailModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock
{
    if (_staffDetailTask) {
        [_staffDetailTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/employees_info",SERVER_COUNT];
    _staffDetailTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJStaffDetailModel  * model = [TJStaffDetailModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJCustomerGradeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(CustomerGradeListModel *model,
                                                                                          BOOL isSuccess,
                                                                                          NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJCustomerGradeDataParam:param resultBlock:resultBlock];
}
- (void)requestTJCustomerGradeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(CustomerGradeListModel *model,
                                                                                          BOOL isSuccess,
                                                                                          NSDictionary *errorDic))resultBlock
{
    if (_customerGradeListTask) {
        [_customerGradeListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/user_grade_list",SERVER_COUNT];
    _customerGradeListTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            CustomerGradeListModel  * model = [CustomerGradeListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJGradeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJGradeListModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJGradeDataParam:param resultBlock:resultBlock];
}
- (void)requestTJGradeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJGradeListModel *model,
                                                                                  BOOL isSuccess,
                                                                                  NSDictionary *errorDic))resultBlock
{
    if (_customerGradeTask) {
        [_customerGradeTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/user_grade",SERVER_COUNT];
    _customerGradeTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJGradeListModel  * model = [TJGradeListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJCustomerActiveTopeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerActiveTopModel *model,
                                                                                               BOOL isSuccess,
                                                                                               NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJCustomerActiveTopeDataParam:param resultBlock:resultBlock];
}
- (void)requestTJCustomerActiveTopeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerActiveTopModel *model,
                                                                                               BOOL isSuccess,
                                                                                               NSDictionary *errorDic))resultBlock
{
    if (_customerActiveTopTask) {
        [_customerActiveTopTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/user_active",SERVER_COUNT];
    _customerActiveTopTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJCustomerActiveTopModel  * model = [TJCustomerActiveTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJCustomerActiveListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerActiveListModel *model,
                                                                                               BOOL isSuccess,
                                                                                               NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJCustomerActiveListDataParam:param resultBlock:resultBlock];
}
- (void)requestTJCustomerActiveListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerActiveListModel *model,
                                                                                               BOOL isSuccess,
                                                                                               NSDictionary *errorDic))resultBlock
{
    if (_customerActiveListTask) {
        [_customerActiveListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/user_active_list",SERVER_COUNT];
    _customerActiveListTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJCustomerActiveListModel  * model = [TJCustomerActiveListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJCustomerActiveDetailDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerActiveDetailModel *model,
                                                                                                 BOOL isSuccess,
                                                                                                 NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJCustomerActiveDetailDataParam:param resultBlock:resultBlock];
}
- (void)requestTJCustomerActiveDetailDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCustomerActiveDetailModel *model,
                                                                                                 BOOL isSuccess,
                                                                                                 NSDictionary *errorDic))resultBlock
{
    if (_customerActiveDetailTask) {
        [_customerActiveDetailTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/user_active_info",SERVER_COUNT];
    _customerActiveDetailTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJCustomerActiveDetailModel  * model = [TJCustomerActiveDetailModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJExpendTopeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJExpendTopModel *model,
                                                                                       BOOL isSuccess,
                                                                                       NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJExpendTopeDataParam:param resultBlock:resultBlock];
}
- (void)requestTJExpendTopeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJExpendTopModel *model,
                                                                                       BOOL isSuccess,
                                                                                       NSDictionary *errorDic))resultBlock
{
    if (_expendTopTask) {
        [_expendTopTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/consumption_index",SERVER_COUNT];
    _expendTopTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJExpendTopModel  * model = [TJExpendTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJExpendListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJExpendListModel *model,
                                                                                       BOOL isSuccess,
                                                                                       NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJExpendListDataParam:param resultBlock:resultBlock];
}
-  (void)requestTJExpendListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJExpendListModel *model,
                                                                                       BOOL isSuccess,
                                                                                       NSDictionary *errorDic))resultBlock
{
    if (_expendListTask) {
        [_expendListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/consumption_list",SERVER_COUNT];
    _expendListTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJExpendListModel  * model = [TJExpendListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJCashTopeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCashTopModel *model,
                                                                                     BOOL isSuccess,
                                                                                     NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJCashTopeDataParam:param resultBlock:resultBlock];
}
- (void)requestTJCashTopeDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCashTopModel *model,
                                                                                     BOOL isSuccess,
                                                                                     NSDictionary *errorDic))resultBlock
{
    if (_cashTopTask) {
        [_cashTopTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/cashier_index",SERVER_COUNT];
    _cashTopTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJCashTopModel  * model = [TJCashTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJCashListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCashListModel *model,
                                                                                     BOOL isSuccess,
                                                                                     NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJCashListDataParam:param resultBlock:resultBlock];
}
- (void)requestTJCashListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(TJCashListModel *model,
                                                                                     BOOL isSuccess,
                                                                                     NSDictionary *errorDic))resultBlock
{
    if (_cashListTask) {
        [_cashListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/cashier_list",SERVER_COUNT];
    _cashListTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            TJCashListModel  * model = [TJCashListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJCustomerRetainListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(CustomerRetainListModel *model,
                                                                                               BOOL isSuccess,
                                                                                               NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJCustomerRetainListDataParam:param resultBlock:resultBlock];
}
- (void)requestTJCustomerRetainListDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(CustomerRetainListModel *model,
                                                                                               BOOL isSuccess,
                                                                                               NSDictionary *errorDic))resultBlock
{
    if (_customerRetainListTask) {
        [_customerRetainListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/user_keep_list",SERVER_COUNT];
    _customerRetainListTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            CustomerRetainListModel  * model = [CustomerRetainListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJCustomerRetainTopDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(CustomerRetainTopModel *model,
                                                                                              BOOL isSuccess,
                                                                                              NSDictionary *errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJCustomerRetainTopDataParam:param resultBlock:resultBlock];
}
- (void)requestTJCustomerRetainTopDataParam:(NSMutableDictionary *)param resultBlock:(void(^)(CustomerRetainTopModel *model,
                                                                                              BOOL isSuccess,
                                                                                              NSDictionary *errorDic))resultBlock
{
    if (_customerRetainTopTask) {
        [_customerRetainTopTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@Achievement/user_keep_index",SERVER_COUNT];
    _customerRetainTopTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            CustomerRetainTopModel  * model = [CustomerRetainTopModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestTJDataCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    TJRequest * request = [[TJRequest alloc] init];
    [request requestTJDataCommonUrl:url Param:params resultBlock:resultBlock];
}
- (void)requestTJDataCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_commonTask) {
        [_commonTask cancel];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",SERVER_COUNT,url];
    _commonTask = [Networking requestWithURL:urlStr params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
