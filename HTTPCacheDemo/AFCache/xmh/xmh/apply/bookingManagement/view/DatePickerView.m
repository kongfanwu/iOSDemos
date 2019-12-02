//
//  DatePickerView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/23.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "DatePickerView.h"
#import "DateView.h"
@interface DatePickerView ()
@property (nonatomic ,copy)NSString *startTime;
@property (nonatomic ,copy)NSString *endTime;
@end
@implementation DatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        [self initBlackGroundView];
        [self initSubViews];
    }
    return self;
}
- (void)initBlackGroundView{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    view.backgroundColor = [UIColor darkGrayColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [view addGestureRecognizer:tap];
    view.alpha = 0.7;
    [self addSubview:view];
    
}
- (void)tap{
    
    [self hidenDatePickerView];
    
}
- (void)showDatePickerView{
    
    self.hidden = NO;
}

- (void)hidenDatePickerView{
    self.hidden = YES;
}
- (void)initSubViews{
    
    UIView * container = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 285, SCREEN_WIDTH, 285)];
    container.backgroundColor = [UIColor whiteColor];
    [self addSubview:container];
    
    UIView * nav = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, 50)];
    [container addSubview:nav];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.font = FONT_SIZE(13);
    lb.textColor = kLabelText_Commen_Color_3;
    lb.textAlignment = NSTextAlignmentLeft;
    lb.text = @"请选择";
    [lb sizeToFit];
    lb.frame = CGRectMake(15, 15, lb.width, lb.height);
    [nav addSubview:lb];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
    btn1.titleLabel.font = FONT_SIZE(13);
    _btnCancel = btn1;
    [nav addSubview:btn1];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btn2 setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    btn2.titleLabel.font = FONT_SIZE(13);
    _btnSure = btn2;
    [nav addSubview:btn2];
    
    btn2.frame = CGRectMake(SCREEN_WIDTH - 15-30, (50 - 20)/2, 30, 20);

    btn1.frame = CGRectMake(btn2.left - 30-30, (50 - 20)/2, 30, 20);

    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = kBackgroundColor ;
    line.frame = CGRectMake(0, nav.height - 1 , SCREEN_WIDTH, 2);
    [nav addSubview:line];
    if (!_simple) {
        DateView *date1 = [[DateView alloc] initWithFrame:CGRectMake(0, line.bottom, SCREEN_WIDTH/2, container.height - 50) title:@"起始时间"];
        _dateLeft =date1;
        [container addSubview:date1];
        
        DateView *date2 = [[DateView alloc] initWithFrame:CGRectMake(date1.right, 50, SCREEN_WIDTH/2, container.height - 50) title:@"结束时间"];
        _dateRight = date2;
        [container addSubview:date2];
    }else{
        DateView *date1 = [[DateView alloc] initWithFrame:CGRectMake(10, line.bottom, SCREEN_WIDTH - 20, container.height - 50) title:@"起始时间"];
        _dateLeft = date1;
        [container addSubview:date1];
    }
    
//    if (_DatePickerViewBlcok) {
//        
//        _DatePickerViewBlcok([NSString stringWithFormat:@"%@",_dateLeft.selectDateStr],[NSString stringWithFormat:@"%@",_dateRight.selectDateStr]);
//    }
   
}
- (void)setSimple:(BOOL)simple{
    _simple = simple;
    [self.subviews respondsToSelector:@selector(removeFromSuperview)];
    [self initSubViews];
}
- (void)cancelBtn{
     [self hidenDatePickerView];
}

- (void)sure{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年-MM月-dd日"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDate * left = [dateFormatter dateFromString:_dateLeft.selectDateStr];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    dateFormatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    _dateLeft.selectDateStr = [dateFormatter1 stringFromDate:left];
    if (![_dateLeft.selectDateStr isEqualToString:@""] && _dateLeft.selectDateStr) {
        _startTime = _dateLeft.selectDateStr;
    }
    
    
    NSDate * right = [dateFormatter dateFromString:_dateRight.selectDateStr];
    _dateRight.selectDateStr = [dateFormatter1 stringFromDate:right];
    
    if (![_dateRight.selectDateStr isEqualToString:@""] && _dateRight.selectDateStr) {
        _endTime = _dateRight.selectDateStr;
    }
    
    
    if (_DatePickerViewBlcok) {
        
        _DatePickerViewBlcok([NSString stringWithFormat:@"%@",_dateLeft.selectDateStr?_dateLeft.selectDateStr:_startTime],[NSString stringWithFormat:@"%@",_dateRight.selectDateStr?_dateRight.selectDateStr:_endTime]);
    }
    [self hidenDatePickerView];
}

@end
