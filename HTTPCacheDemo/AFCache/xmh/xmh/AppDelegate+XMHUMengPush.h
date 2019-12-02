//
//  AppDelegate+XMHUMengPush.h
//  xmh
//
//  Created by ald_ios on 2019/5/28.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (XMHUMengPush) 
//@property (nonatomic, strong) NSDictionary *userInfo;
/**
 配置友盟推送
 
 @param appKey 友盟appkey
 @param launchOptions App launchOptions
 */
- (void)configureUMessageWithAppKey:(NSString *)appKey launchOptions:(NSDictionary *)launchOptions;

/**
 给类别属性赋值
 
 @param userInfo 推送消息字典
 */
- (void)xmh_setUserInfo:(NSDictionary *)userInfo;

/**
 获取类别属性值
 
 @return 暂存的推送消息
 */
- (NSDictionary *)xmh_getUserInfo;
@end

NS_ASSUME_NONNULL_END
