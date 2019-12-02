//
//  MzzPickerTextField.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzPickerTextField.h"
#import "MzzDengjiModel.h"
@interface MzzPickerTextField()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic ,copy)NSString *oriNs;

@end
@implementation MzzPickerTextField
{
    NSArray *_dataList;
}

- (void)setupData:(NSArray *)datalist{
     _dataList = datalist;
    [_Picker reloadAllComponents];
    if (_dataList.count > 0) {
        if ([_dataList[0] isKindOfClass:[MzzDengji class]]) {
            MzzDengji *dengji = _dataList[0];
            _selectStr = dengji.name;
            _selectKey = dengji.key;
        }else{
            _selectStr = _dataList[0];
        }
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.borderStyle = UITextBorderStyleNone;
        _Picker = [[UIPickerView alloc]init];
        _Picker.delegate = self;
        _Picker.dataSource =self;
        //将弹出键盘设置为选择器
        self.inputView = _Picker;
  
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
- (void)awakeFromNib{
    [super awakeFromNib];
    self.borderStyle = UITextBorderStyleNone;
    _Picker = [[UIPickerView alloc]init];
    _Picker.delegate = self;
    _Picker.dataSource =self;
    //将弹出键盘设置为选择器
    self.inputView = _Picker;
   
    //添加工具栏
    UIToolbar *toolbar = [[UIToolbar alloc]init];
    toolbar.tintColor = [ColorTools colorWithHexString:@"F10180"];
    //设置frame
    toolbar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    //创建
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"请选择" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cencelButton)];
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton)];
    //添加到工具栏中
    toolbar.items = @[item1,item2,item3,item4];
    //将工具栏设置给键盘
    self.inputAccessoryView = toolbar;
   
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)doneButton{
    self.text = _selectStr;
    if (self.doneclick) {
        self.doneclick(self);
        if (_isStore) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"jishi" object:nil];
        }
    }
    [self resignFirstResponder];
}
-(void)cencelButton{
    
    if (self.cencelclick) {
        self.cencelclick(self);
    }
    [self resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([_dataList[0] isKindOfClass:[MzzDengji class]]) {
        MzzDengji *dengji = _dataList[row];
        return  dengji.name;
    }else{
        return  _dataList[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    if ([_dataList[0] isKindOfClass:[MzzDengji class]]) {
        MzzDengji *dengji = _dataList[row];
        _selectStr = dengji.name;
        _selectKey =dengji.key;
    }else{
        _selectStr = _dataList[row];
    }
    
}



@end
