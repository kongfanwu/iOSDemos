//
//  NSDate-Helper.h
//  ViewImage
//
//  Created by gushuo on 10-8-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSDate (Helpers)

//该月有几天
- (NSUInteger)getDayNumOfMonth;
//该月跨几周
- (int )getWeekNumOfMonth;
//该年有几周
- (int )getWeekOfYear;
//返回day天后的日期
- (NSDate *)dateAfterDay:(int)day;
- (NSDate *)dateafterMonth:(int)month;


- (NSUInteger)getDay;
- (NSUInteger)getMonth;
- (NSUInteger)getYear;
- (int )getHour;
- (int )getMinute;
- (int)getSecond;

- (NSUInteger)daysAgo;
- (NSUInteger)daysAgoAgainstMidnight;
- (NSString *)stringDaysAgo;
- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag;
//返回周几。周日是第一天
- (NSUInteger)weekday;

//根据年月日生成日期对象
+ (NSDate *)dateFromYear:(int)year Month:(int)month Day:(int)day;
+ (NSDate *)dateFromYear:(int)year Month:(int)month Day:(int)day hour:(int)hour minute:(int)minute second:(int)second;
+ (NSDate *)dateFromString:(NSString *)string;//@"yyyy-MM-dd HH:mm:ss"
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;

- (NSString *)string;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

//返回周日的的开始时间
- (NSDate *)beginningOfWeek;
- (NSDate *)beginningOfMonth;
- (NSDate *)endOfMonth;
- (NSDate *)beginningOfDay;
- (NSDate *)endOfWeek;

+ (NSString *)dateFormatString;
+ (NSString *)timeFormatString;
+ (NSString *)timestampFormatString;
+ (NSString *)dbFormatString;

- (NSString *)dateStringForYearMonthDay;//@“2012-12-12”

/**
 *  根据开始 结束时间返回周间隔。不足一周按一周算：如8天，返回2周
 *
 *  @param startDate 开始时间
 *  @param endDate   结束时间
 *
 *  @return 周数
 */
+ (NSUInteger)weekGapWithStartData:(NSDate *)startDate endDate:(NSDate *)endDate;
@end