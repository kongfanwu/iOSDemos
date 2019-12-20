//
//  FWLoginVC.m
//  FWRACDEmo
//
//  Created by kfw on 2019/12/20.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "FWLoginVC.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "ReactiveObjC-umbrella.h"
#import "VMLoginViewModel.h"


@interface FWLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) VMLoginViewModel *loginVM;
@end

@implementation FWLoginVC

- (VMLoginViewModel *)loginVM{
    if (!_loginVM){
        _loginVM = [[VMLoginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    RAC(self.loginVM,account) = _accountTF.rac_textSignal;
    RAC(_loginBtn,enabled) = self.loginVM.btnEnableSignal;
    [self.loginVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录成功，跳转页面");
    }];
    
    @weakify(self);
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击了  点击了");
        @strongify(self);
        [self.loginVM.loginCommand execute:@{@"account":self.accountTF.text}];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
