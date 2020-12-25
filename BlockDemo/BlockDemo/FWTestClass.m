//
//  FWTestClass.m
//  BlockDemo
//
//  Created by kfw on 2020/12/21.
//

#import "FWTestClass.h"

@implementation FWTestClass

- (void)method1 {
    NSInteger num = 3;
    NSInteger(^myBlock)(NSInteger) = ^NSInteger(NSInteger n){
        return n * num;
    };
    myBlock(2);
}

static NSInteger num3 = 300;
NSInteger num4 = 3000;
- (void)method2
{
    NSInteger num = 30;
    static NSInteger num2 = 3;
    __block NSInteger num5 = 30000;
    void(^block)(void) = ^{
        NSLog(@"%zd",num);//局部变量
        NSLog(@"%zd",num2);//静态变量
        NSLog(@"%zd",num3); //全局静态变量
        NSLog(@"%zd",num4);//全局变量
        NSLog(@"%zd",num5);//__block修饰变量
    };
    
    block();
}

@end
