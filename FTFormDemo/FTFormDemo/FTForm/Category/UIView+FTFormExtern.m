//
//  UIView+FTFormExtern.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/11.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "UIView+FTFormExtern.h"

@implementation UIView (FTFormExtern)

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (UITableView *)tableView {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableView class]]) {
            return (UITableView*)nextResponder;
        }
    }
    return nil;
}

@end
