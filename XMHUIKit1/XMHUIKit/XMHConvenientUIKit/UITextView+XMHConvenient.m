//
//  UITextView+XMHConvenient.m
//  XMHUIKit
//
//  Created by kfw on 2019/12/14.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "UITextView+XMHConvenient.h"

@implementation UITextView (XMHConvenient)

- (UITextView *(^)(NSString *))xmhText {
    return ^UITextView *(NSString *text){
        self.text = text;
        return self;
    };
}

- (UITextView *(^)(UIColor *))xmhTextColor {
    return ^UITextView *(UIColor *color){
        self.textColor = color;
        return self;
    };
}

- (UITextView *(^)(UIFont *))xmhFont {
    return ^UITextView *(UIFont *font){
        self.font = font;
        return self;
    };
}

- (UITextView *(^)(NSTextAlignment))xmhTextAlignment {
    return ^UITextView *(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (UITextView *(^)(id<UITextViewDelegate>))xmhDelegate {
    return ^UITextView *(id<UITextViewDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
}

- (UITextView *(^)(UIKeyboardType))xmhKeyboardType {
    return ^UITextView *(UIKeyboardType keyboardType){
        self.keyboardType = keyboardType;
        return self;
    };
}

- (UITextView *(^)(UIReturnKeyType))xmhReturnKeyType {
    return ^UITextView *(UIReturnKeyType returnKeyType){
        self.returnKeyType = returnKeyType;
        return self;
    };
}

- (UITextView *(^)(NSAttributedString *))xmhAttributedText {
    return ^UITextView *(NSAttributedString *attributedText){
        self.attributedText = attributedText;
        return self;
    };
}

- (UITextView *(^)(NSString *, UIColor *, UIFont *))xmhTextAndTextColorAndFont {
    return ^UITextView *(NSString *text, UIColor *color, UIFont *font){
        self.text = text;
        self.textColor = color;
        self.font = font;
        return self;
    };
}

@end
