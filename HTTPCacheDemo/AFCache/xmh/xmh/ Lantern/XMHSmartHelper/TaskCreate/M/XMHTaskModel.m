//
//  XMHTaskModel.m
//  xmh
//
//  Created by kfw on 2019/6/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTaskModel.h"
// 根据追踪方式创建相应的section tag
NSString *const XMHTaskModel_trackMethodSectionTag = @"trackMethodSectionTag";
// 日历section tag
NSString *const XMHTaskModel_calendarSectionTag = @"calendarSectionTag";

// 追踪时间类型;
NSString *const XMHTaskModel_time_type = @"time_type";
// 追踪规则类型;
NSString *const XMHTaskModel_rules_type = @"rules_type";
// 结束方式类型;
NSString *const XMHTaskModel_end_type = @"end_type";
// 追踪用户ID 1,2,3;
NSString *const XMHTaskModel_track_user_ids = @"track_user_ids";
// 任务名称;
NSString *const XMHTaskModel_name = @"name";
// 追踪方式
NSString *const XMHTaskModel_track_method = @"track_method";
// 日历
NSString *const XMHTaskModel_calendar = @"calendar";
// 追踪话术
NSString *const XMHTaskModel_track_msg = @"track_msg";
// 具体发送时间
NSString *const XMHTaskModel_send_date = @"send_date";
// 选择优惠券
NSString *const XMHTaskModel_coupon_list = @"coupon_list";
// 每人发送几张优惠券
NSString *const XMHTaskModel_person_send = @"person_send";


@implementation XMHTrackDayMonthModel

/**
 校验当前追踪方式下，数据是否完整

 @return YES：完整
 */
- (BOOL)checkDataFull {
    if (IsEmpty(_date) || IsEmpty(_track_method)) return NO;
    if ([_track_method isEqualToString:@"1"]) {
        if (!IsEmpty(_track_msg) && !IsEmpty(_send_date)) return YES;
    }
    else if ([_track_method isEqualToString:@"2"]) {
        if (!IsEmpty(_person_send) && !IsEmpty(_send_date) && _coupon_list.count) return YES;
    }
    else if ([_track_method isEqualToString:@"3"]) {
        if (!IsEmpty(_send_date)) return YES;
    }
    return NO;
}

- (void)setTrack_method:(NSString *)track_method {
    _track_method = track_method;
}

@end

@implementation XMHTrackDateModel 
@end

@implementation XMHTaskModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID": @[@"id", @"ID"]};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"track_date" : [XMHTrackDateModel class], @"list" : [XMHTrackDayMonthModel class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *track_user_ids = dic[@"remain_user_ids"];
    if ([track_user_ids isKindOfClass:[NSString class]]) {
        NSArray *idArray = [track_user_ids componentsSeparatedByString:@","];
        self.track_user = idArray;
    }
    
    return YES;
}

/**
 将string array 包装成 XLFormOptionsObject Array

 @param array string array
 @return XLFormOptionsObject Array
 */
+ (NSArray *)formOptionsObjectArrayFromArray:(NSArray *)array {
    if (IsEmpty(array)) return @[];
    NSMutableArray *newArray = NSMutableArray.new;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [newArray addObject:[XLFormOptionsObject formOptionsObjectWithValue:obj displayText:nil]];
    }];
    return newArray;
}

/**
 获取已选天集合，最小一天model
 
 */
- (XMHTrackDayMonthModel *)minDayModel {
    __block XMHTrackDayMonthModel *minModel = self.list.firstObject;
    __block NSTimeInterval minTime = [minModel.date doubleValue];
    [self.list enumerateObjectsUsingBlock:^(XMHTrackDayMonthModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTimeInterval currentTime = [obj.date doubleValue];
        if (currentTime < minTime) {
            minTime = currentTime;
            minModel = obj;
        }
    }];
    return minModel;
}

@end
