//
//  UIView+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/13.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

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

@interface UILabel (XMHConvenient2)
+ (UILabel *(^)(UIView *))xmhNewAndSuperView;
- (UILabel *(^)(UIView *))xmhSuperView;
- (UILabel *(^)(CGRect))xmhFrame;
- (UILabel *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints;
- (UILabel *(^)(UIColor *))xmhBackgroundColor;
- (UILabel *(^)(CGFloat))xmhCornerRadius;
- (UILabel *(^)(CGFloat))xmhBorderWidth;
- (UILabel *(^)(UIColor *))xmhBorderColor;
@end
@implementation UILabel (XMHConvenient2)
@end

@interface UIImageView (XMHConvenient2)
+ (UIImageView *(^)(UIView *))xmhNewAndSuperView;
- (UIImageView *(^)(UIView *))xmhSuperView;
- (UIImageView *(^)(CGRect))xmhFrame;
- (UIImageView *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints;
- (UIImageView *(^)(UIColor *))xmhBackgroundColor;
- (UIImageView *(^)(CGFloat))xmhCornerRadius;
- (UIImageView *(^)(CGFloat))xmhBorderWidth;
- (UIImageView *(^)(UIColor *))xmhBorderColor;
@end
@implementation UIImageView (XMHConvenient2)
@end

@interface UITextField (XMHConvenient2)
+ (UITextField *(^)(UIView *))xmhNewAndSuperView;
- (UITextField *(^)(UIView *))xmhSuperView;
- (UITextField *(^)(CGRect))xmhFrame;
- (UITextField *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints;
- (UITextField *(^)(UIColor *))xmhBackgroundColor;
- (UITextField *(^)(CGFloat))xmhCornerRadius;
- (UITextField *(^)(CGFloat))xmhBorderWidth;
- (UITextField *(^)(UIColor *))xmhBorderColor;
@end
@implementation UITextField (XMHConvenient2)
@end

@interface UITextView (XMHConvenient2)
+ (UITextView *(^)(UIView *))xmhNewAndSuperView;
- (UITextView *(^)(UIView *))xmhSuperView;
- (UITextView *(^)(CGRect))xmhFrame;
- (UITextView *(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints;
- (UITextView *(^)(UIColor *))xmhBackgroundColor;
- (UITextView *(^)(CGFloat))xmhCornerRadius;
- (UITextView *(^)(CGFloat))xmhBorderWidth;
- (UITextView *(^)(UIColor *))xmhBorderColor;
@end
@implementation UITextView (XMHConvenient2)
@end

@interface UIControl (XMHConvenient2)
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
@implementation UIControl (XMHConvenient2)
@end

@interface UIButton (XMHConvenient2)
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
@implementation UIButton (XMHConvenient2)
@end

NS_ASSUME_NONNULL_END
