//
//  LDealDaiFaHuoCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LDeatailDaiFaHuoCell.h"
#import "RolesTools.h"
@implementation LDeatailDaiFaHuoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btnSend.layer.cornerRadius = 2;
    _btnSend.layer.masksToBounds = YES;
    [_btnSend addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(OOrderModel *)model
{
    _model = model;
    _lbCode.text = [NSString stringWithFormat:@"订单编号：%@",model.ordernum];
    _lb1.text = model.create;
    _lb2.text = model.name;
    _lb3.text = model.num;
    _lb4.text = model.pay_type;
    _lb5.text = model.user_name;
    _lb6.text = model.mobile;
    _lb7.text = model.amount;
    NSString * state= @"";
    if (model.type.integerValue ==2) {
        state = @"待发放";
        _lbState.textColor = [ColorTools colorWithHexString:@"@F3B337"];
    }else if (model.type.integerValue ==4){
        state = @"已完成";
        _lbState.textColor = kLabelText_Commen_Color_9;
    }else{}
    _lbState.text = state;
    if ([RolesTools getUserMainRole] == RoleTypeDaoGou) {
        _btnSend.hidden = NO;
    }else{
        _btnSend.hidden = YES;
    }
}
- (void)click
{
    if (_LDeatailDaiFaHuoCellBlock) {
        _LDeatailDaiFaHuoCellBlock(_model);
    }
}
@end
