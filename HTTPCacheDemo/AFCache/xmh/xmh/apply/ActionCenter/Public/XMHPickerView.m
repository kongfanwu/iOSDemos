//
//  XMHPickerView.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHPickerView.h"

#define WScale ([UIScreen mainScreen].bounds.size.width) / 375
#define HScale ([UIScreen mainScreen].bounds.size.height) / 667

@interface XMHPickerView ()

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *completeBtn;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,assign) NSInteger selectIndex, component;
@property(nonatomic,strong) XMHItemModel * model;
@property(nonatomic,strong) NSMutableArray * selectArr;


@end
@implementation XMHPickerView
- (UIPickerView *)picker{
    
    if (!_picker) {
        _picker = [[UIPickerView alloc]init];
        _selectArr = [[NSMutableArray alloc] init];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}
- (UIDatePicker *)datePicke{
    
    if (!_datePicke) {
        _datePicke = [UIDatePicker new];
    }
    return _datePicke;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]; //[[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.frame = [UIScreen mainScreen].bounds;
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, SCREEN_WIDTH, 319*HScale)];
    [self addSubview:_bgView];
    _bgView.tag = 100;
    _bgView.backgroundColor = [UIColor whiteColor];
    [self showAnimation];
    
    //取消
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44);
        
    }];
    self.cancelBtn.titleLabel.font = FONT_SIZE(15);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    //完成
    self.completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.completeBtn];
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44);
        
    }];
    self.completeBtn.titleLabel.font = FONT_SIZE(15);
    [self.completeBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.completeBtn setTitleColor:kLabelText_Commen_Color_ea007e forState:UIControlStateNormal];

    self.titleLab = [[UILabel alloc] init];
    self.titleLab.textColor = kLabelText_Commen_Color_ea007e;
    self.titleLab.font = FONT_SIZE(15);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.centerY.mas_equalTo(self.completeBtn.mas_centerY);
    }];
    
    
    self.line = [[UIView alloc]init];
    
    [self.bgView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.cancelBtn.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(kSeparatorHeight);
        
    }];
    self.line.backgroundColor = kSeparatorColor;
    
}

#pragma mark type
- (void)setType:(PickerViewType)type{
    
    _type = type;
    
    switch (type) {
        case PickerViewTypeStatus:{
        
            [self statusData];
            [self.picker selectRow:0 inComponent:0 animated:NO];
            [self addDataPicker];
        }
            break;
        case PickerViewTypeUserLimits:{
           
            [self useLimitData];
            [self.picker selectRow:0 inComponent:0 animated:NO];
             [self addDataPicker];
        }
            break;
        case PickerViewTypeSendLimits:{
            
            [self sendLimitData];
            [self.picker selectRow:0 inComponent:0 animated:NO];
            [self addDataPicker];
        }
            break;
        case PickerViewTypeAddType:
        {
            [self addTypeData];
            [self.picker selectRow:0 inComponent:0 animated:NO];
            [self addDataPicker];
        }
            break;
        case PickerViewTypeCustom: {
//            [self.picker selectRow:0 inComponent:0 animated:NO];
            [self addDataPicker];
            break;
        }
        default:
            break;
    }
    
}
#pragma mark -- 数据
- (void)statusData
{
    [self.dataArray addObject:@[@"全部",@"已投放",@"未投放",@"已过期"]];
}
- (void)useLimitData
{
     [self.dataArray addObject:@[@"可转赠/可自己使用",@"不可转赠/可自己使用",@"可转赠/初始领取人不可使用"]];
}
- (void)sendLimitData
{
    [self.dataArray addObject:@[@"所有人都可发放",@"仅管理员"]];
}
- (void)addTypeData
{
    [self.dataArray addObject:@[@"批量添加",@"逐条添加"]];
}
- (void)setSelectComponent:(NSInteger)selectComponent{
    _selectComponent = selectComponent;
    [self.picker selectRow:selectComponent inComponent:0 animated:NO];
    
}
- (void)setSelectSecRow:(NSInteger)selectSecRow
{
    _selectSecRow = selectSecRow;
    [self.picker selectRow:selectSecRow inComponent:1 animated:NO];
    [_selectArr addObject:_dataArray[0][_selectComponent]];
    [_selectArr addObject:_dataArray[1][_selectSecRow]];
}
- (void)addDataPicker{
    [_bgView addSubview:self.picker];
    [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        
    }];

}
#pragma mark event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    
    if (touch.view.tag !=100) {
        
        [self hideAnimation];
    }

}
- (void)showAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgView.frame;
        frame.origin.y = self.frame.size.height-260*HScale;
        self.bgView.frame = frame;
    }];
    
}
- (void)hideAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgView.frame;
        frame.origin.y = self.frame.size.height;
        self.bgView.frame = frame;
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        if (_dismissBlock) {
            _dismissBlock();
        }
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
#pragma mark Click
- (void)cancelBtnClick{
    
    [self hideAnimation];
    
}
-(void)completeBtnClick{
    
    [self hideAnimation];
    NSString *resultStr = [NSString string];

    for (int i = 0; i < self.dataArray.count; i++) {
        
        NSArray *arr = [self.dataArray objectAtIndex:i];
        NSString *str = [arr safeObjectAtIndex:[self.picker selectedRowInComponent:i]];
        if ([str isKindOfClass:[XMHItemModel class]]) {
            XMHItemModel *itemModel = (XMHItemModel *)str;
            str = itemModel.title;
        }
        if (str.length) {
            resultStr = [resultStr stringByAppendingString:str];
        }
    }
 
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:result:)]) {
        [_delegate pickerView:self result:resultStr];
    }
    id model = [[_dataArray safeObjectAtIndex:_component] safeObjectAtIndex:_selectIndex];
    if (self.sureBlock) self.sureBlock(model);
    
    if (_selectArr.count >= 2) {
        XMHItemModel * model0 = _selectArr[0];
        XMHItemModel * model1 = _selectArr[1];
        NSString * time = [NSString stringWithFormat:@"%@:%@",model0.title,model1.title];
        if (self.timesSureBlock) self.timesSureBlock(time);
    }
}
#pragma mark-----UIPickerViewDataSource
//列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerVie{
    
    return self.dataArray.count;
}
//指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

   
    NSArray * arr = (NSArray *)[self.dataArray objectAtIndex:component];
    return arr.count;
}
//指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *arr = (NSArray *)[self.dataArray objectAtIndex:component];
    self.selectIndex = row % arr.count;
    NSString *str = [arr objectAtIndex:row % arr.count];
    UILabel *selectLab = (UILabel *)[pickerView viewForRow:self.selectIndex forComponent:component];
    selectLab.textColor = kLabelText_Commen_Color_ea007e;
    if ([str isKindOfClass:[XMHItemModel class]]) {
        XMHItemModel *itemModel = (XMHItemModel *)str;
        return itemModel.title;
    }
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
            speartorView.backgroundColor = kLabelText_Commen_Color_ea007e;
        }
    }
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel){

        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextColor:kColor9];
//        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:FONT_SIZE(15)];
        pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        [pickerLabel sizeToFit];
    }
    return pickerLabel;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectIndex = row;
    self.component = component;
    if (_selectArr.count >= 2) {
       [_selectArr replaceObjectAtIndex:component withObject:_dataArray[component][row]];
    }
    UILabel *selectLab = (UILabel *)[pickerView viewForRow:self.selectIndex forComponent:component];
    selectLab.textColor = kLabelText_Commen_Color_ea007e;
}
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//
//    NSArray *arr = (NSArray *)[self.dataArray objectAtIndex:component];
//    NSString *titleString = [arr objectAtIndex:row % arr.count];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:titleString];
//    NSRange range = [titleString rangeOfString:titleString];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:kLabelText_Commen_Color_ea007e range:range];
//
//    return attributedString;
//}
//防止崩溃
- (NSUInteger)indexOfNSArray:(NSArray *)arr WithStr:(NSString *)str{
    
    NSUInteger chosenDxInt = 0;
    if (str && ![str isEqualToString:@""]) {
        chosenDxInt = [arr indexOfObject:str];
        if (chosenDxInt == NSNotFound)
            chosenDxInt = 0;
    }
    return chosenDxInt;
}


@end
