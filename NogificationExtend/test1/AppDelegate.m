//
//  AppDelegate.m
//  test1
//
//  Created by KFW on 2018/9/29.
//  Copyright © 2018 KFW. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"权限 %d", granted);
    }];
    
    [self sendMsg];
    return YES;
}

- (void)sendMsg {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"hello" arguments:nil];
    content.subtitle = @"subtitle";
    content.body = [NSString localizedUserNotificationStringForKey:@"body" arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @1;
    content.categoryIdentifier = @"category";
    content.launchImageName = @"banner";
    
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"head" ofType:@"png"];
    UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"head" URL:[NSURL fileURLWithPath:imgPath] options:nil error:nil];
    
    NSString *imgPath2 = [[NSBundle mainBundle] pathForResource:@"git.jpg" ofType:nil];
    UNNotificationAttachment *att2 = [UNNotificationAttachment attachmentWithIdentifier:@"head" URL:[NSURL fileURLWithPath:imgPath2] options:nil error:nil];
    
    content.attachments = @[att2];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    UNNotificationRequest *req = [UNNotificationRequest requestWithIdentifier:@"timeSecond" content:content trigger:trigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:req withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
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
