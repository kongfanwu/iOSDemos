//
//  XMHFormTextFieldCell.m
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTextFieldCell.h"

#import "XMHFormModel.h"

@interface XMHFormTextFieldCell() <UITextFieldDelegate>
@end

@implementation XMHFormTextFieldCell

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
        _textField.font = FONT_SIZE(14);
        _textField.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_textField];
        _textField.mas_key = @"textField";
        // 拉伸优先级低
//        [_textField setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        // 压缩优先级低
//        [_textField setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        
        self.valueTypeLabel = UILabel.new;
        _valueTypeLabel.font = FONT_SIZE(15);
        _valueTypeLabel.textColor = kColor3;
        [self.contentView addSubview:_valueTypeLabel];
        _valueTypeLabel.mas_key = @"valueTypeLabel";
        
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
    
    if (IsEmpty(model.valueType)) {
        _valueTypeLabel.hidden = YES;
        [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(44).priorityMedium();
            make.bottom.mas_equalTo(0).priority(999); // 改变优先级：子类调用，此约束会与子类约束冲突。
            make.top.equalTo(self.lineView.mas_bottom);
        }];
    } else {
        _valueTypeLabel.hidden = NO;
        _valueTypeLabel.text = model.valueType;
        
        [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right);
            make.right.mas_equalTo(_valueTypeLabel.mas_left).offset(-10);
            make.height.mas_equalTo(44).priorityMedium();
            make.bottom.mas_equalTo(0).priority(999);
            make.top.equalTo(self.lineView.mas_bottom);
        }];
        
        [_valueTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(_textField.mas_right).offset(10);
        }];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    // Check maximum length requirement
    XMHFormModel *model = (XMHFormModel *)self.model;
    if (newString.length > model.inputMax) {
        return NO;
    }
    
//    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//    textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSInteger existedLength = textField.text.length;
//    NSInteger selectedLength = range.length;
//    NSInteger replaceLength = string.length;
//    if (string.length == 0) return YES;
//
//    XMHFormModel *model = (XMHFormModel *)self.model;
//
//    if (existedLength - selectedLength + replaceLength > model.inputMax) {
//        return NO;
//    }
    
    return YES;
}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    XMHFormModel *model = (XMHFormModel *)self.model;
//    if (textField.text.length > model.inputMax) {
//        NSString *subStr = [textField.text substringToIndex:model.inputMax];
//        textField.text = subStr;
//    }
//
//    ((XMHFormModel *)self.model).value = textField.text;
//}

#pragma mark - NSNotification

- (void)textFieldTextDidChangeNotification:(NSNotification *)not {
    if (not.object == _textField) {
        UITextField *tf = not.object;
        
        ((XMHFormModel *)self.model).value = tf.text;
    }
}

@end
