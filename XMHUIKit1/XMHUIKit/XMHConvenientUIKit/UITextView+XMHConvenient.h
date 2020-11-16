//
//  UITextView+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/14.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (XMHConvenient)

- (UITextView *(^)(NSString *))xmhText;
- (UITextView *(^)(UIColor *))xmhTextColor;
- (UITextView *(^)(UIFont *))xmhFont;
- (UITextView *(^)(NSTextAlignment))xmhTextAlignment;
- (UITextView *(^)(id<UITextViewDelegate>))xmhDelegate;
- (UITextView *(^)(UIKeyboardType))xmhKeyboardType;
- (UITextView *(^)(UIReturnKeyType))xmhReturnKeyType;
- (UITextView *(^)(NSAttributedString *))xmhAttributedText;
- (UITextView *(^)(NSString *, UIColor *, UIFont *))xmhTextAndTextColorAndFont;

@end

NS_ASSUME_NONNULL_END
