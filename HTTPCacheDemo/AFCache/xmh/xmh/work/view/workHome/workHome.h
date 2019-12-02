//
//  workHome.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/3.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkModel.h"
@interface workHome : UIView

/*
 标题(1)
 目标(2)：目标数(4) 亿（6）
 实际(3)：实际数(5) 万（7）
 */
@property (strong, nonatomic) UILabel *lb1;
@property (strong, nonatomic) UILabel *lb2;
@property (strong, nonatomic) UILabel *lb3;
@property (strong, nonatomic) UILabel *lb4;
@property (strong, nonatomic) UILabel *lb5;

@property (strong, nonatomic) UILabel *lb6;
@property (strong, nonatomic) UILabel *lb7;

@property (strong, nonatomic) UIImageView *line1;
@property (strong, nonatomic) UIImageView *line2;
/**
 *刷新workHome数据
 */
- (void)reloadworkHome:(WorkTopModel *)model;

@end
