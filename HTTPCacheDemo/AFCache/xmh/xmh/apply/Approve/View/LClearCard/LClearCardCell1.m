//
//  LClearCardCell1.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LClearCardCell1.h"
#import "LSponsorApproceModel.h"
#import "LClearCardCell1Model.h"
@interface LClearCardCell1 ()<UITextFieldDelegate>

@end

@implementation LClearCardCell1
{
    LClearCardCell1Model * _modelsubmit;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _btn.layer.cornerRadius = 3;
    [_btn addTarget:self action:@selector(createClick) forControlEvents:UIControlEventTouchUpInside];
    _tf1.delegate = self;
    _tf2.delegate = self;
    _tf3.delegate = self;
    _tf4.delegate = self;
    // Initialization code
    LClearCardCell1Model * model = [[LClearCardCell1Model alloc] init];
    _modelsubmit = model;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(LSponsorApproceModel *)model
{
    _model = model;
    _lb1.text = [NSString stringWithFormat:@"%ld元",model.user_surplus];
    _lb2.text = [NSString stringWithFormat:@"%ld元",model.pre_surplus];
    _lb3.text = [NSString stringWithFormat:@"%ld元",model.user_freeze];
    _modelsubmit.remainder = [NSString stringWithFormat:@"%ld",model.user_surplus];
    _modelsubmit.pres_money = [NSString stringWithFormat:@"%ld",model.pre_surplus];
    _modelsubmit.freeze = [NSString stringWithFormat:@"%ld",model.user_freeze];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:_tf1]) {
        _modelsubmit.timeCard_remainder = textField.text;
    }else if ([textField isEqual:_tf2]){
        _modelsubmit.goods_remainder = textField.text;
    }else if ([textField isEqual:_tf3]){
        _modelsubmit.ticket_remainder = textField.text;
    }else if ([textField isEqual:_tf4]){
        _modelsubmit.actual = textField.text;
        if (_LClearCardCell1Block) {
            _LClearCardCell1Block(_modelsubmit);
        }
    }
}
- (void)createClick
{
    [_tf3 resignFirstResponder];
    [_tf2 resignFirstResponder];
    [_tf1 resignFirstResponder];
    _lb4.text = [NSString stringWithFormat:@"%.2f",_modelsubmit.timeCard_remainder.floatValue + _modelsubmit.goods_remainder.floatValue + _modelsubmit.ticket_remainder.floatValue + _modelsubmit.remainder.floatValue + _modelsubmit.pres_money.floatValue + _modelsubmit.freeze.floatValue];
    _modelsubmit.total = _lb4.text;
}
@end
