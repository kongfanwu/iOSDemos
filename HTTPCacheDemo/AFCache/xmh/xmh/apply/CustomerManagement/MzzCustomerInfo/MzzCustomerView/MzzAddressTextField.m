//
//  MzzAddressTextField.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/21.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzAddressTextField.h"
#import "YJProvince.h"
@interface MzzAddressTextField()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic ,copy)NSString *oriNs;
@property (strong, nonatomic)NSArray *provinces;
@property (strong, nonatomic) UIPickerView *picker;
@end
@implementation MzzAddressTextField
//懒加载
-(NSArray *)provinces{
    if (_provinces == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"cities.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            YJProvince *province = [YJProvince provinceWithDict:dict];
            [arrayModel addObject:province];
        }
        _provinces = arrayModel;
    }
    return _provinces;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.borderStyle = UITextBorderStyleNone;
        _picker = [[UIPickerView alloc]init];
        _picker.delegate = self;
        _picker.dataSource =self;
        //将弹出键盘设置为选择器
        self.inputView = _picker;
        
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

-(void)doneButton{
    
    if (self.doneclick) {
        self.doneclick(self);
    }
    [self resignFirstResponder];
}
-(void)cencelButton{
    
    if (self.cencelclick) {
        self.cencelclick(self);
    }
    [self resignFirstResponder];
}

//数据源
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinces.count;
    }else{
        //根据列索引动态改变行索引
        NSInteger colIndex = [self.picker selectedRowInComponent:0];
        YJProvince * province = self.provinces[colIndex];
        return province.cities.count;
    }
}
//代理
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        YJProvince *province = self.provinces[row];
        return province.name;
    }else{
        NSInteger provinceIndex = [self.picker selectedRowInComponent:0];
        YJProvince * province = self.provinces[provinceIndex];
        if (row < province.cities.count) {
            return province.cities[row];
        }else{
            return nil;
        }
    }
}

//被选中时调用
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        //NSInteger index = [self.pickerVIew selectedRowInComponent:0];
        [self.picker reloadComponent:1];
        [self.picker selectRow:0 inComponent:1 animated:YES];
    }
    //获取当期索引
    NSInteger provinceIndex = [self.picker selectedRowInComponent:0];
    NSInteger cityIndex = [self.picker selectedRowInComponent:1];
    
    YJProvince *province = self.provinces[provinceIndex];
    
   
    if (cityIndex < province.cities.count) {
        self.text = [province.name stringByAppendingString:province.cities[cityIndex]];
    }
    
}


@end
