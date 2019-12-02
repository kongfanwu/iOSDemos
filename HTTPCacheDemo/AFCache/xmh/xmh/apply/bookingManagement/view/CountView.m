//
//  CountView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CountView.h"
#import "LolCalendarModelList.h"
@implementation CountView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
    
    [self initSubViews];
}
- (void)initSubViews{
    
    UILabel *lb0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lb0.backgroundColor = kBackgroundColor;
//    [self addSubview:lb0];
    
    _lb1 = [[UILabel alloc] init];
    _lb1.font = FONT_SIZE(14);
    _lb1.textColor = kLabelText_Commen_Color_6;
    [self addSubview:_lb1];
    
    _lb2 = [[UILabel alloc] init];
    _lb2.font = FONT_SIZE(14);
    _lb2.textColor = kLabelText_Commen_Color_6;
    [self addSubview:_lb2];
    
    _lb3 = [[UILabel alloc] init];
    _lb3.font = FONT_SIZE(14);
    _lb3.textColor = kLabelText_Commen_Color_6;
    [self addSubview:_lb3];
    
    _lb4 = [[UILabel alloc] init];
    _lb4.font = FONT_SIZE(14);
    _lb4.textColor = kLabelText_Commen_Color_6;
    [self addSubview:_lb4];
    
    _lb5 = [[UILabel alloc] init];
    _lb5.font = FONT_SIZE(14);
    _lb5.textColor = kLabelText_Commen_Color_6;
    [self addSubview:_lb5];
    
    _lb6 = [[UILabel alloc] init];
    _lb6.font = FONT_SIZE(14);
    _lb6.textColor = kLabelText_Commen_Color_6;
    [self addSubview:_lb6];
    
    _line = [[UILabel alloc] init];
    _line.backgroundColor = kBackgroundColor;
    [self addSubview:_line];
    
}
- (void)updateCountView{
    
    _lb1.text = @"选择日期";
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake(15, 15, _lb1.width, _lb1.height);
    
    _lb2.text = @"预约服务人数:30";
    [_lb2 sizeToFit];
    _lb2.frame = CGRectMake(_lb1.left, _lb1.bottom + 10, _lb2.width, _lb2.height);
    
    _lb3.text = @"预约服务项目:600";
    [_lb3 sizeToFit];
    _lb3.frame = CGRectMake(_lb1.left, _lb2.bottom + 10, _lb3.width, _lb3.height);
    
    _lb4.text = @"达标率:50%";
    [_lb4 sizeToFit];
    _lb4.frame = CGRectMake(_lb1.left, _lb3.bottom + 10, _lb4.width, _lb4.height);
    
    _lb5.text = @"预约服务人次:150";
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb2.right + 40, _lb1.bottom + 10, _lb5.width, _lb5.height);
    
    _lb6.text = @"达标天数";
    [_lb6 sizeToFit];
    _lb6.frame = CGRectMake(_lb5.left, _lb5.bottom + 10, _lb6.width, _lb6.height);
    
    _line.frame = CGRectMake(0, _lb6.bottom + 15, SCREEN_WIDTH , 0);
    
}
- (void)updateCountViewCalendarModelList:(LolCalendarModelList *)model{
    NSMutableString * datestr = [[NSMutableString alloc] init];
    NSArray * arr = [model.date componentsSeparatedByString:@"-"];
    if (arr.count > 0) {
        [datestr appendString:[NSString stringWithFormat:@"%@年",arr[0]]];
        [datestr appendString:[NSString stringWithFormat:@"%@月",arr[1]]];
    }
    if (model.selectDate) {
        _lb1.text = [NSString stringWithFormat:@"选择日期:%@",model.selectDate];
    }else{
       _lb1.text = [NSString stringWithFormat:@"选择日期:%@",datestr];
    }
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake(15, 15, _lb1.width, _lb1.height);
    
    _lb2.text = [NSString stringWithFormat:@"预约服务人数:%ld",(long)model.num];
    [_lb2 sizeToFit];
    _lb2.frame = CGRectMake(_lb1.left, _lb1.bottom + 10, _lb2.width, _lb2.height);
    
    _lb3.text = [NSString stringWithFormat:@"预约服务项目:%ld",(long)model.pro_num];
    [_lb3 sizeToFit];
    _lb3.frame = CGRectMake(_lb1.left, _lb2.bottom + 10, _lb3.width, _lb3.height);
    
    _lb4.text = [NSString stringWithFormat:@"达标率:%@",model.probability?model.probability:@"0"];
    [_lb4 sizeToFit];
    _lb4.frame = CGRectMake(_lb1.left, _lb3.bottom + 10, _lb4.width, _lb4.height);
    _lb5.text = [NSString stringWithFormat:@"预约服务人次:%ld",(long)model.serv_num];
    [_lb5 sizeToFit];
//    _lb5.frame = CGRectMake(_lb2.right + 40, _lb1.bottom + 10, _lb5.width, _lb5.height);
    _line.frame = CGRectMake(0, _lb4.bottom + 15, SCREEN_WIDTH, 10);
    _lb6.text = [NSString stringWithFormat:@"达标天数:%ld",(long)model.standard];

    if (model.isShowProbability) {
        _lb4.hidden = NO;
        _lb6.hidden = NO;
        _lb5.frame = CGRectMake(_lb2.right + 40, _lb1.bottom + 10, _lb5.width, _lb5.height);
    }else{
        _lb4.hidden = YES;
        _lb6.hidden = YES;
        _lb5.frame = CGRectMake(_lb1.left, _lb3.bottom + 10, _lb5.width, _lb5.height);
        _line.frame = CGRectMake(0, _lb5.bottom + 15, SCREEN_WIDTH, 10);
    }
    [_lb6 sizeToFit];
    _lb6.frame = CGRectMake(_lb5.left, _lb5.bottom + 10, _lb6.width, _lb6.height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
