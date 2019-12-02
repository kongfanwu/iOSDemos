//
//  XMHFormTextView.m
//  xmh
//
//  Created by KFW on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTextView.h"
#import "UITextView+XMHPlaceholder.h"

@interface XMHFormTextView() <UITextViewDelegate>
/** <##> */
@property (nonatomic, strong) UITextView *textView;
@end

@implementation XMHFormTextView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textView = [[UITextView alloc] init];
        _textView.contentInset = UIEdgeInsetsZero;
        _textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0);;
        _textView.font = FONT_SIZE(14);
        _textView.textColor = kColor3;
        _textView.xmhPlaceholderColor = kColorC;
        _textView.delegate = self;
        [self.contentView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(40).priorityHigh();
            make.bottom.mas_equalTo(-15);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:_textView];
    }
    return self;
}

- (void)configureWithModel:(XMHFormModel *)model {
    [super configureWithModel:model];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [_textView xmhAddPlaceholder:model.placeholder];
    _textView.text = model.value;
    _textView.userInteractionEnabled = model.isEdit;
}

#pragma mark - NSNotification

- (void)textViewTextDidChangeNotification:(NSNotification *)not {
    UITextView *textView = not.object;
    if (textView == _textView) {
        ((XMHFormModel *)self.model).value = textView.text;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    // Check maximum length requirement
    if (newString.length > ((XMHFormModel *)self.model).inputMax) {
        return NO;
    }
    return YES;
}

@end
