//
//  BookReachStandardView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/22.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 顾客预约服务次数/服务项目数(1)
 圆(2)
 达标(3)
 圆(4)
 不达标(5)
 线(6)
 */
@interface BookReachStandardView : UIView
@property (strong, nonatomic)UILabel * lb1;
@property (strong, nonatomic)UILabel * lb2;
@property (strong, nonatomic)UILabel * lb3;
@property (strong, nonatomic)UILabel * lb4;
@property (strong, nonatomic)UILabel * lb5;
@property (strong, nonatomic)UILabel * lb6;
- (void)updateBookReachStandardView;
@end
