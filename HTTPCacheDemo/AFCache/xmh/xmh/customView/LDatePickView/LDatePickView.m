//
//  LDatePickView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LDatePickView.h"
#import "DateView.h"
@implementation LDatePickView
{
    UILabel * _lbShow;
    UIView * _view;
    UIButton * _btnCancel;
    UIButton * _btnSure;
    DateView * _dateLeft;
    DateView * _dateRight;
    NSDateFormatter *_form1;
    NSDateFormatter *_form2;
    NSDateFormatter *_form3;
    UIView * _container;
    // 默认传参
    NSString *_startTime;
    NSString *_endTime;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSubViews];
        UITapGestureRecognizer *tapDown = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown)];
        [self addGestureRecognizer:tapDown];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame dateBlock:(LDatePickViewBlock)block
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        [self initSubViews];
        UITapGestureRecognizer *tapDown = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown)];
        [self addGestureRecognizer:tapDown];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        _form3 = dateFormatter;
        [dateFormatter setDateFormat:@"yyyy年-MM月-dd日"];
        block(_startParam,_endParam);
        _LDatePickViewBlock = block;
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame startTime:(NSString *)startTime endTime:(NSString *)endTime dateBlock:(LDatePickViewBlock)block
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        _startTime = startTime;
        _endTime = endTime;
        [self createShowLabel];
        [self setDefalutDate];
        UITapGestureRecognizer *tapDown = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown)];
        [self addGestureRecognizer:tapDown];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        _form3 = dateFormatter;
        [dateFormatter setDateFormat:@"yyyy年-MM月-dd日"];
        block(_startParam,_endParam);
        _LDatePickViewBlock = block;
        
    }
    return self;
}
- (void)initSubViews
{
    [self createShowLabel];
    [self getCurrentDate];
}

- (void)createShowLabel
{
    if (!_lbShow) {
        _lbShow = [[UILabel alloc] init];
        _lbShow.font = FONT_SIZE(13);
        _lbShow.textColor = kLabelText_Commen_Color_6;
//        _lbShow.backgroundColor = kColorTheme;
        [_lbShow sizeToFit];
        _lbShow.textAlignment = NSTextAlignmentCenter;
    }
    
//    [self addSubview:_lbShow];
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setImage:[UIImage imageNamed:@"st_gkglyoujiantou"] forState:UIControlStateNormal];
        _btn.frame = CGRectMake(_lbShow.right + 10, (self.height - 11)/2, 6, 11);
    }
    if (!_container) {
        _container = [[UIView alloc] init];
        CGFloat w  = 10 + _btn.width + _lbShow.width;
        _container.frame = CGRectMake((self.width - w)/2 , 0, w, self.height);
    }
//    _container.backgroundColor = [UIColor cyanColor];
    [_container addSubview:_lbShow];
    [_container addSubview:_btn];
//    [self addSubview:_btn];
    [self addSubview:_container];
}
- (void)getCurrentDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    _form1 = dateFormatter;
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    
    NSCalendar * gregorian =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [gregorian components: unitFlags fromDate:[NSDate date]];
    _startShow = [NSString stringWithFormat:@"%ld年%02ld月01日",(long)comp.year,(long)comp.month];
    _endShow = [dateFormatter stringFromDate:[NSDate date]];
    
//
    _lbShow.text = [[_endShow stringByAppendingString:@"一"] stringByAppendingString:_endShow];
//    _lbShow.text = _endShow;
    [_lbShow sizeToFit];
    _lbShow.frame = CGRectMake(0, (self.height - _lbShow.height)/2, _lbShow.width, _lbShow.height);
    _btn.frame = CGRectMake(_lbShow.right + 10, (self.height - 11)/2, 6, 11);
    CGFloat w  = 10 + _btn.width + _lbShow.width;
    _container.frame = CGRectMake((self.width - w)/2 , 0, w, self.height);
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    _form2 = dateFormatter1;
    dateFormatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    _endParam = [dateFormatter1 stringFromDate:[NSDate date]];
//    _startParam = [NSString stringWithFormat:@"%ld-%02ld-01",(long)comp.year,(long)comp.month];
    _startParam = _endParam;
    if (_LDatePickViewBlock) {
        _LDatePickViewBlock(_startParam,_endParam);
    }
}

- (void)setDefalutDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    _form1 = dateFormatter;
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSCalendar * gregorian =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [gregorian components: unitFlags fromDate:[dateFormatter1 dateFromString:_startTime]];
    _startShow = [NSString stringWithFormat:@"%ld年%02ld月%02ld日",(long)comp.year,(long)comp.month,(long)comp.day];
    _endShow = [dateFormatter stringFromDate:[dateFormatter1 dateFromString:_endTime]];
    
    //
    _lbShow.text = [[_startShow stringByAppendingString:@"一"] stringByAppendingString:_endShow];
    //    _lbShow.text = _endShow;
    [_lbShow sizeToFit];
    _lbShow.frame = CGRectMake(0, (self.height - _lbShow.height)/2, _lbShow.width, _lbShow.height);
    _btn.frame = CGRectMake(_lbShow.right + 10, (self.height - 11)/2, 6, 11);
    CGFloat w  = 10 + _btn.width + _lbShow.width;
    _container.frame = CGRectMake((self.width - w)/2 , 0, w, self.height);
  
    _form2 = dateFormatter1;
    dateFormatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    _endParam = [dateFormatter1 stringFromDate:[dateFormatter1 dateFromString:_endTime]];
    //    _startParam = [NSString stringWithFormat:@"%ld-%02ld-01",(long)comp.year,(long)comp.month];
    _startParam = [dateFormatter1 stringFromDate:[dateFormatter1 dateFromString:_startTime]];
    if (_LDatePickViewBlock) {
        _LDatePickViewBlock(_startParam,_endParam);
    }
}
- (void)createDataPickView
{
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _view = view;
    UIView * viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    viewbg.backgroundColor = [UIColor darkGrayColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [viewbg addGestureRecognizer:tap];
    viewbg.alpha = 0.7;
    [view addSubview:viewbg];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    UIView * container = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 285, SCREEN_WIDTH, 285)];
    container.backgroundColor = [UIColor whiteColor];
    [view addSubview:container];
    
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
    DateView *date1 = [[DateView alloc] initWithFrame:CGRectMake(0, line.bottom, SCREEN_WIDTH/2, container.height - 50) title:@"起始时间"];
    _dateLeft =date1;
    date1.setDate = [_form2 dateFromString:_startParam];
    [container addSubview:date1];
    
    DateView *date2 = [[DateView alloc] initWithFrame:CGRectMake(date1.right, 50, SCREEN_WIDTH/2, container.height - 50) title:@"结束时间"];
    _dateRight = date2;
    date2.setDate = [_form2 dateFromString:_endParam];
    [container addSubview:date2];
}
- (void)tap
{
    [_view removeFromSuperview];
    if (self.removeBlock) self.removeBlock(self);
}
- (void)tapDown
{
    [self createDataPickView];
}
- (void)cancelBtn
{
    [self tap];
}
- (void)sure
{
    NSDate * left = [_form3 dateFromString:_dateLeft.selectDateStr];
    NSDate * right = [_form3 dateFromString:_dateRight.selectDateStr];
    
    _startParam = [_form2 stringFromDate:left];
    _endParam = [_form2 stringFromDate:right];
    NSComparisonResult result = [left compare:right];
    if (result == NSOrderedDescending) {
        [XMHProgressHUD showOnlyText:@"开始时间不能大于结束时间"];
    }else{
        NSString * leftStr = [_form1 stringFromDate:[_form2 dateFromString:_startParam]];
        NSString * rightStr = [_form1 stringFromDate:[_form2 dateFromString:_endParam]];
        _lbShow.text = [[leftStr stringByAppendingString:@"一"] stringByAppendingString:rightStr];
        [_lbShow sizeToFit];
        _lbShow.frame = CGRectMake(0, (self.height - _lbShow.height)/2, _lbShow.width, _lbShow.height);
        _btn.frame = CGRectMake(_lbShow.right + 10, (self.height - 11)/2, 6, 11);
        CGFloat w  = 10 + _btn.width + _lbShow.width;
        _container.frame = CGRectMake((self.width - w)/2 , 0, w, self.height);
        if (_LDatePickViewBlock) {
            _LDatePickViewBlock(_startParam,_endParam);
        }
        [self tap];
    }
//    MzzLog(@"..........%@",_startParam);
//    MzzLog(@"..........%@",_endParam);
}

/**
 显示
 */
- (void)show {
    [self tapDown];
}
@end
