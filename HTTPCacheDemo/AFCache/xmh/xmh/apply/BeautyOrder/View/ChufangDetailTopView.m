//
//  ChufangDetailTopView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ChufangDetailTopView.h"
#import <YYWebImage/YYWebImage.h>
@implementation ChufangDetailTopView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    
    _line1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    _line1.backgroundColor = [UIColor whiteColor];
    
    _im1.frame = CGRectMake(15, _line1.bottom+15, 57, 57);
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(13);
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(13);
    _lb3.textColor = kLabelText_Commen_Color_3;
    _lb3.font = FONT_SIZE(13);
    
    _lb1.text = @"姓名:";
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(_im1.right+10, _im1.top, _lb1.width, _lb1.height);
    
    _lb3.text = @"处方执行:";
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _im1.bottom - _lb3.height, _lb3.width, _lb3.height);
    
    _lb4.textColor = kBtn_Commen_Color;
    _lb4.font = FONT_SIZE(13);
    
    _lb5.textColor = kLabelText_Commen_Color_3;
    _lb5.font = FONT_SIZE(13);
    
    _line2.frame = CGRectMake(0, _im1.bottom+15, SCREEN_WIDTH, 10);
    _line2.backgroundColor = kBackgroundColor;
    
    _btn2.frame = CGRectMake(SCREEN_WIDTH - 15 - 64, _line2.top - 15-28, 64, 28);
    [_btn2 setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    _btn2.layer.borderWidth = 1;
    _btn2.layer.borderColor = [kBtn_Commen_Color CGColor];
    _btn2.layer.cornerRadius = 1;
    _btn2.titleLabel.font = FONT_SIZE(12);
    
    _btn1.frame = CGRectMake(_btn2.left - 15 - 64, _line2.top - 15-28, 64, 30);
    [_btn1 setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    _btn1.layer.borderWidth = 0.5;
    _btn1.layer.borderColor = [kBtn_Commen_Color CGColor];
    _btn1.titleLabel.font = FONT_SIZE(12);
    _btn1.layer.cornerRadius = 3;
}
- (void)freshChufangDetailTopView2:(NSString *)zt num1:(NSInteger )numl{
    if (numl == 0) {
        [_btn2 setTitle:@"删除" forState:UIControlStateNormal];
    } else {
        switch ([zt integerValue]) {
            case 1://进行中
            {
                [_btn2 setTitle:@"结束处方" forState:UIControlStateNormal];
            }
                break;
            case 2://已终止
            {
                _btn1.hidden = YES;
                [_btn2 setTitle:@"已终止" forState:UIControlStateNormal];
                _btn2.userInteractionEnabled = NO;
            }
                break;
            case 3://已完成
            {
                _btn1.hidden = YES;
                [_btn2 setTitle:@"已完成" forState:UIControlStateNormal];
                _btn2.userInteractionEnabled = NO;
            }
                break;
            default:
                break;
        }
    }
}
- (void)freshChufangDetailTopView:(NSString *)name img:(NSString *)img num:(NSString *)num num1:(NSString *)num1 zt:(NSString *)zt{
    
    [_im1 yy_setImageWithURL:[NSURL URLWithString:img] placeholder:kDefaultCustomerImage];
    
    _lb2.text = name;
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.right+5, _im1.top, _lb2.width, _lb2.height);
    
    _lb4.text = num1;
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb4.width, _lb4.height);
    _lb5.text = [NSString stringWithFormat:@"/%@",num];
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb4.right, _lb4.top, _lb5.width, _lb5.height);
}


@end
