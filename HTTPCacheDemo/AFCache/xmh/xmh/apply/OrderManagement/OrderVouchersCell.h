//
//  OrderVouchersCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/10/29.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SATicketListModel.h"
#import "SellProTicketListModel.h"

@interface OrderVouchersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *imageWeiK;
@property (weak, nonatomic) IBOutlet UILabel *lbGuiZ;

@property (nonatomic, copy) void (^btnSKXKDiYongQuanCellBlock)(SATicketModel *model);
@property (nonatomic, copy) void (^btnSellProDiYongQuanCellBlock)(SellProTicketModel *model);

- (void)freshSKXKDiYongQuanCell:(SATicketModel *)model;
- (void)freshSellProDiYongQuanCell:(SellProTicketModel *)model;
@end
