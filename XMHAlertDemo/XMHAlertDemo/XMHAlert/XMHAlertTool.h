//
//  XMHAlertTool.h
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/23.
//

#ifndef XMHAlertTool_h
#define XMHAlertTool_h

#pragma mark - Tool

#define XMHScreenWidth [UIScreen mainScreen].bounds.size.width
#define XMHScreenHeight [UIScreen mainScreen].bounds.size.height

#define XMHRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define XMHRGBAHexA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]


#pragma mark - Configure

#define kLineColor XMHRGBHex(0xECECEC)
#define kLineHeight 0.5

#define kTitleColor XMHRGBHex(0x333333) // title颜色
#define kMessageColor XMHRGBHex(0x666666) // message 颜色

#define kActionDefaultColor XMHRGBHex(0x333333)
#define kActionMostlyColor XMHRGBHex(0xE73462)
#define kActionDestructiveColor XMHRGBHex(0xFF1300)

#define kTitleFont [UIFont systemFontOfSize:18]
#define kMessageFont [UIFont systemFontOfSize:14]

#endif /* XMHAlertTool_h */
