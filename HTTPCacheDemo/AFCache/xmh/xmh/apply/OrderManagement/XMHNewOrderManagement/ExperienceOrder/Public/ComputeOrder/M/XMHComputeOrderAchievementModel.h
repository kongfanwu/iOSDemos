//
//  XMHComputeOrderAchievementModel.h
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 业绩归属model

#import <Foundation/Foundation.h>
#import "FWDYeJGuiShuModel.h"
#import "SLSearchManagerModel.h"
#import "MzzStoreModel.h"
@class MLJiShiModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHComputeOrderAchievementModel : NSObject
/** 已购商品列表 */
@property (nonatomic, strong) NSMutableArray *modelArray;
/** 业绩归属 */
@property (nonatomic, strong) FWDYeJGuiShuModel *yeJGuiShuModel;
/** 店长归属 */
@property (nonatomic, strong) SLManagerModel *dianZhangModel;
/** 门店归属 */
@property (nonatomic, strong) MzzStoreModel *menDianModel;
/** 算不算厂家业绩 默认 NO */
@property (nonatomic) BOOL changJiaYeji;
/** 算不算消耗 默认 YES */
@property (nonatomic) BOOL xiaohao;
/** <##> */
@property (nonatomic, strong) NSMutableArray <MLJiShiModel *>*jiShiList;

/**
 获取技师列表。剔除不同产品一个技师服务情况
 
 @return 技师集合
 */
//- (NSMutableArray <MLJiShiModel *> *)jiShiList;

/**
 检查是否分配了员工归属
 
 @return YES 分配了。 NO 未分配
 */
- (BOOL)checkInputGuiShu;

/**
 检查技师分配价格是否等于总价格
 
 @return YES 合法 NO 不合法
 */
- (BOOL)checkJiShiPrice;

/**
 检查技师分配价格是否等于总价格
 
 @param allPrice 总价格
 @return YES 合法 NO 不合法
 */
- (BOOL)checkJiShiPriceAllPrice:(CGFloat)allPrice;

/**
 拼接开单接口 员工归属字段（guishu）所需参数
 
 @return 归属后的集合
 */
- (NSMutableArray *)guiShuArray;



@end

NS_ASSUME_NONNULL_END
