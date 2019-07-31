//
//  XMHMonthAndWeekModel.m
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/2.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "XMHMonthAndWeekModel.h"

@implementation XMHMonthAndWeekModel

+ (NSNumberFormatter *)sharedformatter
{
    static NSNumberFormatter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NSNumberFormatter alloc] init];
        sharedInstance.numberStyle = kCFNumberFormatterRoundHalfDown;
    });
    return sharedInstance;
}

@end
