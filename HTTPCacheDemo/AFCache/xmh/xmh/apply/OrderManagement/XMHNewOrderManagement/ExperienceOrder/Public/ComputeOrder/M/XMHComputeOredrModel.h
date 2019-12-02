//
//  XMHComputeOredrModel.h
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 商品集合 详情model

#import <Foundation/Foundation.h>
#import "CustomerListModel.h"
#import "MLJishiSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHComputeOredrModel : NSObject

/** 已购商品列表 */
@property (nonatomic, strong) NSMutableArray *modelArray;
/** 总时长 */
@property (nonatomic, copy) NSString *shiChang;
/** 服务端 总价格 */
@property (nonatomic, copy) NSString *price;
/** 提卡价格 */
@property (nonatomic) CGFloat tikaPrice;

@property (nonatomic, strong) NSMutableArray <MLJiShiModel *>*jiShiList;

///** 项目列表 注意：需先设置modelArray */
//@property (nonatomic, strong, readonly) NSMutableArray *projectList;
///** 产品列表 注意：需先设置modelArray */
//@property (nonatomic, strong, readonly) NSMutableArray *goodsList;
///** 体验 项目产品列表 注意：需先设置modelArray */
//@property (nonatomic, strong, readonly) NSMutableArray *experienceList;


/**
 获取项目参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getProjectParamList;

/**
 获取产品参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getGoodsParamList;

/**
 获取体现卡 项目 产品 参数集合
 
 @return 项目 产品 参数集合
 */
- (NSMutableArray *)getExperienceParamList;

/**
 获取处方参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getChuFangParamList;

/**
 获取提卡-储值卡参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getStoredCardParamList;

/**
 获取提卡-任选卡参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getNumCardParamList;

/**
 获取提卡-时间卡参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getTimeCardParamList;

/**
 获取服务单项目参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getServiceProjectParamList;

/**
 获取服务单产品参数集合
 
 @return 项目参数
 */
- (NSMutableArray *)getServiceGoodsParamList;

@end

NS_ASSUME_NONNULL_END
