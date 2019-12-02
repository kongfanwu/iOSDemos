//
//  GKGLCustomerDetailVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  顾客详情界面

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN
@class GKGLHomeCustomerModel;
@interface GKGLCustomerDetailVC : BaseCommonViewController
@property (nonatomic , strong)GKGLHomeCustomerModel * customerModel;
/** 订单管理 列表账单跳转过来 */
@property (nonatomic, copy)NSString * userID;
@end

NS_ASSUME_NONNULL_END
