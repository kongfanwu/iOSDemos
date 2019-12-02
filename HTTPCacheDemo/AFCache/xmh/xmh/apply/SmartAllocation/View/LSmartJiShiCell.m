//
//  LSmartJiShiCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LSmartJiShiCell.h"
#import <YYWebImage/YYWebImage.h>
@implementation LSmartJiShiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btn1.layer.cornerRadius = 3;
    _btn1.layer.masksToBounds = YES;
    _btn1.layer.borderWidth = 1;
    _btn1.layer.borderColor = kLabelText_Commen_Color_6.CGColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_btn1 addTarget:self action:@selector(exChange) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)setModel:(LAllocationListModel *)model
{
    _model = model;
    [_imgV1 yy_setImageWithURL:[NSURL URLWithString:model.jis_img] placeholder:kDefaultJisImage];
    _lb1.text = model.jis_name;
     _lb2.text = [NSString stringWithFormat:@"%ld",model.jis_min];
    _lb8.text = [NSString stringWithFormat:@"/%@",model.jis_max];
    _lb3.text = [NSString stringWithFormat:@"%@",model.jis_cql];
    _lb4.text = [NSString stringWithFormat:@"到店频次: %@次",model.jis_ddpc];
    _lb5.text = [NSString stringWithFormat:@"销售业绩: %@元",model.jis_xsyj];
    _lb6.text = [NSString stringWithFormat:@"消耗项目: %@个",model.jis_xhxm];
    _lb7.text = [NSString stringWithFormat:@"耗卡单价: %@元",model.jis_hkdj];
    
}
- (void)exChange
{
    if (_LSmartJiShiCellBlock) {
        _LSmartJiShiCellBlock(_model);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
