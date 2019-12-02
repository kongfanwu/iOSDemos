//
//  XMHOrderContentSearchView.m
//  xmh
//
//  Created by KFW on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOrderContentSearchView.h"

@interface XMHOrderContentSearchView() <UITextFieldDelegate>
@end

@implementation XMHOrderContentSearchView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        
        UIImageView *leftView = [[UIImageView alloc] initWithImage:UIImageName(@"order_search")];
        leftView.frame = CGRectMake(10, 0, 16, 17);
        
        UIView *leftBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16 + 15, 17)];
        [leftBGView addSubview:leftView];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(14, (self.height - 33) / 2.f, (self.width - 14 * 2), 33)];
        _textField.placeholder = @"请输入名称";
        _textField.leftView = leftBGView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.layer.cornerRadius = _textField.height / 2.f;
        _textField.layer.masksToBounds = YES;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
        _textField.backgroundColor = RGBColor(250, 250, 250);
        _textField.textColor = kLabelText_Commen_Color_9;
        _textField.font = FONT_SIZE(13);
        [self addSubview:_textField];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:_textField];
    }
    return self;
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
        if (self.clearSearchTextBlock) self.clearSearchTextBlock(self);
    }else{
        if (self.changeSearchTextBlock) self.changeSearchTextBlock(self);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
