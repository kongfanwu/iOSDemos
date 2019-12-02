//
//  XMHACSendDataStatisticsCell.h
//  xmh
//
//  Created by ald_ios on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHCouponSendDataListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHACSendDataStatisticsCell : UITableViewCell
- (void)updateCellModel:(XMHCouponSendDataModel *)model;
@end

NS_ASSUME_NONNULL_END
