//
//  TimeTools.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/26.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTools : NSObject
/**
 *返回的是英文星期
 */
+ (NSString *)getCurrentWeekday;

/**
 *11位时间字符串
 */
+ (NSString *)getCurrentTimestamp11;
+ (NSString *)getWeekDayFromDate:(NSString *)paramDate;
@end
