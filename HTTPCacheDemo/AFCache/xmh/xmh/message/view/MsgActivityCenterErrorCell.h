//
//  MsgActivityCenterErrorCell.h
//  xmh
//
//  Created by ald_ios on 2019/5/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHCouponSendCustomerListModel.h"
typedef NS_ENUM(NSInteger, CellFrom) {
    CellFromMsg, //消息列表
    CellFromSearch, // 搜索
    CellFromResult // 修改
};
NS_ASSUME_NONNULL_BEGIN

@interface MsgActivityCenterErrorCell : UITableViewCell
@property (nonatomic, copy) void (^MsgActivityCenterErrorCellDelBlock)(XMHCouponSendCustomerModel * model);
- (void)updateCellModel:(XMHCouponSendCustomerModel *)model cellFrom:(CellFrom)from;
@end

NS_ASSUME_NONNULL_END
