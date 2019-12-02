//
//  XMHUserManager.m
//  xmh
//
//  Created by ald_ios on 2019/4/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUserManager.h"
#import "LolUserInfoModel.h"
@interface XMHUserManager ()
/** 商家编码 */
@property (nonatomic, copy)NSString * userJoinCode;
/** 登陆账号 */
@property (nonatomic, copy)NSString * userAccount;
/** 登录人ID */
@property (nonatomic, copy)NSString * userAccountID;
/** 登录人层级ID */
@property (nonatomic, copy)NSString * userFramID;
/** 登录人joinCode信息 */
@property (nonatomic, strong)Join_Code * join_code;
/** 登陆成功后信息model */
@property (nonatomic, strong)LolUserInfoModel * userInfoModel;
@end


static NSString * kUserAccount = @"account";
static NSString * kUserPassword = @"password";
static NSString * kUserInfo = @"userInfo";
@implementation XMHUserManager
singleton_implementation(XMHUserManager)

- (instancetype)init
{
    if (self = [super init]) {
        _join_code = [[Join_Code alloc] init];
    }
    return self;
}
- (void)saveAccount:(NSString *)account password:(NSString *)password
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:account forKey:kUserAccount];
    [userDefaults setObject:password forKey:kUserPassword];
    [userDefaults synchronize];
}
- (BOOL)isLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults objectForKey:kUserAccount];
    if (account.length > 0) {
        return YES;
    }
    return NO;
}
- (void)logOut
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kUserAccount];
    [userDefaults removeObjectForKey:kUserPassword];
    [userDefaults removeObjectForKey:kUserInfo];
    [userDefaults synchronize];
    
    /** 清空数据 */
    _userInfoModel = nil;
    _userFramID = nil;
    _userJoinCode = nil;
    _userAccount = nil;
    _userAccountID = nil;
}
- (void)saveUserInfo:(LolUserInfoModel *)userInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (userDefaults){
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
        [userDefaults setObject:data forKey:kUserInfo];
        [userDefaults synchronize];
    }
    if (!_userInfoModel) {
        NSData * userInfoData = [userDefaults objectForKey:kUserInfo];
        _userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userInfoData];
    }    
    _userInfoModel = userInfo;
    _userAccountID = [NSString stringWithFormat:@"%ld",_userInfoModel.data.ID];
    _userAccount = _userInfoModel.data.account;
    /** 默认joinCode 为数组第一位 */
    _join_code = _userInfoModel.data.join_code[0];
    Join_Code * join_code = _join_code;
    _userJoinCode = join_code.code;
    _userFramID = [NSString stringWithFormat:@"%ld",join_code.fram_id];
}
/** 获取用户账号 */
- (NSString *)getUserAccount
{
    return _userAccount;
}
/** 获取用户ID */
- (NSString *)getUserAccountID
{
    return _userAccountID;
}
/** 获取joinCode */
- (NSString *)getUserCurrentJoinCode
{
    return _userJoinCode;
}
/** 获取FramID */
- (NSString *)getUserFramID
{
    return _userFramID;
}
/** 获取多品牌 */
- (NSArray *)getUserJoinCodes
{
    return _userInfoModel.data.join_code;
}
/** 切换品牌 JoinCode */
- (void)setUserCurrentJoinCode:(Join_Code *)join_code
{
    _join_code = join_code;
    _userFramID = [NSString stringWithFormat:@"%ld",_join_code.fram_id];
    _userJoinCode = _join_code.code;
}
/** 获取登陆账号密码 */
- (LoginModel *)getLoginInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    LoginModel * login = [[LoginModel alloc]init];
    [login setAccount:[userDefaults objectForKey:kUserAccount] password:[userDefaults objectForKey:kUserPassword]];
    return login;
}
/** 获取用户主权限 */
- (NSString *)getUserMainRole
{
    return [NSString stringWithFormat:@"%ld",_join_code.framework_function_main_role];
}
/** 获取用户所有权限 */
- (NSArray *)getUserAllRoles
{
    return _join_code.framework_function_role;
}
@end

@interface LoginModel ()

@end
@implementation LoginModel
- (void)setAccount:(NSString *)account password:(NSString *)password
{
    _account = account;
    _password = password;
}
@end

