//
//  CustomerDetailCell1.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerDetailCell1.h"

@implementation CustomerDetailCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    _lb2.textColor = kLabelText_Commen_Color_9;
    _lb2.font = FONT_SIZE(13);
    _lb3.textColor = kLabelText_Commen_Color_9;
    _lb3.font = FONT_SIZE(13);
    
    _lb4.textColor = kLabelText_Commen_Color_9;
    _lb4.font = FONT_SIZE(13);
    _lb5.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    _lb5.font = FONT_SIZE(17);
 
    _line1.backgroundColor = kBackgroundColor;
}
- (void)reFreshCustomerDetailCell1:(ZhangDanMingXiSubModel*)model{
    _lb1.text = model.name?model.name:@"";
    if ([model.money isEqualToString:@"-1"]) {
        _lb2.text = @"余次:";
        _lb3.text = model.num?model.num:@"";
    }else if ([model.num isEqualToString:@"-1"]){
        _lb2.text = @"余额:";
        _lb3.text = model.money?model.money:@"";
    }
    
    
    _lb4.text = @"预计消耗周期";
    _lb5.text =[NSString stringWithFormat:@"%@ 天",model.yjxhzq?model.yjxhzq:@""];
 
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(15, 15, _lb1.width, _lb1.height);
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+10, _lb2.width, _lb2.height);
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb2.right+5, _lb2.top, _lb3.width, _lb3.height);
    
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(SCREEN_WIDTH - _lb4.width-15, _lb1.top, _lb4.width, _lb1.height);
    [_lb5 sizeToFit];
    _lb5.frame =CGRectMake(SCREEN_WIDTH - _lb5.width-15, _lb4.bottom+10, _lb5.width, _lb5.height);
    _line1.frame = CGRectMake(0, _lb3.bottom+15, SCREEN_WIDTH, 1);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
