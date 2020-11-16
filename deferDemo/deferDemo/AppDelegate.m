//
//  AppDelegate.m
//  deferDemo
//
//  Created by kfw on 2019/6/19.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "AppDelegate.h"
#import "NSArray+XMHMap.h"
#import "Person.h"
@interface AppDelegate ()
///
@property (nonatomic, strong) NSArray <NSString *> *arr;

//- (instancetype)initWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
///
@property (nonatomic, copy) void (^block)(NSString *name, ...);

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    self.arr = @[@"1", @"2", @"3", @"4"];
//    NSArray *result = _arr.xmh_map(^id (id obj){
//        return [NSString stringWithFormat:@"%@%@", obj, obj];
//    });
//    NSLog(@"result=%@", result); // 11 22  33
//
//    NSArray *result2 = _arr.xmh_map2(^id (NSUInteger idx, NSString *obj) {
//        return [obj isEqualToString:@"2"] ? nil : obj; // 返回 nil 过滤
//    });
//    NSLog(@"result2=%@", result2); // 11  33
//
//    NSInteger sum = _arr.xmh_reduce(0, ^NSInteger (NSInteger x, NSInteger y) {
//        return x + y;
//    });
//    NSLog(@"sum = %ld", sum);
    
    [self setBlock:^(NSString *name, ...){
        va_list args;
        va_start(args, name); // scan for arguments after firstObject.
        // get rest of the objects until nil is found
        for (NSString *str = name; str != nil; str = va_arg(args,NSString*)) {
            NSLog(@"------:%@", str);
        }
        
        va_end(args);
    }];
    self.block(@"1", @"2", @"3", nil);
    
    Person.new.xmhText(@"4", @"5", @"6", nil);
    
    
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
