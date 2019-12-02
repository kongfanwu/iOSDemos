//
//  XMHACSendDiscountCouponCell.h
//  xmh
//
//  Created by ald_ios on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHCouponModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHACSendDiscountCouponCell : UITableViewCell
- (void)updateCellModel:(XMHCouponModel *)model;
@end

NS_ASSUME_NONNULL_END
