//
//  AppDelegate.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/10/31.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNavigationController.h"
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/** <##> */
@property (nonatomic, strong) LNavigationController *rootNav;
/** <##> */
@property (nonatomic, strong) MainViewController * main;
///////
@end

