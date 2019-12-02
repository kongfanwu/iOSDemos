//
//  XMHTraceSelectDiscountCouponVC.h
//  xmh
//
//  Created by ald_ios on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
#import "XMHFormTaskNextVCProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHTraceSelectDiscountCouponVC : BaseCommonViewController <XLFormRowDescriptorViewController, XMHFormTaskNextVCProtocol>
@property (nonatomic, copy) void (^XMHTraceSelectDiscountCouponVCBlock)(NSMutableArray * discountCouponArr);
@end

NS_ASSUME_NONNULL_END
