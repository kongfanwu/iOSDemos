//
//  DateTools.m
//  xmh
//
//  Created by ald_ios on 2018/12/4.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "DateTools.h"

@implementation DateTools
+(NSArray *)getFirstAndLastDayOfThisWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger weekday = [dateComponents weekday];   //第几天(从sunday开始)
    NSInteger firstDiff,lastDiff;
    if (weekday == 1) {
        firstDiff = -6;
        lastDiff = 0;
    }else {
        firstDiff =  - weekday + 2;
        lastDiff = 8 - weekday;
    }
    NSInteger day = [dateComponents day];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [firstComponents setDay:day+firstDiff];
    NSDate *firstDay = [calendar dateFromComponents:firstComponents];
    
    NSDateComponents *lastComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [lastComponents setDay:day+lastDiff];
    NSDate *lastDay = [calendar dateFromComponents:lastComponents];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [NSArray arrayWithObjects:[formatter stringFromDate:firstDay],[formatter stringFromDate:lastDay], nil];
}

+(NSArray *)getFirstAndLastDayOfThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:[NSDate date]];
    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear |NSCalendarUnitDay fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [NSArray arrayWithObjects:[formatter stringFromDate:firstDay],[formatter stringFromDate:lastDay], nil];
}

+(NSArray *)getFirstAndLastDayOfLastMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //当前时间
    NSDate *dateNow = [NSDate date];
    //转换当前时间的格式为 XXXX-XX-XX
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:dateNow];
    //获取 年月日
    NSInteger year = [[dateStr substringToIndex:4] integerValue];
    NSInteger month = [[dateStr substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger day = [[dateStr substringFromIndex:8] integerValue];
    NSLog(@"year -> %ld month -> %ld day -> %ld",(long)year,(long)month,(long)day);
    //NSDateComponents这个叫什么还真不知道。 大致理解为时间元,构造时间的
    //构造当月的1号时间
    NSDateComponents *firstDayCurrentMonth = [[NSDateComponents alloc] init];
    [firstDayCurrentMonth setYear:year];
    [firstDayCurrentMonth setMonth:month];
    [firstDayCurrentMonth setDay:1];
    //当月1号
    NSDate *firstDayOfCurrentMonth = [calendar dateFromComponents:firstDayCurrentMonth];
    NSLog(@"firstDayOfCurrentMonth -> %@",firstDayOfCurrentMonth);
    //构造上月1号时间
    month --;
    //获取上月月份 没的说
    if (month == 0) {
        month = 12;
        year--;
    }
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:1];
    //上月1号时间
    NSDate *firstDayOfLastMonth = [calendar dateFromComponents:dateComponents];
    NSDate *lastDayOfLastlMonth = [firstDayOfCurrentMonth dateByAddingTimeInterval:-1];
    return [NSArray arrayWithObjects:[formatter stringFromDate:firstDayOfLastMonth],[formatter stringFromDate:lastDayOfLastlMonth], nil];
}

+(NSArray *)getFirstAndLastDayOfThisYear
{
    //通过2月天数的改变，来确定全年天数
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyy"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    dateStr = [dateStr stringByAppendingString:@"-02-14"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *aDayOfFebruary = [formatter dateFromString:dateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitYear startDate:&firstDay interval:nil forDate:[NSDate date]];
    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay fromDate:firstDay];
    NSUInteger dayNumberOfFebruary = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:aDayOfFebruary].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+337+dayNumberOfFebruary-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
}
+ (NSString*)getCurrentTimesFormatter:(NSDateFormatter *)formatter{
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}
+ (NSString *)getStringFromString:(NSString *)dateStringYY_MM_dd Formatter:(NSDateFormatter *)formatter
{
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [formatter1 dateFromString:dateStringYY_MM_dd];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"yyyy.MM.dd"];
    return [formatter2 stringFromDate:date];
}

+ (NSString *)getMonthLastDayWith:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *firstString = [myDateFormatter stringFromDate: firstDate];
    NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    return lastString;
}
+ (NSString *)getMonthFirstDayWith:(NSString *)dateStr
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstString = [myDateFormatter stringFromDate: firstDate];
//    NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    return firstString;
}
+ (NSString *)getCurrentMonth
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString * currentDateStr = [formatter stringFromDate:currentDate];
    return currentDateStr;
}
+ (NSString *)getNextMonth
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:+1];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
    return dateStr;
}
+ (NSInteger)differDaysFromStartDate:(NSString *)startDate toEndDate:(NSString *)endDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *start = [dateFormatter dateFromString:startDate];
    NSDate *end = [dateFormatter dateFromString:endDate];
    
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitDay;//只比较天数差异
    //比较的结果是NSDateComponents类对象
    NSDateComponents *delta = [calendar components:unit fromDate:start toDate:end options:0];
    //打印
//    NSLog(@"%@",delta);
    //获取其中的"天"
//    NSLog(@"%ld",delta.day);
    return delta.day;
}
+(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime
{
    
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    
    NSLog(@"转换的时间戳=%f",interval);
    
    long long totalMilliseconds = interval*1000 ;
    
    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    
    return totalMilliseconds;
    
}
@end
