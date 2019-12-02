//
//  LolDateManager.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/15.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LolDateManager : NSObject
@property (strong, nonatomic) NSDateFormatter * formatter;
//获取当前日期字符串
+ (NSString *)currentDate;
/**
 日期格式转成字符串

@param date 日期
@return 日期字符串
 */
+ (NSString *)DateToString:(NSDate *)date;
/**
 字符串转日期
 
 @param string 日期字符串
 @return 日期
 */
+ (NSDate *)stringToDate:(NSString *)string;
/**
 日期字符串转为标准的2001-12-01字符串
 
 @param string 日期字符串
 @return 日期字符串
 */
+ (NSString *)formatterDateString:(NSString *)string;

@end
