//
//  RolesTools.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/8/8.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RolesTools.h"
#import "ShareWorkInstance.h"
#import "ApproveRequest.h"
#import "BaseModel.h"
#import "XMHUserManager.h"
@implementation RolesTools
+ (NSInteger)getUserMainRole
{
    return [ShareWorkInstance shareInstance].share_join_code.framework_function_main_role;
//    return [[[XMHUserManager sharedXMHUserManager]getUserMainRole]integerValue];
}
+ (NSArray *)getUserAllRoles
{
    return [ShareWorkInstance shareInstance].share_join_code.framework_function_role;
//    return [[XMHUserManager sharedXMHUserManager]getUserAllRoles];
}
//************************会工作快捷入口权限***********************************
//美丽定制
+ (BOOL)workPushMLDZVC
{
    NSArray * roles = @[@"1",@"3",@"7",@"11"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?NO:YES;
}
//账单矫正
+ (BOOL)workPushToZDJZVC
{    
    return NO;
}
//会员冻结
+ (BOOL)workPushToHYDJVC
{
    return YES;
}
//申请退款
+ (BOOL)workPushToSQTKVC
{
    return YES;
}
//开服务单
+ (BOOL)workPushToKFWDVC
{
    NSArray * roles = @[@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?YES:NO;
}
//开销售单
+ (BOOL)workPushToKXSDVC
{
    NSArray * roles = @[@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?YES:NO;
}
//会员调店
+ (BOOL)workPushToHYTDVC
{
    return YES;
}
//一键预约
+ (BOOL)workPushToYJYYVC
{
    NSArray * roles = @[@"4",@"5",@"6",@"8",@"9",@"10"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?YES:NO;
}
//添加顾客
+ (BOOL)workPushToTJGKVC
{
    NSArray * roles = @[@"1",@"2"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?NO:YES;
}
//************************审批模块入口曲线***********************************
//应用模块进入审批应用权限
+ (BOOL)applyPushToApproveVC
{
    return [[RolesTools getUserAllRoles]containsObject:@"3"]?YES:NO;
}
//应用模块进入线上交易
+ (BOOL)applyPushToDealOnlineVC
{
    NSArray * roles = @[@"1",@"3",@"7"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?YES:NO;
}
//应用模块进入卡项统计权限
+ (BOOL)applyPushToCardVC
{
    return [RolesTools getUserMainRole]==11?NO:YES;
}
//应用模块进入卡项统计权限
+ (BOOL)applyPushToFuZhaiVC
{
    return [RolesTools getUserMainRole]==11?NO:YES;
}

//应用模块进入只能管家权限
+ (BOOL)applyPushToSmartStewardVC
{
    NSArray * roles = @[@"1",@"2"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?NO:YES;
}
+(BOOL)orderReverseFlowPush
{
    NSArray * roles = @[@"7"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?YES:NO;
}

//***********************层级权限***********************************
//层级权限
+ (NSInteger)getCengJiQuanXian
{
    
    NSInteger role = [RolesTools getUserMainRole];
    if (role == 1) {
        return 0;
    }else if (role == 3){
        return 1;
    }else if(role == 4 ||role == 5 ||role == 6 ||role == 7 ){
        return 2;
    }else{
        return 2;
    }
}
+ (BOOL)isYuanGongQuanXian
{
    NSArray * roles = @[@"1",@"3",@"4",@"5",@"6"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?YES:NO;
}

// 顾客管理是否显示添加顾客按钮
 
+ (BOOL)customerShowBtnQuanxian
{
    NSArray * roles = @[@"1",@"2"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?NO:YES;
}
+ (BOOL)beautyOrderShowBtnQuanxian
{
    NSArray * roles = @[@"4",@"5",@"6",@"8",@"9",@"10"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?YES:NO;
}
+ (BOOL)bookMeiRongShiQuanxian
{
    NSArray * roles = @[@"4",@"5",@"6",@"8",@"9",@"10"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?YES:NO;
}

+ (BOOL)beautyCanPushToMLWZ
{
    NSArray * roles = @[@"4",@"5",@"6",@"8",@"9",@"10"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?YES:NO;
}
+ (BOOL)bookStaffLimits
{
    NSArray * roles = @[@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    return [roles containsObject:mainrole]?YES:NO;
}
+ (BOOL)bookShopManagerLismits
{
    if ([RolesTools getUserMainRole] == 3) {
        return YES;
    }
    return NO;
}
+ (BOOL)bookManagerLismits
{
    if ([RolesTools getUserMainRole] == 1) {
        return YES;
    }
    return NO;
}
/** 优惠券权限 */
+ (BOOL)couponLimits
{
    return [ShareWorkInstance shareInstance].share_join_code.is_active_role?YES:NO;
}
@end
