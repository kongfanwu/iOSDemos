//
//  OrderSaleSearchCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerListModel.h"
#import "SANewDingDanListModel.h"
@interface OrderSaleSearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;

- (void)freshOrderSaleSearchCell:(CustomerModel *)model;
- (void)freshOrderCell:(SANewDingDanModel *)model;


@end
