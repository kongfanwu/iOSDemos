//
//  XMHTraceSelectDiscountCouponSubVC.h
//  xmh
//
//  Created by ald_ios on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHSmartManagerEnum.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHTraceSelectDiscountCouponSubVC : UIViewController
@property (nonatomic, assign)NSInteger tag;
@property (nonatomic, copy) void (^XMHTraceSelectDiscountCouponSubVCBlock)(NSMutableArray *selectArr, NSInteger tag);
@property (nonatomic, assign) XMHTraceDiscountCouponCellType cellType;
@property (nonatomic, strong) NSArray * paramArr;
@end

NS_ASSUME_NONNULL_END
