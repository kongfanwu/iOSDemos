//
//  ApplySectionFooter.m
//  xmh
//
//  Created by ald_ios on 2018/9/10.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "ApplySectionFooter.h"

@implementation ApplySectionFooter
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView * v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, 10)];
        v1.backgroundColor = [UIColor whiteColor];
        [self addSubview:v1];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:v1.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = v1.bounds;
        maskLayer.path = maskPath.CGPath;
        v1.layer.mask = maskLayer;
        v1.layer.masksToBounds = YES;
    }
    return self;
}

@end
