//
//  LDealDaiFaHuoCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 250

#import <UIKit/UIKit.h>
#import "OOrderListModel.h"
@interface LDeatailDaiFaHuoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbCode;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (weak, nonatomic) IBOutlet UILabel *lbState;

@property (nonatomic, strong)OOrderModel *model;
@property (nonatomic, copy)void (^LDeatailDaiFaHuoCellBlock)(OOrderModel *model);
@end
