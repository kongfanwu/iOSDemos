//
//  XMHFormTaskTrackMsgCell.m
//  xmh
//
//  Created by kfw on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskTrackMsgCell.h"
#import "IQKeyboardManager.h"

@implementation XMHFormTaskTrackMsgCell

// 在主表单中注册对应的cell以及对应的ID
+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[XMHFormTaskTrackMsgCell class] forKey:XLFormRowDescriptorTypeXMHFormTaskTrackMsgCell];
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
    
    self.textView.editable = !self.rowDescriptor.isDisabled;
    self.textView.text = self.rowDescriptor.value;
    _numberLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.textView.text.length, self.textFieldMaxNumberOfCharacters.integerValue];
}

/**
 返回行高，autolayout 布局一般用不到此方法
 */
+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 175;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 40;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 10;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
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
