//
//  SizeMacro.h
//  iCard
//
//  Created by lujunjing on 16-08-02.
//  Copyright (c) 2016年 woaika.com. All rights reserved.
//   工程所有尺寸大小的宏定义

#ifndef iCard_SizeMacro_h
#define iCard_SizeMacro_h



//获取屏幕 宽度、高度
//#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
//#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)

//#define I6_I5                           (SCREEN_WIDTH >= 375.0) ？(((667/375)/(568/320)) : ((568/320)/(667/375)));

//#define IS_IPHONE_X         ((SCREEN_HEIGHT == 812.0f) ? YES : NO) // 不推荐使用

// iPhone X ，XR，XS ，XS Max等。
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})


#define IS_IPHONE_X (IPHONE_X)

//#define IS_IPHONE_X (IPHONE_X);


//其他设备和4寸屏幕的高比例
#define SCREEN_HEIGHT_SALE              (((SCREEN_HEIGHT / 568.0) > 1) ? (SCREEN_HEIGHT / 568.0) : 1)

//其他设备和iphone6的高比例
#define I6_HEIGHT_SALE                  (SCREEN_HEIGHT / 667.0)

//UI图对照各机型的高度
#define RealH(a)                        ((a)/2.0*I6_HEIGHT_SALE)
#define RealW(a)                        ((a)/2.0)
//用于文字布局 //其他设备和6屏幕的宽比例
#define New_SCREEN_WIDTH_SALE           ((SCREEN_WIDTH >= 375.0) ? (SCREEN_WIDTH / 375.0) : 1)


#define WIDTH_SALE_BASE                 (SCREEN_WIDTH / 375.0)



#define WIDTH_SELFVIEW                  (self.view.frame.size.width)
#define HEIGHT_SELFVIEW                 (self.view.frame.size.height)
#define WIDTH_SELF                      (self.frame.size.width)
#define HEIGHT_SELF                     (self.frame.size.height)
#define WindowSize                      ([[UIScreen mainScreen] currentMode].size)

#define Above10 (([UIDevice currentDevice].systemVersion.doubleValue >=10.0)?YES:NO)
//Nav高度
static NSInteger const Heigh_NavBar    = 44;
//Nav高度
static NSInteger const Heigh_StatusBar = 20;
//Nav高度
#define Heigh_NavBarAndStatusBar        (IOS7 ? Heigh_StatusBar+Heigh_NavBar : Heigh_NavBar)
//动态定义top Y坐标，ios7留20
#define IOS7_OFFSET                     (IOS7 ? 20 : 0)
#define IOS7_Content_OFFSET             (IOS7 ? 64 : 44)

#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define KNaviBarHeight     (StatusBarHeight>20?88:64) // 适配iPhone x 顶栏高度
#define KTabbarHeight     (StatusBarHeight>20?83:49) // 适配iPhone x 底栏高度

//各个页面Nav的高度
#define Heigh_Nav (KNaviBarHeight)        //(IS_IPHONE_X ? 88 : 64)
//tabbar的高度
#define Heigh_Tabbar (KTabbarHeight)      //(IS_IPHONE_X ? 83 : 49)
//view的可用高度
#define Heigh_View                     (SCREEN_HEIGHT - Heigh_Nav - Heigh_Tabbar)
#define Heigh_View_normal              (SCREEN_HEIGHT - Heigh_Nav)


#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define KNaviBarHeight     (StatusBarHeight>20?88:64) // 适配iPhone x 顶栏高度
#define KTabbarHeight     (StatusBarHeight>20?83:49) // 适配iPhone x 底栏高度

// 导航栏高
#define kNavigationBarHeight (44)

// 上安全区域高
#define kSafeAreaTop \
({CGFloat safeAreaTop = 0;\
if (@available(iOS 11.0, *)) {\
    safeAreaTop = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.top;\
} else {\
    safeAreaTop = [[UIApplication sharedApplication] statusBarFrame].size.height;\
}\
(safeAreaTop);})

// 下安全区域高
#define kSafeAreaBottom \
({CGFloat safeAreaBottom = 0;\
if (@available(iOS 11.0, *)) {\
safeAreaBottom = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;\
}\
(safeAreaBottom);})

// 安全区域高
#define kSafeHeight (SCREEN_HEIGHT - kSafeAreaTop - kSafeAreaBottom)

// 导航VC内容高，不包括导航栏高
#define kNavContentHeight (kSafeHeight - kNavigationBarHeight)

// 简化代码的宏
// 读取nib
#define loadNibName(className) [[[NSBundle mainBundle]loadNibNamed:className owner:nil options:nil]lastObject]

//
#define UIImageName(className) [UIImage imageNamed:className]

#define URLSTR(className) [NSURL URLWithString:className]

#define kNotice(className) [[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ToastName" ofType:@"plist"]]objectForKey:className]

#define kMargin 15

#endif

