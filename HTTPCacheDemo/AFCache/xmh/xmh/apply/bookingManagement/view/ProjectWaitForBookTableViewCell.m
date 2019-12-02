//
//  ProjectWaitForBookTableViewCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ProjectWaitForBookTableViewCell.h"
#import "DaiYuYueModel.h"
#import <YYWebImage/YYWebImage.h>
@implementation ProjectWaitForBookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imgV.layer.borderWidth = 0.25;
    _imgV.layer.cornerRadius = 3;
    _imgV.layer.masksToBounds = YES;
    
    _btn1.layer.borderWidth = 0.25;
    _btn1.layer.cornerRadius = 3;
    _btn1.layer.masksToBounds = YES;
    _btn1.layer.borderColor = kLabelText_Commen_Color_9.CGColor;
    [_btn1 addTarget:self action:@selector(modify:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)updateProjectWaitForBookTableViewCell:(DaiYuYueModel *)model{
    [_imgV yy_setImageWithURL:[NSURL URLWithString:model.user_headimgurl] placeholder:kDefaultCustomerImage];
    _lb1.text = [NSString stringWithFormat:@"顾客姓名:%@",model.user_name];
    _lb2.text = [NSString stringWithFormat:@"服务技师:%@",model.jis_name];
    _lb3.text = [NSString stringWithFormat:@"服务项目:%@",model.name];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)modify:(UIButton *)btn{
    if (_projectWaitForBookTableViewCellBlock) {
        _projectWaitForBookTableViewCellBlock(btn);
    }
}
@end
