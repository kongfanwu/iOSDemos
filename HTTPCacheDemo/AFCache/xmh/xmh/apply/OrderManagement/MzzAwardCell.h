//
//  MzzAwardCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/14.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASaleListModel.h"
@interface MzzAwardCell : UITableViewCell
@property (nonatomic ,strong)SaleModel *model;
@property (weak, nonatomic) IBOutlet UIButton *shanchu;
@end
