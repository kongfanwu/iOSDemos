//
//  UIControl+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/14.
//  Copyright © 2019 神灯智能. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (XMHConvenient)

- (UIControl *(^)(UIControlEvents controlEvents, void(^)(UIControl *)))xmhAddEvent;
- (UIControl *(^)(UIControlEvents controlEvents))xmhRemoveEvent;

@end

NS_ASSUME_NONNULL_END
