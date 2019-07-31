//
//  XMHTextFieldCell.m
//  XLFormDemo
//
//  Created by KFW on 2019/5/29.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "XMHTextFieldCell.h"

// 内部直接赋值
NSString * const XMHFormRowDescriporTypeTextField = @"XMHFormRowDescriporTypeTextField";

@interface XMHTextFieldCell () <UITextFieldDelegate>
/** <##> */
@property (nonatomic, strong) UILabel *leftLabel;
/** <##> */
@property (nonatomic, strong) UITextField *textField;
@end

@implementation XMHTextFieldCell

// 在主表单中注册对应的cell以及对应的ID
+(void)load
{
     [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[XMHTextFieldCell class] forKey:XMHFormRowDescriporTypeTextField];
}

// 这个方法是用来设置属性的 必须重写  类似于初始化的属性不变的属性进行预先配置
- (void)configure
{
    [super configure];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.leftLabel = UILabel.new;
    [self.contentView addSubview:self.leftLabel];
    self.leftLabel.layer.borderColor = [UIColor yellowColor].CGColor;
    self.leftLabel.layer.borderWidth = 1.0f;
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.textField = [[UITextField alloc] init];
    self.textField.backgroundColor = UIColor.redColor;
    [self.contentView addSubview:self.textField];
    self.textField.delegate = self;
    self.textField.font = [UIFont boldSystemFontOfSize:16];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.textField.textAlignment = NSTextAlignmentRight;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLabel.mas_right);
        make.right.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

// 这个方法是用来进行更新的，外面给唯一的字段Value设定值就好了 通过self.rowDescriptor.value的值变化来进行更新
- (void)update
{
    [super update];
    self.leftLabel.text = self.rowDescriptor.title;
    self.textField.text = self.rowDescriptor.value;
//    self.textField.placeholder = @"placeholder";
    
    [self.textField setEnabled:!self.rowDescriptor.isDisabled];
    self.textField.textColor = self.rowDescriptor.isDisabled ? [UIColor grayColor] : [UIColor blackColor];
}

/**
 返回行高，autolayout 布局一般用不到此方法
 */
//+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
//    return 100;
//}

/**
 能否成为第一响应者
 */
-(BOOL)formDescriptorCellCanBecomeFirstResponder
{
    return (!self.rowDescriptor.isDisabled);
}

/**
 那个对象成为第一响应者
 */
-(BOOL)formDescriptorCellBecomeFirstResponder
{
    return [self.textField becomeFirstResponder];
}

/**
 cell 被选中调用此方法
 */
-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller {
    NSLog(@"formDescriptorCellDidSelectedWithFormController");
}

/*
 自定义key
 NSLog(@"%@", [self formValues]);
 NSLog(@"%@", [self httpParameters]);
 */
-(NSString *)formDescriptorHttpParameterName {
    return @"formDescriptorHttpParameterName";
}

/**
 当单元格变为firstResponder时调用，可用于更改单元格在最佳响应者时的外观。
 */
-(void)highlight
{
    [super highlight];
    self.textLabel.textColor = self.tintColor;
}

/**
 在单元格重新签名firstResponder时调用
 */
-(void)unhighlight
{
    [super unhighlight];
    [self.formViewController updateFormRow:self.rowDescriptor];
}

@end
