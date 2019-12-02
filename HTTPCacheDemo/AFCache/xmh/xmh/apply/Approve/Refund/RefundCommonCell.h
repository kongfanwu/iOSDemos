//
//  RefundCommonCell.h
//  xmh
//
//  Created by ald_ios on 2018/11/12.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//  项目 人选卡 产品 时间卡  cell

#import <UIKit/UIKit.h>
@class RefundModel;
@interface RefundCommonCell : UITableViewCell
/** 展开按钮回调 */
@property (nonatomic, copy) void (^RefundCommonCellShowBlock)(RefundModel *model);
/** 全部退款按钮回调 */
@property (nonatomic, copy) void (^RefundCommonCellAllBlock)(RefundModel *model);
/** 加入购物车按钮回调 */
@property (nonatomic, copy) void (^RefundCommonCellAddGWCBlock)(RefundModel *model);
- (void)updateRefundCommonCellModel:(RefundModel *)model;
@end
