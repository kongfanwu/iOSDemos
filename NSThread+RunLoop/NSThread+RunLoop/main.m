//
//  main.m
//  NSThread+RunLoop
//
//  Created by kfw on 2019/7/30.
//  Copyright © 2019 kfw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    /*
     Autorelease对象什么时候释放？
     在非手动添加Autorelease pool下，Autorelease对象是在当前runloop 循环 进入休眠等待前 被释放的
     http://www.cocoachina.com/articles/10107
     
     1 即将进入Loop
     _objc_autoreleasePoolPush() 创建自动释放池
     
     2 即将进入休眠
     _objc_autoreleasePoolPop() 释放旧的池
     _objc_autoreleasePoolPush() 创建新池
     
     3 即将退出Loop
     _objc_autoreleasePoolPop() 释放旧的池
     */
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
