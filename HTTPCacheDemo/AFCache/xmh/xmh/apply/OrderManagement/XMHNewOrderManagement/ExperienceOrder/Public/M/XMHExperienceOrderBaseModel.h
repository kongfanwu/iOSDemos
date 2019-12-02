//
//  XMHExperienceOrderBaseModel.h
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// SLS_Pro SLGoodModel SLPro_ListM SLGoods_ListM 的基类

#import <Foundation/Foundation.h>
#import "XMHShoppingCartBaseModel.h"
#import "XMHTicketModel.h"
#import "MLJishiSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHExperienceOrderBaseModel : XMHShoppingCartBaseModel

/** 礼品卷model */
@property (nonatomic, strong) XMHTicketModel *ticketModel;
/** 已选技师集合 */
@property (nonatomic, strong) NSMutableArray <MLJiShiModel *> *jiShiList;
/** 服务类型 */
//@property (nonatomic) XMHExperienceOrderType type;
/** 用户输入的价格 */
@property (nonatomic, copy) NSString *inputPrice;
/** 产品是否用完，1是，0否 */
@property (nonatomic) BOOL is_end;

/**
 计算总原价格
 单价 * 购买数量
 */
- (CGFloat)computeOriginPrice;

/**
 计算总价格
 单价 * 购买数量 - 礼品卷（如果有）
 */
- (CGFloat)computeTotalPrice;

/**
 服务类型转字符串
 
 @return 服务类型描述
 */
- (NSString *)stringFromType;



@end

NS_ASSUME_NONNULL_END
