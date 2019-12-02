//
//  XMHOrderSearchCustomerVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
@class CustomerModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHOrderSearchCustomerVC : BaseCommonViewController
@property (nonatomic, assign)BOOL fromRecoverBill;// 回收账单使用
@property (nonatomic, copy) void(^selectedCustomer)(CustomerModel *model);
@end

NS_ASSUME_NONNULL_END
