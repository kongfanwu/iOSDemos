//
//  UIViewController+XMHAdditions.m
//  xmh
//
//  Created by kfw on 2019/6/24.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "UIViewController+XMHAdditions.h"

@implementation UIViewController (XMHAdditions)

/**
 从navagation搜索VC
 */
- (UIViewController *)searchNavigationStackClassVC:(Class)vcCls {
    NSString *vcStr = NSStringFromClass(vcCls);
    return [self searchNavigationStackStringVC:vcStr];
}

/**
 从navagation搜索VC
 */
- (UIViewController *)searchNavigationStackStringVC:(NSString *)vcStr {
    __block UIViewController *vc;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *currentVCStr = NSStringFromClass(obj.class);
        if ([currentVCStr isEqualToString:vcStr]) {
            vc = obj;
            *stop = YES;
        }
    }];
    return vc;
}

@end
