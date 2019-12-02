//
//  LolCalendarModelList.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/9.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolCalendarModelList.h"
#import "LolDayModel.h"
#import "YYModel.h"
@implementation LolCalendarModelList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [LolDayModel class] };
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
