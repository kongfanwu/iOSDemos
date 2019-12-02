//
//  WorkCommonCell3.h
//  xmh
//
//  Created by ald_ios on 2018/9/13.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
// H 86

#import <UIKit/UIKit.h>
#import "MzzDaiGenJinModel.h"
#import "WorkModel.h"
@interface WorkCommonCell3 : UITableViewCell
- (void)updateWorkCommonCellSqgjModel:(MzzSqgk *)model;
- (void)updateWorkCommonCellDgModel:(WorkUserModel *)model;
@end
