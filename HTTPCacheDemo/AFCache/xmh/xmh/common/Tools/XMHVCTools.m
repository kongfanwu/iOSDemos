//
//  XMHVCTools.m
//  xmh
//
//  Created by ald_ios on 2019/5/16.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHVCTools.h"

@implementation XMHVCTools
+ (BOOL)isHaveVCByName:(NSString *)vcName
{
    UIWindow * w  = [UIApplication sharedApplication].keyWindow;
    UINavigationController * nav = (UINavigationController *)w.rootViewController;
    for (int i = 0; i < nav.viewControllers.count; i++) {
        UIViewController * VC = nav.viewControllers[i];
        Class class =  NSClassFromString(vcName);
        if ([VC isKindOfClass:class]) {
            return YES;
        }
    }
    return NO;
}

/**
 获得当前的控制器

 @return 当前的控制器
 */
+ (UIViewController *)getCurrentViewController{
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    UIViewController* currentViewController = window.rootViewController;
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}
@end
