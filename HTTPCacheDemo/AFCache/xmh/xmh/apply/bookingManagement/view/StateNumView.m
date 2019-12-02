//
//  StateNumView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "StateNumView.h"

@implementation StateNumView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)initSubViews{
    _lb1 = [[UILabel alloc] init];
    _lb1.font = FONT_SIZE(13);
    _lb1.textColor = kLabelText_Commen_Color_9;
    _lb1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lb1];
    
    _lb2 = [[UILabel alloc] init];
    _lb2.font = FONT_BOLD_SIZE(14);
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lb2];
    
    _line = [[UILabel alloc] init];
    _line.backgroundColor = kBackgroundColor;
    _line.frame = CGRectMake(0, self.height - 1, self.width, 1);
    [self addSubview:_line];
    
    _btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnMore setImage:[UIImage imageNamed:@"gengduo"] forState:UIControlStateNormal];
    _btnMore.frame = CGRectMake(SCREEN_WIDTH/2 - 15 - 8, (self.height - 15)/2, 8, 15);
    _btnMore.hidden = YES;
    [self addSubview:_btnMore];
    
    
    _line1 = [[UILabel alloc] init];
    _line1.backgroundColor = kBackgroundColor;
    _line1.frame = CGRectMake(self.width - 1, 8, 1, self.height - 8 *2);
    [self addSubview:_line1];
    
    
    
    
}
- (void)updateStateNumView{
//    _lb1.text = @"待预约";
    _lb2.text = @"999 人";
    
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake((self.width - _lb1.width)/2, 8, _lb1.width, _lb1.height);
    
    [_lb2 sizeToFit];
    _lb2.frame = CGRectMake((self.width - _lb2.width)/2, _lb1.bottom +4, _lb2.width, _lb2.height);
    
}
@end
