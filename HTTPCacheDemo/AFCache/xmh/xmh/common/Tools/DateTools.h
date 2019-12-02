//
//  DateTools.h
//  xmh
//
//  Created by ald_ios on 2018/12/4.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTools : NSObject
/**
 *  得到这个周的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfThisWeek;
/**
 *  得到这个月的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfThisMonth;
/**
 *  得到上个月月的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfLastMonth;
/**
 *  得到今年的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfThisYear;
/**
 *  当前时间
 */
+ (NSString*)getCurrentTimesFormatter:(NSDateFormatter *)formatter;

+ (NSString *)getStringFromString:(NSString *)dateStringYY_MM_dd Formatter:(NSDateFormatter *)formatter;

/**
 *  获取任意月份的最后一天
 */
+ (NSString *)getMonthLastDayWith:(NSString *)dateStr;
/**
 *  获取任意月份的第一天
 */
+ (NSString *)getMonthFirstDayWith:(NSString *)dateStr;

/**
 *  获取当前月份
 */
+ (NSString *)getCurrentMonth;
/**
 *  获取下个月份
 */
+ (NSString *)getNextMonth;
/** 两个日期相隔天数 */
+ (NSInteger)differDaysFromStartDate:(NSString *)startDate toEndDate:(NSString *)endDate;

/** NSDate转时间戳*/
+(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime;
@end
