//
//  CustomerDetailCell2.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerDetailCell2.h"

@implementation CustomerDetailCell2{
    GuKeChuFang *_model;
}

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
    _lb5.hidden = YES;
    _lb6.textColor = kLabelText_Commen_Color_9;
    _lb6.font = FONT_SIZE(13);
    _lb7.textColor = [ColorTools colorWithHexString:@"#f86f5c"];
    _lb7.font = FONT_SIZE(13);
    _lb8.textColor = kLabelText_Commen_Color_9;
    _lb8.font = FONT_SIZE(13);
    _lb9.textColor = kLabelText_Commen_Color_9;
    _lb9.font = FONT_SIZE(13);
    
    _lb10.textColor = [ColorTools colorWithHexString:@"#f86f5c"];
    _lb10.font = FONT_SIZE(13);
    
    [_btn1 setTitle:@"处方报告" forState:UIControlStateNormal];
    [_btn1 setTitle:@"处方报告" forState:UIControlStateHighlighted];
    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    _btn1.backgroundColor = kBtn_Commen_Color;
    _btn1.titleLabel.font = FONT_SIZE(13);
    _btn1.layer.cornerRadius = 3;
    CGSize titleSize = [@"处方报告" sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:_btn1.titleLabel.font.fontName size:_btn1.titleLabel.font.pointSize]}];
    float btnwidth = titleSize.width + 30;
    _btn1.frame = CGRectMake(SCREEN_WIDTH -btnwidth-15 ,0, btnwidth, 30);
    [_btn1 addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    _line1.backgroundColor = kBackgroundColor;
}
- (void)btnEvent:(UIButton *)sender{
    if (_CustomerDetailCell2Block) {
        _CustomerDetailCell2Block(_model);
    }
}
- (void)reFreshCustomerDetailCell2:(GuKeChuFang*)model{
    _model = model;
    _lb1.text = @"处方名称:";
    _lb2.text = @"预约技师:";
    _lb3.text = @"执行次数:";
    
    _lb1.text = model.name?model.name:@"";
    _lb6.text = model.jis_name?model.jis_name:@"";
    _lb7.text = [NSString stringWithFormat:@"%ld",model.num1];
    _lb8.text =[NSString stringWithFormat:@"/%ld",model.num];
    
    _lb9.text = model.time?model.time:@"";
    switch ([model.zt integerValue]) {
        case 1:
        {
            _lb10.text = @"进行中";
            _btn1.hidden = YES;
            _lb4.text = @"规划时间:";

        }
            break;
        case 2:
        {
            _lb10.text = @"已终止";
            _btn1.hidden = NO;
            _lb4.text = @"完成时间:";
        }
            break;
        case 3:
        {
            _lb10.text = @"已完成";
            _btn1.hidden = NO;
            _lb4.text = @"完成时间:";

        }
            break;
            
        default:
            break;
    }
    _lb10.textColor = [ColorTools colorCauseByText:_lb10.text];
    
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
    _lb7.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb7.width, _lb1.height);
    [_lb8 sizeToFit];
    _lb8.frame =CGRectMake(_lb7.right, _lb3.top, _lb8.width, _lb8.height);
    [_lb9 sizeToFit];
    _lb9.frame =CGRectMake(_lb4.right+5, _lb4.top, _lb9.width, _lb9.height);
    
    [_lb10 sizeToFit];
    _lb10.frame =CGRectMake(SCREEN_WIDTH - _lb10.width-15, 15, _lb10.width, _lb10.height);
    
    _line1.frame = CGRectMake(0, _lb4.bottom+15, SCREEN_WIDTH, 1);
    
    _btn1.frame = CGRectMake(_btn1.left ,_line1.top - _btn1.height-15, _btn1.width, 30);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
