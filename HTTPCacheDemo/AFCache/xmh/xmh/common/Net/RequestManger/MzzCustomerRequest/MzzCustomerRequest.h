//
//  BookRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@class LevelData,MzzStoreList,MzzStoreModel,MzzAccountList,MzzAccountModel,MzzJobSelector,InfoModel,MzzTagDatas,MzzCustomerInfoCommitModel,BaseModel,ManageData,ESRootClass,CustomerListModel,PujiModel,MzzUser_bill,MzzUserInfoModel,MzzUser_salesModel,MzzConsumptionListModel,MzzConsumption_salesListModel,MzzDengjiModel,MzzChangeInfoModel,MzzBillInfoListModel,MzzGuideModel,MzzSelectModel,MzzPortraitModel,GKGLHomeCustomerListModel,GKGLBillListModel;

@interface MzzCustomerRequest : NSObject{
    NSURLSessionDataTask    *_yiYuYueTask;
    NSURLSessionDataTask    *_daiYuYueTask;
    NSURLSessionDataTask    *_customerMessageTask;
    NSURLSessionDataTask    *_customerBookProjectTask;
    NSURLSessionDataTask    *_homePageHeadTask;
    NSURLSessionDataTask    *_homePageCalendarTask;
    NSURLSessionDataTask    *_homeListTask;
    NSURLSessionDataTask    *_SearchCustomerTask;
    NSURLSessionDataTask    *_AddContentTagsTask;
//    NSURLSessionDataTask    *_AddTagsTask;
//    NSURLSessionDataTask    *_EditContentTagsTask;
    NSURLSessionDataTask    *_manageTask;
    NSURLSessionDataTask    *_manageGroupListTask;
    NSURLSessionDataTask    *_cardTask;
    NSURLSessionDataTask    *_customerTask;
    NSURLSessionDataTask    *_pujiTask;
    NSURLSessionDataTask    *_billTask;
    NSURLSessionDataTask    *_billAddTask;
    NSURLSessionDataTask    *_userInfoTask;
    NSURLSessionDataTask    *_user_salesTask;
    NSURLSessionDataTask    *_user_portraitTask;
    NSURLSessionDataTask    *_user_selectTask;

    NSURLSessionDataTask    *_consumptionTask;
    NSURLSessionDataTask    *_consumptionSalesTask;
    NSURLSessionDataTask    *_totalAddTask;
    NSURLSessionDataTask    *_changeInfoTask;
    NSURLSessionDataTask    *_billInfoTask;
    NSURLSessionDataTask    *_guideTask;
    NSURLSessionDataTask    *_customerFreezeTask;
    NSURLSessionDataTask    *_customerAcrivat;
    NSURLSessionDataTask    *_approvalChangeState;
    NSURLSessionDataTask    *_stopTicketTask;
    NSURLSessionDataTask    *_stopGoodTask;
    NSURLSessionDataTask    *_selectAddTask;
    NSURLSessionDataTask    *_IndicatorsTask;
    NSURLSessionDataTask    *_addIndicatorsTask;
    
    
    
    NSURLSessionDataTask    *_GKGLAddCustomerTask;
    NSURLSessionDataTask    *_GKGLHomeCustomerListTask;
    NSURLSessionDataTask    *_GKGLCustomeDetailTask;
    NSURLSessionDataTask    *_GKGLCustomeBillTask;
    NSURLSessionDataTask    *_GKGLCustomeBillXSOrderTask;
    NSURLSessionDataTask    *_GKGLCustomeBillFWOrderTask;
    NSURLSessionDataTask    *_GKGLCustomeCFDataTask;
    NSURLSessionDataTask    *_GKGLCustomeCommonTask;
}
/**
 * 一级页前面八块数据
 */
- (void)requestManagerParams:(NSMutableDictionary *)params resultBlock:(void(^)( ManageData*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestManagerParams:(NSMutableDictionary *)params resultBlock:(void(^)( ManageData*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/**
 * 一级页下分组数据
 */
- (void)requestManageGroupListParams:(NSMutableDictionary *)params resultBlock:(void(^)( LevelData*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestManageGroupListParams:(NSMutableDictionary *)params resultBlock:(void(^)( LevelData*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 顾客列表（全部顾客）
 */
- (void)requestCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)( CustomerListModel*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)( CustomerListModel*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

+ (void)requestBeautyCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)( CustomerListModel*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestBookCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)( CustomerListModel*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 所有已经上线的卡
 */
- (void)requestCardListParams:(NSMutableDictionary *)params resultBlock:(void(^)( ESRootClass*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestCardListParams:(NSMutableDictionary *)params resultBlock:(void(^)( ESRootClass*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 获取顾客等级列表
 */
- (void)requestCustomerLevelParams:(NSMutableDictionary *)params resultBlock:(void(^)( MzzDengjiModel*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestCustomerLevelParams:(NSMutableDictionary *)params resultBlock:(void(^)( MzzDengjiModel*listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 获取门店选择列表
 */
- (void)requestStoreListParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzStoreList *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestStoreListParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzStoreList *listModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 技师和导购选择
 */
- (void)requestAccountParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzAccountList *customerMessageModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestAccountParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzAccountList *customerMessageModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 首页统计数据接口
 */
- (void)requestHomePageDataParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzJobSelector *projectModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+(void)requestHomePageDataParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzJobSelector *projectModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/*
 * 顾客详情（添加页面的详情）
 */
- (void)requestCustomerInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(InfoModel *homePageHeadModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+(void)requestCustomerInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(InfoModel *homePageHeadModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 *  顾客标签
 */
- (void)requestCustomerTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzTagDatas *lolCalendarModelList, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestCustomerTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzTagDatas *lolCalendarModelList, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/*
 * 顾客管理 -commit用户信息
 */
- (void)requestCustomerInfoCommitParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzCustomerInfoCommitModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestCustomerInfoCommitParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzCustomerInfoCommitModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 顾客Content标签添加 -commit
 */
- (void)requestAddContentTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestAddContentTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 顾客组标签添加 -commit
 */
//- (void)requestAddTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
//+ (void)requestAddTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 顾客组标签添加 -commit
 */
//- (void)requestEditTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
//+ (void)requestEditTagsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 卡项普及
 */
- (void)requestCardPujiParams:(NSMutableDictionary *)params resultBlock:(void(^)(PujiModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestCardPujiParams:(NSMutableDictionary *)params resultBlock:(void(^)(PujiModel *homeListModel, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 添加顾客账单时具体的东西选择
 */
- (void)requestBillParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzUser_bill *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestBillParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzUser_bill *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 添加顾客账单的购物车数据提交
 */
- (void)requestBillAddParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestBillAddParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 顾客账单上面的顾客信息
 */
- (void)requestUserInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzUserInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestUserInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzUserInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/*
 * 顾客账单
 */
- (void)requestUserSalesParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzUser_salesModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestUserSalesParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzUser_salesModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 顾客健康档案列表
 */
- (void)requestUserPortraitParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzPortraitModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestPortraitSalesParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzPortraitModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 顾客画像
 */
- (void)requestUserSelectParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzSelectModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestSelectParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzSelectModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 消耗记录
 */
- (void)requestConsumptionParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzConsumptionListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestConsumptionParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzConsumptionListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 消费记录
 */
- (void)requestConsumptionSalesParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzConsumption_salesListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestConsumptionSalesParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzConsumption_salesListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/*
 * 顾客添加总提交
 */
- (void)requestTotal_AddParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestTotal_AddParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/*
 * 完善资料审批发起
 */
- (void)requestChangeInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzChangeInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestChangeInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzChangeInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/*
 * 账单详情
 */
- (void)requestBillInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzBillInfoListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestBillInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzBillInfoListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/*
 * 消费引导
 */
+ (void)requestGuideParams:(NSMutableDictionary *)params resultBlock:(void(^)(MzzGuideModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 添加顾客时判断顾客是否冻结
 */
+ (void)requestCustomerFreezeParams:(NSMutableDictionary *)params resultBlock:(void(^)(NSNumber *ID, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 激活顾客
 */
+ (void)requestCustomerActivatParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 改变审批状态(全局)
 */
+ (void)requestApprovalChangeStateParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 顾客账单里的票券，消券
 */
+ (void)requestStopTicketParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 顾客账单-产品终止服务
 */
+ (void)requestStopGoodParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 添加标签
 */
- (void)requestSelectAddParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestSelectAddParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 顾客指标添加
 */
- (void)requestAddIndicatorsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
+ (void)requestAddIndicatorsParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/************************************************************************新版顾客管理*************************************************************/
/*
 * 顾客管理首页 顾客列表
 */
+ (void)requestGKGLHomeCustomerListParams:(NSMutableDictionary *)params resultBlock:(void(^)(GKGLHomeCustomerListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 添加顾客
 */
+ (void)requestGKGLAddCustomer:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/*
 * 顾客详情信息
 */
+ (void)requestGKGLCustomerDetail:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 顾客账单
 */
+ (void)requestGKGLCustomerBillDetail:(NSMutableDictionary *)params resultBlock:(void(^)(GKGLBillListModel * model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/*
 * 顾客订单 销售订单
 */
+ (void)requestGKGLCustomerBillXSOrderList:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 顾客订单 服务订单
 */
+ (void)requestGKGLCustomerBillFWOrderList:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/*
 * 顾客处方
 */
+ (void)requestGKGLCustomerCFDataParam:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

+ (void)requestGKGLCustomerCommonUrl:(NSString *)url Param:(NSMutableDictionary *)params resultBlock:(void(^)(NSDictionary * resultDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end

