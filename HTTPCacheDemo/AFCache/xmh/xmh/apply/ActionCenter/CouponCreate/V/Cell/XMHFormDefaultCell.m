//
//  XMHFormDefaultCell.m
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormDefaultCell.h"
#import "XMHFormModel.h"

@interface XMHFormDefaultCell() <UITextFieldDelegate>
/** <##> */
@property (nonatomic, strong) UITextField *textField;
@end

@implementation XMHFormDefaultCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_textField];
        _textField.mas_key = @"textField";
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(44).priorityMedium();
            make.bottom.mas_equalTo(0);
            make.top.equalTo(self.lineView.mas_bottom);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:_textField];
    }
    return self;
}

- (void)configureWithModel:(XMHFormModel *)model {
    [super configureWithModel:model];
    
    _textField.keyboardType = model.keyboardType;
    _textField.placeholder = model.placeholder;
    _textField.userInteractionEnabled = model.isEdit;
    _textField.text = model.value;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (string.length == 0) return YES;
    
    XMHFormModel *model = (XMHFormModel *)self.model;
    
    if (existedLength - selectedLength + replaceLength > model.inputMax) {
        return NO;
    }
    
    return YES;
}


#pragma mark - NSNotification

- (void)textFieldTextDidChangeNotification:(NSNotification *)not {
    if (not.object == _textField) {
        UITextField *tf = not.object;
        ((XMHFormModel *)self.model).value = tf.text;
    }
}

@end
