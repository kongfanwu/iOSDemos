//
//  XMHDongJieCell2.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/16.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHDongJieCell2.h"
#import "LSponsorApproceModel.h"
@implementation XMHDongJieCell2

- (void)awakeFromNib {
    [super awakeFromNib];
     self.backgroundColor = kBackgroundColor;
    _priceLab.textColor = _countLab.textColor = _awardLab.textColor = kLabelText_Commen_Color_9;
    _lab1.textColor = _priceTLab.textColor = _counttLab.textColor = _awardTLab.textColor = kLabelText_Commen_Color_6;
    _noticeLab.textColor = kPortraitCellTitle_9072;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _lineView.backgroundColor = kSeparatorLineColor;
    
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, 179);
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = rect;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    _bgVIew.layer.mask = cornerRadiusLayer;
    
    _lab1.textColor = _priceTLab.textColor = _counttLab.textColor = _awardTLab.textColor = kLabelText_Commen_Color_6;
    _priceLab.textColor = _countLab.textColor = _awardLab.textColor = kLabelText_Commen_Color_9;
    _noticeLab.textColor = kPortraitCellTitle_9072;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(LSponsorApproceModel *)model
{
    _model = model;
    _priceLab.text = [NSString stringWithFormat:@"%ld元",(long)model.user_surplus];
    _countLab.text = [NSString stringWithFormat:@"%ld次",(long)model.user_serNum];
    if (model.user_awardNum > 0) {
        _awardLab.text = @"有";
    }else{
        _awardLab.text = @"无";
    }
}
@end
