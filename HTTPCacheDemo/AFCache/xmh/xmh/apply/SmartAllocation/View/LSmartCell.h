//
//  LSmartCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 108

#import <UIKit/UIKit.h>
#import "ZFUserListModel.h"
@interface LSmartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
/**
 姓名(1)
 等级(2)
 技师(3)
 门店(4)
 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic)ZFUserModel * model;
@property (copy, nonatomic)void (^LSmartCellBlock)(ZFUserModel * model);
@end
