//
//  SelfDateField.h
//  caodaren
//
//  Created by caoyinliang on 15/8/21.
//  Copyright (c) 2015年 caoyinliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfDateField : UITextField

@property (strong,nonatomic) UIToolbar *accessory;//取消，标题，完成
@property (strong,nonatomic) UIDatePicker  *selectedDate;//键盘弹出来的时间选取器
@property (strong,nonatomic) NSString  *selfTitle;//键盘标题
@property (assign,nonatomic) NSInteger  dateValue;//选取的对应的值

@property (nonatomic, strong, readonly) UILabel *title;

@end
