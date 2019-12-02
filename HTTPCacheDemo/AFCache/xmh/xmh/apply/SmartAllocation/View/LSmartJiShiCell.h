//
//  LSmartJiShiCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 145

#import <UIKit/UIKit.h>
#import "LAllocationDetaiModel.h"
@interface LSmartJiShiCell : UITableViewCell
@property (nonatomic, strong)LAllocationListModel * model;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (copy, nonatomic) void (^LSmartJiShiCellBlock)(LAllocationListModel *model);
@end
