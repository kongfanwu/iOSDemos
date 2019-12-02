//
//  UIView+FTCornerdious.m
//  Freight
//
//  Created by zhongzhi on 2017/7/3.
//  Copyright © 2017年 zhongzhi. All rights reserved.
//

#import "UIView+FTCornerdious.h"

@implementation UIView (FTCornerdious)
-(void)setFTCornerdious:(CGFloat)cornerdious{

    
    self.layer.cornerRadius = cornerdious;
    
    self.layer.masksToBounds = YES;

  }

-(void)setFTBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    
}

-(void)setFtCornerdious:(CGFloat)cornerdious Corners:(UIRectCorner)corners {
    
//  
//    UIBezierPath * maskPath =[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerdious, cornerdious)];
//    
//    
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.frame = self.bounds;
//    maskLayer.path = maskPath.CGPath;
//    
//    self.layer.mask = maskLayer;
    
    
    
    
}


/*
 周边加阴影，并且同时圆角
 */
+ (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
        andCornerRadius:(CGFloat)cornerRadius
{
    //////// shadow /////////
    CALayer *shadowLayer = [CALayer layer];
    
    for (CALayer *lay in view.superview.layer.sublayers) {
        if ([lay.name isEqualToString:@"custom"]) {
            //            [lay removeFromSuperlayer];
            shadowLayer = lay;
        }
    }
    
    shadowLayer.frame = view.layer.frame;
    
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    shadowLayer.shadowOffset = CGSizeMake(0, 0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    shadowLayer.shadowOpacity = shadowOpacity;//0.8;//阴影透明度，默认0
    shadowLayer.shadowRadius = shadowRadius;//8;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = shadowLayer.bounds.size.width;
    float height = shadowLayer.bounds.size.height;
    float x = shadowLayer.bounds.origin.x;
    float y = shadowLayer.bounds.origin.y;
    
    CGPoint topLeft      = shadowLayer.bounds.origin;
    CGPoint topRight     = CGPointMake(x + width, y);
    CGPoint bottomRight  = CGPointMake(x + width, y + height);
    CGPoint bottomLeft   = CGPointMake(x, y + height);
    
    CGFloat offset = -1.f;
    [path moveToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    [path addArcWithCenter:CGPointMake(topLeft.x + cornerRadius, topLeft.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    [path addLineToPoint:CGPointMake(topRight.x - cornerRadius, topRight.y - offset)];
    [path addArcWithCenter:CGPointMake(topRight.x - cornerRadius, topRight.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 * 3 endAngle:M_PI * 2 clockwise:YES];
    [path addLineToPoint:CGPointMake(bottomRight.x + offset, bottomRight.y - cornerRadius)];
    [path addArcWithCenter:CGPointMake(bottomRight.x - cornerRadius, bottomRight.y - cornerRadius) radius:(cornerRadius + offset) startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y + offset)];
    [path addArcWithCenter:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y - cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    
    //设置阴影路径
    shadowLayer.shadowPath = path.CGPath;
    shadowLayer.name = @"custom";
    
    //////// cornerRadius /////////
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
    view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [view.superview.layer insertSublayer:shadowLayer below:view.layer];
}

/**
 view某角添加圆角

 @param view view
 @param corners 枚举
 @param cornerRadii 圆角大小
 */
+ (void)addRadiusWithView:(UIView *)view roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    if (view.layer.mask) {
        view.layer.mask = nil;
    }
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners: corners cornerRadii:cornerRadii];
    
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = view.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    view.layer.mask = cornerRadiusLayer;
}

/**
 添加圆角

 @param cornerRadius 圆角
 */
- (void)cornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}


/**
 cell 动画
 */
-(void)animateCell
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values =  @[ @0, @20, @-20, @10, @0];
    animation.keyTimes = @[@0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.additive = YES;
    
    [self.layer addAnimation:animation forKey:@"shake"];
}

@end
