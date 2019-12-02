//
//  XMHComputeOrderLastVC.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 业绩划分 置后填写

#import "BaseCommonViewController.h"
#import "CustomerListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHComputeOrderLastVC : BaseCommonViewController
/** 已购商品列表 */
@property (nonatomic, strong) NSMutableArray *modelArray;
/** 订单号 */
@property (nonatomic, copy) NSString *ordernum;
/** 创建订单类型 默认 XMHCreateOrderTypeExperience*/
@property (nonatomic) XMHCreateOrderType createOrderType;
/** 自定义title */
@property (nonatomic, copy) NSString *customTitle;
@end

NS_ASSUME_NONNULL_END
