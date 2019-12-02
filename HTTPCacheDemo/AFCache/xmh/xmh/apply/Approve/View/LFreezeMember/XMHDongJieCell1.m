//
//  XMHDongJieCell1.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHDongJieCell1.h"
#import "LSponsorApproceModel.h"
@implementation XMHDongJieCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = kBackgroundColor;
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    _lineView.backgroundColor = kSeparatorLineColor;
    
    /*
     UIRectCornerTopLeft     = 1 << 0,
     UIRectCornerTopRight    = 1 << 1,
     UIRectCornerBottomLeft  = 1 << 2,
     UIRectCornerBottomRight = 1 << 3,
     */
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, 179);
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight |  UIRectCornerBottomLeft |UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = rect;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    _bgView.layer.mask = cornerRadiusLayer;
    
    
    _lb1.textColor = kLabelText_Commen_Color_6;
    _lb2.textColor = _lb3.textColor = _lb4.textColor =_lb5.textColor = _lb6.textColor = _lb7.textColor =kLabelText_Commen_Color_9;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(LSponsorApproceModel *)model
{
    _model = model;
    _lb1.text = [NSString stringWithFormat:@"审批编号: %@",model.code];
    _lb2.text = [NSString stringWithFormat:@"品牌名称: %@",model.join_name];
    _lb3.text = [NSString stringWithFormat:@"审批发起人: %@",model.initiator];
    _lb4.text = [NSString stringWithFormat:@"顾客名称: %@",model.user_name];
    _lb5.text = [NSString stringWithFormat:@"手机: %@",model.user_mobile];
    _lb6.text = [NSString stringWithFormat:@"所属门店: %@",model.user_mdname];
    _lb7.text = [NSString stringWithFormat:@"所属技师: %@",model.user_jis_name];
    
}


@end
