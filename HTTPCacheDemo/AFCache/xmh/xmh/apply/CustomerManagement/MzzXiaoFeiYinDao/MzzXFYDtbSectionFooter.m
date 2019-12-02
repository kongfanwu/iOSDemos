//
//  MzzXFYDtbSectionFooter.m
//  xmh
//
//  Created by ald_ios on 2018/10/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzXFYDtbSectionFooter.h"
@interface MzzXFYDtbSectionFooter ()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation MzzXFYDtbSectionFooter
- (void)awakeFromNib
{
    [super awakeFromNib];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_backView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = _backView.bounds;
    maskLayer.path = maskPath.CGPath;
    _backView.layer.mask = maskLayer;
    _backView.layer.masksToBounds = YES;
}
@end
