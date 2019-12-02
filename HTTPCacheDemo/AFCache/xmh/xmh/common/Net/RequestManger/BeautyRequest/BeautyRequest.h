//
//  BeautyRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/12.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "YYModel.h"
#import "ZhangDanMingXiModel.h"
#import "ZhangDanMingXiSubModel.h"

#import "GuKeChuFangList.h"
#import "GuKeChuFang.h"

#import "LiaoChengXiangMuList.h"
#import "LiaoChengXiangMuModel.h"
#import "LiaoChengXiangMuInfo.h"

#import "choiceCustomerModel.h"
#import "BeautyGuihuaModel.h"
#import "BeautyShijiModel.h"
#import "BeautyHomeListModel.h"
#import "BeautyCardModel.h"
#import "BeautyChoiseJishiModel.h"
@interface BeautyRequest : NSObject{
    NSURLSessionDataTask    *_zhangDanMingXiTask;
    NSURLSessionDataTask    *_guKeChuFangTask;
    NSURLSessionDataTask    *_liaoChengXiangMuTask;
    NSURLSessionDataTask    *_GukeListTask;
    NSURLSessionDataTask    *_BeautyGuiHuaZhiXingTask;
    NSURLSessionDataTask    *_BeautyShiJiZhiXingTask;
    NSURLSessionDataTask    *_HomeGetListTask;
    NSURLSessionDataTask    *_ChoiseJishiTask;
    NSURLSessionDataTask    *_BeautyCardTask;
    NSURLSessionDataTask    *_CreateChufangBillTask;
    NSURLSessionDataTask    *_ChuFangDelTask;
    NSURLSessionDataTask    *_ChuFangJieShuTask;
}
/**
*账单明细
*/
- (void)requestZhangDanMingxi:(NSString*)user_id
                    Join_code:(NSString *)join_code
                  resultBlock:(void(^)(ZhangDanMingXiModel *zhangDanMingXiModel,
                                       BOOL isSuccess,
                                       NSDictionary *errorDic))resultBlock;

/**
 *顾客处方
 */
- (void)requestGuKeChuFang:(NSString*)user_id
               resultBlock:(void(^)(GuKeChuFangList *guKeChuFangList,
                                    BOOL isSuccess,
                                    NSDictionary *errorDic))resultBlock;
/**
 *疗程项目
 */
- (void)requestLiaoChengXiangMu:(NSString*)user_id
                      join_code:(NSString *)join_code
                    resultBlock:(void(^)(LiaoChengXiangMuList *liaoChengXiangMuList,
                                         BOOL isSuccess,
                                         NSDictionary *errorDic))resultBlock;
/**
 *搜索顾客（分页）、选择顾客、顾客列表
 */
- (void)requestGukeList:(NSInteger)page
                      Q:(NSString *)q
                    resultBlock:(void(^)(choiceCustomerModel *uchoiceCustomerModel,
                                         BOOL isSuccess,
                                         NSDictionary *errorDic))resultBlock;

/**
 *美丽定制首页-规划
 */
- (void)requestBeautyGuiHuaiZhiXing:(NSString *)join_code
                           oneClick:(NSString *)oneClick
                           twoClick:(NSString *)twoClick
                          twoListId:(NSString *)twoListId
                               inId:(NSString *)inId
                          startTime:(NSString *)startTime
                            endTime:(NSString *)endTime
                        resultBlock:(void(^)(BeautyGuihuaModel *model,
                                             BOOL isSuccess,
                                             NSDictionary *errorDic))resultBlock;
/**
 *美丽定制首页-实际
 */
- (void)requestBeautyShiJiZhiXing:(NSString *)join_code
                           oneClick:(NSString *)oneClick
                           twoClick:(NSString *)twoClick
                          twoListId:(NSString *)twoListId
                               inId:(NSString *)inId
                          startTime:(NSString *)startTime
                            endTime:(NSString *)endTime
                        resultBlock:(void(^)(BeautyShijiModel *model,
                                             BOOL isSuccess,
                                             NSDictionary *errorDic))resultBlock;
/**
 *美丽定制首页-首页列表数据
 */
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
                                          NSDictionary *errorDic))resultBlock;

/**
 *美丽定-选择美容师
 */
- (void)requestBeautyChoiseJishi:(NSString *)store_code
                     resultBlock:(void(^)(BeautyChoiseJishiModel *model,
                                          BOOL isSuccess,
                                          NSDictionary *errorDic))resultBlock;

/**
 *美丽定制卡接口
 */
- (void)requestBeautyCard:(NSString *)join_code
                  user_id:(NSString *)user_id
              resultBlock:(void(^)(BeautyCardModel *model,
                                   BOOL isSuccess,
                                   NSDictionary *errorDic))resultBlock;

/**
 *处方生成接口
 */
- (void)requestCreateChufangBill:(NSString *)result
              resultBlock:(void(^)(id obj,
                                   BOOL isSuccess,
                                   NSDictionary *errorDic))resultBlock;

/**
 *处方删除接口
 */
- (void)requestChuFangDelordernum:(NSString *)ordernum
                       store_code:(NSString *)store_code
                      resultBlock:(void(^)(id obj,
                                           BOOL isSuccess,
                                           NSDictionary *errorDic))resultBlock;

/**
 *处方结束接口
 */
- (void)requestChuFangJieShuordernum:(NSString *)ordernum
                       store_code:(NSString *)store_code
                      resultBlock:(void(^)(id obj,
                                           BOOL isSuccess,
                                           NSDictionary *errorDic))resultBlock;

@end
