//
//  CustomerDetailHeader.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerDetailHeader.h"
#import <YYWebImage/YYWebImage.h>
@implementation CustomerDetailHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    _line1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    _line1.backgroundColor = kBackgroundColor;
    
    _im1.frame = CGRectMake(15, 25, 57, 57);
    _line2.frame = CGRectMake(0, _im1.bottom+20, SCREEN_WIDTH, 10);
    _line2.backgroundColor = kBackgroundColor;
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    _lb2.textColor = kLabelText_Commen_Color_9;
    _lb2.font = FONT_SIZE(13);
    _lb3.textColor = kLabelText_Commen_Color_9;
    _lb3.font = FONT_SIZE(13);
    
    
    _lb4.textColor = kLabelText_Commen_Color_3;
    _lb4.font = FONT_SIZE(15);
    _lb5.textColor = kLabelText_Commen_Color_9;
    _lb5.font = FONT_SIZE(13);
    _lb6.textColor = kLabelText_Commen_Color_9;
    _lb6.font = FONT_SIZE(13);
    
    _lb7.textColor = kBtn_Commen_Color;
    _lb7.font = FONT_SIZE(13);
    _lb7.layer.borderColor = [kBtn_Commen_Color CGColor];
    _lb7.layer.borderWidth = 1;
    _lb7.layer.cornerRadius = 3;
    _lb7.textAlignment = NSTextAlignmentCenter;
}
- (void)reFreshCustomerDetailHeader:(CustomerMessageModel*)info{
    _lb1.text = @"姓名:";
    _lb2.text = @"门店:";
    _lb3.text = @"技师:";
    [_im1 yy_setImageWithURL:[NSURL URLWithString:info.headimgurl] placeholder:kDefaultJisImage];
    _lb4.text = info.uname?info.uname:@"";
    _lb5.text = info.mdname?info.mdname:@"";
    _lb6.text = info.jis_name?info.jis_name:@"";
    _lb7.text = info.grade;
    
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(_im1.right+10, _im1.top, _lb1.width, _lb1.height);
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+10, _lb2.width, _lb2.height);
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+10, _lb3.width, _lb3.height);
    
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb1.right+5, _lb1.top, _lb4.width, _lb4.height);
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb2.right+5, _lb2.top, _lb5.width, _lb5.height);
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb6.width, _lb6.height);
    
    [_lb7 sizeToFit];
    _lb7.frame =CGRectMake(_lb4.right+5, _lb4.top, _lb7.width+10, _lb1.height);
}
@end
