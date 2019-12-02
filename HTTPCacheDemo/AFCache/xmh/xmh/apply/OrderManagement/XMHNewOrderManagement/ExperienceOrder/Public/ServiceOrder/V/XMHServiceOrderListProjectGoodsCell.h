//
//  XMHServiceOrderListProjectCell.h
//  xmh
//
//  Created by KFW on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 服务制单 项目 产品 cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceOrderListProjectGoodsCell : UITableViewCell
/** 移除项目 */
@property (nonatomic, copy) void (^deleteBlock)(XMHServiceOrderListProjectGoodsCell *cell);
/** 移除技师 */
@property (nonatomic, copy) void (^deleteJiShiBlock)(XMHServiceOrderListProjectGoodsCell *cell, NSIndexPath *indexPath);
/** 添加技师 */
@property (nonatomic, copy) void (^addJiShiBlock)(XMHServiceOrderListProjectGoodsCell *cell, NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
