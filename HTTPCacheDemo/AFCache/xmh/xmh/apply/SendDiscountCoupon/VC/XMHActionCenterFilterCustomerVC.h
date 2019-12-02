//
//  XMHActionCenterFilterCustomer.h
//  xmh
//
//  Created by ald_ios on 2019/5/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHActionCenterFilterCustomerVC : BaseCommonViewController
@property (nonatomic, copy) void(^XMHActionCenterSelectCustomerVCBlock)(NSMutableArray *selectResultArr);
@end

NS_ASSUME_NONNULL_END
