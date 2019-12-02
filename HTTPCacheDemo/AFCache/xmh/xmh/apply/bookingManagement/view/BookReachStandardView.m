//
//  BookReachStandardView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/22.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookReachStandardView.h"

@implementation BookReachStandardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    
    [super setFrame: frame];
    [self initSubViews];
}
- (void)initSubViews{
    _lb1 = [[UILabel alloc] init];
    _lb1.font = FONT_BOLD_SIZE(13);
    _lb1.textColor = kLabelText_Commen_Color_3;
    [self addSubview:_lb1];
    
    _lb2 = [[UILabel alloc] init];
    _lb2.backgroundColor = [ColorTools colorWithHexString:@"#48c3af"];
    [self addSubview:_lb2];
    
    _lb3 = [[UILabel alloc] init];
    _lb3.font = FONT_SIZE(11);
    _lb3.textColor = kLabelText_Commen_Color_9;
    [self addSubview:_lb3];
    
    _lb4 = [[UILabel alloc] init];
    _lb4.backgroundColor = [ColorTools colorWithHexString:@"#f86f5c"];
    [self addSubview:_lb4];
    
    _lb5 = [[UILabel alloc] init];
    _lb5.font = FONT_SIZE(11);
    _lb5.textColor = kLabelText_Commen_Color_9;
    [self addSubview:_lb5];
    
    _lb6 = [[UILabel alloc] init];
    _lb6.backgroundColor = kBackgroundColor;
    _lb6.frame = CGRectMake(0, self.height- 10, SCREEN_WIDTH, 1);
//    [self addSubview:_lb6];
    
}
- (void)updateBookReachStandardView{
    _lb1.text = @"顾客预约服务次数/服务项目数";
    _lb3.text = @"达标";
    _lb5.text = @"不达标";
    
    
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake(15, 15, _lb1.width, _lb1.height);
    
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(SCREEN_WIDTH - _lb5.width - 30, _lb1.top, _lb5.width, _lb5.height);
    
    _lb4.frame = CGRectMake(_lb5.left - 10 - 5, _lb1.top, 10, 10);
    _lb4.layer.cornerRadius = 5;
    _lb4.layer.masksToBounds = YES;
    
    [_lb3 sizeToFit];
    _lb3.frame = CGRectMake(_lb4.left - 15 - _lb3.width, _lb1.top, _lb3.width, _lb3.height);
    
    _lb2.frame = CGRectMake(_lb3.left - 5- 10, _lb1.top, 10, 10);
    _lb2.layer.cornerRadius = 5;
    _lb2.layer.masksToBounds = YES;
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
