//
//  BookProjectTableViewCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  预约项目Cell

#import <UIKit/UIKit.h>
#import "DaiYuYueModel.h"
@interface BookProjectTableViewCell : UITableViewCell
// 选择按钮
@property (weak, nonatomic) IBOutlet UIButton *btn;
// 名称
@property (weak, nonatomic) IBOutlet UILabel *lb1;
//次数
@property (weak, nonatomic) IBOutlet UILabel *lb2;
//时长
@property (weak, nonatomic) IBOutlet UILabel *lb3;

@property (strong, nonatomic)DaiYuYueModel * model;
@end
