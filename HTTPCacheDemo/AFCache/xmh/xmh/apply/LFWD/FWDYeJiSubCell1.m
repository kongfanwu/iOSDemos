//
//  FWDYeJiSubCell1.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FWDYeJiSubCell1.h"

@implementation FWDYeJiSubCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tf.placeholder = @"请输入";
    _tf.delegate = self;
    _tf.keyboardType = UIKeyboardTypeDefault;
    [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel:(MLJiShiModel *)model
{
    _model = model;
    _lb1.text = model.name;
    _btn.hidden = YES;
    if (model.bfb == 0.00) {
        _tf.text = [NSString stringWithFormat:@"%.0f",model.bfb];
    }else{
        _tf.text = [NSString stringWithFormat:@"%.2f",model.bfb];
    }
    model.bfb =[_tf.text floatValue];
}
- (void)click
{
    if (_FWDYeJiSubCellDelBlock) {
        _FWDYeJiSubCellDelBlock(_model);
    }
}
@end
