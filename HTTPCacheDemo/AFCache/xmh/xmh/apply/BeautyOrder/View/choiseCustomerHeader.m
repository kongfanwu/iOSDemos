//
//  choiseCustomerHeader.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "choiseCustomerHeader.h"

@implementation choiseCustomerHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat avgWidth = SCREEN_WIDTH/5.0;
    
    _backView.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 69);
    _backView.layer.cornerRadius = 5;
    _backView.layer.shadowRadius = 10;
    _backView.layer.shadowColor = kLabelText_Commen_Color_9.CGColor;
    _backView.layer.shadowOpacity = 0.5;
    
    self.backgroundColor = [UIColor whiteColor];
    _lineTop.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    _lineTop.backgroundColor = kBackgroundColor;
    _lineTop.hidden = YES;
    
    _im1.frame = CGRectMake(avgWidth - 17, 25, 17, 17);
    _im1.layer.cornerRadius = 17/2.0;
    _im1.backgroundColor = kIm_Background_Color_c;
    
    _im2.frame = CGRectMake(avgWidth*2.0 - 17, 25, 17, 17);
    _im2.layer.cornerRadius = 17/2.0;
    _im2.backgroundColor = kIm_Background_Color_c;
    
    _im3.frame = CGRectMake(avgWidth*3.0 - 17, 25, 17, 17);
    _im3.layer.cornerRadius = 17/2.0;
    _im3.backgroundColor = kIm_Background_Color_c;
    
    _im4.frame = CGRectMake(avgWidth*4.0 - 17, 25, 17, 17);
    _im4.layer.cornerRadius = 17/2.0;
    _im4.backgroundColor = kIm_Background_Color_c;
    
    
    _line1.frame = CGRectMake(_im1.right, _im1.center.y, _im2.left - _im1.right, 1);
    _line1.backgroundColor = kIm_Background_Color_c;
    
    _line2.frame = CGRectMake(_im2.right, _im2.center.y, _im3.left - _im2.right, 1);
    _line2.backgroundColor = kIm_Background_Color_c;
    
    _line3.frame = CGRectMake(_im3.right, _im3.center.y, _im4.left - _im3.right, 1);
    _line3.backgroundColor = kIm_Background_Color_c;
    
    _lb1.text = @"选择顾客";
    _lb2.text = @"美丽问诊";
    _lb3.text = @"选择卡项";
    _lb4.text = @"美丽定制";
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(13);
    
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(13);
    
    _lb3.textColor = kLabelText_Commen_Color_3;
    _lb3.font = FONT_SIZE(13);
    
    _lb4.textColor = kLabelText_Commen_Color_3;
    _lb4.font = FONT_SIZE(13);
    
    [_lb1 sizeToFit];
    _lb1.center = CGPointMake(_im1.center.x, _im1.bottom+15);
    
    [_lb2 sizeToFit];
    _lb2.center = CGPointMake(_im2.center.x, _lb1.center.y);

    [_lb3 sizeToFit];
    _lb3.center = CGPointMake(_im3.center.x, _lb1.center.y);

    [_lb4 sizeToFit];
    _lb4.center = CGPointMake(_im4.center.x, _lb1.center.y);
    
    _lineDown.frame = CGRectMake(0, 110 - 15, SCREEN_WIDTH, 10);
    _lineDown.backgroundColor = kBackgroundColor;
}

- (void)reFreshchoiseCustomerHeader:(NSInteger)stepValue{
    switch (stepValue) {
        case 1:
        {
            _im1.backgroundColor = kBtn_Commen_Color;
            _lb1.textColor = kBtn_Commen_Color;
        }
            break;
        case 2:
        {
            _im1.backgroundColor = kBtn_Commen_Color;
            _line1.backgroundColor = kBtn_Commen_Color;
            _im2.backgroundColor = kBtn_Commen_Color;
            _lb1.textColor = kBtn_Commen_Color;
            _lb2.textColor = kBtn_Commen_Color;

        }
            break;
        case 3:
        {
            _im1.backgroundColor = kBtn_Commen_Color;
            _line1.backgroundColor = kBtn_Commen_Color;
            _im2.backgroundColor = kBtn_Commen_Color;
            _line2.backgroundColor = kBtn_Commen_Color;
            _im3.backgroundColor = kBtn_Commen_Color;
            _lb1.textColor = kBtn_Commen_Color;
            _lb2.textColor = kBtn_Commen_Color;
            _lb3.textColor = kBtn_Commen_Color;
        }
            break;
        case 4:
        {
            _im1.backgroundColor = kBtn_Commen_Color;
            _line1.backgroundColor = kBtn_Commen_Color;
            _im2.backgroundColor = kBtn_Commen_Color;
            _line2.backgroundColor = kBtn_Commen_Color;
            _im3.backgroundColor = kBtn_Commen_Color;
            _line3.backgroundColor = kBtn_Commen_Color;
            _im4.backgroundColor = kBtn_Commen_Color;
            _lb1.textColor = kBtn_Commen_Color;
            _lb2.textColor = kBtn_Commen_Color;
            _lb3.textColor = kBtn_Commen_Color;
            _lb4.textColor = kBtn_Commen_Color;
        }
            break;
            
        default:
            break;
    }
}
@end
