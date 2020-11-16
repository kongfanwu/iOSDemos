//
//  UIView+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/13.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

// 创建分类
#define XMHConvenientCreateCateory(ClassType, CategoryName, ProtocolName) \
@interface ClassType (CategoryName) <ProtocolName> \
@end \
@implementation ClassType (CategoryName) \
@end \

// 创建协议、分类，并让分类遵循协议。 ...动态参数为协议需要添加的方法
#define XMHConvenientCreateProtocolAndCategory(ClassType, ...) \
@protocol XMH##ClassType##Convenient2Protocol <NSObject> \
@optional \
XMHConvenientUIViewMethods(__kindof ClassType *, \
__VA_ARGS__ \
) \
@end \
XMHConvenientCreateCateory(ClassType, XMHConvenient2, XMH##ClassType##Convenient2Protocol) \

// 定义UIControl基类方法
#define XMHConvenientUIControlMethods(ClassType, ...) \
__VA_ARGS__ \
- (__kindof ClassType (^)(UIControlEvents controlEvents, void(^)(ClassType)))xmhAddEvent; \

// 定义UIView基类方法
#define XMHConvenientUIViewMethods(ClassType, ...) \
__VA_ARGS__ \
+ (ClassType (^)(UIView *))xmhNewAndSuperView; \
- (ClassType(^)(UIView *))xmhSuperView; \
- (ClassType(^)(CGRect))xmhFrame; \
- (ClassType(^)(void(^)(MASConstraintMaker *)))xmhMakeConstraints; \
- (ClassType(^)(UIColor *))xmhBackgroundColor; \
- (ClassType(^)(CGFloat))xmhCornerRadius; \
- (ClassType(^)(CGFloat))xmhBorderWidth; \
- (ClassType(^)(UIColor *))xmhBorderColor; \

NS_ASSUME_NONNULL_BEGIN

// 可直接写成此宏，考虑此文件是UIVeiw和应该有示例代码。此处不替换。
//XMHConvenientCreateProtocolAndCategory(UIView,
//+ (instancetype)xmhNew;
//)
@protocol XMHUIViewConvenient2Protocol <NSObject>
@optional
XMHConvenientUIViewMethods(__kindof UIView *,
+ (instancetype)xmhNew;
)
@end
XMHConvenientCreateCateory(UIView, XMHConvenient2, XMHUIViewConvenient2Protocol)


XMHConvenientCreateProtocolAndCategory(UILabel)
XMHConvenientCreateProtocolAndCategory(UIImageView)
XMHConvenientCreateProtocolAndCategory(UITextField)
XMHConvenientCreateProtocolAndCategory(UITextView)
XMHConvenientCreateProtocolAndCategory(UIControl,
    XMHConvenientUIControlMethods(UIControl *)
    // 在此可添加协议方法定义。例如：
    // - (void)test;
)
XMHConvenientCreateProtocolAndCategory(UIButton,
    XMHConvenientUIControlMethods(UIButton *)
)
XMHConvenientCreateProtocolAndCategory(UITableView)

NS_ASSUME_NONNULL_END
