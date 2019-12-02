//
//  NSString+NCDate.h
//  NatureCard
//
//  Created by zhongzhi on 2017/8/18.
//  Copyright © 2017年 zhongzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NCDate)
+(NSString *)timeIntervalFromTimeStr:(NSString *)timeStr; //时间转换为时间戳
+(NSString *)formateDate:(NSString *)string;//时间戳转换为时间
+(NSInteger)getNowInterVal;//获取当前的时间戳
+(NSString *)getNowTime;//获取当前的时间字符串
+(NSString *)formateDateToDay:(NSString *)string;//时间戳转换为时间
+(NSString *)formateDateOnlyYueri:(NSString *)string;//时间戳转换为时间
+(NSString *)formateDateOnlyShifen:(NSString *)string;//时间戳转换为时间

+(NSDate *)dateFromTimeStr:(NSString *)timeStr;//年月日转换为date;
+(NSString *)ret32bitString;//随机的32位字符串

/**
 字符串转时间

 @param string 时间字符串 eg: 2019-06-13 20:00:00
 @return 时间 eg:2019年06月13日 20:00
 */
+(NSString *)formateDateToYYYYMMddHHmm:(NSString *)string;
/**
 字符串转时间
 
 @param string 时间字符串 eg: 2019-06-13 20:00:00
 @return 时间 eg:2019-06-13
 */
+(NSString *)formateDateToYYYYMMdd:(NSString *)string;
/**
 字符串转时间

 @param string 时间字符串 eg: 2019-06-13 20:00:00
 @return 时间 eg: 20:00
 */
+(NSString *)formateDateToHHmm:(NSString *)string;

/**
 字符串转时间
 
 @param string 时间字符串 eg: 2019-06-13 20:00:00
 @return 时间 eg: 06-13
 */
+(NSString *)formateDateToMMdd:(NSString *)string;
/**
 判断是否是今天

 @param timeString 时间字符串
 @return Y/N
 */
+ (BOOL)checkIsToday:(NSString *)timeString;

/**
 判断是否是当月
 
 @param timeString 时间字符串
 @return Y/N
 */
+ (BOOL)checkIsCurrentMonth:(NSString *)timeString;


@end
