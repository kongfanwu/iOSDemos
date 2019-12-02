//
//  TJStaffCell.h
//  xmh
//
//  Created by ald_ios on 2018/12/6.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJCustomerListModel.h"
@interface TJStaffCell : UITableViewCell
- (void)updateTJStaffCellModel:(TJCustomerModel *)model index:(NSInteger)index;
@end
