//
//  BookReachView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookReachView.h"

@implementation BookReachView
{
    
    NSArray * _colors;
    NSArray * _titles;
}
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
       
        _colors = @[RGBColor(72, 194, 175),RGBColor(248, 111, 92),RGBColor(153, 153, 153)];
        _titles = @[@"达标",@"不达标",@"休息"];
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews{
    
    for (int i = 0; i< 3; i++) {
        
        UILabel * lb1 = [[UILabel alloc] init];
        lb1.backgroundColor = _colors[i];
        lb1.frame = CGRectMake(110 + i * 60, 18, 10, 10);
        if(i ==2){
          lb1.frame = CGRectMake(120 + i * 60, 18, 10, 10);
        }
        lb1.layer.cornerRadius = 5;
        lb1.layer.masksToBounds = YES;
        [self addSubview:lb1];
        
        UILabel *lb2 = [[UILabel alloc] init];
        lb2.font = FONT_SIZE(13);
        lb2.textColor = kLabelText_Commen_Color_3;
        lb2.text = _titles[i];
        [lb2 sizeToFit];
        lb2.frame = CGRectMake(lb1.right + 10, 15, lb2.width, lb2.height);
        [self addSubview:lb2];
        
    }
    
}
@end
