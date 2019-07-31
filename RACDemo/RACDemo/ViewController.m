//
//  ViewController.m
//  RACDemo
//
//  Created by KFW on 2018/11/16.
//  Copyright © 2018 KFW. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa.h>
#import "model.h"
#import <Masonry.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.ml = model.new;
//
//    RAC(self.label, text, @"foobar") = self.tf.rac_textSignal;
//    RAC(self.ml, name) = self.tf.rac_textSignal;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        NSLog(@"%@", self.ml.name);
//    });
//
//    [RACObserve(self.ml, name) subscribeNext:^(id x) {
//
//        NSLog(@"RACObserve:%@", x);
//    }];
//
//    self.button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        NSLog(@"%@", input);
//        return [RACSignal empty];
//    }];
//
//    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        NSLog(@"---:%@", x);
//    }];
    _userTF.text = @"123";
    RAC(self.loginButton, selected) = [RACSignal combineLatest:@[self.userTF.rac_textSignal,self.pwdTF.rac_textSignal] reduce:^(NSString *userName, NSString *password) {
            NSLog(@"%@ %@", userName, password);
            return @(userName.length > 0 && password.length > 0);
        }];
    
   
}


@end
