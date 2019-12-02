//
//  LanternPlanProTableViewCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/26.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASaleListModel.h"

@interface LanternPlanProTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnReduce;

@property (nonatomic, copy) void (^btnGDKDReduiceAddBlock)(SaleModel *model,NSInteger addflag);
- (void)freshGuDingProOneCell:(SaleModel *)model;

@end
