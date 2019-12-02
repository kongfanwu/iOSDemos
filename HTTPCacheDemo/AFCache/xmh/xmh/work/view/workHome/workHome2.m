//
//  workHome2.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/3.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "workHome2.h"

@implementation workHome2

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
    _lb1 =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.width - 20, 20)];
    _lb1.textColor = kLabelText_Commen_Color_6;
    _lb1.font = FONT_SIZE(13);
    _lb1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lb1];
    
    _lb2 =[[UILabel alloc]initWithFrame:CGRectMake(10, _lb1.bottom+5, self.width - 20, 20)];
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_BOLD_SIZE(13);
    _lb2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lb2];
    
    
    _lb3 =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.width - 20, 20)];
    _lb3.textColor = kLabelText_Commen_Color_6;
    _lb3.font = FONT_SIZE(13);
    _lb3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lb3];
    
    _lb4 =[[UILabel alloc]initWithFrame:CGRectMake(10, _lb1.bottom+5, self.width - 20, 20)];
    _lb4.textColor = kLabelText_Commen_Color_3;
    _lb4.font = FONT_BOLD_SIZE(13);
    _lb4.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lb4];
    
    
    
    _lb5 =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.width - 20, 20)];
    _lb5.textColor = kLabelText_Commen_Color_6;
    _lb5.font = FONT_SIZE(13);
    _lb5.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lb5];
    
    _lb6 =[[UILabel alloc]initWithFrame:CGRectMake(10, _lb1.bottom+5, self.width - 20, 20)];
    _lb6.textColor = kLabelText_Commen_Color_3;
    _lb6.font = FONT_BOLD_SIZE(13);
    _lb6.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lb6];
}
- (void)reloadworkHome2:(WorkTodayModel *)model{
    _lb1.text = @"今日预约";
    _lb2.text = [NSString stringWithFormat:@"%ld",model.appo];
    
    _lb3.text = @"今日服务";
    _lb4.text = [NSString stringWithFormat:@"%ld",model.serv];
    
    _lb5.text = @"今日拓客";
    _lb6.text = [NSString stringWithFormat:@"%ld",model.toker];
    
    
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(0, 15, SCREEN_WIDTH/3.0, _lb1.height);
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(0, _lb1.bottom+10, SCREEN_WIDTH/3.0, _lb2.height);
    
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.right, 15, SCREEN_WIDTH/3.0, _lb3.height);
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb1.right, _lb3.bottom+10, SCREEN_WIDTH/3.0, _lb4.height);
    
    [_lb5 sizeToFit];
    _lb5.frame =CGRectMake(_lb3.right, 15, SCREEN_WIDTH/3.0, _lb5.height);
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(_lb3.right, _lb5.bottom+10, SCREEN_WIDTH/3.0, _lb6.height);
}
@end
