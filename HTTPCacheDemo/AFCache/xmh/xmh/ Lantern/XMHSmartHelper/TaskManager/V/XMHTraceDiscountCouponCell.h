//
//  XMHTraceDiscountCouponCell.h
//  xmh
//
//  Created by ald_ios on 2019/6/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHSmartManagerEnum.h"
@class XMHCouponModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHTraceDiscountCouponCell : UITableViewCell
- (void)updateCellType:(XMHTraceDiscountCouponCellType)cellType;
- (void)updateCellModel:(XMHCouponModel *)model;
@end

NS_ASSUME_NONNULL_END
