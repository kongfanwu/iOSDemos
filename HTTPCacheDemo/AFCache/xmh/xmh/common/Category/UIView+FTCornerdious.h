//
//  UIView+FTCornerdious.h
//  Freight
//
//  Created by zhongzhi on 2017/7/3.
//  Copyright © 2017年 zhongzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FTCornerdious)
-(void)setFTCornerdious:(CGFloat)cornerdious;//设置全部圆角
-(void)setFtCornerdious:(CGFloat)cornerdious  Corners:(UIRectCorner)corners ;  //设置圆角，设置某个位置的圆角
-(void)setFTBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;//设置border 以及color

/*
 周边加阴影，并且同时圆角
 */
+ (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
        andCornerRadius:(CGFloat)cornerRadius;

/**
 view某角添加圆角
 
 @param view view
 @param corners 枚举
 @param cornerRadii 圆角大小
 */
+ (void)addRadiusWithView:(UIView *)view roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 添加圆角
 
 @param cornerRadius 圆角
 */
- (void)cornerRadius:(CGFloat)cornerRadius;

/**
 cell 动画
 */
-(void)animateCell;
@end
