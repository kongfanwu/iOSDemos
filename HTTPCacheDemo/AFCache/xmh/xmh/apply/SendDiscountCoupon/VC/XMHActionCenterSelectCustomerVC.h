//
//  XMHActionCenterSelectCustomerVC.h
//  xmh
//
//  Created by ald_ios on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  初次选择顾客VC

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHActionCenterSelectCustomerVC : BaseCommonViewController
@property (nonatomic, copy) void(^XMHActionCenterSelectCustomerVCBlock)(NSMutableArray *selectResultArr);
/** 选择的顾客数据 */
@property (nonatomic, strong)NSMutableArray * selectResultArr;
@end

NS_ASSUME_NONNULL_END
