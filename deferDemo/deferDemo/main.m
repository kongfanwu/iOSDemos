//
//  main.m
//  deferDemo
//
//  Created by kfw on 2019/6/19.
//  Copyright © 2019 kfw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

__attribute__((constructor))
static void beforeMain(void) {
    NSLog(@"beforeMain");
}
__attribute__((destructor))
static void afterMain(void) {
    NSLog(@"afterMain");
}

int  tabs(int a)
__attribute__((diagnose_if(a >= 0, "12333", "warning")));

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        int val =tabs(1); // warning: Redundant abs call
//        int val3 = tabs(val);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
