//
//  AppDelegate.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/10/31.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#import "AppDelegate.h"
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
#import "JYCWindow.h"
#import "MzzNewfeatureController.h"
#import "UserManager.h"
#import "LNavigationController.h"
#import "UserInfoRequest.h"
#import<CoreTelephony/CTCellularData.h>
#import <UMCommon/UMCommon.h>
#import "UpdateRequest.h"
#import <UMAnalytics/DplusMobClick.h>
#import <UMAnalytics/MobClick.h>
#import "MessageVC.h"
#import "MainViewController.h"
#import "LanternHomeVC.h"
#import <UMShare/UMShare.h>
#import "XMHTestVC.h"
#import "AppDelegate+XMHUMengPush.h"
#ifdef DEBUG
#import <DoraemonKit/DoraemonManager.h>
#endif
#import <UMPush/UMessage.h>    // // Push组件

@interface AppDelegate ()

@property(nonatomic,strong)JYCWindow *jycWindow;
@property(nonatomic,strong)NSDictionary *launchOptions;
@end
@implementation AppDelegate
{
//    MainViewController * _main;
//    LNavigationController *_rootNav;
}
- (void)chooseRootViewController{
    // 获取软件当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    // 获取本地保存的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sandboxVersion = [defaults valueForKey:@"sandboxVersion"];
//    NSLog(@"sandboxVersion = %@", sandboxVersion);
    // 判断是否需要显示新特性
    if ([currentVersion compare:sandboxVersion] == NSOrderedDescending) {
        // 更新本地保存的版本号
        [defaults setValue:currentVersion forKey:@"sandboxVersion"];
        self.window.rootViewController = [[MzzNewfeatureController alloc] init];
    }else{
        if ([YFKeychainTool readKeychainValue:@"password"]) {
            [self check];
        }else{
            self.window.rootViewController = [[LoginViewController alloc] init];
        }
    }
}

- (void)check{
    NSString *userName = [YFKeychainTool readKeychainValue:@"userName"];
    NSString *password = [YFKeychainTool readKeychainValue:@"password"];
    [[[UserInfoRequest alloc]init] requestLoginAccount:userName Password:password  resultBlock:^(LolUserInfoModel *longinModel, BOOL isSuccess, NSDictionary *errorDic) {
        if(isSuccess){
            if (longinModel.code ==1) {
                [XMHProgressHUD showOnlyText:@"登录成功"];
                [SVProgressHUD dismissWithCompletion:^{
                    [self rootController];
                }];
            }else{
                [XMHProgressHUD showOnlyText:longinModel.msg];
                self.window.rootViewController = [[LoginViewController alloc] init];
            }
        }else{
              [XMHProgressHUD showOnlyText:errorDic[@"error"]];
              self.window.rootViewController = [[LoginViewController alloc] init];
        }
       
    }];
}

- (void)rootController
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
    
    LNavigationController *rootNav = [[LNavigationController alloc]initWithRootViewController:tabBarController];
    rootNav.navigationBar.hidden = YES;
    self.window.rootViewController = rootNav;
    
#elif SERVER_MAIN == 1
    MainViewController * main = [[MainViewController alloc] init];
    _main = main;
    LNavigationController *rootNav = [[LNavigationController alloc]initWithRootViewController:main];
    _rootNav = rootNav;
    rootNav.navigationBar.hidden = YES;
    self.window.rootViewController = rootNav;
    
#else

#endif
    
    
    
}
- (void)messageCount:(NSNotification *)not{
    UITabBarItem * item = [_main.tabBar.items objectAtIndex:0];
    NSString * num = [NSString stringWithFormat:@"%@",not.object];
    if (num.integerValue == 0) {
        item.badgeValue = nil;
    }else{
        item.badgeValue = num;
        item.badgeColor = kColorTheme;
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置全局状态栏颜色
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
#ifdef DEBUG
//    [[DoraemonManager shareInstance] install];
#endif
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    //检查网络情况
//    if (Above10) {
//        [self networkStatus:application didFinishLaunchingWithOptions:launchOptions];
//    }else {
//        //2.2已经开启网络权限 监听网络状态
//        [self addReachabilityManager:application didFinishLaunchingWithOptions:launchOptions];
//    }
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = NSClassFromString(@"XMHTestVC").new;
    return YES;
    
//    [self.window makeKeyAndVisible];
//    _launchOptions = launchOptions;
//    //初始化友盟模块
//    [self initUmengSDK];
//    //检查版本更新
//    [self examineUpdate];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chooseRootViewController) name:AppDelegate_ChooseRoot object:nil];
//    [self chooseRootViewController];
//
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(messageCount:) name:Nav_MsgCount object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mainRoot) name:AppDelegate_LoginSuccess object:nil];
    return YES;
}

- (void)mainRoot
{
    if (!_main) {
        MainViewController * main = [[MainViewController alloc] init];
        _main = main;
        LNavigationController *rootNav = [[LNavigationController alloc]initWithRootViewController:main];
        _rootNav = rootNav;
        rootNav.navigationBar.hidden = YES;
        self.window.rootViewController = rootNav;
    }else{
        [_main setSelectedIndex:2];
        _main.selectIndex = 2;
        self.window.rootViewController = _rootNav;
    }
   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==0){//稍后再说
        
    }else if (buttonIndex == 1){//立即安装
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",@"1376509234"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        
    }
}
- (void)showAlertView
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"版本更新" message:@"欢迎您下载使用新版本" delegate:self cancelButtonTitle:nil otherButtonTitles:@"稍后再说",@"立即安装" ,nil];
    [alert show];
}
- (void)examineUpdate
{
    WeakSelf
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    [param setValue:currentVersion forKey:@"version_name"];
    [param setValue:@"2" forKey:@"phone_type"];
    [UpdateRequest requestVersionParam:param resultBlock:^(NSDictionary *dataDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            if ([dataDic[@"update"] integerValue] ==1) {//跳转appStore
                [weakSelf showAlertView];
            }else if([dataDic[@"update"] integerValue] ==0){//隐藏
                
            }else{
                
            }
        }
    }];
}
- (void)initUmengSDK
{
    [UMConfigure setLogEnabled:NO];
    [UMConfigure initWithAppkey:@"5b5ebf8a8f4a9d79c00001a0" channel:nil];
    [MobClick setScenarioType:E_UM_DPLUS];
    
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    /* 设置微信的appKey和appSecret */
    NSString * const kWechatKey = @"wxe8907453bd507468";
    NSString * const kWechatSecret = @"a1b79b5d962e4004a5d60934de4a4487";
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWechatKey appSecret:kWechatSecret redirectURL:@"http://mobile.umeng.com/social"];
//    [self configureUMessageWithAppKey:@"5b5ebf8a8f4a9d79c00001a0" launchOptions:_launchOptions];
}
/*
 CTCellularData在iOS9之前是私有类，权限设置是iOS10开始的，所以App Store审核没有问题
 获取网络权限状态
 */
- (void)networkStatus:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //2.根据权限执行相应的交互
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    
    /*
     此函数会在网络权限改变时再次调用
     */
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
        switch (state) {
            case kCTCellularDataRestricted:
                
                NSLog(@"Restricted");
                //2.1权限关闭的情况下 再次请求网络数据会弹出设置网络提示
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请到设置-网络中设置网络权限" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                break;
            case kCTCellularDataNotRestricted:
                
                NSLog(@"NotRestricted");
                //2.2已经开启网络权限 监听网络状态
                [self addReachabilityManager:application didFinishLaunchingWithOptions:launchOptions];
                //                [self getInfo_application:application didFinishLaunchingWithOptions:launchOptions];
                break;
            case kCTCellularDataRestrictedStateUnknown:
                
                NSLog(@"Unknown");
                //2.3未知情况 （还没有遇到推测是有网络但是连接不正常的情况下）
                
                break;
                
            default:
                break;
        }
    };
}
/**
 实时检查当前网络状态
 */
- (void)addReachabilityManager:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"网络不通：%@",@(status) );
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"网络通过WIFI连接：%@",@(status));
                
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"网络通过无线连接：%@",@(status) );
               
                break;
            }
            default:
                break;
        }
    }];
    
    [afNetworkReachabilityManager startMonitoring];  //开启网络监视器；
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
#pragma clang diagnostic pop
