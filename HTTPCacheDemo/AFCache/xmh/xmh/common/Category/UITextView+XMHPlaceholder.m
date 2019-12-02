//
//  UITextView+XMHPlaceholder.m
//  test
//
//  Created by KFW on 2019/3/29.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "UITextView+XMHPlaceholder.h"

static const char *placeHolderLabel = "placeHolderLabel";
static const char *placeHolderColorKey = "placeHolderColor";

@implementation UITextView (XMHPlaceholder)

- (UILabel *)xmhPlaceholder {
    return objc_getAssociatedObject(self, placeHolderLabel);
}

- (void)setXmhPlaceholder:(UILabel *)xmhPlaceholder {
    objc_setAssociatedObject(self, placeHolderLabel, xmhPlaceholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)xmhPlaceholderColor {
    return objc_getAssociatedObject(self, placeHolderColorKey);
}

- (void)setXmhPlaceholderColor:(UIColor *)xmhPlaceholderColor {
    objc_setAssociatedObject(self, placeHolderColorKey, xmhPlaceholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xmhAddPlaceholder:(NSString *)text {
    // _placeholderLabel
    
    if (!self.xmhPlaceholder) {
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = self.xmhPlaceholderColor ? self.xmhPlaceholderColor : [UIColor lightGrayColor];
        placeHolderLabel.font = self.font;
        [self addSubview:placeHolderLabel];
        [self setXmhPlaceholder:placeHolderLabel];
    }
    
    self.xmhPlaceholder.text = text;
    [self.xmhPlaceholder sizeToFit];
    [self setValue:self.xmhPlaceholder forKey:@"_placeholderLabel"];
    
    self.text = @"123";
    self.text = nil;
}
@end
