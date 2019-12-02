//
//  workHome2.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/3.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkModel.h"
@interface workHome2 : UIView
/*
 今日预约 (1)(3)(5)
  数字   (2)(4)(6)
 */
@property (strong, nonatomic) UILabel *lb1;
@property (strong, nonatomic) UILabel *lb2;

@property (strong, nonatomic) UILabel *lb3;
@property (strong, nonatomic) UILabel *lb4;

@property (strong, nonatomic) UILabel *lb5;
@property (strong, nonatomic) UILabel *lb6;
/**
 *刷新workHome2数据
 */
- (void)reloadworkHome2:(WorkTodayModel *)model;

@end
