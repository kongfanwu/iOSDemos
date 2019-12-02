//
//  NSString+NCDate.m
//  NatureCard
//
//  Created by zhongzhi on 2017/8/18.
//  Copyright © 2017年 zhongzhi. All rights reserved.
//

#import "NSString+NCDate.h"
#import "NSDate-Helper.h"
@implementation NSString (NCDate)
+(NSString *)timeIntervalFromTimeStr:(NSString *)timeStr{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:timeStr];
    
    return [NSString stringWithFormat:@"%.f",date.timeIntervalSince1970 *1000];
}
+(NSString *)formateDate:(NSString *)string{
    NSTimeInterval second = string.longLongValue / 1000.0; //毫秒需要除
    
    // 时间戳 -> NSDate *
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    //    NSLog(@"%@", date);
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSString *stringNew = [fmt stringFromDate:date];
    return stringNew;
}
+(NSString *)formateDateToDay:(NSString *)string{
    NSTimeInterval second = string.longLongValue / 1000.0; //毫秒需要除
    
    // 时间戳 -> NSDate *
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    //    NSLog(@"%@", date);
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *stringNew = [fmt stringFromDate:date];
    return stringNew;
}

+(NSString *)formateDateOnlyYueri:(NSString *)string{
    NSTimeInterval second = string.longLongValue / 1000.0; //毫秒需要除
    
    // 时间戳 -> NSDate *
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    //    NSLog(@"%@", date);
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM-dd";
    
    NSString *stringNew = [fmt stringFromDate:date];
    return stringNew;
}
+(NSString *)formateDateOnlyShifen:(NSString *)string{
    
    NSTimeInterval second = string.longLongValue / 1000.0; //毫秒需要除
    
    // 时间戳 -> NSDate *
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    //    NSLog(@"%@", date);
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    
    NSString *stringNew = [fmt stringFromDate:date];
    return stringNew;
}
+(NSInteger)getNowInterVal{
    NSDate  *date = [NSDate date];
    return date.timeIntervalSince1970 * 1000; //乘以1000为毫秒
}
+(NSString *)getNowTime{
    NSDate  *date = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr =[fmt stringFromDate:date];
    return dateStr;
}
+(NSDate *)dateFromTimeStr:(NSString *)timeStr{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    [fmt setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    fmt.dateFormat = @"yyyy年-MM月-dd日";
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:timeStr];
    return date;
}

+(NSString *)ret32bitString

{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}

+(NSString *)formateDateToYYYYMMddHHmm:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *someDay = [formatter dateFromString:string];
    // 设置日期格式
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    // 获取当前日期
    
    NSString *currentDateString = [formatter stringFromDate:someDay];
    return currentDateString;
}
+(NSString *)formateDateToYYYYMMdd:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *someDay = [formatter dateFromString:string];
    // 设置日期格式
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // 获取当前日期
    
    NSString *currentDateString = [formatter stringFromDate:someDay];
    return currentDateString;
}
+(NSString *)formateDateToHHmm:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *someDay = [formatter dateFromString:string];
    // 设置日期格式
    [formatter setDateFormat:@"HH:mm"];
    // 获取当前日期
    
    NSString *currentDateString = [formatter stringFromDate:someDay];
    return currentDateString;
}

+(NSString *)formateDateToMMdd:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *someDay = [formatter dateFromString:string];
    // 设置日期格式
    [formatter setDateFormat:@"MM-dd"];
    // 获取当前日期
    
    NSString *currentDateString = [formatter stringFromDate:someDay];
    
    return currentDateString;
}

+ (BOOL)checkIsToday:(NSString *)timeString{
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [format dateFromString:timeString];
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];
   
    return isToday;
}

+ (BOOL)checkIsCurrentMonth:(NSString *)timeString{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [format dateFromString:timeString];

    NSDate *newDate= [NSDate date] ;
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }
    
    BOOL lessThan = ([firstDate compare:date] == kCFCompareLessThan);
    BOOL greaterThan = [lastDate compare:date] == kCFCompareGreaterThan;
    if (lessThan && greaterThan) {
        return YES;
    }
    return NO;
}



@end
