//
//  XHMACSendHomeCell.h
//  xmh
//
//  Created by ald_ios on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHCouponSendHomeListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XHMACSendHomeCell : UITableViewCell
- (void)updateCellModel:(XMHCouponSendHomeModel *)model;
@end

NS_ASSUME_NONNULL_END
