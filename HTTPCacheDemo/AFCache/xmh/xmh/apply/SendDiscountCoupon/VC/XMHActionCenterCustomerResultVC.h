//
//  XMHActionCenterCustomerResultVC.h
//  xmh
//
//  Created by ald_ios on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  选择结果进入的顾客VC

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHActionCenterCustomerResultVC : BaseCommonViewController
/** 选择的顾客数据 */
@property (nonatomic, strong)NSMutableArray * selectResultArr;

@property (nonatomic, copy) void(^XMHActionCenterCustomerResultVCBlock)(NSMutableArray *selectResultArr);
@end

NS_ASSUME_NONNULL_END
