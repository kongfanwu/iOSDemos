//
//  NSDate-Helper.m
//  ViewImage
//
//  Created by gushuo on 10-8-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSDate-Helper.h"
#import "NSDate+Extension.h"

@implementation NSDate(Helpers)


- (NSUInteger)getDayNumOfMonth
{
    return [[self endOfMonth] getDay];
}
- (int )getWeekNumOfMonth
{
	return [[self endOfMonth] getWeekOfYear] - [[self beginningOfMonth] getWeekOfYear] + 1;
}

- (int )getWeekOfYear
{
	int i;
	NSUInteger year = [self getYear];
	NSDate *date = [self endOfWeek];
	for (i = 1;[[date dateAfterDay:-7 * i] getYear] == year;i++)
	{
	}
	return i;
}

- (NSDate *)dateAfterDay:(int)day
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
#if !__has_feature(objc_arc)
    [componentsToAdd autorelease];
#endif
	[componentsToAdd setDay:day];
	NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
	
	return dateAfterDay;
}

- (NSDate *)dateafterMonth:(int)month
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
#if !__has_feature(objc_arc)
    [componentsToAdd autorelease];
#endif
	[componentsToAdd setMonth:month];
	NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
	
	return dateAfterMonth;
}

- (NSUInteger)getDay{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
	return [dayComponents day];
}
- (NSUInteger)getMonth
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
	return [dayComponents month];
}
- (NSUInteger)getYear
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
	return [dayComponents year];
}
- (int )getHour {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSUInteger unitFlags =NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
	NSDateComponents *components = [calendar components:unitFlags fromDate:self];
	NSInteger hour = [components hour];
	return (int)hour;
}
- (int)getMinute {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSUInteger unitFlags =NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
	NSDateComponents *components = [calendar components:unitFlags fromDate:self];
	NSInteger minute = [components minute];
	return (int)minute;
}
- (int)getSecond {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSUInteger unitFlags =NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents *components = [calendar components:unitFlags fromDate:self];
	NSInteger minute = [components second];
	return (int)minute;
}


- (NSUInteger)daysAgo {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
											   fromDate:self
												 toDate:[NSDate date]
												options:0];
	return [components day];
}

- (NSUInteger)daysAgoAgainstMidnight {
	// get a midnight version of ourself:
	NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
#if !__has_feature(objc_arc)
    [mdf autorelease];
#endif
	[mdf setDateFormat:@"yyyy-MM-dd"];
	NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
	
	return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)stringDaysAgo {
	return [self stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag {
	NSUInteger daysAgo = (flag) ? [self daysAgoAgainstMidnight] : [self daysAgo];
	NSString *text = nil;
	switch (daysAgo) {
		case 0:
			text = @"今天";//@"Today";
			break;
		case 1:
			text = @"昨天";//@"Yesterday";
			break;
		default:
			text = [NSString stringWithFormat:@"%ld天前", (unsigned long)daysAgo];//days ago
	}
	return text;
}

- (NSUInteger)weekday {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitWeekday) fromDate:self];
	return [weekdayComponents weekday];
}

+ (NSDate *)dateFromYear:(int)year Month:(int)month Day:(int)day hour:(int)hour minute:(int)minute second:(int)second
{
    NSString *s = [NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d:%02d",year,month,day, hour, minute, second];
    NSDate *date = [self dateFromString:s withFormat:@"yyyy-MM-dd HH:mm:ss"];
    return date;
}

+ (NSDate *)dateFromYear:(int)year Month:(int)month Day:(int)day
{
    NSString *s = [NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    return [self dateFromString:s withFormat:[self dateFormatString]];
}
+ (NSDate *)dateFromString:(NSString *)string {
	return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
//    [inputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
#if !__has_feature(objc_arc)
    [inputFormatter autorelease];
#endif
	[inputFormatter setDateFormat:format];
	NSDate *date = [inputFormatter dateFromString:string];
	return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
	return [date stringWithFormat:format];
}

+ (NSString *)stringFromDate:(NSDate *)date {
	return [date string];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
	/*
	 * if the date is in today, display 12-hour time with meridian,
	 * if it is within the last 7 days, display weekday name (Friday)
	 * if within the calendar year, display as Jan 23
	 * else display as Nov 11, 2008
	 */
	
	NSDate *today = [NSDate date];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *offsetComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
													 fromDate:today];
	
	NSDate *midnight = [calendar dateFromComponents:offsetComponents];
	
	NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
#if !__has_feature(objc_arc)
    [displayFormatter autorelease];
#endif
	NSString *displayString = nil;
	
	// comparing against midnight
	if ([date compare:midnight] == NSOrderedDescending) {
		if (prefixed) {
			[displayFormatter setDateFormat:@"'at' h:mm a"]; // at 11:30 am
		} else {
			[displayFormatter setDateFormat:@"h:mm a"]; // 11:30 am
		}
	} else {
		// check if date is within last 7 days
		NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
#if !__has_feature(objc_arc)
        [componentsToSubtract autorelease];
#endif
		[componentsToSubtract setDay:-7];
		NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
		if ([date compare:lastweek] == NSOrderedDescending) {
			[displayFormatter setDateFormat:@"EEEE"]; // Tuesday
		} else {
			// check if same calendar year
			NSInteger thisYear = [offsetComponents year];
			
			NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
														   fromDate:date];
			NSInteger thatYear = [dateComponents year];
			if (thatYear >= thisYear) {
				[displayFormatter setDateFormat:@"MMM d"];
			} else {
				[displayFormatter setDateFormat:@"MMM d, yyyy"];
			}
		}
		if (prefixed) {
			NSString *dateFormat = [displayFormatter dateFormat];
			NSString *prefix = @"'on' ";
			[displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
		}
	}
	
	// use display formatter to return formatted date string
	displayString = [displayFormatter stringFromDate:date];
	return displayString;
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date {
	return [self stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)stringWithFormat:(NSString *)format {
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
#if !__has_feature(objc_arc)
    [outputFormatter autorelease];
#endif
	[outputFormatter setDateFormat:format];
	NSString *timestamp_str = [outputFormatter stringFromDate:self];
	return timestamp_str;
}

- (NSString *)string {
	return [self stringWithFormat:[NSDate dbFormatString]];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
#if !__has_feature(objc_arc)
    [outputFormatter autorelease];
#endif
	[outputFormatter setDateStyle:dateStyle];
	[outputFormatter setTimeStyle:timeStyle];
	NSString *outputString = [outputFormatter stringFromDate:self];
	return outputString;
}
//返回周日的的开始时间
- (NSDate *)beginningOfWeek {
	// largely borrowed from "Date and Time Programming Guide for Cocoa"
	// we'll use the default calendar and hope for the best
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDate *beginningOfWeek = nil;
	BOOL ok = [calendar rangeOfUnit:NSCalendarUnitWeekOfYear startDate:&beginningOfWeek
						   interval:NULL forDate:self];
	if (ok) {
		return beginningOfWeek;
	}
	
	// couldn't calc via range, so try to grab Sunday, assuming gregorian style
	// Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
	
	/*
	 Create a date components to represent the number of days to subtract from the current date.
	 The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
	 */
	NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
#if !__has_feature(objc_arc)
    [componentsToSubtract autorelease];
#endif
	[componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
	beginningOfWeek = nil;
	beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
	
	//normalize to midnight, extract the year, month, and day components and create a new date from those components.
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
											   fromDate:beginningOfWeek];
	return [calendar dateFromComponents:components];
}
//返回当前天的年月日.
- (NSDate *)beginningOfDay {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	// Get the weekday component of the current date
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
											   fromDate:self];
	return [calendar dateFromComponents:components];
}
- (NSDate *)beginningOfMonth
{
	return [self dateAfterDay:-(int)[self getDay] + 1];
}
- (NSDate *)endOfMonth
{
	return [[[self beginningOfMonth] dateafterMonth:1] dateAfterDay:-1];
}
//返回当前周的周末
- (NSDate *)endOfWeek {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	// Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
	NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
#if !__has_feature(objc_arc)
    [componentsToAdd autorelease];
#endif
	// to get the end of week for a particular date, add (7 - weekday) days
	[componentsToAdd setDay:(7 - [weekdayComponents weekday])];
	NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
	
	return endOfWeek;
}

+ (NSString *)dateFormatString {
	return @"yyyy-MM-dd";
}

+ (NSString *)timeFormatString {
	return @"HH:mm:ss";
}

+ (NSString *)timestampFormatString {
	return @"yyyy-MM-dd HH:mm:ss";
}

// preserving for compatibility
+ (NSString *)dbFormatString {
	return [NSDate timestampFormatString];
}

- (NSString *)dateStringForYearMonthDay
{
    return [self stringWithFormat:@"yyyy-MM-dd"];
}

/**
 *  根据开始 结束时间返回周间隔。不足一周按一周算：如8天，返回2周
 *
 *  @param startDate 开始时间
 *  @param endDate   结束时间
 *
 *  @return 周数
 */
+ (NSUInteger)weekGapWithStartData:(NSDate *)startDate endDate:(NSDate *)endDate
{
    NSTimeInterval dayTime = 60 * 60 * 24;
    NSTimeInterval dateGap = endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970;
    NSInteger dayNum = dateGap / dayTime;
    NSInteger week = ceil(dayNum / 7.f);
    return week;
}

@end
