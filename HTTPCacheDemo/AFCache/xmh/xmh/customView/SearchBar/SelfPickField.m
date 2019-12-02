//
//  SelfPickField.m
//  caodaren
//
//  Created by caoyinliang on 15/8/20.
//  Copyright (c) 2015年 caoyinliang. All rights reserved.
//

#import "SelfPickField.h"

@implementation SelfPickField

- (UIToolbar *)inputAccessoryView{
    if(!_accessory)
    {
        CGRect rx = [ UIScreen mainScreen ].bounds;
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SELF, 44)];
        toolBar.barStyle = UIBarStyleDefault;
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(doCancel)];
        [left setTintColor:[UIColor blackColor]];
        
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, rx.size.width - 160, 44)];
        title.text = _selfTitle;
        title.textAlignment = NSTextAlignmentCenter;
        spaceBarItem.customView = title;
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doOk)];
        [right setTintColor:[UIColor blackColor]];
        
        toolBar.items = [NSArray arrayWithObjects:left,spaceBarItem,right,nil];
        _accessory = toolBar;
        return _accessory;
    }
    return _accessory;
}

- (UIPickerView *)inputView
{
    //隐藏箭头
    if (_jiantBtn.hidden == NO) {
        _jiantBtn.hidden = YES;
    }
    
    if(!_selectedPicker)
    {
        UIPickerView *tempPickView = [[UIPickerView alloc]init];
        tempPickView.backgroundColor = [UIColor whiteColor];
        tempPickView.delegate =self;
        tempPickView.dataSource = self;
        tempPickView.showsSelectionIndicator = YES;
        _selectedPicker = tempPickView;
        [self reSetPickerValue];
        return _selectedPicker;
    }
    [self reSetPickerValue];
    return _selectedPicker;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataTitleArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_dataTitleArr objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

- (void)reSetPickerValue{
    
    if(_pickerValue )
    {
        NSInteger row = 0;
        BOOL find = NO;
        for (NSInteger i = 0;i< [_dataValueArr count]; i++)
        {
            if([_pickerValue isEqualToString:[_dataValueArr objectAtIndex:i]])
            {
                row = i;
                find = YES;
                break;
            }
        }
        if(find == YES)
        {
            [_selectedPicker selectRow:row inComponent:0 animated:NO];
        }
    }
}

//选择器取消事件
- (void)doCancel{
    [self reSetPickerValue];
    [self resignFirstResponder];
    
//    if ([self.text isEqualToString:@""]) {
//        NSString *strTitle =@"1";
//        NSString *strValue =@"1";
//        self.text = strTitle;
//        _pickerValue = strValue;
//    }
}

//选择器完成事件
- (void)doOk{
    
    NSInteger row = [_selectedPicker selectedRowInComponent:0];
    NSString *strTitle =[_dataTitleArr objectAtIndex:row];
    NSString *strValue =[_dataValueArr objectAtIndex:row];
    self.text = strTitle;
    _pickerValue = strValue;
    [self resignFirstResponder];
    if (_okBlock) {
        _okBlock();
    }
}

@end
