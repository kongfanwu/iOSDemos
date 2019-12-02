//
//  XMHCredentiaManageSearchView.m
//  xmh
//
//  Created by KFW on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaManageSearchView.h"

@interface XMHCredentiaManageSearchView() <UITextFieldDelegate>
/** <##> */
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *searchBtn;
@end

@implementation XMHCredentiaManageSearchView


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.searchBtn = searchBtn;
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [searchBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        searchBtn.titleLabel.font = FONT_SIZE(14);
        [self addSubview:searchBtn];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(48);
            make.height.mas_equalTo(39);
            make.centerY.equalTo(self);
        }];
        __weak typeof(self) _self = self;
        [searchBtn bk_addEventHandler:^(id sender) {
            __strong typeof(_self) self = _self;
            if (self.searchBlock) self.searchBlock(self, self.textField.text);
            [self endEditing:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *leftView = [[UIImageView alloc] initWithImage:UIImageName(@"order_search")];
        leftView.frame = CGRectMake(10, 0, 16, 17);
        
        UIView *leftBGView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 16 + 20, 17)];
        [leftBGView addSubview:leftView];
        
        self.textField = [[UITextField alloc] init];
        _textField.leftView = leftBGView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.layer.cornerRadius = 5;
        _textField.layer.masksToBounds = YES;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
        _textField.backgroundColor = RGBColor(250, 250, 250);
        _textField.textColor = kLabelText_Commen_Color_9;
        _textField.font = FONT_SIZE(13);
        [self addSubview:_textField];
        
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.equalTo(searchBtn.mas_left);
            make.height.mas_equalTo(39);
            make.centerY.equalTo(self);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:_textField];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _textField.placeholder = placeholder;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.searchBlock) self.searchBlock(self, textField.text);
    [textField endEditing:YES];
    return YES;
}

#pragma mark - notification

- (void)textFieldTextDidChangeNotification:(NSNotification *)not {
    NSString *text = ((UITextField *)not.object).text;
    if (text == nil || text.length <= 0) {
        _textField.textColor = kLabelText_Commen_Color_9;
        if (self.clearSearchTextBlock) self.clearSearchTextBlock(self);
    }else{
      _textField.textColor = kColor3;
    }
    
}

@end
