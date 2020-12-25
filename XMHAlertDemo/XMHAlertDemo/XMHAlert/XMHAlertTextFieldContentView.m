//
//  XMHAlertTextFieldContentView.m
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/24.
//

#import "XMHAlertTextFieldContentView.h"
#import "XMHAlertTool.h"
#import "UIView+Exting.h"
#import "XMHAlertAction.h"
#import "XMHAlertContentBottomView.h"

@interface XMHAlertTextFieldContentView()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) XMHAlertContentBottomView *bottomView;
@end

@implementation XMHAlertTextFieldContentView

@synthesize actions = _actions;

- (NSMutableArray *)actions {
    if (_actions) return _actions;
    _actions = NSMutableArray.new;
    return _actions;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 280, 0);
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (UITextField *)textField {
    if (_textField) return _textField;
    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = XMHRGBHex(0xF9F9F9);
    _textField.placeholder = @"";
    [_textField setValue:XMHRGBHex(0x999999) forKeyPath:@"placeholderLabel.textColor"];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12.5, 0)];;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:_textField];
    return _textField;
}

- (XMHAlertContentBottomView *)bottomView {
    if (_bottomView) return _bottomView;
    _bottomView = XMHAlertContentBottomView.new;
    [self addSubview:_bottomView];
    return _bottomView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textField.frame = CGRectMake(15, 33, self.width - 30, 39);
    UIView *lastView = self.textField;
    
    if (_actions.count > 0) {
        self.bottomView.actions = _actions;
        self.bottomView.frame = CGRectMake(0, lastView.bottom + 20, self.width, 49);
        lastView = self.bottomView;
    }
    self.height = lastView.bottom;
    self.center = CGPointMake(self.superview.width / 2.f, self.superview.height / 2.f);
    
    [self addCornerRadiu:10.f];
}

@end
