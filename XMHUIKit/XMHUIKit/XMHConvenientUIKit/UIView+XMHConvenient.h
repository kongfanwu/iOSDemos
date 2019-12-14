//
//  UIView+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/13.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

// 创建类
#define XMHCreateClass(ClassType, CategoryName, ProtocolName) \
@interface ClassType (CategoryName) <ProtocolName> \
@end \
@implementation ClassType (CategoryName) \
@end \

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XMHConvenient)

+ (instancetype)xmhNew;
+ (UIView *(^)(UIView *))xmhNewAndSuperView;
- (UIView *(^)(UIView *))xmhSuperView;
- (UIView *(^)(CGRect))xmhFrame;
- (UIView *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints;
- (UIView *(^)(UIColor *))xmhBackgroundColor;
- (UIView *(^)(CGFloat))xmhCornerRadius;
- (UIView *(^)(CGFloat))xmhBorderWidth;
- (UIView *(^)(UIColor *))xmhBorderColor;

@end

@protocol XMHUILabelConvenient2Protocol <NSObject>
@optional
+ (UILabel *(^)(UIView *))xmhNewAndSuperView;
- (UILabel *(^)(UIView *))xmhSuperView;
- (UILabel *(^)(CGRect))xmhFrame;
- (UILabel *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints;
- (UILabel *(^)(UIColor *))xmhBackgroundColor;
- (UILabel *(^)(CGFloat))xmhCornerRadius;
- (UILabel *(^)(CGFloat))xmhBorderWidth;
- (UILabel *(^)(UIColor *))xmhBorderColor;
@end
XMHCreateClass(UILabel, XMHConvenient2, XMHUILabelConvenient2Protocol)

@protocol XMHUIImageViewConvenient2Protocol <NSObject>
@optional
+ (UIImageView *(^)(UIView *))xmhNewAndSuperView;
- (UIImageView *(^)(UIView *))xmhSuperView;
- (UIImageView *(^)(CGRect))xmhFrame;
- (UIImageView *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints;
- (UIImageView *(^)(UIColor *))xmhBackgroundColor;
- (UIImageView *(^)(CGFloat))xmhCornerRadius;
- (UIImageView *(^)(CGFloat))xmhBorderWidth;
- (UIImageView *(^)(UIColor *))xmhBorderColor;
@end
XMHCreateClass(UIImageView, XMHConvenient2, XMHUIImageViewConvenient2Protocol)

@protocol XMHUIUITextFieldConvenient2Protocol <NSObject>
@optional
+ (UITextField *(^)(UIView *))xmhNewAndSuperView;
- (UITextField *(^)(UIView *))xmhSuperView;
- (UITextField *(^)(CGRect))xmhFrame;
- (UITextField *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints;
- (UITextField *(^)(UIColor *))xmhBackgroundColor;
- (UITextField *(^)(CGFloat))xmhCornerRadius;
- (UITextField *(^)(CGFloat))xmhBorderWidth;
- (UITextField *(^)(UIColor *))xmhBorderColor;
@end
XMHCreateClass(UITextField, XMHConvenient2, XMHUIUITextFieldConvenient2Protocol)

@protocol XMHUIUITextViewConvenient2Protocol <NSObject>
@optional
+ (UITextView *(^)(UIView *))xmhNewAndSuperView;
- (UITextView *(^)(UIView *))xmhSuperView;
- (UITextView *(^)(CGRect))xmhFrame;
- (UITextView *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints;
- (UITextView *(^)(UIColor *))xmhBackgroundColor;
- (UITextView *(^)(CGFloat))xmhCornerRadius;
- (UITextView *(^)(CGFloat))xmhBorderWidth;
- (UITextView *(^)(UIColor *))xmhBorderColor;
@end
XMHCreateClass(UITextView, XMHConvenient2, XMHUIUITextViewConvenient2Protocol)

@protocol XMHUIControlConvenient2Protocol <NSObject>
@optional
+ (UIControl *(^)(UIView *))xmhNewAndSuperView;
- (UIControl *(^)(UIView *))xmhSuperView;
- (UIControl *(^)(CGRect))xmhFrame;
- (UIControl *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints;
- (UIControl *(^)(UIColor *))xmhBackgroundColor;
- (UIControl *(^)(CGFloat))xmhCornerRadius;
- (UIControl *(^)(CGFloat))xmhBorderWidth;
- (UIControl *(^)(UIColor *))xmhBorderColor;
- (UIControl *(^)(UIControlEvents controlEvents, void(^)(UIButton *)))xmhAddEvent;
@end
XMHCreateClass(UIControl, XMHConvenient2, XMHUIControlConvenient2Protocol)

@protocol XMHUIButtonConvenient2Protocol <NSObject>
@optional
+ (UIButton *(^)(UIView *))xmhNewAndSuperView;
- (UIButton *(^)(UIView *))xmhSuperView;
- (UIButton *(^)(CGRect))xmhFrame;
- (UIButton *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints;
- (UIButton *(^)(UIColor *))xmhBackgroundColor;
- (UIButton *(^)(CGFloat))xmhCornerRadius;
- (UIButton *(^)(CGFloat))xmhBorderWidth;
- (UIButton *(^)(UIColor *))xmhBorderColor;
- (UIButton *(^)(UIControlEvents controlEvents, void(^)(UIButton *)))xmhAddEvent;
@end
XMHCreateClass(UIButton, XMHConvenient2, XMHUIButtonConvenient2Protocol)

NS_ASSUME_NONNULL_END
