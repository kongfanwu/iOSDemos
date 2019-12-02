//
//  ApplySectionHeader.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/10.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ApplySectionHeader.h"

@implementation ApplySectionHeader{
    UIView * _view2;                //白色条
    UILabel * _lb1;                 //
    UILabel * _lb;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _view2 = [[UIView alloc] init];
        _view2.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        [self addSubview:_view2];
        _lb = [[UILabel alloc] init];
        _lb.font = FONT_SIZE(16);
        [_lb sizeToFit];
        _lb.frame = CGRectMake(17, 15, SCREEN_WIDTH, 16);
        _lb.textColor = kLabelText_Commen_Color_3;
        _lb.text = @"管理应用";
        [_view2 addSubview:_lb];
        
        _lb1 = [[UILabel alloc] init];
        _lb1.backgroundColor = kSeparatorColor;
        _lb1.frame = CGRectMake(0, _view2.bottom, SCREEN_WIDTH, 0.6);
        [self addSubview:_lb1];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (void)updateApplySectionHeaderTitle:(NSString *)title
{
    _lb.text = title;
}
@end
