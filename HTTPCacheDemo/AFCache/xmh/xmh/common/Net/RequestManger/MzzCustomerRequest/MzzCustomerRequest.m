//
//  BookRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzCustomerRequest.h"
#import "Networking.h"

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
#import "MzzDengjiModel.h"
#import "MzzLevelModel.h"
#import "MzzStoreModel.h"
#import "MzzWaiterModel.h"
#import "MzzHomePageModel.h"
#import "MzzHud.h"
#import "MzzCustomerInfoModel.h"
#import "MzzTags.h"
#import "MzzCustomerInfoCommitModel.h"
#import "MzzManageModel.h"
#import "MzzCardsModel.h"
#import "CustomerListModel.h"
#import "MzzPujiModel.h"
#import "MzzUser_bill.h"
#import "MzzUserInfoModel.h"
#import "MzzUser_salesModel.h"
#import "MzzConsumptionListModel.h"
#import "MzzConsumption_salesListModel.h"
#import "MzzChangeInfoModel.h"
#import "MzzBillInfoListModel.h"
#import "MzzGuideModel.h"
#import "MzzSelectModel.h"
#import "MzzPortraitModel.h"
#import "GKGLBillListModel.h"

#import "GKGLHomeCustomerListModel.h"

@implementation MzzCustomerRequest

- (void)requestManagerParams:(NSMutableDictionary *)params resultBlock:(void(^)(ManageData *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_manageTask) {
        [_manageTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_management/manage",SERVER_APP];
    _manageTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            ManageData *listModel  = [ManageData yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

+ (void)requestManagerParams:(NSMutableDictionary *)params resultBlock:(void(^)( ManageData*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestManagerParams:params resultBlock:resultBlock];
}



- (void)requestManageGroupListParams:(NSMutableDictionary *)params resultBlock:(void(^)(LevelData *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_manageGroupListTask) {
        [_manageGroupListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_management/get_group_list",SERVER_APP];
    _manageGroupListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LevelData *listModel  = [LevelData yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

+ (void)requestManageGroupListParams:(NSMutableDictionary *)params resultBlock:(void(^)( LevelData*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestManageGroupListParams:params resultBlock:resultBlock];
}
+ (void)requestBookCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)( CustomerListModel*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestBookCustomerListParams:params resultBlock:resultBlock];
}
- (void)requestBookCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)(CustomerListModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_customerTask) {
        [_customerTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_management/userlist",SERVER_APP];
    //    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/search_user",SERVER_APP];
    _customerTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            CustomerListModel *listModel  = [CustomerListModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
+ (void)requestBeautyCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)( CustomerListModel*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestBeautyCustomerListParams:params resultBlock:resultBlock];
}
- (void)requestBeautyCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)(CustomerListModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_customerTask) {
        [_customerTask cancel];
    }
        NSString * url = [NSString stringWithFormat:@"%@v5.Mldz_new/userList",SERVER_APP];
//    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/search_user",SERVER_APP];
    _customerTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            CustomerListModel *listModel  = [CustomerListModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}
- (void)requestCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)(CustomerListModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_customerTask) {
        [_customerTask cancel];
    }
//    NSString * url = [NSString stringWithFormat:@"%@v5.user_management/userlist",SERVER_APP];
    NSString * url = [NSString stringWithFormat:@"%@v5.serv_1/search_user",SERVER_APP];
    _customerTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            CustomerListModel *listModel  = [CustomerListModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

+ (void)requestCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)( CustomerListModel*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestCustomerListParams:params resultBlock:resultBlock];
}

- (void)requestCardListParams:(NSMutableDictionary *)params resultBlock:(void(^)(ESRootClass *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_cardTask) {
        [_cardTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_management/card_list",SERVER_APP];
    _cardTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        ESRootClass  * info = [ESRootClass yy_modelWithDictionary:result];
//        if (info.code ==1) {
//            LevelData *listModel  = [LevelData yy_modelWithDictionary:info.data];
            resultBlock(info,YES,nil);
//        }else{
//            [MzzHud toastWithTitle:@"提示" message:info.msg];
//        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

+ (void)requestCardListParams:(NSMutableDictionary *)params resultBlock:(void(^)( ESRootClass*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestCardListParams:params resultBlock:resultBlock];
}

- (void)requestCustomerLevelParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzDengjiModel *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_manageGroupListTask) {
        [_manageGroupListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user/grade",SERVER_APP];
    _manageGroupListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzDengjiModel *listModel  = [MzzDengjiModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
               [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
    }];
}

+ (void)requestCustomerLevelParams:(NSMutableDictionary *)params resultBlock:(void(^)( MzzDengjiModel*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestCustomerLevelParams:params resultBlock:resultBlock];
}


- (void)requestStoreListParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzStoreList *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_daiYuYueTask) {
        [_daiYuYueTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user/stores_list",SERVER_APP];
    _daiYuYueTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzStoreList *listModel  = [MzzStoreList yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
//               [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
//        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestStoreListParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzStoreList *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestStoreListParams:params resultBlock:resultBlock];
}

- (void)requestAccountParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzAccountList *customerMessageModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_customerMessageTask) {
        [_customerMessageTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user/choose",SERVER_APP];
    _customerMessageTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzAccountList *customerMessageModel  = [MzzAccountList yy_modelWithDictionary:info.data];
            resultBlock(customerMessageModel,YES,nil);
        }else{
               [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestAccountParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzAccountList *customerMessageModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestAccountParams:params resultBlock:resultBlock];
}
/**
 * 首页统计数据接口
 */
- (void)requestHomePageDataParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzJobSelector *projectModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_customerBookProjectTask) {
        [_customerBookProjectTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_management/manage",SERVER_APP];
    _customerBookProjectTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzJobSelector *model  = [MzzJobSelector yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestHomePageDataParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzJobSelector *homePageHeadModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestHomePageDataParams:params resultBlock:resultBlock];
}

- (void)requestCustomerInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(InfoModel *homePageHeadModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_homePageHeadTask) {
        [_homePageHeadTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user/user_info",SERVER_APP];
    _homePageHeadTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            InfoModel *homePageHeadModel  = [InfoModel yy_modelWithDictionary:info.data];
            resultBlock(homePageHeadModel,YES,nil);
        }else{
               [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestCustomerInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(InfoModel *projectModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestCustomerInfoParams:params resultBlock:resultBlock];
}



- (void)requestCustomerTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzTagDatas *lolCalendarModelList, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    
    if (_homePageCalendarTask) {
        [_homePageCalendarTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.User_label/lists",SERVER_APP];
    _homePageCalendarTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzTagDatas *listModel  = [MzzTagDatas yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
               [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestCustomerTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzTagDatas *projectModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestCustomerTagsParams:params resultBlock:resultBlock];
}

- (void)requestCustomerInfoCommitParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzCustomerInfoCommitModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_homeListTask) {
        [_homeListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user/user_add",SERVER_APP];
    _homeListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzCustomerInfoCommitModel *listModel  = [MzzCustomerInfoCommitModel yy_modelWithDictionary:info.data];
            resultBlock(listModel,YES,nil);
        }else{
               [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+(void)requestCustomerInfoCommitParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzCustomerInfoCommitModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestCustomerInfoCommitParams:params resultBlock:resultBlock];
}


- (void)requestAddContentTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_AddContentTagsTask) {
        [_AddContentTagsTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_label/label",SERVER_APP];
    _AddContentTagsTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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

+(void)requestAddContentTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestAddContentTagsParams:params resultBlock:resultBlock];
}

- (void)requestCardPujiParams:(NSMutableDictionary *)params resultBlock:(void(^)(PujiModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_pujiTask) {
        [_pujiTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_sales/card_item",SERVER_APP];
    _pujiTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
             PujiModel *model = [PujiModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestCardPujiParams:(NSMutableDictionary *)params resultBlock:(void(^)( PujiModel*homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestCardPujiParams:params resultBlock:resultBlock];
}

- (void)requestBillParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzUser_bill *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
//    if (_billTask) {
//        [_billTask cancel];
//    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_bill/index",SERVER_APP];
    _billTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzUser_bill *model = [MzzUser_bill yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestBillParams:(NSMutableDictionary *)params resultBlock:(void (^)(MzzUser_bill *, BOOL, NSDictionary *))resultBlock{
     MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestBillParams:params resultBlock:resultBlock];
}

- (void)requestBillAddParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_billAddTask) {
        [_billAddTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_bill/add",SERVER_APP];
    _billAddTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
            [MzzHud toastWithTitle:@"提示" message:@"提交成功"];
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestBillAddParams:(NSMutableDictionary *)params resultBlock:(void (^)(BaseModel *model, BOOL, NSDictionary *))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestBillAddParams:params resultBlock:resultBlock];
}


- (void)requestUserInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzUserInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_userInfoTask) {
        [_userInfoTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_bill/user_info",SERVER_APP];
    _userInfoTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzUserInfoModel *model = [MzzUserInfoModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestUserInfoParams:(NSMutableDictionary *)params resultBlock:(void (^)(MzzUserInfoModel *, BOOL, NSDictionary *))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestUserInfoParams:params resultBlock:resultBlock];
}

+(void)requestPortraitSalesParams:(NSMutableDictionary *)params resultBlock:(void (^)(MzzPortraitModel *, BOOL, NSDictionary *))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestUserPortraitParams:params resultBlock:resultBlock];
}
- (void)requestUserPortraitParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzPortraitModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_user_portraitTask) {
        [_user_portraitTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.health_record_parts/lists.html",SERVER_APP];
    _user_salesTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzPortraitModel *model = [MzzPortraitModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+(void)requestSelectParams:(NSMutableDictionary *)params resultBlock:(void (^)(MzzSelectModel *, BOOL, NSDictionary *))resultBlock
{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestUserSelectParams:params resultBlock:resultBlock];
}
-(void)requestUserSelectParams:(NSMutableDictionary *)params resultBlock:(void (^)(MzzSelectModel *, BOOL, NSDictionary *))resultBlock
{
    if (_user_selectTask) {
        [_user_selectTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.User_label_sys_select/lists.html",SERVER_APP];
    _user_salesTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzSelectModel *model = [MzzSelectModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
    
}

- (void)requestUserSalesParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzUser_salesModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_user_salesTask) {
        [_user_salesTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_sales/index",SERVER_APP];
    _user_salesTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzUser_salesModel *model = [MzzUser_salesModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestUserSalesParams:(NSMutableDictionary *)params resultBlock:(void (^)(MzzUser_salesModel *, BOOL, NSDictionary *))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestUserSalesParams:params resultBlock:resultBlock];
}

- (void)requestConsumptionParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzConsumptionListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_consumptionTask) {
        [_consumptionTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_sales/consumption_serv",SERVER_APP];
    _consumptionTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzConsumptionListModel *model = [MzzConsumptionListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestConsumptionParams:(NSMutableDictionary *)params resultBlock:(void (^)(MzzConsumptionListModel *, BOOL, NSDictionary *))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestConsumptionParams:params resultBlock:resultBlock];
}

- (void)requestConsumptionSalesParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzConsumption_salesListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_consumptionSalesTask) {
        [_consumptionSalesTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_sales/consumption_sales",SERVER_APP];
    _consumptionSalesTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzConsumption_salesListModel *model = [MzzConsumption_salesListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestConsumptionSalesParams:(NSMutableDictionary *)params resultBlock:(void (^)(MzzConsumption_salesListModel *, BOOL, NSDictionary *))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestConsumptionSalesParams:params resultBlock:resultBlock];
}


- (void)requestTotal_AddParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_totalAddTask) {
        [_totalAddTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user/total_add",SERVER_APP];
    _totalAddTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
             resultBlock(info,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
        
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestTotal_AddParams:(NSMutableDictionary *)params resultBlock:(void (^)(BaseModel *, BOOL, NSDictionary *))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestTotal_AddParams:params resultBlock:resultBlock];
}

- (void)requestChangeInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzChangeInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_changeInfoTask) {
        [_changeInfoTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/changeInfo.html",SERVER_APP];
    _changeInfoTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code == 1) {
            MzzChangeInfoModel *infoModel = [MzzChangeInfoModel yy_modelWithDictionary:info.data];
            resultBlock(infoModel,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
        
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestChangeInfoParams:(NSMutableDictionary *)params resultBlock:(void (^)(MzzChangeInfoModel *, BOOL, NSDictionary *))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestChangeInfoParams:params resultBlock:resultBlock];
}

- (void)requestBillInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzBillInfoListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_billInfoTask) {
        [_billInfoTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_sales/bill_info",SERVER_APP];
    _billInfoTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzBillInfoListModel *infoModel = [MzzBillInfoListModel yy_modelWithDictionary:info.data];
            resultBlock(infoModel,YES,nil);
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+(void)requestBillInfoParams:(NSMutableDictionary *)params resultBlock:(void (^)(MzzBillInfoListModel *, BOOL, NSDictionary *))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestBillInfoParams:params resultBlock:resultBlock];
}


- (void)requestGuideParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzGuideModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_guideTask) {
        [_guideTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_sales/guide",SERVER_APP];
    _guideTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MzzGuideModel *infoModel = [MzzGuideModel yy_modelWithDictionary:info.data];
            resultBlock(infoModel,YES,nil);
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

+ (void)requestGuideParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzGuideModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestGuideParams:params resultBlock:resultBlock];
}


/*
 * 添加顾客时判断顾客是否冻结
 */
+ (void)requestCustomerFreezeParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSNumber *ID, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestCustomerFreezeParams:params resultBlock:resultBlock];
}
- (void)requestCustomerFreezeParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSNumber *ID, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_customerFreezeTask) {
        [_customerFreezeTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user/customer_freeze",SERVER_APP];
    _customerFreezeTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            NSNumber *ID = [info.data objectForKey:@"id"];
           resultBlock(ID,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
        
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
/*
 * 激活顾客
 */
+ (void)requestCustomerActivatParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestCustomerActivatParams:params resultBlock:resultBlock];
}
- (void)requestCustomerActivatParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_customerAcrivat) {
        [_customerAcrivat cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user/customer_activat",SERVER_APP];
    _customerAcrivat = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}

/*
 * 改变审批状态(全局)
 */
+ (void)requestApprovalChangeStateParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestApprovalChangeStateParams:params resultBlock:resultBlock];
}
- (void)requestApprovalChangeStateParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_approvalChangeState) {
        [_approvalChangeState cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Approval/changeState",SERVER_APP];
    _approvalChangeState = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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

/*
 * 顾客账单里的票券，消券
 */
+ (void)requestStopTicketParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestStopTicketParams:params resultBlock:resultBlock];
}

- (void)requestStopTicketParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_stopTicketTask) {
        [_stopTicketTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_bill/stop_ticket",SERVER_APP];
    _stopTicketTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
/*
 * 顾客账单-产品终止服务
 */

+ (void)requestStopGoodParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestStopGoodParams:params resultBlock:resultBlock];
}

- (void)requestStopGoodParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_stopGoodTask) {
        [_stopGoodTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_bill/stop_goods",SERVER_APP];
    _stopGoodTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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

+ (void)requestSelectAddParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestSelectAddParams:params resultBlock:resultBlock];
}

- (void)requestSelectAddParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_selectAddTask) {
        [_selectAddTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.User_label_sys_select/add.html",SERVER_APP];
    _selectAddTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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


+ (void)requestAddIndicatorsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestAddIndicatorsParams:params resultBlock:resultBlock];
}

- (void)requestAddIndicatorsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_addIndicatorsTask) {
        [_addIndicatorsTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.health_record/add.html",SERVER_APP];
    _addIndicatorsTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
+ (void)requestGKGLHomeCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)(GKGLHomeCustomerListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestGKGLHomeCustomerListParams:params resultBlock:resultBlock];
}
- (void)requestGKGLHomeCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)(GKGLHomeCustomerListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_GKGLHomeCustomerListTask) {
        [_GKGLHomeCustomerListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_new/user_new_list",SERVER_APP];
    _GKGLHomeCustomerListTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            GKGLHomeCustomerListModel * model = [GKGLHomeCustomerListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
    
}
+ (void)requestGKGLAddCustomer:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestGKGLAddCustomer:params resultBlock:  resultBlock];
}
- (void)requestGKGLAddCustomer:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
{
    if (_GKGLAddCustomerTask) {
        [_GKGLAddCustomerTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_new/user_add",SERVER_APP];
    _GKGLAddCustomerTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
            resultBlock(info,NO,nil);
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestGKGLCustomerDetail:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestGKGLCustomerDetail:params resultBlock:resultBlock];
}
- (void)requestGKGLCustomerDetail:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_GKGLCustomeDetailTask) {
        [_GKGLCustomeDetailTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_new/user_new_info",SERVER_APP];
    _GKGLCustomeDetailTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
+ (void)requestGKGLCustomerBillDetail:(NSMutableDictionary *)params resultBlock:(void(^)(GKGLBillListModel * model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestGKGLCustomerBillDetail:params resultBlock:resultBlock];
}
- (void)requestGKGLCustomerBillDetail:(NSMutableDictionary *)params resultBlock:(void(^)(GKGLBillListModel * model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_GKGLCustomeBillTask) {
        [_GKGLCustomeBillTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_new/user_bill",SERVER_APP];
    _GKGLCustomeBillTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            GKGLBillListModel * model = [GKGLBillListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
/*
 * 顾客订单 销售订单
 */
+ (void)requestGKGLCustomerBillXSOrderList:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestGKGLCustomerBillXSOrderList:params resultBlock:resultBlock];
}
- (void)requestGKGLCustomerBillXSOrderList:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_GKGLCustomeBillXSOrderTask) {
        [_GKGLCustomeBillXSOrderTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_new/user_sales_orders",SERVER_APP];
    _GKGLCustomeBillXSOrderTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
+ (void)requestGKGLCustomerBillFWOrderList:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestGKGLCustomerBillFWOrderList:params resultBlock:resultBlock];
}
- (void)requestGKGLCustomerBillFWOrderList:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_GKGLCustomeBillFWOrderTask) {
        [_GKGLCustomeBillFWOrderTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_new/user_serv_orders",SERVER_APP];
    _GKGLCustomeBillFWOrderTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
+ (void)requestGKGLCustomerCFDataParam:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestGKGLCustomerCFDataParam:params resultBlock:resultBlock];
}
- (void)requestGKGLCustomerCFDataParam:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_GKGLCustomeCFDataTask) {
        [_GKGLCustomeCFDataTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.user_new/user_pres",SERVER_APP];
    _GKGLCustomeCFDataTask = [Networking requestWithURL:url params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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
+ (void)requestGKGLCustomerCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    MzzCustomerRequest *request = [[MzzCustomerRequest alloc] init];
    [request requestGKGLCustomerCommonUrl:url Param:params resultBlock:resultBlock];
}
- (void)requestGKGLCustomerCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_GKGLCustomeCommonTask) {
        [_GKGLCustomeCommonTask cancel];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",SERVER_APP,url];
    _GKGLCustomeCommonTask = [Networking requestWithURL:urlStr params:params requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
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

