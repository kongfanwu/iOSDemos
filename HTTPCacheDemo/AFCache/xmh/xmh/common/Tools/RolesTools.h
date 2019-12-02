//
//  RolesTools.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/8/8.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//  权限类

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,RoleType) {
    RoleTypeNone,
    RoleTypeGuanLi,
    RoleTypeCaiWu,
    RoleTypeDianJingLi,
    RoleTypeJiShuDianZhang,
    RoleTypeXiaoShouDianZhang,
    RoleTypeShouQianDianZhang,
    RoleTypeQianTai,
    RoleTypeShouHouMeiRongShi,
    RoleTypeShouQianMeiRongShi,
    RoleTypeShouZhongMeiRongShi,
    RoleTypeDaoGou
    
};
@interface RolesTools : NSObject
/** 权限介绍
 *
 *  1管理层
 *  2财务人员
 *  3店经理
 *  4技术店长
 *  5销售店长
 *  6售前店长
 *  7前台
 *  8售后美容师
 *  9售前美容师
 *  10售中美容师
 *  11导购
*/
+ (NSInteger)getUserMainRole;
+ (NSArray *)getUserAllRoles;
//************************会工作快捷入口权限***********************************
/*
 *跳转美丽定制权限
 */
+ (BOOL)workPushMLDZVC;
/*
 *跳转账单矫正权限
 */
+ (BOOL)workPushToZDJZVC;
/*
 *跳转会员冻结权限
 */
+ (BOOL)workPushToHYDJVC;
/*
 *跳转申请退款权限
 */
+ (BOOL)workPushToSQTKVC;

/*
 *跳转开服务单权限
 */
+ (BOOL)workPushToKFWDVC;
/*
 *跳转开销售单权限
 */
+ (BOOL)workPushToKXSDVC;
/*
 *跳转会员调店
 */
+ (BOOL)workPushToHYTDVC;
/*
 *跳转一键预约
 */
+ (BOOL)workPushToYJYYVC;

/*
 *跳转添加顾客
 */
+ (BOOL)workPushToTJGKVC;
//************************应用模块入口权限***********************************
/*
 *应用模块进入审批应用权限
 */
+ (BOOL)applyPushToApproveVC;

/*
 *应用模块进入线上交易权限
 */
+ (BOOL)applyPushToDealOnlineVC;

/*
 *应用模块进入卡项统计权限
 */
+ (BOOL)applyPushToCardVC;
/*
 *应用模块进入负债统计权限
 */
+ (BOOL)applyPushToFuZhaiVC;
/*
 *应用模块进入只能管家权限
 */
+ (BOOL)applyPushToSmartStewardVC;
//***********************层级权限***********************************
/*
 *层级权限
 */
+ (NSInteger)getCengJiQuanXian;
+ (BOOL)isYuanGongQuanXian;

/*
 * 顾客管理是否显示添加顾客按钮
 */
+ (BOOL)customerShowBtnQuanxian;

/** 是否显示开处方按钮 */
+ (BOOL)beautyOrderShowBtnQuanxian;

/** 是否是美容师权限 */
+ (BOOL)bookMeiRongShiQuanxian;

/** 是否有跳转到美丽问诊的权限 */
+ (BOOL)beautyCanPushToMLWZ;

/** 是否有跳转到快速开单的权限 */
+ (BOOL)orderReverseFlowPush;

//+ (BOOL)Lantern

//***********************预约管理***********************************
/** 员工店长权限 */
+ (BOOL)bookStaffLimits;

/** 员工店长权限 */
+ (BOOL)bookShopManagerLismits;

+ (BOOL)bookManagerLismits;

/** 优惠券权限 */
+ (BOOL)couponLimits;
@end
