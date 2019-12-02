//
//  StatisticsAndApplyCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/9.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineCellModel;
@interface StatisticsAndApplyCell : UICollectionViewCell
- (void)setTitle:(NSArray *)titles icon:(NSArray *)icons index:(NSIndexPath *)indexPath;
- (void)updateStatisticsAndApplyCellModel:(MineCellModel *)model withCount:(NSString *)count;
@end
