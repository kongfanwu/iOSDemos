//
//  UIView+XMHXIBProperty.m
//  xmh
//
//  Created by KFW on 2019/4/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "UIView+XMHXIBProperty.h"

static const char *xmhCornerRadiusKey = "xmhCornerRadiusKey";
static const char *xmhMaskToBoundsKey = "xmhMaskToBoundsKey";
static const char *xmhBorderWidthKey = "xmhBorderWidthKey";
static const char *xmhBorderColorKey = "xmhBorderColorKey";

@implementation UIView (XMHXIBProperty)

- (void)setCornerRadius:(CGFloat)xmhCornerRadius {
    objc_setAssociatedObject(self, xmhCornerRadiusKey, @(xmhCornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.cornerRadius = xmhCornerRadius;
}

- (CGFloat)cornerRadius {
    return [objc_getAssociatedObject(self, xmhCornerRadiusKey) floatValue];
}

- (void)setMaskToBounds:(BOOL)xmhMaskToBounds {
    objc_setAssociatedObject(self, xmhMaskToBoundsKey, @(xmhMaskToBounds), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.masksToBounds = xmhMaskToBounds;
}

- (BOOL)maskToBounds {
    return [objc_getAssociatedObject(self, xmhMaskToBoundsKey) boolValue];
}

- (void)setBorderWidth:(CGFloat)xmhBorderWidth {
    objc_setAssociatedObject(self, xmhBorderWidthKey, @(xmhBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderWidth = xmhBorderWidth;
}

- (CGFloat)borderWidth {
    return [objc_getAssociatedObject(self, xmhBorderWidthKey) floatValue];
}

- (void)setBorderColor:(UIColor *)xmhBorderColor {
    objc_setAssociatedObject(self, xmhBorderColorKey, xmhBorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderColor = xmhBorderColor.CGColor;
}

- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, xmhBorderColorKey);
}

@end
