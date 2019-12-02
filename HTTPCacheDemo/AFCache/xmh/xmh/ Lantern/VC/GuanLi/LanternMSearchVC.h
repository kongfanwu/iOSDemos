//
//  LanternMSearchVC.h
//  xmh
//
//  Created by ald_ios on 2019/2/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN
@class CustomerModel;
@interface LanternMSearchVC : BaseCommonViewController
@property (nonatomic, copy) void (^BookSearchCustomerVCBlock)(CustomerModel * model);
@end
NS_ASSUME_NONNULL_END
