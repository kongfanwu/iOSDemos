//
//  YiGouZhiHuanFuckHeader.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/10.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "YiGouZhiHuanFuckHeader.h"

@implementation YiGouZhiHuanFuckHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat avgWidth = SCREEN_WIDTH/4.0;
    
    self.backgroundColor = [UIColor whiteColor];
    
    _im1.frame = CGRectMake(avgWidth - 17, 8, 15, 15);
    _im1.layer.cornerRadius = 17/2.0;
    _im1.backgroundColor = kIm_Background_Color_c;
    
    _im2.frame = CGRectMake(avgWidth*2.0 - 17, 8, 15, 15);
    _im2.layer.cornerRadius = 17/2.0;
    _im2.backgroundColor = kIm_Background_Color_c;
    
    _im3.frame = CGRectMake(avgWidth*3.0 - 17, 8, 15, 15);
    _im3.layer.cornerRadius = 17/2.0;
    _im3.backgroundColor = kIm_Background_Color_c;
    

    
    _line1.frame = CGRectMake(_im1.right, _im1.center.y, _im2.left - _im1.right, 1);
    _line1.backgroundColor = kIm_Background_Color_c;
    
    _line2.frame = CGRectMake(_im2.right, _im2.center.y, _im3.left - _im2.right, 1);
    _line2.backgroundColor = kIm_Background_Color_c;
    
 
    
    _lb1.text = @"内容回收";
    _lb2.text = @"置换选择";
    _lb3.text = @"凭证移交";
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(13);
    
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(13);
    
    _lb3.textColor = kLabelText_Commen_Color_3;
    _lb3.font = FONT_SIZE(13);
    
  
    
    [_lb1 sizeToFit];
    _lb1.center = CGPointMake(_im1.center.x, _im1.bottom+15);
    
    [_lb2 sizeToFit];
    _lb2.center = CGPointMake(_im2.center.x, _lb1.center.y);
    
    [_lb3 sizeToFit];
    _lb3.center = CGPointMake(_im3.center.x, _lb1.center.y);

}


- (void)YiGouZhiHuanFuckHeader:(NSInteger)stepValue{
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

        default:
            break;
    }
}
@end
