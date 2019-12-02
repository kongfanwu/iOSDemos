//
//  XMHFormTaskInputRightPointCell.m
//  xmh
//
//  Created by kfw on 2019/6/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskInputRightPointCell.h"

@implementation XMHFormTaskInputRightPointCell

// 在主表单中注册对应的cell以及对应的ID
+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[XMHFormTaskInputRightPointCell class] forKey:XLFormRowDescriptorTypeXMHFormTaskInputRightPointCell];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureUI];
}

- (void)configureUI {
}

// 这个方法是用来进行更新的，外面给唯一的字段Value设定值就好了 通过self.rowDescriptor.value的值变化来进行更新
- (void)update
{
    [super update];
    self.leftLabel.text = self.rowDescriptor.title;
    
    self.textField.enabled = !self.rowDescriptor.isDisabled;
    self.textField.text = self.rowDescriptor.value;
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
    self.rowDescriptor.value = newString;
    return YES;
}
@end
