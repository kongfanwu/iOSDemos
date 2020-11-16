//
//  UIView+XMHConvenient.m
//  XMHUIKit
//
//  Created by kfw on 2019/12/13.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "UIView+XMHConvenient.h"

//#define XMHCreateLazy(ReturnType, Parameter, MethodName, f) \
//- (ReturnType (^)(Parameter))xmh##MethodName { \
//    return ^UIView *(Parameter value){ \
//        f(self, value);\
//        return self; \
//    }; \
//} \

//XMHCreateLazy(UIView *, CGFloat, CornerRadius, CornerRadiusBlock)
//void CornerRadiusBlock(UIView *aSelf, CGFloat value) {
//    aSelf.layer.cornerRadius = value;
//    aSelf.layer.masksToBounds = YES;
//}

@implementation UIView (XMHConvenient)

+ (instancetype)xmhNew {
    return self.new;
}

+ (UIView *(^)(UIView *))xmhNewAndSuperView {
    return ^UIView *(UIView *superView){
        UIView *view = self.new;
        [superView addSubview:view];
        return view;
    };
}

- (UIView *(^)(UIView *))xmhSuperView {
    return ^UIView *(UIView *superView){
        [superView addSubview:self];
        return self;
    };
}

- (UIView *(^)(CGRect))xmhFrame {
    return ^UIView *(CGRect rect){
        self.frame = rect;
        return self;
    };
}

- (UIView *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints {
    return ^UIView *(void(^block)(MASConstraintMaker *make)){
        if (block) { [self mas_makeConstraints:^(MASConstraintMaker *make) { block(make); }]; }
        return self;
    };
}

- (UIView *(^)(UIColor *))xmhBackgroundColor {
    return ^UIView *(UIColor *backgroundColor){
        self.backgroundColor = backgroundColor;
        return self;
    };
}

- (UIView *(^)(CGFloat))xmhCornerRadius {
    return ^UIView *(CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
        return self;
    };
}

- (UIView *(^)(CGFloat))xmhBorderWidth {
    return ^UIView *(CGFloat borderWidth){
        self.layer.borderWidth = borderWidth;
        return self;
    };
}

- (UIView *(^)(UIColor *))xmhBorderColor {
    return ^UIView *(UIColor *borderColor){
        self.layer.borderColor = borderColor.CGColor;
        return self;
    };
}




@end
