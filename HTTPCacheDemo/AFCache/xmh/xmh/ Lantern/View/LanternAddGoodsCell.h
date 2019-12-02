//
//  LanternAddGoodsCell.h
//  xmh
//
//  Created by ald_ios on 2018/12/29.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LanternPlanProModel;
@interface LanternAddGoodsCell : UITableViewCell
/** 加号回调 */
@property (nonatomic, copy)void (^LanternAddGoodsCellAddBlock)(LanternPlanProModel *model);
/** 减号回调 */
@property (nonatomic, copy)void (^LanternAddGoodsCellReduceBlock)(LanternPlanProModel *model);
- (void)updateLanternAddGoodsCellModel:(LanternPlanProModel *)model;
@end
