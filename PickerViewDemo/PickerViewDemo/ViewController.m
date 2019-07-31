//
//  ViewController.m
//  PickerViewDemo
//
//  Created by kfw on 2019/6/25.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "ViewController.h"
#import "aViewController.h"

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
/** <##> */
@property (nonatomic, strong) UIPickerView *picker;
/** <##> */
@property (nonatomic, strong) NSMutableArray *dataArray;
/* */
@property (nonatomic) NSInteger selectIndex;
@end

@implementation ViewController
- (UIPickerView *)picker{
    
    if (!_picker) {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
        _picker.delegate = self;
        _picker.dataSource = self;
        _picker.backgroundColor = UIColor.purpleColor;
    }
    return _picker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = NSMutableArray.new;
    for (int i = 0; i < 20; i++) {
        [self.dataArray addObject:@(i).stringValue];
    }
    
    [self.view addSubview:self.picker];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self presentViewController:aViewController.new animated:YES completion:nil];
}

#pragma mark-----UIPickerViewDataSource
//列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerVie{
    
    return 1;
}
//指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}
//指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = self.dataArray[row];
    UILabel *selectLab = (UILabel *)[pickerView viewForRow:row forComponent:component];
    selectLab.textColor = UIColor.blueColor;
    NSLog(@"com:%ld row:%ld str:%@, label:%p", component, row, str, selectLab);
    return str;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 110;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    for(UIView *speartorView in self.picker.subviews)
    {
        
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.backgroundColor = UIColor.redColor;
        }
    }
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextColor:UIColor.blackColor];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        [pickerLabel sizeToFit];
    }
    return pickerLabel;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}
@end
