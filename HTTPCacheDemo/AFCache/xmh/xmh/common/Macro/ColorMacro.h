//
//  ColorMacro.h
//  iCard
//
//  Created by lujunjing on 16-08-02.
//  Copyright (c) 2016年 woaika.com. All rights reserved.
//   工程所有颜色的宏定义

#ifndef iCard_ColorMacro_h
#define iCard_ColorMacro_h


#pragma mark -
#pragma mark 颜色转换宏定义

#define RGBColor(r,g,b)                         [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorWithAlpha(r,g,b,a)              [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
//主题颜色
#define Theme_Color                             RGBColor(212,60,51)
//主题红色
#define Theme_RedColor                          RGBColor(254, 63, 68)
//字体的颜色
#define Theme_FontColor                         RGBColor(212,60,51)
//白色
#define Theme_WhiteColor                        [UIColor whiteColor]
//黑色
#define Theme_BlackColor                        [UIColor blackColor]
//灰色
#define Theme_GrayColor                         RGBColor(246,246,246)
//主题黄
#define Theme_YellowColor                       RGBColor(253,182,49)
//一般页面的背景颜色
#define Color_NormalBG                          [ColorTools colorWithHexString:@"#F5F5F5"]


#define Theme_Button_YellowColor                RGBColor(255, 186, 36)
#define Theme_Button_YellowHighlightedColor     RGBColor(241, 171, 19)
//分割线高度
#define Separator_Line_Height                   0.6
//分割线色值
#define Separator_LineColor                     RGBColor(220,221,221)



//优惠列表特惠简称圈圈的默认色值
#define Color_SpecialSaleCicle                  RGBColor(102,102,102)
#define kSeparatorLineColor                        [ColorTools colorWithHexString:@"#e5e5e5"]
#define kLabelText_Commen_Color_F5               [ColorTools colorWithHexString:@"#F5F5F5"]

//一般文字颜色
#define kLabelText_Commen_Color_6               [ColorTools colorWithHexString:@"#666666"]

#define kLabelText_Commen_Color_3               [ColorTools colorWithHexString:@"#333333"]

#define kLabelText_Commen_Color_9               [ColorTools colorWithHexString:@"#999999"]

#define kIm_Background_Color_c                  [ColorTools colorWithHexString:@"#cccccc"]
#define kColorF5F5F5                  [ColorTools colorWithHexString:@"#F5F5F5"]
#define kColorE5E5E5                  [ColorTools colorWithHexString:@"#E5E5E5"]
#define kColorTheme                  [ColorTools colorWithHexString:@"#f10180"]
#define kColor6                  [ColorTools colorWithHexString:@"#666666"]
#define kColor3                  [ColorTools colorWithHexString:@"#333333"]
#define kColor9                  [ColorTools colorWithHexString:@"#999999"]
#define kColorE                  [ColorTools colorWithHexString:@"#eeeeee"]
#define kColorC                  [ColorTools colorWithHexString:@"#cccccc"]
//一般按钮颜色、主题色
#define kBtn_Commen_Color                       [ColorTools colorWithHexString:@"#f10180"]

#define kDefaultImage                           [UIImage imageNamed:@"morentouxiang"]

/** 顾客默认图片 */
#define kDefaultCustomerImage                   [UIImage imageNamed:@"xmhDefaultCustomer"]
/** 技师默认图片 */
#define kDefaultJisImage                        [UIImage imageNamed:@"xmhDefaultJis"]
/** 商品默认图片 */
#define kDefaultGoodsImage                      [UIImage imageNamed:@"xmhDefaultGoods"]

#define kDefaultPortraitImage                   [UIImage imageNamed:@"morentouxiang"]

#define kLabelText_Commen_Color_ea007e             [ColorTools colorWithHexString:@"#EA007E"]

#define kBackgroundColor_CCCCCC             [ColorTools colorWithHexString:@"#CCCCCC"]

#define kPortraitCellTitle_9072             [ColorTools colorWithHexString:@"#FF9072"]
#define kPortraitCellTitle_F3F0             [ColorTools colorWithHexString:@"#FFF3F0"]
#define kBackgroundColor_FF9072             [ColorTools colorWithHexString:@"#FF9072"]
#define kBackgroundColor_FF3F0             [ColorTools colorWithHexString:@"#FFF3F0"]
#define kBackgroundColor_C5C5C5             [ColorTools colorWithHexString:@"#C5C5C5"]

//分割线高度
#define kSeparatorHeight 0.6
//分割线色值
#define kSeparatorColor kColorF5F5F5
//边缘宽
#define kBorderWidth 0.6


#endif


