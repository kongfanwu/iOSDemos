//
//  BookSearchCustomerVC.h
//  xmh
//
//  Created by ald_ios on 2018/10/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
@class CustomerModel;
@interface BookSearchCustomerVC : BaseCommonViewController
@property (nonatomic, copy) void (^BookSearchCustomerVCBlock)(CustomerModel * model);
@end
