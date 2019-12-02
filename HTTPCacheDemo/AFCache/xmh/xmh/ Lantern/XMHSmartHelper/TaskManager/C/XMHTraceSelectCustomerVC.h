//
//  XMHTraceSelectCustomerVC.h
//  xmh
//
//  Created by ald_ios on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
#import "XMHFormTaskNextVCProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHTraceSelectCustomerVC : BaseCommonViewController <XLFormRowDescriptorViewController, XMHFormTaskNextVCProtocol>
@property (nonatomic, strong)NSMutableArray * selectArr;
@end

NS_ASSUME_NONNULL_END
