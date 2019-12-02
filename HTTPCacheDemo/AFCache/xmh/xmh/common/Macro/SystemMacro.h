//
//  SystemMacro.h
//  iCard
//
//  Created by lujunjing on 16-08-02.
//  Copyright (c) 2016年 woaika.com. All rights reserved.
//   工程所有系统的宏定义

#ifndef iCard_SystemMacro_h
#define iCard_SystemMacro_h


#pragma mark -
#pragma mark 系统信息宏
//浏览器特性版本
static NSString *const Version_Browser = @"1.5";
//版本号
#define Version_iCard [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//系统版本
#define IOS7_OR_LATER                           ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS8_OR_LATER                           ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )

//系统判断宏定义
#define iPhone5                                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//系统判断宏定义
#define iPhone4                                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否是iOS7
#define IOS7                                    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

//判断是否是iOS8
#define IOS8                                    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//判断是否是iOS10
#define IOS10                                   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
//APPID
static NSString *const APPID_iCard = @"783533977";

#define  WeakSelf  __weak typeof(self) weakSelf = self;

#endif

