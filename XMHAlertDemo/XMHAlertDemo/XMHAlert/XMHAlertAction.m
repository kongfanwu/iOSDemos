//
//  XMHAlertAction.m
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/23.
//

#import "XMHAlertAction.h"
#import "XMHAlertTool.h"
#import "UIView+Exting.h"

@interface XMHAlertAction()
@property (nullable, nonatomic) NSString *title;
@property (nonatomic) XMHAlertActionStyle style;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) void (^handler)(XMHAlertAction *action);

@end

@implementation XMHAlertAction

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.enabled = YES;
    }
    return self;
}

/// 默认初始化方法
/// @param title 显示的文字
/// @param style 按钮样式
/// @param handler 回调
+ (instancetype)actionWithTitle:(nullable NSString *)title style:(XMHAlertActionStyle)style handler:(void (^ __nullable)(XMHAlertAction *action))handler {
    XMHAlertAction *action = XMHAlertAction.new;
    action.title = title;
    action.style = style;
    action.handler = handler;
    return action;
}

/// 自定义样式初始化方法
/// @param button 按钮对象
/// @param handler 回调
+ (instancetype)actionWithButton:(nullable UIButton *)button handler:(void (^ __nullable)(XMHAlertAction *action))handler {
    XMHAlertAction *action = XMHAlertAction.new;
    action.style = XMHAlertActionStyleCustom;
    action.button = button;
    action.handler = handler;
    
    [button addTarget:action action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.enabled = action.enabled;
    return action;
}

- (XMHAlertAction *(^)(BOOL))xmhEnable {
    return ^XMHAlertAction *(BOOL enable){
        self.enabled = enable;
        return self;
    };
}

- (void)buttonClick:(UIButton *)sender {
    UIViewController *vc = [sender viewController];
    [vc dismissViewControllerAnimated:YES completion:nil];
    if (self.handler) {
        self.handler(self);
        self.handler = nil;
    }
}

@end

#pragma mark - Category

@implementation XMHAlertAction(Private)

/// 创建按钮，通过action对象
/// @param action action
+ (UIButton *)buttonFromAction:(XMHAlertAction *)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:action.title forState:UIControlStateNormal];
    [button setTitleColor:[self colorFromAction:action] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIView imageWithColor:UIColor.whiteColor size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIView imageWithColor:[UIColor colorWithWhite:0.f alpha:0.1] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    
    [button addTarget:action action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.enabled = action.enabled;
    action.button = button;
    return button;
}

+ (UIColor *)colorFromAction:(XMHAlertAction *)action {
    switch (action.style) {
        case XMHAlertActionStyleDefault:
            return kActionDefaultColor;
            break;
        case XMHAlertActionStyleMostly:
            return kActionMostlyColor;
            break;
        case XMHAlertActionStyleDestructive:
            return kActionDestructiveColor;
            break;
        default:
            return kActionDefaultColor;
            break;
    }
}



@end
