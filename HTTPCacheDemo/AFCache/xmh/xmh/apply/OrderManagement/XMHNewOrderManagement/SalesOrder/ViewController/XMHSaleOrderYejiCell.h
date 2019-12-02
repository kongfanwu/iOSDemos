//
//  XMHSaleOrderYejiCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/1.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHComputeOrderAchievementModel;
@class MLJiShiModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSaleOrderYejiCell : UITableViewCell
/** 移除技师 */
@property (nonatomic, copy) void (^deleteJiShiBlock)(XMHComputeOrderAchievementModel *model,XMHSaleOrderYejiCell *cell, NSIndexPath *indexPath);
/** 归属回调 tag 1 业绩 2 门店 3 店长 4 技师*/
@property (nonatomic, copy) void (^shuiShuBlock)(NSInteger tag);

@property (nonatomic, strong) NSMutableArray <MLJiShiModel *>*jishiArr;
- (void)refresCellModel:(XMHComputeOrderAchievementModel *)model;


@end

NS_ASSUME_NONNULL_END
