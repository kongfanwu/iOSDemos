//
//  XMHBuYeJiVC.h
//  xmh
//
//  Created by KFW on 2019/4/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 补齐业绩

#import "BaseCommonViewController.h"

typedef NS_ENUM(NSInteger, XMHBuYeJiVCType) {
    XMHBuYeJiVCTypeServiceOrderAndSalesServiceOrder, // 服务单 体验制单（销售服务单）
    XMHBuYeJiVCTypeSalesOrder, // 销售单
};

NS_ASSUME_NONNULL_BEGIN

@interface XMHBuYeJiVC : BaseCommonViewController
/** 默认 XMHBuYeJiVCTypeServiceOrderAndSalesServiceOrder */
@property (nonatomic) XMHBuYeJiVCType type;
/** 订单号 */
@property (nonatomic, copy) NSString *ordernum;
@end

NS_ASSUME_NONNULL_END
