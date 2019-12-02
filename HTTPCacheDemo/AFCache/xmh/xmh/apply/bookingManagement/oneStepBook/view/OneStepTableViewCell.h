//
//  OneStepTableViewCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YiYuYueModel;
@interface OneStepTableViewCell : UITableViewCell
/*
 顾客姓名 1
 服务技师 2
 处方项目 3
 预约时间 4
 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@property (nonatomic, copy)void(^OneStepTableViewCellModifyBtnBlock)(UIButton *btn);
- (void)updateOneStepTableViewCell:(NSObject *)model;
@end
