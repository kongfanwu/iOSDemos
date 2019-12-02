//
//  SaleServiceJishiCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLJishiSearchModel.h"
#import "LJiangZengListModel.h"
@interface SaleServiceJishiCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *im;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;

-(void)freshSaleServiceJishiCell:(MLJiShiModel *)model;
-(void)freshSaleServiceShenpiCell:(LJiangZengPersonModel *)model;
@end
