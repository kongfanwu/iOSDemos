//
//  AppDelegate+XMHUMengPush.m
//  xmh
//
//  Created by ald_ios on 2019/5/28.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#import "AppDelegate+XMHUMengPush.h"
//#import "UMessage.h"
#import <UMPush/UMessage.h>    // // Push组件
#import <UserNotifications/UserNotifications.h>   //// Push组件必须的系统库
#import <objc/runtime.h>
#import "XMHOutComeNoteVC.h"
#import "XMHUMPushRespManager.h"
#import "XMHOutComeFactory.h"
static char UserInfoKey;

@interface AppDelegate () <UNUserNotificationCenterDelegate>
@end

@implementation AppDelegate (XMHUMengPush)
#pragma mark - Configure UMessage SDK

- (void)configureUMessageWithAppKey:(NSString *)appKey launchOptions:(NSDictionary *)launchOptions {
  /*
    // 设置AppKey & LaunchOptions
    [UMessage startWithAppkey:appKey launchOptions:launchOptions];

    // 注册
    [UMessage registerForRemoteNotifications];

    // 开启Log
    [UMessage setLogEnabled:YES];

    // 检查是否为iOS 10以上版本
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {

        // 如果检查到时iOS 10以上版本则必须执行以下操作
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate                  = self;
        UNAuthorizationOptions types10   = \
        UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound;

        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {

            if (granted) {

                // 点击允许
                // 这里可以添加一些自己的逻辑
            } else {

                // 点击不允许
                // 这里可以添加一些自己的逻辑
            }
        }];

    }
    
    */
    // 设置是否允许SDK自动清空角标
    [UMessage setBadgeClear:NO];
    // Push功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
 
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
        entity.categories=categories;
    }
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
              NSLog(@"用户选择了接收push消息");
        }else{
              NSLog(@"用户拒绝接收Push消息");
        }
    }];
 
    //由本地通知启动
    UILocalNotification * localNotify = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if(localNotify)
    {
        NSLog(@"本地通知启动");
    }
    // 由远程通知启动
    NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo)
    {
        [self handleUMPush:userInfo];
         NSLog(@"远程通知启动");
    }

}

#pragma mark - UMessage Delegate Methods

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo {

    // 关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    // 统计点击次数
    [UMessage didReceiveRemoteNotification:userInfo];

    [self xmh_setUserInfo:userInfo];

    // 定制自己的弹出框
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:userInfo[@"aps"][@"alert"]
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView bk_setHandler:^{
            [UMessage sendClickReportForRemoteNotification:[self xmh_getUserInfo]];
        } forButtonAtIndex:0];
    }
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //注册deviceToken，现在不用手动注册，但测试模式下要将deviceToken添加到Umeng后台的测试设备中 [UMessage registerDeviceToken:deviceToken];
    [UMessage registerDeviceToken:deviceToken];
    NSLog(@"deviceToken = %@",[[[[deviceToken description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""]);
    [YFKeychainTool saveKeychainValue:[[[[deviceToken description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""] key:kAPP_DEVICETOKEN];
    
}
// iOS 10新增: 处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{

    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {

        //应用处于前台时的远程推送接受
        //关闭友盟自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];

    }else{

        NSLog(@"应用处于前台时的本地推送接受");
        //应用处于前台时的本地推送接受
    }

    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound |
                      UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
        withCompletionHandler:(void (^)())completionHandler{

    NSDictionary * userInfo = response.notification.request.content.userInfo;
   
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {

        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [self handleUMPush:userInfo];

    }else{
        NSLog(@"应用处于前台时的本地推送接受");
        //应用处于后台时的本地推送接受
    }
}
//当app没有启动的时候或者被杀掉的时候将无法收到静默推送。 静默推送必须实现 application:didReceiveRemoteNotification:fetchCompletionHandler:
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//
//    [UMessage sendClickReportForRemoteNotification:[self xmh_getUserInfo]];
//}

- (void)xmh_setUserInfo:(NSDictionary *)userInfo {

    objc_setAssociatedObject(self, &UserInfoKey, userInfo, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)xmh_getUserInfo {

    if (objc_getAssociatedObject(self, &UserInfoKey)) {

        return objc_getAssociatedObject(self, &UserInfoKey);
    } else {

        return nil;
    }
}

// 处理友盟推送
- (void)handleUMPush:(NSDictionary *)userInfo
{
    NSLog(@"handleUMPush_userInfo == %@",userInfo);
    /**
    userInfo == {
     aps =     {
     alert =         {
     body = 4444;
     subtitle = "";
     title = "";
     };
     "mutable-content" = 1;
     name = xiaoming;
     sound = default;
     };
     d = uug387k156111072779810;
     p = 0;
     }
     */
    
    
    if (userInfo)
    {
        // test
        UIViewController *currentVC =  [XMHVCTools getCurrentViewController];
        
//        XMHOutComeNoteVC *gkglVc = [[XMHOutComeNoteVC alloc]init];
//        // 跳转的控制器进行数据处理，则成为代理，实现方法
//        [XMHUMPushRespManager sharedManager].delegate = gkglVc;
//        [XMHUMPushRespManager handleOpenUserInfo:userInfo];
//        [currentVC.navigationController pushViewController:gkglVc animated:YES];
//        [UMessage setWebViewClassString:@""];
        id vc =  [XMHOutComeFactory createOutComeVCMsgModel:nil pushUserInfo:userInfo isUMPush:YES];
        [currentVC.navigationController pushViewController:(UIViewController *)vc animated:YES];
    }
}
@end
#pragma clang diagnostic pop
