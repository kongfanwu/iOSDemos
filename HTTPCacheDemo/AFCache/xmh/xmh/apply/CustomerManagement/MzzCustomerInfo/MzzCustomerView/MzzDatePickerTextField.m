//
//  MzzTextFiedl.m
//  0312日期选择器
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 张英杰. All rights reserved.
//

#import "MzzDatePickerTextField.h"

@implementation MzzDatePickerTextField
{
//    NSString *_originNs;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.borderStyle = UITextBorderStyleNone;
        _datePicker = [[UIDatePicker alloc]init];
        _datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans"];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        //监听时期数值变化
//        [_datePicker addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
        //将弹出键盘设置为日期选择器
        self.inputView = _datePicker;
        self.tintColor =[UIColor clearColor];
        
        //添加工具栏
        UIToolbar *toolbar = [[UIToolbar alloc]init];
        toolbar.tintColor = [ColorTools colorWithHexString:@"F10180"];
        //设置frame
        toolbar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        //创建
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"请选择" style:UIBarButtonItemStylePlain target:nil action:nil];
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:@selector(cencelButton)];
        UIBarButtonItem *item4 = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton)];
        //添加到工具栏中
        toolbar.items = @[item1,item2,item3,item4];
        //将工具栏设置给键盘
        self.inputAccessoryView = toolbar;
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.borderStyle = UITextBorderStyleNone;
    _datePicker = [[UIDatePicker alloc]init];
    _datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans"];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    //监听时期数值变化
    [_datePicker addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];

    //将弹出键盘设置为日期选择器
    self.inputView = _datePicker;
    
    
    //添加工具栏
    UIToolbar *toolbar = [[UIToolbar alloc]init];
    //设置frame
    toolbar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    toolbar.tintColor = [ColorTools colorWithHexString:@"F10180"];
    //创建
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"请选择" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:@selector(cencelButton)];
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton)];
    //添加到工具栏中
    toolbar.items = @[item1,item2,item3,item4];
    //将工具栏设置给键盘
    self.inputAccessoryView = toolbar;
}
-(void)doneButton{
    //
    [self resignFirstResponder];
        //获取当期数值
        NSDate *date =  _datePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        //赋值
        self.text = [formatter stringFromDate:date];
    
    if (self.doneclick) {
        self.doneclick(self);
    }
    
}
-(void)cencelButton{
    //
    [self resignFirstResponder];
    if (self.cencelclick) {
        self.cencelclick(self);
    }
}

- (void)valueChanged{
    //获取当期数值
    NSDate *date =  _datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    //赋值
    self.text = [formatter stringFromDate:date];
}

-(void)setPlace:(NSString *)place{
    self.text = @"";
    self.placeholder = place;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat =  @"yyyy-MM-dd";
    if ([formatter dateFromString:place]) {
        _datePicker.date = [formatter dateFromString:place];
    }
}

- (void)keyboardWasShown:(NSNotification *)notification {
    NSDate *date =  _datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    //赋值
    self.text = [formatter stringFromDate:date];
}
// 获取键盘的高度 CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]; CGFloat height = kViewHeight - 64 - frame.size.height; if (height < 455.5) { self.textFiledScrollView.frame = CGRectMake(0, 64, kViewWidth, height); } if (![self.titleTextView.text isEqualToString:@""]) { self.titleTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0); } else { self.titleTextView.contentInset = UIEdgeInsetsMake(20, 0, -20, 0);// 光标偏移 } [self contentSizeToFit];// 垂直居中 }
    
@end
