//
//  ProjectWaitForBookTableViewCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DaiYuYueModel;
@interface ProjectWaitForBookTableViewCell : UITableViewCell
//头像
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
//顾客姓名
@property (weak, nonatomic) IBOutlet UILabel *lb1;
//服务技师
@property (weak, nonatomic) IBOutlet UILabel *lb2;
//服务项目
@property (weak, nonatomic) IBOutlet UILabel *lb3;
//

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (nonatomic, copy)void(^projectWaitForBookTableViewCellBlock)(UIButton *btn);
- (void)updateProjectWaitForBookTableViewCell:(DaiYuYueModel *)model;
@end
