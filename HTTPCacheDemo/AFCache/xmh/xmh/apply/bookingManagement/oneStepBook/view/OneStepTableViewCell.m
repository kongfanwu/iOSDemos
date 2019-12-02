//
//  OneStepTableViewCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OneStepTableViewCell.h"
#import <YYWebImage/YYWebImage.h>
#import "YiYuYueModel.h"
@implementation OneStepTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btn1.layer.borderWidth = 0.25;
    _btn1.layer.cornerRadius = 3;
    _btn1.layer.masksToBounds = YES;
    
    _imgv.layer.borderWidth = 0.25;
    _imgv.layer.cornerRadius = 3;
    _imgv.layer.masksToBounds = YES;
    [_btn1 addTarget:self action:@selector(modify:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)updateOneStepTableViewCell:(YiYuYueModel *)model{
    [_imgv yy_setImageWithURL:[NSURL URLWithString:model.user_headimgurl] placeholder:kDefaultCustomerImage];
    _lb1.text = [NSString stringWithFormat:@"顾客姓名: %@",model.user_name];
    _lb2.text = [NSString stringWithFormat:@"服务技师:%@",model.jis_name];
    _lb3.text = [NSString stringWithFormat:@"处方名称:%@",model.pro_string];
    _lb4.text = [NSString stringWithFormat:@"预约时间:%@ %@",model.appo_data,model.appo_time];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)modify:(UIButton *)btn{
    if (_OneStepTableViewCellModifyBtnBlock) {
        _OneStepTableViewCellModifyBtnBlock(btn);
    }
}
@end
