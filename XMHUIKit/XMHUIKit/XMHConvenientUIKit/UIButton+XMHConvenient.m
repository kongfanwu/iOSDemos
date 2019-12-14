//
//  UIButton+XMHConvenient.m
//  XMHUIKit
//
//  Created by kfw on 2019/12/14.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "UIButton+XMHConvenient.h"

@implementation UIButton (XMHConvenient)

- (UIButton *(^)(NSString *, UIControlState))xmhSetTitleAndState {
    return ^UIButton *(NSString *title, UIControlState state){
        [self setTitle:title forState:state];
        return self;
    };
}

- (UIButton *(^)(NSAttributedString *, UIControlState))xmhSetAttributedTitleAndState {
    return ^UIButton *(NSAttributedString *title, UIControlState state){
        [self setAttributedTitle:title forState:state];
        return self;
    };
}

- (UIButton *(^)(UIColor *, UIControlState))xmhSetTitlColorAndState {
    return ^UIButton *(UIColor *color, UIControlState state){
        [self setTitleColor:color forState:state];
        return self;
    };
}

- (UIButton *(^)(UIImage *, UIControlState))xmhSetImageAndState {
    return ^UIButton *(UIImage *image, UIControlState state){
        [self setImage:image forState:state];
        return self;
    };
}

- (UIButton *(^)(UIImage *, UIControlState))xmhSetBackgroundImageAndState {
    return ^UIButton *(UIImage *image, UIControlState state){
        [self setBackgroundImage:image forState:state];
        return self;
    };
}

- (UIButton *(^)(void(^)(UILabel *)))xmhTitleLabel {
    return ^UIButton *(void(^block)(UILabel *titleLabel)){
        if (block) { block(self.titleLabel); }
        return self;
    };
}

- (UIButton *(^)(void(^)(UIImageView *)))xmhImageView {
    return ^UIButton *(void(^block)(UIImageView *imageView)){
        if (block) { block(self.imageView); }
        return self;
    };
}

- (UIButton *(^)(NSString *, UIColor *, UIFont *, UIControlState state))xmhSetTitleAndColorAndFontAndState {
    return ^UIButton *(NSString *title, UIColor *color, UIFont *font, UIControlState state){
        [self setTitle:title forState:state];
        [self setTitleColor:color forState:state];
        self.titleLabel.font = font;
        return self;
    };
}

@end
