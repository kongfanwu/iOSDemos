//
//  ViewController.m
//  BlockDemo
//
//  Created by kfw on 2020/12/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block NSInteger num5 = 1;
    void(^block)(void) = ^{
        num5 = 2;
        NSLog(@"3:%zd",num5);//__block修饰变量
    };
    num5 = 3;
    NSLog(@"1:%zd",num5);//__block修饰变量
    block();

    NSLog(@"2:%zd",num5);//__block修饰变量
}


@end
