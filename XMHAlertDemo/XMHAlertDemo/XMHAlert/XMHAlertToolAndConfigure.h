//
//  XMHAlertTool.h
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/23.
//

#ifndef XMHAlertToolAndConfigure_h
#define XMHAlertToolAndConfigure_h

#pragma mark - Tool

#define XMHAlertScreenWidth [UIScreen mainScreen].bounds.size.width
#define XMHAlertScreenHeight [UIScreen mainScreen].bounds.size.height

#define XMHRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define XMHRGBAHexA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]


#pragma mark - Configure

#define kAlertLineColor XMHRGBHex(0xECECEC)
#define kAlertLineHeight 0.5

#define kAlertTitleColor XMHRGBHex(0x333333) // title颜色
#define kAlertMessageColor XMHRGBHex(0x666666) // message 颜色

#define kAlertActionDefaultColor XMHRGBHex(0x333333)
#define kAlertActionMostlyColor XMHRGBHex(0xE73462)
#define kAlertActionDestructiveColor XMHRGBHex(0xFF1300)

#define kAlertTitleFont [UIFont systemFontOfSize:18]
#define kAlertMessageFont [UIFont systemFontOfSize:14]

#endif /* XMHAlertTool_h */
