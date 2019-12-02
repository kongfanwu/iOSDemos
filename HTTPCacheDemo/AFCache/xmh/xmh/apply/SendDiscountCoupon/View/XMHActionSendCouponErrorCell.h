//
//  XMHActionSendCouponErrorCell.h
//  xmh
//
//  Created by ald_ios on 2019/5/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHCouponSendErrorListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHActionSendCouponErrorCell : UITableViewCell
- (void)updateCellModel:(XMHCouponSendErrorModel *)model index:(NSInteger)index;
@property (nonatomic, copy) void (^XMHActionSendCouponErrorCellBlock)(XMHCouponSendErrorModel *model);
@end

NS_ASSUME_NONNULL_END
