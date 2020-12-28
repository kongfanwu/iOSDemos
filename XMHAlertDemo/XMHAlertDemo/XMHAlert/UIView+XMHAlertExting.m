//
//  UIView+Exting.m
//  iLoan
//
//  Created by kubook008 kubook008 on 15/9/21.
//  Copyright © 2015年 51credit.com. All rights reserved.
//

#import "UIView+XMHAlertExting.h"

@implementation UIView (XMHAlertExting)

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame    = self.frame;
    frame.origin.y  = y;
    self.frame      = frame;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame    = self.frame;
    frame.origin.x  = x;
    self.frame      = frame;
}

- (void)setRight:(CGFloat)right
{

    CGRect frame    = self.frame;
    frame.origin.x  = right - frame.size.width;
    self.frame      = frame;
}

- (void)setBottom:(CGFloat)bottom
{

    CGRect frame    = self.frame;
    frame.origin.y  = bottom - frame.size.height;
    self.frame      = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame        = self.frame;
    frame.size.width    = width;
    self.frame          = frame;
}

- (void)setHeight:(CGFloat)height
{

    CGRect frame        = self.frame;
    frame.size.height   = height;
    self.frame          = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    
    self.center = CGPointMake(centerX, self.center.y);
}
- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.centerX, centerY);
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)removeAllSubViews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (UIViewController *)viewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass: [UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

/**
 通过颜色创建图片

 @param color 颜色
 @param size 大小
 @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/// 添加圆角
- (void)addCornerRadiu:(CGFloat)cornerRadius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = self.bounds;
    cornerRadiusLayer.path = maskPath.CGPath;
    self.layer.mask = cornerRadiusLayer;
}

/// 获取当前 window
+ (UIWindow *)getCurrentWindow {
    UIWindow* window = nil;
    if (@available(iOS 13.0, *)) {
        NSSet<UIScene *> *connectedScenes = UIApplication.sharedApplication.connectedScenes;
        if (connectedScenes.count) {
            for (UIWindowScene* windowScene in connectedScenes){
                if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                    window = windowScene.windows.firstObject;
                    break;
                }
            }
        } else {
            window = [[UIApplication sharedApplication].windows lastObject];
        }
    }else{
        window = [[UIApplication sharedApplication].windows lastObject];
    }
    return window;
}

@end
