//
//  LApprovePointView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 75

#import <UIKit/UIKit.h>

@interface LApprovePointView : UIView
@property (strong, nonatomic)  UIButton *btn1;
@property (strong, nonatomic)  UILabel *lbPoint;
@property (strong, nonatomic)  UILabel *lbTitle;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imgName:(NSString *)imgName;
@end
