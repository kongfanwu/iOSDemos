//
//  XMHOrderSaleBuYeJiVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
@class CustomerModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHOrderSaleBuYeJiVC : BaseCommonViewController
@property (nonatomic, copy) NSString *ordernum;
@property (nonatomic, strong) CustomerModel *customer;// 所选择的顾客
@end

NS_ASSUME_NONNULL_END
