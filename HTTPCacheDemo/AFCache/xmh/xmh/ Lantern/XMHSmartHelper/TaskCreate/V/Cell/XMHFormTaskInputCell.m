//
//  XMHFormTaskInputCell.m
//  xmh
//
//  Created by kfw on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskInputCell.h"



@implementation XMHFormTaskInputCell


// 在主表单中注册对应的cell以及对应的ID
+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[XMHFormTaskInputCell class] forKey:XLFormRowDescriptorTypeXMHFormTaskInputCell];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureUI];
}

- (void)configureUI {
}

- (void)setTextFieldMaxNumberOfCharacters:(NSNumber *)textFieldMaxNumberOfCharacters {
    [super setTextFieldMaxNumberOfCharacters:textFieldMaxNumberOfCharacters];
    _numberLabel.text = [NSString stringWithFormat:@"0/%ld", self.textFieldMaxNumberOfCharacters.integerValue];
}

// 这个方法是用来进行更新的，外面给唯一的字段Value设定值就好了 通过self.rowDescriptor.value的值变化来进行更新
- (void)update
{
    [super update];
    self.textField.enabled = !self.rowDescriptor.isDisabled;
    self.textField.text = self.rowDescriptor.value;
    _numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.textField.text.length, self.textFieldMaxNumberOfCharacters.integerValue];
}

- (IBAction)add:(UIButton *)sender {
//    NSDate *date = [NSDate dateFromYear:2019 Month:[sender.titleLabel.text integerValue] Day:1];
//    self.rowDescriptor.value = date;
}

/**
 返回行高，autolayout 布局一般用不到此方法
 */
+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 50;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (self.textFieldMaxNumberOfCharacters != nil) {
        // Check maximum length requirement
        if (newString.length > self.textFieldMaxNumberOfCharacters.integerValue) {
            return NO;
        }
    }
    _numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", newString.length, self.textFieldMaxNumberOfCharacters.integerValue];
    self.rowDescriptor.value = newString;
    
    return YES;
}

@end
