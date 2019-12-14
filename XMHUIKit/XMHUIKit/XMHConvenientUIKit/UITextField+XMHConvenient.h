//
//  UITextField+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/14.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (XMHConvenient)

- (UITextField *(^)(NSString *))xmhText;
- (UITextField *(^)(NSAttributedString *))xmhAttributedText;
- (UITextField *(^)(UIColor *))xmhTextColor;
- (UITextField *(^)(UIFont *))xmhFont;
- (UITextField *(^)(NSTextAlignment))xmhTextAlignment;
- (UITextField *(^)(UITextBorderStyle))xmhBorderStyle;
- (UITextField *(^)(NSString *))xmhPlaceholder;
- (UITextField *(^)(NSAttributedString *))xmhAttributedPlaceholder;
- (UITextField *(^)(id<UITextFieldDelegate>))xmhDelegate;
- (UITextField *(^)(UITextFieldViewMode))xmhClearButtonMode;
- (UITextField *(^)(UIView *leftView, UITextFieldViewMode leftViewMode))xmhLeftViewAdnMode;
- (UITextField *(^)(UIView *rightView, UITextFieldViewMode rightViewMode))xmhRightViewAdnMode;
- (UITextField *(^)(UIKeyboardType))xmhKeyboardType;
- (UITextField *(^)(UIReturnKeyType))xmhReturnKeyType;

@end

NS_ASSUME_NONNULL_END
