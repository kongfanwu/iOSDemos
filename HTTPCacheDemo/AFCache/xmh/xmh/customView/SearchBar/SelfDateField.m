//
//  SelfDateField.m
//  caodaren
//
//  Created by caoyinliang on 15/8/21.
//  Copyright (c) 2015年 caoyinliang. All rights reserved.
//

#import "SelfDateField.h"

@interface SelfDateField ()

@end

@implementation SelfDateField

- (UIToolbar *)inputAccessoryView
{
    if (!_accessory) {
        CGRect rx = [UIScreen mainScreen].bounds;
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SELF, 44)];
        toolBar.barStyle = UIBarStyleDefault;
        // 取消
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(doCancel)];
        [left setTintColor:[UIColor blackColor]];
        // 间隔
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        // 文字显示
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, rx.size.width - 160, 44)];
        title.text = _selfTitle;
        title.textAlignment = NSTextAlignmentCenter;
        spaceBarItem.customView = title;
        // 确定
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doOk)];
        [right setTintColor:[UIColor blackColor]];
        
        toolBar.items = [NSArray arrayWithObjects:left,spaceBarItem,right,nil];
        _accessory = toolBar;
        return _accessory;
    }
    return _accessory;
}

- (UIDatePicker *)inputView
{
    if (!_selectedDate) {
        UIDatePicker *tempPickView = [[UIDatePicker alloc]init];
        tempPickView.backgroundColor = [UIColor whiteColor];
        tempPickView.datePickerMode = UIDatePickerModeDate;
//        tempPickView.minimumDate = [NSDate date];
        if (_dateValue) {
            tempPickView.date = [NSDate dateWithTimeIntervalSince1970:_dateValue];
        } else {
            tempPickView.date = [NSDate date];
        }
        _selectedDate = tempPickView;
        return _selectedDate;
    } else {
        return _selectedDate;
    }
}

// 取消
- (void)doCancel
{
    [self resignFirstResponder];
}

// 完成
- (void)doOk
{
    NSString *str = [self procesDate:_selectedDate.date];
    long value = (long)[_selectedDate.date timeIntervalSince1970];
    self.text = str;
    _dateValue = value;
    [self resignFirstResponder];
}

// 处理时间
- (NSString *)procesDate:(NSDate *)selectdate
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selectdate];
    NSInteger year= [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSString *strTime =[NSString stringWithFormat:@"%@-%@-%@",@(year),@(month),@(day)];
//    if (month <= 9) {
//        strTime = [NSString stringWithFormat:@"%@-0%@",@(year),@(month)];
//    }else
//        strTime = [NSString stringWithFormat:@"%@-%@",@(year),@(month)];
    return strTime;
}

@end
