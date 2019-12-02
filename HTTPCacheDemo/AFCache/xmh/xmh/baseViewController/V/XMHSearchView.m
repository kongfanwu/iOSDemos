//
//  XMHSearchView.m
//  xmh
//
//  Created by kfw on 2019/8/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSearchView.h"

@interface XMHSearchView() <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *textFieldLeftView;
/** <##> */
@property (nonatomic, strong) UIImageView *textFieldLeftImageView;
/** <##> */
@property (nonatomic, strong) UIButton *searchButton;
/** <##> */
@property (nonatomic, strong) UIView *contentView;

@end

@implementation XMHSearchView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        _type = XMHSearchViewTypeSearch;
        _textFieldMaxNumberOfCharacters = NSIntegerMax;
        _leftSearchImageName = @"order_search";
        _focusSpacing = 5.f;
        
        self.contentView = UIView.new;
        _contentView.backgroundColor = UIColor.clearColor;
        [self addSubview:_contentView];
        
        self.textFieldLeftImageView = [[UIImageView alloc] initWithImage:UIImageName(_leftSearchImageName)];
        _textFieldLeftImageView.frame = CGRectMake(10, 0, 16, 16);
        
        self.textFieldLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _textFieldLeftImageView.width + _focusSpacing, _textFieldLeftImageView.height)];
        [_textFieldLeftView addSubview:_textFieldLeftImageView];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(14, (self.height - 33) / 2.f, (self.width - 14 * 2), 33)];
        _textField.leftView = _textFieldLeftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.layer.cornerRadius = 5;
        _textField.layer.masksToBounds = YES;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
        _textField.backgroundColor = _contentView.backgroundColor;
        _textField.textColor = kLabelText_Commen_Color_9;
        _textField.font = FONT_SIZE(13);
        [_contentView addSubview:_textField];
        
        self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton setTitleColor:kColor3 forState:UIControlStateNormal];
        _searchButton.backgroundColor = _contentView.backgroundColor;
        _searchButton.titleLabel.font = FONT_SIZE(14);
        [_contentView addSubview:_searchButton];
        __weak typeof(self) _self = self;
        [_searchButton bk_addEventHandler:^(id sender) {
            __strong typeof(_self) self = _self;
            if (self.searchBlock) self.searchBlock(self, self.textField.text);
        } forControlEvents:UIControlEventTouchUpInside];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:_textField];
    }
    return self;
}

- (void)setLeftSearchImageName:(NSString *)leftSearchImageName {
    _leftSearchImageName = leftSearchImageName;
    _textFieldLeftImageView.image = UIImageName(_leftSearchImageName);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _contentView.frame = CGRectMake(_contentEdgeInset.left, _contentEdgeInset.top, self.width - _contentEdgeInset.left - _contentEdgeInset.right, self.height - _contentEdgeInset.top - _contentEdgeInset.bottom);
    
    CGFloat tfInsetTopBottom = _textFieldEdgeInset.top + _textFieldEdgeInset.bottom;
    CGFloat tfInsetLeftRight = _textFieldEdgeInset.left + _textFieldEdgeInset.right;
    // 内间距高度大于 最大高度间距。将失效
    if (tfInsetTopBottom > _contentView.height) tfInsetTopBottom = 0;
    
    if (_type == XMHSearchViewTypeNormal) {
        [_searchButton removeFromSuperview];
        _searchButton = nil;
        
        CGFloat tfW = _contentView.width - tfInsetLeftRight;
        _textField.frame = CGRectMake(_textFieldEdgeInset.left, _textFieldEdgeInset.top, tfW, _contentView.height - tfInsetTopBottom);
        
        _textField.leftView = nil;
    }
    else if (_type == XMHSearchViewTypeTextFieldLeftView) {
        [_searchButton removeFromSuperview];
        _searchButton = nil;
        
        CGFloat tfW = _contentView.width - tfInsetLeftRight;
        _textField.frame = CGRectMake(_textFieldEdgeInset.left, _textFieldEdgeInset.top, tfW, _contentView.height - tfInsetTopBottom);
        
        _textFieldLeftImageView.frame = CGRectMake(10, 0, 16, 16);
        _textFieldLeftView.frame = CGRectMake(0, 0, 10 + _textFieldLeftImageView.width + _focusSpacing, _textFieldLeftImageView.height);
        _textField.leftView = _textFieldLeftView;
    }
    else if (_type == XMHSearchViewTypeSearch) {
        [_searchButton sizeToFit];
        CGFloat searchBtnW = _searchButton.width + _searchButtonContentInset.left + _searchButtonContentInset.right;
        CGFloat searchBtnInsetTopBottom = _searchButtonContentInset.top + _searchButtonContentInset.bottom;
        // 内间距高度大于 最大高度间距。将失效
        if (searchBtnInsetTopBottom > _contentView.height - _searchButton.height) searchBtnInsetTopBottom = 0;
        _searchButton.frame = CGRectMake(_contentView.width - searchBtnW,
                                         searchBtnInsetTopBottom == 0 ? 0 : _searchButtonContentInset.top,
                                         searchBtnW,
                                         _contentView.height - searchBtnInsetTopBottom);
        
        CGFloat tfW = _contentView.width - _searchButton.width - tfInsetLeftRight;
        _textField.frame = CGRectMake(_textFieldEdgeInset.left, _textFieldEdgeInset.top, tfW, _contentView.height - tfInsetTopBottom);
        
        _textFieldLeftImageView.frame = CGRectMake(10, 0, 16, 16);
        _textFieldLeftView.frame = CGRectMake(0, 0, 10 + _textFieldLeftImageView.width + _focusSpacing, _textFieldLeftImageView.height);
        _textField.leftView = _textFieldLeftView;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.searchBlock) self.searchBlock(self, textField.text);
    [textField endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    // Check maximum length requirement
    if (newString.length > self.textFieldMaxNumberOfCharacters) return NO;
    return YES;
}

#pragma mark - notification

- (void)textFieldTextDidChangeNotification:(NSNotification *)not {
    NSString *text = ((UITextField *)not.object).text;
    if (text == nil || text.length <= 0) {
        if (self.clearSearchTextBlock) self.clearSearchTextBlock(self);
    }else{
        if (self.changeSearchTextBlock) self.changeSearchTextBlock(self);
    }
}

@end
