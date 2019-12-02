//
//  TJGuKeShouHouCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJGuKeShouHouCell.h"
#import <YYWebImage/YYWebImage.h>
@implementation TJGuKeShouHouCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btn.layer.cornerRadius = 2;
    _btn.layer.borderWidth = 0.5;
    _btn.layer.borderColor = kBtn_Commen_Color.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TJGuKeSubModel *)model
{
    [_imgV yy_setImageWithURL:[NSURL URLWithString:model.headimg] placeholder:kDefaultCustomerImage];
    _lb1.text = [NSString stringWithFormat:@"姓名：%@",model.name];
    _lb2.text = [NSString stringWithFormat:@"产值：%@",model.chanzhi];
    _lb3.text = [NSString stringWithFormat:@"产值：%@",model.pro_num];
    [_btn setTitle:model.grade_name forState:UIControlStateNormal];
}
@end
