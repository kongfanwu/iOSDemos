//
//  UILabel+XMHConvenient.m
//  XMHUIKit
//
//  Created by kfw on 2019/12/13.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "UILabel+XMHConvenient.h"

@implementation UILabel (XMHConvenient)

- (UILabel *(^)(NSString *))xmhText {
    return ^UILabel *(NSString *text){
        self.text = text;
        return self;
    };
}

- (UILabel *(^)(UIColor *))xmhTextColor {
    return ^UILabel *(UIColor *color){
        self.textColor = color;
        return self;
    };
}

- (UILabel *(^)(UIFont *))xmhFont {
    return ^UILabel *(UIFont *font){
        self.font = font;
        return self;
    };
}

- (UILabel *(^)(NSTextAlignment))xmhTextAlignment {
    return ^UILabel *(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (UILabel *(^)(NSInteger))xmhNumberOfLines {
    return ^UILabel *(NSInteger numberOfLines){
        self.numberOfLines = numberOfLines;
        return self;
    };
}

- (UILabel *(^)(NSString *, UIColor *, UIFont *))xmhTextAndTextColorAndFont {
    return ^UILabel *(NSString *text, UIColor *color, UIFont *font){
        self.text = text;
        self.textColor = color;
        self.font = font;
        return self;
    };
}


@end

