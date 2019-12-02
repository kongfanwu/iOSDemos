//
//  XMHSmartHelperHomeCell.h
//  xmh
//
//  Created by ald_ios on 2019/6/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  智能助手首页cell

#import <UIKit/UIKit.h>
#import "MineCellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHSmartHelperHomeCell : UICollectionViewCell
- (void)updateCellModel:(MineCellModel *)model;
@end

NS_ASSUME_NONNULL_END
