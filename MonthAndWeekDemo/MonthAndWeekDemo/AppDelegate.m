//
//  AppDelegate.m
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/1.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "AppDelegate.h"
#import "Aspects.h"
#import "XMHMonthAndWeekModel.h"

@interface AppDelegate ()
/** <#type#> */
@property (nonatomic, copy) BOOL (^block)(NSString *a);
/** <##> */
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.array = NSMutableArray.new;
    
    XMHMonthAndWeekModel *m = XMHMonthAndWeekModel.new;

    __weak XMHMonthAndWeekModel *m2 = m;
    [_array addObject:m];
    
    m = nil;
    
//    [self setBlock:^BOOL(NSString *a) {
//        NSLog(@"%@", a);
//        return YES;
//    }];
//
//    BOOL r = self.block(@"name");
//    NSLog(@"%ld", r);
    
//    [self test:^BOOL(NSString * a) {
//        NSLog(@"%@", a);
//        return YES;
//    }];

    [self aspect_hookSelector:@selector(pringa:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo, NSString *string) {
        NSLog(@"%@: %@ %@", aspectInfo.instance, aspectInfo.arguments, string);
//        return @"xiaoming";
        NSString * processTouches;
        NSInvocation *invocation = aspectInfo.originalInvocation;
        [invocation invoke];
        [invocation getReturnValue:&processTouches];
        
        if (processTouches) {
            processTouches =  @"xiaoming";//pspdf_stylusShouldProcessTouches(touches, event);
            [invocation setReturnValue:&processTouches];
        }
    } error:NULL];
    
    NSString *res = [self pringa:@"kongfanwu"];
    NSLog(@"res:%@", res);
    return YES;
}

- (NSString *)pringa:(NSString *)name {
    return @"futing";
}

- (void)test:(BOOL(^)(NSString * a))block {
    NSLog(@"test");
    BOOL m = block(@"123");
    NSLog(@"m:%ld", m);
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
