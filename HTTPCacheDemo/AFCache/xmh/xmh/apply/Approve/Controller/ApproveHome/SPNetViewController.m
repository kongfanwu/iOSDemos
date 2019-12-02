//
//  SPNetViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/29.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SPNetViewController.h"
#import "SPRequest.h"

@interface SPNetViewController ()

@end

@implementation SPNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNav];
//    [self request1];
//    [self request3];
    [self request4];
}

- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"NetTest" withleftImageStr:@"back" withRightStr:nil];
    
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nav];
    
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
};



//获得待我、抄送审批的未读数量
- (void)request1{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"] = @"61b3204d0c0c7ad30a6d1bfc48911896";
    params[@"join_code"] = @"SJ000003";
    params[@"account_id"] = @"222";
    [SPRequest requestGetNumParams:params resultBlock:^(SPGetNumModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        
    }];
}
//搜索顾客
- (void)request3{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"] = @"61b3204d0c0c7ad30a6d1bfc48911896";
    params[@"account"] = @"18337678567";
    params[@"fram_id"] = @"1";
    params[@"keyword"] = @"18337678567";
    [SPRequest requestSearchUserParams:params resultBlock:^(SPSearchUserModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        
    }];
}

//会员冻结发起审批
- (void)request4{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"] = @"61b3204d0c0c7ad30a6d1bfc48911896";
    params[@"account"] = @"18337678567";
    params[@"fram_id"] = @"1";
    params[@"join_code"] = @"SJ000003";
    params[@"user_id"] = @"222";
    [SPRequest requestCongealUserParams:params resultBlock:^(SPCongealModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        
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
