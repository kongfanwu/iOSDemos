//
//  GKGLCustomerBillVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  顾客账单界面

#import <UIKit/UIKit.h>
#import "BaseViewController1.h"
NS_ASSUME_NONNULL_BEGIN
@class GKGLHomeCustomerModel;
@interface GKGLCustomerBillVC : BaseViewController1
@property (nonatomic , strong)GKGLHomeCustomerModel * customerModel;
@end

NS_ASSUME_NONNULL_END
