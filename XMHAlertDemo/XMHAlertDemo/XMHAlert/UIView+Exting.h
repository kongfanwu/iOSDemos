//
//  UIView+Exting.h
//  iLoan
//
//  Created by kubook008 kubook008 on 15/9/21.
//  Copyright © 2015年 51credit.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Exting)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGSize size;

- (void)removeAllSubViews;

- (UIViewController *)viewController;

/**
 通过颜色创建图片

 @param color 颜色
 @param size 大小
 @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/// 添加圆角
- (void)addCornerRadiu:(CGFloat)cornerRadius;

/// 获取当前 window
+ (UIWindow *)getCurrentWindow;
@end
