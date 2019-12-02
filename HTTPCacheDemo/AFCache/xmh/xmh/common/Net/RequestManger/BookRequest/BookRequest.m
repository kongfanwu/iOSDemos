//
//  BookRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookRequest.h"
#import "Networking.h"
#import "BaseModel.h"
#import "YiYuYueModel.h"
#import "YiYuYueListModel.h"
#import "DaiYuYueModel.h"
#import "DaiYuYueListModel.h"
#import "CustomerMessageModel.h"
#import "CustomerBookProjectModel.h"
#import "HomePageHeadModel.h"
#import "LolCalendarModelList.h"
#import "LolHomeListModel.h"
#import "LolSearchCustomerModel.h"
#import "LolSearchCustomerModelList.h"
#import "LolDetailModel.h"
#import "LolHomeGuKeModel.h"
#import "LolGuKeListModel.h"
#import "LolGuKeStateModelList.h"
#import "BookJisTimeList.h"
@implementation BookRequest
+ (void)requestYiYuYueParams:(NSMutableDictionary *)params resultBlock:(void(^)(YiYuYueListModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    BookRequest * request = [[BookRequest alloc] init];
    [request requestYiYuYueParams:params resultBlock:resultBlock];
}
- (void)requestYiYuYueParams:(NSMutableDictionary *)params resultBlock:(void(^)(YiYuYueListModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_yiYuYueTask) {
        [_yiYuYueTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.appo/alreadyAppo",SERVER_APP];
    _yiYuYueTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            YiYuYueListModel *listModel  = [YiYuYueListModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
    
}
+ (void)requestDaiYuYueParams:(NSMutableDictionary *)params resultBlock:(void(^)(DaiYuYueListModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    BookRequest * request = [[BookRequest alloc] init];
    [request requestDaiYuYueParams:params resultBlock:resultBlock];
}
- (void)requestDaiYuYueParams:(NSMutableDictionary *)params resultBlock:(void(^)(DaiYuYueListModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_daiYuYueTask) {
        [_daiYuYueTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.appo/waitAppo",SERVER_APP];
    _daiYuYueTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            DaiYuYueListModel *listModel  = [DaiYuYueListModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
    
}
+ (void)requestCustomerMessageParams:(NSMutableDictionary *)params resultBlock:(void(^)(CustomerMessageModel *customerMessageModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    BookRequest * request = [[BookRequest alloc] init];
    [request requestCustomerMessageParams:params resultBlock:resultBlock];
}
- (void)requestCustomerMessageParams:(NSMutableDictionary *)params resultBlock:(void(^)(CustomerMessageModel *customerMessageModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_customerMessageTask) {
        [_customerMessageTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user/userInfo",SERVER_APP];
    _customerMessageTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            CustomerMessageModel *customerMessageModel  = [CustomerMessageModel yy_modelWithDictionary:info.data];
            resultBlock(customerMessageModel,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
+ (void)requestCustomerBookProjectParams:(NSMutableDictionary *)params resultBlock:(void(^)(CustomerBookProjectModel *projectModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    BookRequest * request = [[BookRequest alloc] init];
    [request requestCustomerBookProjectParams:params resultBlock:resultBlock];
}
- (void)requestCustomerBookProjectParams:(NSMutableDictionary *)params resultBlock:(void(^)(CustomerBookProjectModel *projectModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_customerBookProjectTask) {
        [_customerBookProjectTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.appo_pro/index_appo",SERVER_APP];
    _customerBookProjectTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            CustomerBookProjectModel *model  = [CustomerBookProjectModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
    
}
+ (void)requestHomePageHeadParams:(NSMutableDictionary *)params resultBlock:(void(^)(HomePageHeadModel *homePageHeadModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    BookRequest * request = [[BookRequest alloc] init];
    [request requestHomePageHeadParams:params resultBlock:resultBlock];
}
- (void)requestHomePageHeadParams:(NSMutableDictionary *)params resultBlock:(void(^)(HomePageHeadModel *homePageHeadModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_homePageHeadTask) {
        [_homePageHeadTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Yuyueguanli/getData",SERVER_APP];
    _homePageHeadTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            HomePageHeadModel *homePageHeadModel  = [HomePageHeadModel yy_modelWithDictionary:info.data];
            resultBlock(homePageHeadModel,YES,nil);
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
    
}
- (void)requestHomePageHead:(NSString *)join_code
                   oneClick:(NSString *)oneClick
                   twoClick:(NSString *)twoClick
                  twoListId:(NSString *)twoListId
                       inId:(NSString *)inId
                  startTime:(NSString *)startTime
                    endTime:(NSString *)endTime
                resultBlock:(void(^)(HomePageHeadModel *homePageHeadModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_homePageHeadTask) {
        [_homePageHeadTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Yuyueguanli/getData",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"join_code":join_code?join_code:@"",
                                       @"oneClick":oneClick?oneClick:@"",
                                       @"twoClick":twoClick?twoClick:@"",
                                       @"twoListId":twoListId?twoListId:@"",
                                       @"inId":inId?inId:@"",
                                       @"startTime":startTime?startTime:@"",
                                       @"endTime":endTime?endTime:@""} mutableCopy];
    _homePageHeadTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            HomePageHeadModel *homePageHeadModel  = [HomePageHeadModel yy_modelWithDictionary:info.data];
            resultBlock(homePageHeadModel,YES,nil);
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
+ (void)requestHomePageCalendarParams:(NSMutableDictionary *)params resultBlock:(void(^)(LolCalendarModelList *lolCalendarModelList, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    BookRequest * request = [[BookRequest alloc] init];
    [request  requestHomePageCalendarParams:params resultBlock:resultBlock];
}
- (void)requestHomePageCalendarParams:(NSMutableDictionary *)params resultBlock:(void(^)(LolCalendarModelList *lolCalendarModelList, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    
    if (_homePageCalendarTask) {
        [_homePageCalendarTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Yuyueguanli/standard",SERVER_APP];
    _homePageCalendarTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LolCalendarModelList *listModel  = [LolCalendarModelList yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
- (void)requestHomePageCalendar:(NSString *)join_code
                       oneClick:(NSString *)oneClick
                       twoClick:(NSString *)twoClick
                      twoListId:(NSString *)twoListId
                           inId:(NSString *)inId
                      date:(NSString *)date
                        time:(NSString *)time
                    resultBlock:(void(^)(LolCalendarModelList *lolCalendarModelList, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    
    if (_homePageCalendarTask) {
        [_homePageCalendarTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Yuyueguanli/standard",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"join_code":join_code?join_code:@"",
                                       @"oneClick":oneClick?oneClick:@"",
                                       @"twoClick":twoClick?twoClick:@"",
                                       @"twoListId":twoListId?twoListId:@"",
                                       @"inId":inId?inId:@"",
                                       @"date":date?date:@"",
                                       @"time":time?time:@""} mutableCopy];
    _homePageCalendarTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LolCalendarModelList *listModel  = [LolCalendarModelList yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
    
}
+ (void)requestHomePageListParams:(NSMutableDictionary *)params
                      resultBlock:(void(^)(LolHomeListModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    BookRequest * request = [[BookRequest alloc] init];
    [request requestHomePageListParams:params resultBlock:resultBlock];
}
- (void)requestHomePageListParams:(NSMutableDictionary *)params
                      resultBlock:(void(^)(LolHomeListModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_homeListTask) {
        [_homeListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Yuyueguanli/get_list",SERVER_APP];
//    NSMutableDictionary *parmsDic = [@{@"join_code":join_code?join_code:@"",
//                                       @"oneClick":oneClick?oneClick:@"",
//                                       @"twoClick":twoClick?twoClick:@"",
//                                       @"twoListId":twoListId?twoListId:@"",
//                                       @"inId":inId?inId:@"",
//                                       @"startTime":startTime?startTime:@"",
//                                       @"endTime":endTime?endTime:@""} mutableCopy];
    _homeListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LolHomeListModel *listModel  = [LolHomeListModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
- (void)requestHomePageList:(NSString *)join_code
                   oneClick:(NSString *)oneClick
                   twoClick:(NSString *)twoClick
                  twoListId:(NSString *)twoListId
                       inId:(NSString *)inId
                  startTime:(NSString *)startTime
                    endTime:(NSString *)endTime
                resultBlock:(void(^)(LolHomeListModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_homeListTask) {
        [_homeListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Yuyueguanli/get_list",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"join_code":join_code?join_code:@"",
                                       @"oneClick":oneClick?oneClick:@"",
                                       @"twoClick":twoClick?twoClick:@"",
                                       @"twoListId":twoListId?twoListId:@"",
                                       @"inId":inId?inId:@"",
                                       @"startTime":startTime?startTime:@"",
                                       @"endTime":endTime?endTime:@""} mutableCopy];
    _homeListTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LolHomeListModel *listModel  = [LolHomeListModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
+ (void)requestSubmitParams:(NSMutableDictionary *)params resultBlock:(void(^)(BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    BookRequest * request = [[BookRequest alloc] init];
    [request requestSubmitParams:params resultBlock:resultBlock];
}
- (void)requestSubmitParams:(NSMutableDictionary *)params resultBlock:(void(^)(BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_submitTask) {
        [_submitTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.appo/oneKeyAppo",SERVER_APP];
    _submitTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            
            resultBlock(YES,nil);
        }else if(info.code ==0){
            resultBlock(NO,@{@"error":info.msg});
        }else{
             NSLog(@"/////");
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(NO,@{@"error":@"网络请求错误"});
    }];
}
+ (void)requestDetailParams:(NSMutableDictionary *)params resultBlock:(void(^)(LolDetailModel *detailModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
     BookRequest * request = [[BookRequest alloc] init];
    [request requestDetailParams:params resultBlock:resultBlock];
}
- (void)requestDetailParams:(NSMutableDictionary *)params resultBlock:(void(^)(LolDetailModel *detailModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_detailTask) {
        [_detailTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.appo_pro/index_appo",SERVER_APP];
    _detailTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        LolDetailModel * model = [LolDetailModel yy_modelWithDictionary:info.data];
        if (info.code ==1) {
            
            resultBlock(model,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
+ (void)requestHomePageGuKeBookCountParams:(NSMutableDictionary *)params resultBlock:(void(^)(LolGuKeListModel *guKeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    BookRequest * request = [[BookRequest alloc] init];
    [request requestHomePageGuKeBookCountParams:params resultBlock:resultBlock];
}
- (void)requestHomePageGuKeBookCountParams:(NSMutableDictionary *)params resultBlock:(void(^)(LolGuKeListModel *guKeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_homeGuKeBookCountTask) {
        [_homeGuKeBookCountTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Yuyueguanli/get_user_list",SERVER_APP];
    _homeGuKeBookCountTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LolGuKeListModel *listModel  = [LolGuKeListModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
- (void)requestHomePageGuKeBookCount:(NSString *)join_code
                            oneClick:(NSString *)oneClick
                            twoClick:(NSString *)twoClick
                           twoListId:(NSString *)twoListId
                                page:(NSString *)page
                                date:(NSString *)date
                                inID:(NSString *)inId resultBlock:(void(^)(LolGuKeListModel *guKeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_homeGuKeBookCountTask) {
        [_homeGuKeBookCountTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Yuyueguanli/get_user_list",SERVER_APP];
    NSMutableDictionary *parmsDic = [@{@"join_code":join_code?join_code:@"",
                                       @"oneClick":oneClick?oneClick:@"",
                                       @"twoClick":twoClick?twoClick:@"",
                                       @"twoListId":twoListId?twoListId:@"",
                                       @"date":date?date:@"",@"inId":inId?inId:@"",@"page":page?page:@""} mutableCopy];
    _homeGuKeBookCountTask = [Networking requestWithURL:url params:parmsDic requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LolGuKeListModel *listModel  = [LolGuKeListModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
+ (void)requestOneGukeListParam:(NSMutableDictionary *)param resultBlock:(void(^)(LolGuKeStateModelList *guKeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    BookRequest * request = [[BookRequest alloc] init];
    [request requestOneGukeListParam:param resultBlock:resultBlock];
}
- (void)requestOneGukeListParam:(NSMutableDictionary *)param resultBlock:(void(^)(LolGuKeStateModelList *guKeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_gukeStateTask) {
        [_gukeStateTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Yuyueguanli/get_user_info",SERVER_APP];
    _gukeStateTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LolGuKeStateModelList *listModel  = [LolGuKeStateModelList yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
+ (void)requestJisTimeParam:(NSMutableDictionary *)param resultBlock:(void(^)(BookJisTimeList *timeList, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    BookRequest * request = [[BookRequest alloc] init];
    [request requestJisTimeParam:param resultBlock:resultBlock];
}
- (void)requestJisTimeParam:(NSMutableDictionary *)param resultBlock:(void(^)(BookJisTimeList *timeList, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_jisTimeTask) {
        [_jisTimeTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Yuyueguanli/kyy",SERVER_APP];
    _gukeStateTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            BookJisTimeList *listModel  = [BookJisTimeList yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            resultBlock(nil,NO,@{@"error":info.msg});
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
+ (void)requestCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    BookRequest *request = [[BookRequest alloc] init];
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
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
@end
