//
//  MzzGuKeChuFangCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H 110

#import <UIKit/UIKit.h>
#import "GuKeChuFang.h"
@interface MzzGuKeChuFangCell : UITableViewCell
/*
 处方名称(1)
 预约技师(2)
 剩余次数(3)
 规划时间(4)
 是否完成(5)
 处方报告(btn1)
 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (nonatomic ,strong)GuKeChuFang *model;
@end
