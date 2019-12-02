//
//  XMHComputeOredrVC.h
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 体验制单 服务制单 提交结算清单

#import "BaseCommonViewController.h"
#import "CustomerListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHComputeOredrVC : BaseCommonViewController
/** 选择用户model */
@property (nonatomic, strong) CustomerModel *selectUserModel;
/** 已购商品列表 */
@property (nonatomic, strong) NSMutableArray *modelArray;
/** 总时长 */
@property (nonatomic, copy) NSString *shiChang;
/** 创建订单类型 默认 XMHCreateOrderTypeExperience */
@property (nonatomic) XMHCreateOrderType createOrderType;
@end

NS_ASSUME_NONNULL_END
