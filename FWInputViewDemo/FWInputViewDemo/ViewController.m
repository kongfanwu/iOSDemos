//
//  ViewController.m
//  FWInputViewDemo
//
//  Created by KFW on 2019/1/28.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "ViewController.h"
#import "FWInputView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FWInputView *inputView = [[FWInputView alloc] initWithFrame:CGRectMake(0,
                                                                           self.view.window.frame.size.height,
                                                                           self.view.frame.size.width,
                                                                           kFWInputViewHeight)];
    [self.view.window addSubview:inputView];
}


@end
