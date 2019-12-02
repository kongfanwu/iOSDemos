//
//  TimeTools.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/26.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TimeTools.h"

@implementation TimeTools

+ (NSString *)getCurrentWeekday{
    NSDate*date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    comps =[calendar components:(NSCalendarUnitWeekday)
                       fromDate:date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"EEEE"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getCurrentTimestamp11
{
    double r = [[NSDate date] timeIntervalSince1970];
    NSString *result = [NSString stringWithFormat:@"%.0f", r];
    return result;
}

+ (NSString *)getWeekDayFromDate:(NSString *)paramDate
{
    NSDateFormatter * dateFormatter1 = [[NSDateFormatter alloc] init] ;
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter1 dateFromString:paramDate];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    comps =[calendar components:(NSCalendarUnitWeekday)
                       fromDate:date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"EEEE"];
    return [dateFormatter stringFromDate:date];
}
@end
