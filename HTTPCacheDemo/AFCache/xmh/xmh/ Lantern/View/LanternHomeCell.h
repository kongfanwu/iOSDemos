//
//  LanternHomeCell.h
//  xmh
//
//  Created by ald_ios on 2019/1/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineCellModel;
NS_ASSUME_NONNULL_BEGIN

@interface LanternHomeCell : UITableViewCell
- (void)updateLanternHomeCellModel:(MineCellModel *)model;
@end

NS_ASSUME_NONNULL_END
