//
//  LNavigationController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/15.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LNavigationController.h"
#import "MsgRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "BaseModel.h"
@interface LNavigationController ()

@end

@implementation LNavigationController
static LNavigationController *_instance;

- (void)dealloc
{
    MzzLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
     MzzLog(@"self.viewControllers.count   :  %ld.......................",self.viewControllers.count);
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    NSArray *tmpJoin_code_arr = infomodel.data.join_code;
    NSString * joincode = @"";
    if (tmpJoin_code_arr.count) {
        Join_Code *jon_code = tmpJoin_code_arr[0];
        joincode = jon_code.code;
    }
    if (self.viewControllers.count == 1) {
        NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
        [param setValue:accountId forKey:@"account_id"];
        [param setValue:joincode forKey:@"join_code"];
        [MsgRequest requestUnReadNumParma:param resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                NSString * num = [NSString stringWithFormat:@"%@",model.data[@"num"]];
                if (num.integerValue > 999) {
                    num = @"999+";
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:Nav_MsgCount object:num];
            }
        }];
    }
    return YES;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:YES];
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
   return  [super popViewControllerAnimated:YES];
}
@end
