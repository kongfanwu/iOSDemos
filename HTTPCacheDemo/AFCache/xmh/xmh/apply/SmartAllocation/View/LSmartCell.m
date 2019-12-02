//
//  LSmartCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LSmartCell.h"
#import <YYWebImage/YYWebImage.h>
@implementation LSmartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btn1.layer.cornerRadius = 3;
    _btn1.layer.masksToBounds = YES;
    _btn1.layer.borderWidth = kBorderWidth;
    _btn1.layer.borderColor = kColorC.CGColor;
    _btn1.titleLabel.font = FONT_SIZE(13);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_btn1 addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setModel:(ZFUserModel *)model{
    _model = model;
    _lb1.text = [NSString stringWithFormat:@"姓名:%@",model.uname];
    _lb2.text = [NSString stringWithFormat:@"等级:%@",model.grade];
    _lb3.text = [NSString stringWithFormat:@"技师:%@",model.jis_name];
    _lb4.text = [NSString stringWithFormat:@"门店:%@",model.mdname];
    [_imgV yy_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholder:kDefaultJisImage];
}
- (void)click
{
    if (_LSmartCellBlock) {
        _LSmartCellBlock(_model);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
