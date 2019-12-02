//
//  CustomerDetailCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerDetailCell.h"
#import "ZhangDanMingXiModel.h"
@implementation CustomerDetailCell

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
    
    _lb5.textColor = kLabelText_Commen_Color_3;
    _lb5.font = FONT_SIZE(15);
    _lb6.textColor = kLabelText_Commen_Color_9;
    _lb6.font = FONT_SIZE(13);
    _lb7.textColor = kLabelText_Commen_Color_9;
    _lb7.font = FONT_SIZE(13);
    _lb8.textColor = kLabelText_Commen_Color_9;
    _lb8.font = FONT_SIZE(13);
    
    _lb9.textColor = kLabelText_Commen_Color_9;
    _lb9.font = FONT_SIZE(11);
    _lb10.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    _lb10.font = FONT_SIZE(15);
    
    _line1.backgroundColor = kBackgroundColor;
}
- (void)reFreshCustomerDetailCell:(ZhangDanMingXiModel*)model{
    _lb1.text = @"总负债:";
    _lb2.text = @"月均做项目数:";
    _lb3.text = @"月均耗卡单价:";
    _lb4.text = @"月到店次数";
    
    _lb5.text = [NSString stringWithFormat:@"%@ 元",model.zfz?model.zfz:@""];
    _lb6.text = [NSString stringWithFormat:@"%.1f 个",model.yjzxms?model.yjzxms:0];
    _lb7.text = [NSString stringWithFormat:@"%.1f 元",model.yjhkdj?model.yjhkdj:0];;
    _lb8.text = [NSString stringWithFormat:@"%.1f 次",model.yddpc?model.yddpc:0];
    
    _lb9.text = @"预计总消耗周期";
    _lb10.text = [NSString stringWithFormat:@"%@~%.0f 天",model.min?model.min:@"",model.sum?model.sum:0];
    
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(15, 15, _lb1.width, _lb1.height);
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+10, _lb2.width, _lb2.height);
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+10, _lb3.width, _lb3.height);
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb1.left, _lb3.bottom+10, _lb4.width, _lb4.height);
    
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb1.right+5, _lb1.top, _lb5.width, _lb5.height);
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(_lb2.right+5, _lb2.top, _lb6.width, _lb6.height);
    [_lb7 sizeToFit];
    _lb7.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb7.width+10, _lb7.height);
    [_lb8 sizeToFit];
    _lb8.frame =CGRectMake(_lb4.right+5, _lb4.top, _lb8.width, _lb8.height);
    
    [_lb9 sizeToFit];
    _lb9.frame =CGRectMake(SCREEN_WIDTH - _lb9.width-15, _lb1.top, _lb9.width, _lb1.height);
    [_lb10 sizeToFit];
    _lb10.frame =CGRectMake(SCREEN_WIDTH - _lb10.width-15, _lb9.bottom+10, _lb10.width, _lb10.height);
    
    _line1.frame = CGRectMake(0, _lb4.bottom+15, SCREEN_WIDTH, 1);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
