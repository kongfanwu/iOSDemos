//
//  WorkDyyCell.h
//  xmh
//
//  Created by ald_ios on 2018/9/12.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
// H 86

#import <UIKit/UIKit.h>
#import "MzzDaiYuYueModel.h"
#import "MzzDaiGenJinModel.h"
@interface WorkCommonCell : UITableViewCell
- (void)updateWorkCommonCellDyyModel:(MzzDaiYuYue *)model;
- (void)updateWorkCommonCellKfgkModel:(MzzKfgk *)model;
- (void)updateWorkCommonCellKqwhModel:(MzzKqwh *)model;
@end
