//
//  SLRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SLSearchListModel,SLPresModel,SLServPro,SLServAppoModel,SLGoodsModel,SLTi_CardModel,SLS_ProModel,SLGoodListModel,SLSCourseExper,MLJishiSearchModel,SLSearchManagerModel,SLOrderNumModel,SLServInfoModel,BaseModel,SLCooperateModel,SLGetListModel;
@interface SLRequest : NSObject{
    NSURLSessionDataTask    *_searchTask;
    NSURLSessionDataTask    *_servAppo;
    NSURLSessionDataTask    *_presTask;
    NSURLSessionDataTask    *_proTask;
    NSURLSessionDataTask    *_goodsTask;
    NSURLSessionDataTask    *_tiCardTask;
    NSURLSessionDataTask    *_sProTask;
    NSURLSessionDataTask    *_sGoodTask;
    NSURLSessionDataTask    *_sCourseTask;
    NSURLSessionDataTask    *_jishiSearchTask;
    NSURLSessionDataTask    *_jishiSearchOtherTask;

    NSURLSessionDataTask    *_managerSearchTask;
    NSURLSessionDataTask    *_commitTask;
    NSURLSessionDataTask    *_servInfoTask;
    NSURLSessionDataTask    *_servDelTask;
    NSURLSessionDataTask    *_servImgTask;
    NSURLSessionDataTask    *_servSettlementTask;
    NSURLSessionDataTask    *_servRetroactiveTask;
    NSURLSessionDataTask    *_retroactiveTask;
    NSURLSessionDataTask    *_cooperateTask;
    NSURLSessionDataTask    *_getListTask;
}
/**
 * 服务单开单页搜索顾客
 */
+ (void)requestSearchCustomerParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLSearchListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 服务单-预约服务选择
 */
+ (void)requestServApppParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLServAppoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 服务单-处方服务选择
 */
+ (void)requestPresParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLPresModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/**
 * 服务单-项目服务选择
 */
+ (void)requestServProParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLServPro *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 服务单-产品服务选择
 */
+ (void)requestServGoodsParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLGoodsModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 服务单-提卡服务选择
 */
+ (void)requesTtiCardParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLTi_CardModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 销售服务单-项目服务选择
 */
+ (void)requesSProParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLS_ProModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 销售服务单-产品服务选择
 */
+ (void)requesSGoodParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLGoodListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 销售服务单-体验服务选择
 */
+ (void)requesCourseExperParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLSCourseExper *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 销售服务单- 搜索技师
 */
+ (void)requesSearchJisParams:(NSMutableDictionary *)params resultBlock:(void(^)(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 搜索其他门店技师
 */
+ (void)requesSearchOtherJisParams:(NSMutableDictionary *)params resultBlock:(void(^)(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 销售服务单- 店长归属
 */
+ (void)requesSearchManagerParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLSearchManagerModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 销售服务单- 服务单 销售服务单数据提交
 */
+ (void)commitParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLOrderNumModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 服务单和销售服务单详情页
 */
+ (void)requestServInfoParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLServInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 服务单和销售服务单撤销删除
 */
+ (void)requestServDelParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 服务记录(提交图片)
 */
+ (void)requestSerImgParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 服务单，销售服务单结算（代收）
 */
+ (void)requestSerSettlementParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 服务单，销售服务单，补签
 */
+ (void)requestSerRetroactiveParams:(NSMutableDictionary *)params resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 配合耗卡
 */
+ (void)requestCooperateParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLCooperateModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 配合消费
 */
+ (void)requestCooperateSaleParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLCooperateModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 服务单和销售服务单首页列表
 */
+ (void)requestGetListParams:(NSMutableDictionary *)params resultBlock:(void(^)(SLGetListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


@end
