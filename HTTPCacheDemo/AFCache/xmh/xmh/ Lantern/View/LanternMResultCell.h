//
//  LanternMResultCell.h
//  xmh
//
//  Created by ald_ios on 2019/2/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LanternMResultVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface LanternMResultCell : UITableViewCell
- (void)updateCellParam:(NSDictionary *)param;
- (void)updateCellParam:(NSDictionary *)param searchType:(LanternSearchType)searchType;
@end

NS_ASSUME_NONNULL_END
