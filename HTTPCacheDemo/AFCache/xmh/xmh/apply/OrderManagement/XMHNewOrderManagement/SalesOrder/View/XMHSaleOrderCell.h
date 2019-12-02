//
//  XMHSaleOrderCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SaleModel;

@interface XMHSaleOrderCell : UITableViewCell

/**
 项目cell赋值

 @param model SASaleModel
 */
- (void)refreshCellProModel:(SaleModel *)model;

/**
 产品cell赋值

 @param model SASaleModel
 */
- (void)refreshCellGoodsModel:(SaleModel *)model;

/**
 特惠cell赋值

 @param model SASaleModel
 */
- (void)refreshCellCardCourseModel:(SaleModel *)model;
/**
 任选卡cell赋值
 
 @param model SASaleModel
 */
- (void)refreshCellCardNumModel:(SaleModel *)model;
/**
 时间卡cell赋值
 
 @param model SASaleModel
 */
- (void)refreshCellCardTimeModel:(SaleModel *)model;
/**
 储值卡cell赋值
 
 @param model SASaleModel
 */
- (void)refreshCellStoredModel:(SaleModel *)model;
/**
 票券cell赋值
 
 @param model SASaleModel
 */
- (void)refreshCellTicketModel:(SaleModel *)model;

/**
 续卡充值cell赋值
 
 @param model SASaleModel
 */
- (void)refreshCellSkxkModel:(SaleModel *)model;

/**
 重置cell
 */
- (void)resetCell;
@end

NS_ASSUME_NONNULL_END
