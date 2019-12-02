//
//  MzzFilterDatePickerCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/29.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzFilterDatePickerCell.h"

@implementation MzzFilterDatePickerCell
{
    NSArray * _titles;
    UILabel * _lb;
//    NSString * _startStr;
//    NSString * _endStr;
    BOOL _isStart;
    UIButton * _selectBtn;
    NSDateFormatter * _formatter;
    UIDatePicker * _picker;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"YYYY-MM-dd";
        _titles = @[@"起始时间",@"结束时间"];
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews
{
    for (int i = 0; i < 2; i ++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(98 + (50 + 16)*i, 25, 60, 13);
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
        [btn setTitleColor:kLabelText_Commen_Color_9 forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(13);
        if (i == 0) {
            [self click:btn];
        }
        [self addSubview:btn];
    }
    UILabel * lb = [[UILabel alloc] init];
    lb.frame = CGRectMake(98, 25 + 13 + 6, 60, 2);
    lb.backgroundColor= kBtn_Commen_Color;
    _lb = lb;
    [self addSubview:lb];
    UIDatePicker * picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 66, SCREEN_WIDTH, 110)];
    picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_ch"];
    if (_startStr.length > 0) {
        NSDate * date = [_formatter dateFromString:_startStr];
        [picker setDate:date];
    }
    [picker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    picker.datePickerMode = UIDatePickerModeDate;
    _picker = picker;
    [self addSubview:picker];
}
- (void)click:(UIButton *)btn
{
    _selectBtn.selected = NO;
    btn.selected = YES;
    _selectBtn = btn;
    CGRect frame = btn.frame;
    CGRect end = CGRectMake(frame.origin.x, frame.origin.y + 13 +6, 60, 2);
    _lb.frame = end;
    if ([btn.currentTitle isEqualToString:@"起始时间"]) {
        _isStart = YES;
        if (_startStr.length > 0) {
            [_picker setDate:[_formatter dateFromString:_startStr]];
        }
    }else{
        _isStart = NO;
        if (_endStr.length > 0) {
            [_picker setDate:[_formatter dateFromString:_endStr]];
        }
    }
}
- (void)dateChange:(UIDatePicker *)datePicker
{
    NSDate * date = datePicker.date;
    if (_isStart) {
        _startStr = [_formatter stringFromDate:date];
    }else{
        _endStr = [_formatter stringFromDate:date];
    }
    if (_startStr.length> 0 && _startStr.length > 0) {
        if (_MzzFilterDatePickerCellBlock) {
            _MzzFilterDatePickerCellBlock(_startStr, _endStr);
        }
    }
}
- (void)setStartStr:(NSString *)startStr
{
    _startStr = startStr;
    if (_isStart) {
        if (startStr.length > 0) {
            [_picker setDate:[_formatter dateFromString:startStr]];
        }
    }
   
}
- (void)setEndStr:(NSString *)endStr
{
    _endStr = endStr;
    if (!_isStart) {
        if (endStr.length > 0) {
            [_picker setDate:[_formatter dateFromString:endStr]];
        }
    }
}
@end
