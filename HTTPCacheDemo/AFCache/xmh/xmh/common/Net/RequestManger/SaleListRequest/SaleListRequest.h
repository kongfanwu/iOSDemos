//
//  SaleListRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "ShengKaXuKaProModel.h"
#import "ShengKaXuKaRenXuanKa.h"
#import "ShengKaXuKaChuZhiModel.h"
#import "ShengKaXuKaShiJianModel.h"
#import "ShengKaXuKaKeShengHuiYuanKa.h"
#import "ZheKouModel.h"

@class SASaleListModel,SALeftModelList,SACourseModeList,SATicketListModel,SASalesInfoModel,SABalanceModel,SAStoredCardListModel,SAFQListModel,SANewDingDanListModel,SATongJiModel,SAFuWuXiaoShouListModel,SAZhiHuanPorListModel,SAAccountModel,SADepositListModel,SAZhiHuanListModel,SATuiKuanListModel,LOrderYejiListModel,SellProTicketListModel,XMHOrderListSaleModel,XMHBossOrderListModel,XMHSeverCertificateModel,XMHOrderListSeverModel;
@interface SaleListRequest : NSObject
{
    NSURLSessionDataTask * _guDingKaiDanZheKou;
    NSURLSessionDataTask * _saleListTask;
    NSURLSessionDataTask * _get_leftTask;
    NSURLSessionDataTask * _basic_courseTask;
    NSURLSessionDataTask * _add_seles_aTask;
    NSURLSessionDataTask * _baseTicketTask;
    NSURLSessionDataTask * _sellProTicketTask;

    NSURLSessionDataTask * _salesInfoTask;
    NSURLSessionDataTask * _userBalanceTask;
    NSURLSessionDataTask * _delSalesTask;
    NSURLSessionDataTask * _stored_card_listTask;
    NSURLSessionDataTask * fenQiTask;
    NSURLSessionDataTask * _faQiApproveTask;
    NSURLSessionDataTask * _new_dingdan_listTask;
    NSURLSessionDataTask * _fenqihuankuantijiaoTask;
    NSURLSessionDataTask * _quanehuankuanTask;
    NSURLSessionDataTask * _dingDanTongJiTask;
    NSURLSessionDataTask * _delSalesOrderTask;

    NSURLSessionDataTask * _FuWuandXiaoShouFuWuTask;
    NSURLSessionDataTask * _nixiangTask;

    
    NSURLSessionDataTask * _ShengKaXuKaProTask;
    NSURLSessionDataTask * _ShengKaXuKaRenXuanKaTask;
    NSURLSessionDataTask * _ShengKaXuKaChuZhiKaTask;
    NSURLSessionDataTask * _ShengKaXuKaShiJianKaTask;
    NSURLSessionDataTask * _ShengKaXuKaKeShengHuiYuanTask;
    NSURLSessionDataTask * _commitShenpiTask;
    NSURLSessionDataTask * _fuwuDanXiaoShouDanListTask;
    NSURLSessionDataTask * _renXuanCardTask;
    NSURLSessionDataTask * _timeCardTask;
    NSURLSessionDataTask * _liaoChengCardTask;
    NSURLSessionDataTask * _huiYuanCardTask;
    NSURLSessionDataTask * _accountTask;
    NSURLSessionDataTask * _goodsTask;
    NSURLSessionDataTask * _depositTask;
    NSURLSessionDataTask * _zhiHuanTask;
    NSURLSessionDataTask * _zhiHuanPiaoQuanTask;
    NSURLSessionDataTask * _zhiHuanChuZhiTask;

    NSURLSessionDataTask * _ZheKouHuiYuanListTask;
    NSURLSessionDataTask * _tuiKuanTask;
    NSURLSessionDataTask * _saleyejiTask;
    NSURLSessionDataTask * _zhihuanCommitTask;
    NSURLSessionDataTask * _gexingzhidanTask;
}
/**
 * 固定开单折扣优惠接口
 */
+ (void)requestgetBasicStoredSearchId:(NSString *)searchId
                             userId:(NSString *)userId
                             proNum:(NSString *)proNum
                             type:(NSString *)type
                             joinCode:(NSString *)joinCode
                             storedCode:(NSString *)storedCode
                             resultBlock:(void(^)(ZheKouModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 固定开单右侧列表
 */
+ (void)requestSaleListJoinCode:(NSString *)joinCode
                     store_code:(NSString *)store_code
                           type:(NSString *)type
                        user_id:(NSInteger)user_id
                       resultBlock:(void(^)(SASaleListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 固定开单 左侧tap
 */
+ (void)requestLeftJoinCode:(NSString *)joinCode
                   type:(NSString *)type
                   resultBlock:(void(^)(SALeftModelList *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 固定开单 包含内容
 */
+ (void)requestBasicCourseCode:(NSString *)code
                    joinCode:(NSString *)joinCode
                    resultBlock:(void(^)(SACourseModeList *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 商品购买清单 提交
 */
+ (void)requestSubmitCartParams:(NSMutableDictionary *)params
                         resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 快速开单商品购买清单 提交
 */
+ (void)requestKuaiSubmitCartParams:(NSMutableDictionary *)params
                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 逆向开单 提交
 */
+ (void)requestSubmitParams:(NSMutableDictionary *)params
                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 固定开单 抵用券
 */
+ (void)requestBasicTicketSearchId:(NSString *)serachId
                          userId:(NSString *)userId
                          type:(NSString *)type
                          joinCode:(NSString *)joinCode
                              code:(NSString *)code
                          resultBlock:(void(^)(SATicketListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 销售服务单 抵用券
 */
+ (void)requestSellProTicketSearchId:(NSString *)serachId
                            userId:(NSString *)userId
                              type:(NSString *)type
                            joinCode:(NSString *)joinCode
                                code:(NSString *)code
                              framID:(NSString *)framID
                       resultBlock:(void(^)(SellProTicketListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 固定开单 详情页
 */

+ (void)requestSalesInfoOrderNum:(NSString *)orderNum
                        resultBlock:(void(^)(SASalesInfoModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
//--------------------------------------待验证
/**
 * 支付方式
 */
+ (void)requestUserBalanceUserId:(NSString *)userId
                          resultBlock:(void(^)(SABalanceModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 撤销销售单
 */
+ (void)requestDelSalesId:(NSString *)Id resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 撤销快速开单
 */
+ (void)requestDelSalesOrdernum:(NSString *)orderNum withJoinCode:(NSString *)joinCode resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 用户拥有的会员卡
 */
+ (void)requestStoredCardListUserId:(NSString *)userId resultBlock:(void(^)(SAStoredCardListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 分期还款列表
 */
+ (void)requestFQZDorderNum:(NSString *)orderNum resultBlock:(void(^)(SAFQListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 分期还款提交
 */
+ (void)requestSubmitUPFQAmount:(NSString *)amount
                       orderNum:(NSString *)orderNum
                       hkdate:(NSString *)hkdate
                       payType:(NSString *)payType
                       dingjing:(NSString *)dingjing
                       resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 全额还款
 */
+ (void)requestAllPayOrderNum:(NSString *)orderNum
                       hkdate:(NSString *)hkdate
                       payType:(NSString *)payType
                       resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 销售单列表
 */

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
                      resultBlock:(void(^)(SANewDingDanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 销售统计八块
 */

+ (void)requestDingDanTongJiOneClick:(NSString *)oneClick
                        twoClick:(NSString *)twoClick
                       twoListId:(NSString *)twoListId
                        joinCode:(NSString *)joinCode
                       startTime:(NSString *)startTime
                         endTime:(NSString *)endTime
                          userId:(NSString *)userId
                                inId:(NSString *)inId
                     resultBlock:(void(^)(SATongJiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

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
                               resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 销售单-升卡续卡-获取用户购买的项目
 */
+ (void)requestShengKaXuKaProuser_id:(NSString *)user_id
                           join_code:(NSString *)join_code
                         resultBlock:(void(^)(ShengKaXuKaProModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 销售单-升卡续卡-获取用户购买的任选卡
 */
+ (void)requestShengKaXuKaRenXuanKauser_id:(NSString *)user_id
                                 join_code:(NSString *)join_code
                               resultBlock:(void(^)(ShengKaXuKaRenXuanKa *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 销售单-升卡续卡-获取用户购买的会员卡
 */
+ (void)requestShengKaXuKaChuZhiKauser_id:(NSString *)user_id
                                join_code:(NSString *)join_code
                              resultBlock:(void(^)(ShengKaXuKaChuZhiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 销售单-升卡续卡-获取用户购买的项时间卡
 */
+ (void)requestShengKaXuKaShiJiankauser_id:(NSString *)user_id
                                 join_code:(NSString *)join_code
                               resultBlock:(void(^)(ShengKaXuKaShiJianModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 销售单-升卡续卡-获取用户可升的会员卡
 */
+ (void)requestShengKaXuKaKeShengHuiYuanuser_id:(NSString *)user_id
                                      join_code:(NSString *)join_code
                                           code:(NSString *)code
                                    resultBlock:(void(^)(ShengKaXuKaKeShengHuiYuanKa *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 销售单-升卡续卡-提交审批
 */
+ (void)requestCommitShenpi:(NSMutableDictionary *)params
                                    resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
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
                               resultBlock:(void(^)(SAFuWuXiaoShouListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;


/******************************************************销售单置换********************************************************************************/

/**
 * 获取项目
 */
+ (void)requestProJoinCode:(NSString *)joinCode
                    userId:(NSString *)userId
               resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 获取任选卡
 */
+ (void)requestRenXuanCardJoinCode:(NSString *)joinCode
                    userId:(NSString *)userId
                       resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 获取时间卡
 */
+ (void)requestTimeCardJoinCode:(NSString *)joinCode
                            userId:(NSString *)userId
                       resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 获取疗程卡
 */
+ (void)requestLiaoChengCardJoinCode:(NSString *)joinCode
                         userId:(NSString *)userId
                    resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 获取会员卡
 */
+ (void)requestHuiYuanJoinCode:(NSString *)joinCode
                              userId:(NSString *)userId
                         resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 获取会产品
 */
+ (void)requestGoodsJoinCode:(NSString *)joinCode
                        userId:(NSString *)userId
                   resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 获取账户
 */
+ (void)requestGoodsAccountUserId:(NSString *)userId
                 resultBlock:(void(^)(SAAccountModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 获取票券
 */
+ (void)requestZhiHuanPiaoQuanUserId:(NSString *)userId
                            JoinCode:(NSString *)joinCode
                      resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 获取储值卡
 */
+ (void)requestZhiHuanChuZhiUserId:(NSString *)userId
                            JoinCode:(NSString *)joinCode
                         resultBlock:(void(^)(SAZhiHuanPorListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 已购置换提交结算
 */
+ (void)requestZhiHuanParams:(NSMutableDictionary *)params
                         resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 获取定金订单
 */
+ (void)requestDepositJoinCode:(NSString *)joinCode
                        userId:(NSString *)userId
                   resultBlock:(void(^)(SADepositListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 置换详情获取商品列表
 */
+ (void)requestZhiHuanDetailOrderNum:(NSString *)orderNum
                      resultBlock:(void(^)(SAZhiHuanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 退款金额
 */
+ (void)requestTuiKuanParam:(NSMutableDictionary *)param resultBlock:(void(^)(SATuiKuanListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 销售业绩
 */
+ (void)requestSaleYeJiListParam:(NSMutableDictionary *)param resultBlock:(void(^)(LOrderYejiListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 个性制单审批
 */
+ (void)requestGeXingZhiDanParam:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

#pragma mark -- 订单管理 重构
/**------------------------------订单管理------------------- */

/**
 列表管理层列表数据,boss权限

 @param fram_id 登录人岗位id (必选)
 @param startTime 查询开始时间 (必选)
 @param endTime 查询结束时间 (必选)
 @param join_code 商家编码
 @param inId 登录人账号 (必选)
 @param page 分页，1开始 (必选)
 @param searchText 搜索门店关键字
 @param resultBlock N/Y
 */
+ (void)requestBossOrderListFram_id:(NSInteger)fram_id
                      startTime:(NSString *)startTime
                        endTime:(NSString *)endTime
                      join_code:(NSString *)join_code
                           inId:(NSString *)inId
                           page:(NSInteger)page
                     searchText:(NSString *)searchText
                    resultBlock:(void(^)(NSMutableArray *modelArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 订单一级页列表数据 销售凭证

 @param fram_id 登录人岗位id (必选)
 @param startTime 查询开始时间 (必选)
 @param endTime 查询结束时间 (必选)
 @param join_code 商家编码
 @param inId 登录人账号 (必选)
 @param order_type 列表状态：0=>'全部' 1=>'待付款',10=>'已收款',5=>'未付清','6'=>'已完成' (必选)
 @param page 分页，1开始 (必选)
 @param searchText 搜索关键字
 @param resultBlock N/Y
 */
+ (void)requestOrderListSaleFram_id:(NSInteger)fram_id
               startTime:(NSString *)startTime
                 endTime:(NSString *)endTime
               join_code:(NSString *)join_code
                    inId:(NSString *)inId
              order_type:(NSInteger)order_type
                    page:(NSInteger)page
              searchText:(NSString *)searchText
             resultBlock:(void(^)(NSArray *modelArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

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
                        resultBlock:(void(^)(NSArray *modelArr, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 * 订单管理 统计八块 销售凭证
 */
+ (void)requestOrderStatisticalSaleFram_id:(NSInteger)fram_id
                             startTime:(NSString *)startTime
                               endTime:(NSString *)endTime
                             join_code:(NSString *)join_code
                                  inId:(NSString *)inId
                           resultBlock:(void(^)(SATongJiModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;

/**
 * 订单管理 统计八块 服务凭证
 */
+ (void)requestOrderStatisticalSeverFram_id:(NSInteger)fram_id
                                 startTime:(NSString *)startTime
                                   endTime:(NSString *)endTime
                                 join_code:(NSString *)join_code
                                      inId:(NSString *)inId
                                resultBlock:(void(^)(XMHSeverCertificateModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end
