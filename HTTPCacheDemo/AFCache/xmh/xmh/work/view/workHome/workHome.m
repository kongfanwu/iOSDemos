//
//  workHome.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/3.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "workHome.h"

@implementation workHome

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}
- (void)initSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    _lb1 =[[UILabel alloc]initWithFrame:CGRectMake(33, 13, SCREEN_WIDTH/2.0 -33*2, 20)];
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(17);
    [self addSubview:_lb1];
    
    _lb2 =[[UILabel alloc]initWithFrame:CGRectMake(_lb1.left, _lb1.bottom+12, 20, 20)];
    _lb2.textColor = kLabelText_Commen_Color_6;
    _lb2.font = FONT_SIZE(13);
    [self addSubview:_lb2];

    _lb3 =[[UILabel alloc]initWithFrame:CGRectMake(_lb1.left, _lb2.bottom+5, self.width - 20, 20)];
    _lb3.textColor = kLabelText_Commen_Color_6;
    _lb3.font = FONT_SIZE(13);
    [self addSubview:_lb3];

    _lb4 =[[UILabel alloc]initWithFrame:CGRectMake(_lb2.right+5, _lb2.top, self.width - 20, 50)];
    _lb4.textColor = kLabelText_Commen_Color_6;
    _lb4.font = FONT_BOLD_SIZE(13);
    [self addSubview:_lb4];

    _lb5 =[[UILabel alloc]initWithFrame:CGRectMake(_lb3.right+5, _lb3.top, self.width - 20, 50)];
    _lb5.textColor = kLabelText_Commen_Color_6;
    _lb5.font = FONT_BOLD_SIZE(20);
    [self addSubview:_lb5];
    
    _lb6 =[[UILabel alloc]initWithFrame:CGRectMake(_lb5.left, _lb5.top, 20, 20)];
    _lb6.textColor = kLabelText_Commen_Color_6;
    _lb6.font = FONT_SIZE(13);
    [self addSubview:_lb6];
    
    _lb7 =[[UILabel alloc]initWithFrame:CGRectMake(_lb5.right+3, _lb6.bottom+5, _lb6.width, 20)];
    _lb7.textColor = kLabelText_Commen_Color_6;
    _lb7.font = FONT_SIZE(20);
    [self addSubview:_lb7];
    
    _line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 89, SCREEN_WIDTH/2.0, 1)];
    _line1.backgroundColor = kBackgroundColor;
    [self addSubview:_line1];
    
    _line2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-1, 0, 1, 90)];
    _line2.backgroundColor = kBackgroundColor;
    [self addSubview:_line2];
    
}
- (void)reloadworkHome:(WorkTopModel *)model{
    _lb1.text = model.type;
//    _lb2.text = @"目标:";
//    _lb3.text = @"实际:";
//    _lb4.text =model.target;
    _lb5.text = model.actual?model.actual:@"无数据";
//    _lb6.text = @"元";
//    _lb7.text = @"元";
    
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(33, 13, SCREEN_WIDTH/2.0 -33*2, _lb1.height);
    
//    [_lb2 sizeToFit];
//    _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+8, _lb2.width, _lb2.height);
    
//    [_lb3 sizeToFit];
//    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+8, _lb3.width, _lb3.height);
//     _lb3.frame =CGRectMake(_lb1.left, _lb1.bottom+8, _lb3.width, _lb3.height);
    
//    [_lb4 sizeToFit];
//    _lb4.frame =CGRectMake(_lb2.right+5, _lb2.top, _lb4.width, _lb4.height);
    
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb1.left, _lb1.bottom+12, _lb5.width, _lb5.height);
    
//    [_lb6 sizeToFit];
//    _lb6.frame =CGRectMake(_lb4.right+3, _lb4.top, _lb6.width, _lb6.height);
    
    [_lb7 sizeToFit];
    _lb7.frame =CGRectMake(_lb5.right+3, _lb5.top, _lb7.width, _lb7.height);
}
@end
