//
//  UITextField+XMHConvenient.m
//  XMHUIKit
//
//  Created by kfw on 2019/12/14.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "UITextField+XMHConvenient.h"

@implementation UITextField (XMHConvenient)

- (UITextField *(^)(NSString *))xmhText {
    return ^UITextField *(NSString *text){
        self.text = text;
        return self;
    };
}

- (UITextField *(^)(NSAttributedString *))xmhAttributedText {
    return ^UITextField *(NSAttributedString *attributedText){
        self.attributedText = attributedText;
        return self;
    };
}

- (UITextField *(^)(UIColor *))xmhTextColor {
    return ^UITextField *(UIColor *color){
        self.textColor = color;
        return self;
    };
}

- (UITextField *(^)(UIFont *))xmhFont {
    return ^UITextField *(UIFont *font){
        self.font = font;
        return self;
    };
}

- (UITextField *(^)(NSTextAlignment))xmhTextAlignment {
    return ^UITextField *(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (UITextField *(^)(UITextBorderStyle))xmhBorderStyle {
    return ^UITextField *(UITextBorderStyle borderStyle){
        self.borderStyle = borderStyle;
        return self;
    };
}

- (UITextField *(^)(NSString *))xmhPlaceholder {
    return ^UITextField *(NSString *placeholder){
        self.placeholder = placeholder;
        return self;
    };
}

- (UITextField *(^)(NSAttributedString *))xmhAttributedPlaceholder {
    return ^UITextField *(NSAttributedString *attributedPlaceholder){
        self.attributedPlaceholder = attributedPlaceholder;
        return self;
    };
}

- (UITextField *(^)(id<UITextFieldDelegate>))xmhDelegate {
    return ^UITextField *(id<UITextFieldDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
}

- (UITextField *(^)(UITextFieldViewMode))xmhClearButtonMode {
    return ^UITextField *(UITextFieldViewMode clearButtonMode){
        self.clearButtonMode = clearButtonMode;
        return self;
    };
}

- (UITextField *(^)(UIView *leftView, UITextFieldViewMode leftViewMode))xmhLeftViewAdnMode {
    return ^UITextField *(UIView *leftView, UITextFieldViewMode leftViewMode){
        self.leftView = leftView;
        self.leftViewMode = leftViewMode;
        return self;
    };
}

- (UITextField *(^)(UIView *rightView, UITextFieldViewMode rightViewMode))xmhRightViewAdnMode {
    return ^UITextField *(UIView *rightView, UITextFieldViewMode rightViewMode){
        self.rightView = rightView;
        self.rightViewMode = rightViewMode;
        return self;
    };
}

- (UITextField *(^)(UIKeyboardType))xmhKeyboardType {
    return ^UITextField *(UIKeyboardType keyboardType){
        self.keyboardType = keyboardType;
        return self;
    };
}

- (UITextField *(^)(UIReturnKeyType))xmhReturnKeyType {
    return ^UITextField *(UIReturnKeyType returnKeyType){
        self.returnKeyType = returnKeyType;
        return self;
    };
}

- (UITextField *(^)(NSString *, UIColor *, UIFont *))xmhTextAndTextColorAndFont {
    return ^UITextField *(NSString *text, UIColor *color, UIFont *font){
        self.text = text;
        self.textColor = color;
        self.font = font;
        return self;
    };
}

@end
