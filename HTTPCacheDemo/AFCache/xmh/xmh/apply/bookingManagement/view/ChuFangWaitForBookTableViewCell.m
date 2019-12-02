//
//  ChuFangWaitForBookTableViewCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ChuFangWaitForBookTableViewCell.h"
#import "DaiYuYueModel.h"
#import <YYWebImage/YYWebImage.h>
@implementation ChuFangWaitForBookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imgV.layer.borderWidth = 0.25;
    _imgV.layer.cornerRadius = 3;
    _imgV.layer.masksToBounds = YES;
    
    _btn.layer.borderWidth = 0.25;
    _btn.layer.cornerRadius = 3;
    _btn.layer.masksToBounds = YES;
    _btn.layer.borderColor = kLabelText_Commen_Color_9.CGColor;
    [_btn addTarget:self action:@selector(modify:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateChuFangWaitForBookTableViewCell:(DaiYuYueModel *)model{
    [_imgV yy_setImageWithURL:[NSURL URLWithString:model.user_headimgurl] placeholder:kDefaultCustomerImage];
    _lb1.text = [NSString stringWithFormat:@"顾客姓名:%@",model.user_name];
    _lb2.text = [NSString stringWithFormat:@"服务技师:%@",model.jis_name];
    _lb3.text = [NSString stringWithFormat:@"服务项目:%@",model.name];
    _lb4.text = [NSString stringWithFormat:@"剩余次数:%ld/%ld",model.num - model.num1,model.num];
    _lb5.text = [NSString stringWithFormat:@"规划时间:%@",model.stime];
    
}
- (void)modify:(UIButton *)btn{
    if (_chuFangWaitForBookTableViewCellBlock) {
        _chuFangWaitForBookTableViewCellBlock(btn);
    }
}
@end
