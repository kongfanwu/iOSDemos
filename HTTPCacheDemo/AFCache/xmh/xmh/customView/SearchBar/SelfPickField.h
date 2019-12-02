//
//  SelfPickField.h
//  caodaren
//
//  Created by caoyinliang on 15/8/20.
//  Copyright (c) 2015年 caoyinliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfPickField : UITextField<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong,nonatomic) UIToolbar *accessory;//取消，标题，完成
@property (strong,nonatomic) UIPickerView  *selectedPicker;//键盘弹出来的选取器
@property (strong,nonatomic) NSString  *selfTitle;//键盘的标题
@property (strong,nonatomic) NSString  *pickerValue;//选取的对应的值
@property (strong,nonatomic) NSMutableArray  *dataTitleArr;//选取器显示数值
@property (strong,nonatomic) NSMutableArray  *dataValueArr;//对应的值
@property (strong,nonatomic) UIButton       *jiantBtn;
@property (nonatomic, copy) void (^okBlock)(void);
@end
