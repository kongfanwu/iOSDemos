//
//  LFreezeCell1.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LFreezeCell1.h"
#import "LSponsorApproceModel.h"
@implementation LFreezeCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = kColorF5F5F5;
    self.contentView.backgroundColor = kColorF5F5F5;

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
