//
//  MzzTextFiedl.h
//  0312日期选择器
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 张英杰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DoneBtnOnclick)(UITextField *textField);
typedef void(^CencelBtnOnclick)(UITextField *textField);

@interface MzzDatePickerTextField : UITextField
@property (nonatomic ,strong)UIDatePicker* datePicker;
@property (nonatomic,copy) DoneBtnOnclick doneclick;
@property (nonatomic,copy)CencelBtnOnclick cencelclick;
-(void)setPlace:(NSString *)place;
@end
