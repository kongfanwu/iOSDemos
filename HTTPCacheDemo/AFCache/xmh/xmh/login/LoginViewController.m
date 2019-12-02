//
//  LoginViewController.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/14.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "UserInfoRequest.h"
#import "LLTabBar.h"
#import "LLTabBarItem.h"
#import "MessageViewController.h"
#import "StatisticsViewController.h"
#import "WorkViewController.h"
#import "ApplyViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "RegistViewController.h"
#import "NSString+DE.h"
#import "UserInfoRequest.h"
#import "NSString+Check.h"
#import "LNavigationController.h"
#import "ApplicationInViewController.h"
#import "MainViewController.h"
#import "LanternHomeVC.h"
#import "AppDelegate.h"
@interface LoginViewController ()<UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *numberView;
@property (weak, nonatomic) IBOutlet UIView *passWordView;
@property (weak, nonatomic) IBOutlet UITextField *numberText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (strong, nonatomic)UILabel *lbTitle;//环境切换
@property (weak, nonatomic) IBOutlet UIImageView *bg;


@end

@implementation LoginViewController
-(UILabel *)lbTitle
{
    if (!_lbTitle) {
        _lbTitle=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, _lbTitle.width, _lbTitle.height)];
        _lbTitle.textColor=[UIColor whiteColor];
        _lbTitle.font=FONT_SIZE(14);
//        if (SERVER == 0) {
//            _lbTitle.text = @"测试环境";
//            _lbTitle.hidden = NO;
//        }else if (SERVER == 1){
//            _lbTitle.text = @"验收环境";
//            _lbTitle.hidden = NO;
//        }else if (SERVER == 2){
//            _lbTitle.text = @"正式环境";
//            _lbTitle.hidden = YES;
//        }else{
//            
//        }
        _lbTitle.text = @"测试环境";
        [self configURLTag:0];
        [_lbTitle sizeToFit];
    }
    return _lbTitle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.passWordText.secureTextEntry = YES;
    [self.view addSubview:self.lbTitle];
    _bg.userInteractionEnabled = YES;
    
#ifdef DEBUG
    [_bg bk_whenTapped:^{
        [self showAlert];
    }];
#else
    _lbTitle.hidden = YES;
    
#endif
   
}
- (void)showAlert
{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请选择服务器地址" message:[NSString stringWithFormat:@"当前地址为:%@",_lbTitle.text] preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *testUrl = [UIAlertAction actionWithTitle:@"测试环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [XMHProgressHUD showOnlyText:@"测试环境"];
        _lbTitle.text = @"测试环境";
        [self configURLTag:0];
       
    }];
    UIAlertAction *checkUrl = [UIAlertAction actionWithTitle:@"验收环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [XMHProgressHUD showOnlyText:@"验收环境"];
        _lbTitle.text = @"验收环境";
        [self configURLTag:1];
       
    }];
//    UIAlertAction *productUrl = [UIAlertAction actionWithTitle:@"正式环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////        [XMHProgressHUD showOnlyText:@"正式环境"];
//        _lbTitle.text = @"正式环境";
//    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:testUrl];
    [alertController addAction:checkUrl];
//    [alertController addAction:productUrl];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)configURLTag:(NSInteger)tag
{
    if (tag ==0) {
        [[NSUserDefaults standardUserDefaults] setObject:@"http://192.168.1.200/index.php/" forKey:@"SERVER_APP"];
        [[NSUserDefaults standardUserDefaults] setObject:@"http://192.168.1.200:8082/" forKey:@"SERVER_H5"];
        [[NSUserDefaults standardUserDefaults] setObject:@"http://192.168.1.200/count.php/" forKey:@"SERVER_COUNT"];
        [[NSUserDefaults standardUserDefaults] setObject:@"http://192.168.1.200/statistics.php/" forKey:@"SERVER_REPORT"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"http://pc.test.api.shendengzhineng.com/index.php/" forKey:@"SERVER_APP"];
        [[NSUserDefaults standardUserDefaults] setObject:@"http://v5.test.html.b.aixmh.com/" forKey:@"SERVER_H5"];
        [[NSUserDefaults standardUserDefaults] setObject:@"http://pc.test.api.shendengzhineng.com/count.php/" forKey:@"SERVER_COUNT"];
        [[NSUserDefaults standardUserDefaults] setObject:@"http://pc.test.api.shendengzhineng.com/statistics.php/" forKey:@"SERVER_REPORT"];
    }
}
- (IBAction)clickAction:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    __weak LoginViewController * weakSelf = self;
    
    RegistViewController * registVC = [[RegistViewController alloc]init];
    registVC.successBlock = ^(BOOL isOk) {
        [weakSelf toRootController];
    };
    if ([btn.titleLabel.text isEqualToString:@"登录"]) {
        
        if ([self.numberText.text isEqualToString:@""]) {
            [XMHProgressHUD showOnlyText:@"请先输入手机号"];
            return;
        }
        if (![self.numberText.text isMobileNumber]) {
            [XMHProgressHUD showOnlyText:@"请输入正确的手机号"];
            return;
        }
        if (self.passWordText.text.length && self.numberText.text.length && [self.numberText.text isMobileNumber]) {
            [[[UserInfoRequest alloc]init] requestLoginAccount:self.numberText.text Password:[self.passWordText.text encryptWithMd5] resultBlock:^(LolUserInfoModel *longinModel, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    [XMHProgressHUD showOnlyText:@"登录成功"];
                    [SVProgressHUD dismissWithCompletion:^{
                        [self.passWordText resignFirstResponder];
                        [self.numberText resignFirstResponder];
                        [weakSelf toRootController];
                    }];
                }else{
                    [XMHProgressHUD showOnlyText:errorDic[@"error"]];
                }
            }];
        }
    }else if ([btn.titleLabel.text isEqualToString:@"申请入驻"]){
        ApplicationInViewController *applicationVC = [[ApplicationInViewController alloc]init];
        [self presentViewController:applicationVC animated:nil completion:nil];

    }else{
        [self presentViewController:registVC animated:nil completion:nil];
        if ([btn.titleLabel.text isEqualToString:@"忘记密码 ？"]) {
            registVC.title = @"忘记密码";
        }else{
            registVC.title = btn.titleLabel.text;
        }
    }
}
- (void)toRootController
{
    
    
#if  SERVER_MAIN == 0
    
    MessageViewController *messageViewController = [[MessageViewController alloc] init];
    LanternHomeVC *statisticsViewController = [[LanternHomeVC alloc] init];
    WorkViewController *workViewController = [[WorkViewController alloc] init];
    ApplyViewController *applyViewController = [[ApplyViewController alloc] init];
    MineViewController *mineViewController = [[MineViewController alloc] init];
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[messageViewController, statisticsViewController, workViewController, applyViewController,mineViewController];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabBarController.tabBar.bounds];
    if (IS_IPHONE_X) {
        UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, tabBar.bottom, SCREEN_WIDTH, 34)];
        cover.backgroundColor = [UIColor whiteColor];
        [tabBarController.tabBar addSubview:cover];
    }
    tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"消息", kLLTabBarItemAttributeNormalImageName : @"xiaoxi_weixuan", kLLTabBarItemAttributeSelectedImageName : @"xiaoxi_xuanzhong", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"AI灯神", kLLTabBarItemAttributeNormalImageName : @"aishendeng_weixuan", kLLTabBarItemAttributeSelectedImageName : @"aishendeng_xuanzhong", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"会工作", kLLTabBarItemAttributeNormalImageName : @"huigongzuo_weixuan", kLLTabBarItemAttributeSelectedImageName : @"huigongzuo_kuaijierukouxuanzhong", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"应用", kLLTabBarItemAttributeNormalImageName : @"yingyong_weixuanzhong", kLLTabBarItemAttributeSelectedImageName : @"yingyong_xuanzhong", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"我的", kLLTabBarItemAttributeNormalImageName : @"wode_weixuan", kLLTabBarItemAttributeSelectedImageName : @"wode_xuanzhong", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];
    tabBar.tabbarVc  = tabBarController;
    [tabBar setSelectedIndex:2];
    [tabBarController.tabBar addSubview:tabBar];
    //    tabBarController.selectedViewController =workViewController;
    
    LNavigationController *rootNav = [[LNavigationController alloc]initWithRootViewController:tabBarController];
    rootNav.navigationBar.hidden = YES;
    [UIApplication sharedApplication].keyWindow.rootViewController = rootNav;
    
#elif SERVER_MAIN == 1
    ((AppDelegate *)[UIApplication sharedApplication].delegate).rootNav = nil;
    ((AppDelegate *)[UIApplication sharedApplication].delegate).main = nil;
    ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = nil;
    
    MainViewController * main = [[MainViewController alloc] init];
    LNavigationController *rootNav = [[LNavigationController alloc]initWithRootViewController:main];
    rootNav.navigationBar.hidden = YES;
    [UIApplication sharedApplication].keyWindow.rootViewController = rootNav;
    ((AppDelegate *)[UIApplication sharedApplication].delegate).rootNav = rootNav;
    ((AppDelegate *)[UIApplication sharedApplication].delegate).main = main;
#else
    
#endif
    
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

@end
