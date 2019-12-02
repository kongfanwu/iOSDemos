//
//  CountView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  顾客到店状态标识条View

#import <UIKit/UIKit.h>
@class LolCalendarModelList;
/*
 选择日期(1)
 预约服务人数(2)
 预约服务项目(3)
 达标率(4)
 预约服务人次(5)
 达标天数(6)
 */
@interface CountView : UIView
@property (strong, nonatomic) UILabel *lb1;
@property (strong, nonatomic) UILabel *lb2;
@property (strong, nonatomic) UILabel *lb3;
@property (strong, nonatomic) UILabel *lb4;
@property (strong, nonatomic) UILabel *lb5;
@property (strong, nonatomic) UILabel *lb6;
@property (strong, nonatomic) UILabel *line;
- (void)updateCountViewCalendarModelList:(LolCalendarModelList *)model;
- (void)updateCountView;
@end
