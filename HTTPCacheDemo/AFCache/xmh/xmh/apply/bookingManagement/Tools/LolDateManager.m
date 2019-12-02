//
//  LolDateManager.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/15.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolDateManager.h"

@implementation LolDateManager{

  
}
+ (NSString *)currentDate
{
    return [self currentDate];
}
+ (NSString *)DateToString:(NSDate *)date
{
    LolDateManager * manage = [[LolDateManager alloc]init];
    return [manage.formatter stringFromDate:date];
}
+ (NSDate *)stringToDate:(NSString *)string
{
    LolDateManager * manage = [[LolDateManager alloc]init];
    return [manage.formatter dateFromString:string];
}
+ (NSString *)formatterDateString:(NSString *)string{
    LolDateManager * manage = [[LolDateManager alloc]init];
    NSDate * date = [manage.formatter dateFromString:string];
    return [manage.formatter stringFromDate:date];
}
- (instancetype)init
{
    if (self  = [super init]) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
    }
    return self;
}
- (NSString *)currentDate
{
    return [_formatter stringFromDate:[NSDate date]];
}
@end
