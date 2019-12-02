//
//  XMHDongJieCell3.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/16.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHDongJieCell3.h"

@implementation XMHDongJieCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.backgroundColor = kBackgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH - 20, 106);
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = rect;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    _bgView.layer.mask = cornerRadiusLayer;
    _titleLab.textColor = kLabelText_Commen_Color_6;
    _placeholdLab.textColor = kIm_Background_Color_c;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
