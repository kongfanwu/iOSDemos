//
//  AppDelegate.m
//  NS_OPTIONSDemo
//
//  Created by kfw on 2019/9/20.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "AppDelegate.h"
typedef NS_OPTIONS(NSInteger, SeasonType) {
    //bitmask （位掩码）:1111
    SeasonTypeMask      = 255,
    SeasonSpring        = 1 << 0,   //春天1    0001  '<<'左移运算
    SeasonSummer        = 1 << 1,   //夏天2    0010
    SeasomAutumn        = 1 << 2,   //秋天4    0100
    SeasonWinter        = 1 << 3,   //冬天8    1000
};
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //定义一个SeasonType表示春夏两个季节
    SeasonType seasonType =  SeasonTypeMask;//| SeasomAutumn | SeasonWinter;
    //对应的进行按位或运算seasonType = 0001 | 0010 = 0011
    
    //添加冬季
//    seasonType = seasonType | SeasonWinter;
    //或者
    //seasonType  |= SeasonWinter；
    //对应的进行按位或运算seasonType = 0011 | 1000 = 1011
    //此时seasonType同时表示了三种枚举分别是春、夏、冬
    
    //如果再把冬季去掉可以这样
//    seasonType = seasonType & ~SeasonWinter;
    //或者
    //seasonType &= ~SeasonWinter;
    //对应的运算为 seasonType = 1011 & （~1000） = 1011 & 0111 = 0011；
    //此时seasonType又只表示了春夏两个季节。
    
    NSInteger a = seasonType & SeasonSpring;
    NSInteger b = seasonType & SeasonSummer;
    NSInteger c = seasonType & SeasomAutumn;
    NSInteger d = seasonType & SeasonWinter;
    NSInteger e = seasonType & SeasonTypeMask;
    
//    if (seasonType & SeasonSpring) {
//        NSLog(@"SeasonSpring");
//    }
//    if (seasonType & SeasonSummer) {
//        NSLog(@"SeasonSummer");
//    }
//    if (seasonType & SeasomAutumn) {
//        NSLog(@"SeasomAutumn");
//    }
//    if (seasonType & SeasonWinter) {
//        NSLog(@"SeasonWinter");
//    }
    
    switch (seasonType & SeasonTypeMask) {
        case SeasonSpring:
            NSLog(@"SeasonSpring");
            break;
        case SeasonSummer:
            NSLog(@"SeasonSummer");
            break;
        case SeasomAutumn:
            NSLog(@"SeasomAutumn");
            break;
        case SeasonWinter:
            NSLog(@"SeasonWinter");
            break;
        case SeasonTypeMask:
            NSLog(@"SeasonTypeMask");
            break;
        default:
            break;
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
