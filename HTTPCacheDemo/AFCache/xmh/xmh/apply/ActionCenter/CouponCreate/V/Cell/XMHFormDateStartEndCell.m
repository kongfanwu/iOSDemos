//
//  XMHFormDateStartEndCell.m
//  xmh
//
//  Created by KFW on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormDateStartEndCell.h"

@interface XMHFormDateStartEndCell() <UITextFieldDelegate>
/** <##> */
@property (nonatomic, strong) UITextField *textField1, *textField2;
/** <##> */
@property (nonatomic, strong) UILabel *leftLabel, *centerLabel, *rightLabel;
@end

@implementation XMHFormDateStartEndCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftLabel = [self labelCreate];
        _leftLabel.text = @"领取后";
        [self.contentView addSubview:_leftLabel];
        
        self.textField1 = [[UITextField alloc] init];
        _textField1.delegate = self;
        _textField1.font = FONT_SIZE(14);
        _textField1.textAlignment = NSTextAlignmentCenter;
        _textField1.placeholder = @"输入天数";
        [self.contentView addSubview:_textField1];
        _textField1.mas_key = @"_textField1";
        [_textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(_leftLabel);
            make.left.equalTo(_leftLabel.mas_right);
            make.width.mas_equalTo(60);
        }];
        
        self.centerLabel = [self labelCreate];
        _centerLabel.text = @"天生效，有效天数";
        [self.contentView addSubview:_centerLabel];
        [_centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(_leftLabel);
            make.left.equalTo(_textField1.mas_right);
        }];
        
        self.textField2 = [[UITextField alloc] init];
        _textField2.delegate = self;
        _textField2.font = FONT_SIZE(14);
        _textField2.textAlignment = NSTextAlignmentCenter;
        _textField2.placeholder = @"输入天数";
        [self.contentView addSubview:_textField2];
        _textField2.mas_key = @"_textField2";
        [_textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(_leftLabel);
            make.left.equalTo(_centerLabel.mas_right);
            make.width.mas_equalTo(60);
        }];
        
        self.rightLabel = [self labelCreate];
        _rightLabel.text = @"天";
        [self.contentView addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(_leftLabel);
            make.left.equalTo(_textField2.mas_right);
            make.right.mas_equalTo(-15);
        }];
        // 拉伸优先级低
        [_rightLabel setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        // 压缩优先级低
        [_rightLabel setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:_textField1];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:_textField2];
    }
    return self;
}

- (UILabel *)labelCreate {
    UILabel *label = UILabel.new;
    label.font = FONT_SIZE(15);
    label.textColor = kColor3;
    return label;
}

- (void)configureWithModel:(XMHFormModel *)model {
    [super configureWithModel:model];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    if (model.isEdit) {
        _centerLabel.hidden = _rightLabel.height = _textField1.hidden = _textField2.hidden = NO;
        _textField1.text = model.value;
        _textField2.text = model.value2; // duration
        
        _textField1.keyboardType = model.keyboardType;
        _textField2.keyboardType = model.keyboardType;
        
        [_leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.equalTo(self.titleLabel);
            make.bottom.mas_equalTo(-15);
            make.height.mas_equalTo(20).priorityMedium();
        }];
    } else {
        _centerLabel.hidden = _rightLabel.height = _textField1.hidden = _textField2.hidden = YES;
        _leftLabel.text = [NSString stringWithFormat:@"领取后%@天生效，有效天数%@天", model.value, model.value2];
        [_leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44).priorityMedium();
            make.bottom.mas_equalTo(0);
            make.top.equalTo(self.lineView.mas_bottom);
            make.right.mas_equalTo(-15);
        }];
    }
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
    UITextField *tf = not.object;
    
//    model.value = [obj valueForKey:model.serviceKey];
//    model.value2 = [obj valueForKey:@"duration"];
    
    if (tf == _textField1) {
        ((XMHFormModel *)self.model).value = tf.text;
    }
    else if (tf == _textField2) {
        ((XMHFormModel *)self.model).value2 = tf.text;
    }
}

@end
