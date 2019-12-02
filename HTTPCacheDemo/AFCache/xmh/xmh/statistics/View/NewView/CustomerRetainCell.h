//
//  CustomerRetainCell.h
//  xmh
//
//  Created by ald_ios on 2018/12/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomerRetainModel;
@interface CustomerRetainCell : UITableViewCell
- (void)updateCustomerRetainCellModel:(CustomerRetainModel *)model;
@end
