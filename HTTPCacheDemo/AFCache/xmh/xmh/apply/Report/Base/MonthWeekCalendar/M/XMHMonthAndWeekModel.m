//
//  XMHMonthAndWeekModel.m
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/2.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "XMHMonthAndWeekModel.h"

@implementation XMHMonthAndWeekModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _weekNum = 1;
        _monthNum = 1;
        _enable = YES;
    }
    return self;
}

- (NSString *)ID {
    if (IsEmpty(_firstDate)) nil;
    return @(_firstDate.timeIntervalSince1970).stringValue;
}

- (NSUInteger)currentNum {
    return _weekNum > 1 ? _weekNum : _monthNum;
}

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
