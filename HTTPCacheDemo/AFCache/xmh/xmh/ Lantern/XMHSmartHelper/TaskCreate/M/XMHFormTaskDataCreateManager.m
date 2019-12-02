//
//  XMHFormTaskDataCreateManager.m
//  xmh
//
//  Created by kfw on 2019/6/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskDataCreateManager.h"

@implementation XMHFormTaskDataCreateManager

/**
 根据idstr 寻找数组里的model

 @param idstr
 @param list
 @return XMHItemModel
 */
+(XLFormOptionsObject *)selectModelIdStr:(NSString *)idstr list:(NSArray *)list {
    for (XLFormOptionsObject *itemModel in list) {
        if ([itemModel.formValue isEqualToString:idstr]) {
            return itemModel;
        }
    }
    return nil;
}

/**
 创建跟踪时间
 */
+ (NSArray <XLFormOptionsObject *>*)createTrackDateList {
    NSMutableArray *array = NSMutableArray.new;
    [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:@"1" displayText:@"按天追踪"]];
    [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:@"2" displayText:@"按月追踪"]];
    return array;
}

/**
 返回默认跟踪时间
 */
+ (XLFormOptionsObject *)defaultTrackDate {
    return [self selectModelIdStr:@"1" list:[self createTrackDateList]];
}

/**
 创建规则是否统一 1 每次相同 2 每次不同
 */
+ (NSArray <XLFormOptionsObject *>*)createRulesTypeList {
    NSMutableArray *array = NSMutableArray.new;
    [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:@"1" displayText:@"每次相同"]];
    [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:@"2" displayText:@"每次不同"]];
    return array;
}

/**
 返回默认规则是否统一
 */
+ (XLFormOptionsObject *)defaultRulesType {
    return [self selectModelIdStr:@"1" list:[self createRulesTypeList]];
}

/**
 创建追踪方式 追踪方式 1 消息 2 优惠券 3 预约
 */
+ (NSArray <XLFormOptionsObject *>*)createTrackMethodList {
    NSMutableArray *array = NSMutableArray.new;
    [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:@"1" displayText:@"短信"]];
    [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:@"2" displayText:@"优惠券"]];
    [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:@"3" displayText:@"预约"]];
    return array;
}

/**
 返回默认追踪方式
 */
+ (XLFormOptionsObject *)defaultTrackMethod {
    return [self selectModelIdStr:@"1" list:[self createTrackMethodList]];
}

@end
