//
//  GKGLHealthInquirySearchVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  身体问诊搜索顾客界面

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
#import "JasonSearchView.h"
NS_ASSUME_NONNULL_BEGIN
@class GKGLHomeCustomerModel;
@interface GKGLHealthInquirySearchVC : BaseCommonViewController
@property (nonatomic, copy) void (^GKGLHealthInquirySearchVCBlock)(GKGLHomeCustomerModel *model);
@end

NS_ASSUME_NONNULL_END
