//
//  XMHAlertAction.h
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XMHAlertActionStyle) {
    XMHAlertActionStyleDefault = 0,   // 默认样式，文字黑色
    XMHAlertActionStyleMostly,        // 主要样式，文字主题色
    XMHAlertActionStyleDestructive,   // 警示样式，文字红色
    XMHAlertActionStyleCustom         // 自定义样式，文字颜色自定义
};

@interface XMHAlertAction : NSObject

/// 默认初始化方法
/// @param title 显示的文字
/// @param style 按钮样式
/// @param handler 回调
+ (instancetype)actionWithTitle:(nullable NSString *)title style:(XMHAlertActionStyle)style handler:(void (^ __nullable)(XMHAlertAction *action))handler;

/// 自定义样式初始化方法
/// @param button 按钮对象
/// @param handler 回调
+ (instancetype)actionWithButton:(nullable UIButton *)button handler:(void (^ __nullable)(XMHAlertAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) XMHAlertActionStyle style;
@property (nonatomic, strong, readonly) UIButton *button;
@property (nonatomic, getter=isEnabled) BOOL enabled;

- (XMHAlertAction *(^)(BOOL))xmhEnable;
@end

#pragma mark - Category

@interface XMHAlertAction(Private)

/// 创建按钮，通过action对象
/// @param action action
+ (UIButton *)buttonFromAction:(XMHAlertAction *)action;

@end

NS_ASSUME_NONNULL_END
