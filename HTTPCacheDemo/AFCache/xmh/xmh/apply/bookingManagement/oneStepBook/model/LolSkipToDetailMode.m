//
//  LolSkipToDetailMode.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/18.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolSkipToDetailMode.h"

@implementation LolSkipToDetailMode
- (instancetype)initWithType:(NSString *)type orderNum:(NSString *)ordernum userId:(NSString *)userId toGd:(NSString *)togd;
{
    self = [super init];
    if (self) {
        _type = type;
        _ordernum = ordernum;
        _user_id = userId;
        _to_gd = togd;
    }
    return self;
}
@end
