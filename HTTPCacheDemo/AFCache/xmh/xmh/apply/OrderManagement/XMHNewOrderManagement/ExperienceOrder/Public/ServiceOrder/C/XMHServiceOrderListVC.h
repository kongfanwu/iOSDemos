//
//  XMHServiceOrderList.h
//  xmh
//
//  Created by KFW on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 服务制单列表
// 体验制单。服务制单复用

#import "BaseCommonViewController.h"
@class CustomerModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceOrderListVC : BaseCommonViewController
/** 选择用户model */
@property (nonatomic, strong) CustomerModel *selectUserModel;
/** 已购商品列表 */
@property (nonatomic, strong) NSMutableArray *modelArray;
/** 创建订单类型 默认 XMHCreateOrderTypeExperience */
@property (nonatomic) XMHCreateOrderType createOrderType;
@end

NS_ASSUME_NONNULL_END
