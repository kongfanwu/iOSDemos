//
//  DateHeaderView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "DateHeaderView.h"

@implementation DateHeaderView
{
    UILabel * _lb;               //日期
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews{
    
    _lb = [[UILabel alloc] init];
    _lb.font = FONT_SIZE(13);
    _lb.textColor = kLabelText_Commen_Color_6;
    _lb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lb];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setImage:[UIImage imageNamed:@"gengduo"] forState:UIControlStateNormal];
    _btn.frame = CGRectMake(SCREEN_WIDTH - 15 - 8, (self.height - 15)/2, 8, 15);
    [self addSubview:_btn];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//    [self addGestureRecognizer:tap];
    
    // 获取日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    
    NSCalendar * gregorian =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [gregorian components: unitFlags fromDate:[NSDate date]];
    _startDate = [NSString stringWithFormat:@"%ld-%02ld-01",(long)comp.year,(long)comp.month];
    _endDate = [dateFormatter stringFromDate:[NSDate date]];
    
    _lb.text = [[_startDate stringByAppendingString:@"一"] stringByAppendingString:_endDate];
    [_lb sizeToFit];
    _lb.frame = CGRectMake((SCREEN_WIDTH - _lb.width)/2, (44 - _lb.height)/2, _lb.width, _lb.height);
    
}

- (void)updateDateHeaderViewStartDate:(NSString *)start end:(NSString *)end{
   
    _lb.text = [NSString stringWithFormat:@"%@-%@",start,end];
    // @"2017年10月11日-2017年10月11日";
    [_lb sizeToFit];
    _lb.frame = CGRectMake((SCREEN_WIDTH - _lb.width)/2, (44 - _lb.height)/2, _lb.width, _lb.height);
    
}
- (void)updateDateHeaderView{
//    _lb.text = @"2017年10月11日-2017年10月11日";
//    [_lb sizeToFit];
//    _lb.center = self.center;
}

//- (void)tap{
//    if (_dateHeaderViewBlock) {
//
//        _dateHeaderViewBlock();
//    }
//
//}
@end
