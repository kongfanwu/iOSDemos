//
//  XMHUserManager.h
//  xmh
//
//  Created by ald_ios on 2019/4/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LoginModel,LolUserInfoModel,Join_Code;
@interface XMHUserManager : NSObject
singleton_interface(XMHUserManager)

/**
 是否登陆

 @return YES or NO
 */
- (BOOL)isLogin;
/**
 登出
 */
- (void)logOut;

/**
 保存登陆账号密码

 @param account 账号
 @param password 密码
 */
- (void)saveAccount:(NSString *)account password:(NSString *)password;

/**
 保存用户信息

 @param userInfo  userInfo
 */
- (void)saveUserInfo:(LolUserInfoModel *)userInfo;

/**
 获取用户账号

 @return account
 */
- (NSString *)getUserAccount;

/**
 获取用户ID

 @return 用户ID
 */
- (NSString *)getUserAccountID;

/**
 获取joinCode

 @return joinCode
 */
- (NSString *)getUserCurrentJoinCode;
/**
 获取FramID

 @return FramID
 */
- (NSString *)getUserFramID;

/**
 获取多品牌

 @return 获取多品牌array
 */
- (NSArray *)getUserJoinCodes;

/**
 获取用户主权限

 @return 主权限
 */
- (NSString *)getUserMainRole;

/**
 获取用户所有权限

 @return 用户所有权限
 */
- (NSArray *)getUserAllRoles;
/**
 切换品牌 JoinCode

 @param join_code 切换品牌 JoinCode
 */
- (void)setUserCurrentJoinCode:(Join_Code *)join_code;

/**
 获取登陆账号密码

 @return 获取登陆账号密码
 */
- (LoginModel *)getLoginInfo;
@end
@interface LoginModel : NSObject
/** 账号 */
@property (nonatomic, strong, readonly)NSString *account;
/** 密码 */
@property (nonatomic, strong, readonly)NSString *password;
/** 设置账号密码 */
- (void)setAccount:(NSString *)account password:(NSString *)password;
@end
NS_ASSUME_NONNULL_END
