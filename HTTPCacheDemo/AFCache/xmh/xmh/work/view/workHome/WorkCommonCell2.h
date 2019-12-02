//
//  WorkCommonCell2.h
//  xmh
//
//  Created by ald_ios on 2018/9/13.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//  H 135

#import <UIKit/UIKit.h>
#import "MzzDaiFuWuModel.h"
@interface WorkCommonCell2 : UITableViewCell
- (void)updateWorkCommonCellXsnrModel:(MzzXsnr*)model;
- (void)updateWorkCommonCellFwnrModel:(MzzFwnr*)model;
@end
