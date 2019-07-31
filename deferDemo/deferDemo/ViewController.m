//
//  ViewController.m
//  deferDemo
//
//  Created by kfw on 2019/6/19.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "ViewController.h"


/*
 函数执行完最后执行。 与swift defer 函数一样。
 示例：
 OnBlockExit(block_1) {
    NSLog(@"OnBlockExit 1");
 };
 */
//#ifdef __GNUC__
//__unused static void cleanUpBlock(__strong void(^*block)(void)) {
//    (*block)();
//}
//#define OnBlockExit(block_name) __strong void(^block_name)(void) __attribute__((cleanup(cleanUpBlock), unused)) = ^
//#endif


void cleanup_block(int *a) {
    printf("%d\n", *a);
}



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    int variable __attribute__((cleanup(cleanup_block))) = 2;
    
//    OnBlockExit(block_1) {
//        NSLog(@"OnBlockExit 1");
//    };
//    OnBlockExit(block_2) {
//        NSLog(@"OnBlockExit 2");
//    };
//    OnBlockExit(block_3) {
//        NSLog(@"OnBlockExit 3");
//    };
//    OnBlockExit(w) {
//        NSLog(@"OnBlockExit 4");
//    };
//
//    NSLog(@"End");
}

@end
