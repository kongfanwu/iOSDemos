//
//  XMHFormTaskDataCreateManager.h
//  xmh
//
//  Created by kfw on 2019/6/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 表单数据创建管理者

#import <Foundation/Foundation.h>
#import "XMHItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormTaskDataCreateManager : NSObject

/**
 根据idstr 寻找数组里的model
 */
+(XLFormOptionsObject *)selectModelIdStr:(NSString *)idstr list:(NSArray *)list;

/**
 创建跟踪时间
 */
+ (NSArray <XLFormOptionsObject *>*)createTrackDateList;

/**
 返回默认跟踪时间
 */
+ (XLFormOptionsObject *)defaultTrackDate;

/**
 创建规则是否统一  1 每次相同 2 每次不同
 */
+ (NSArray <XLFormOptionsObject *>*)createRulesTypeList;

/**
 返回默认规则是否统一
 */
+ (XLFormOptionsObject *)defaultRulesType;

/**
 创建追踪方式 追踪方式 1 消息 2 优惠券 3 预约
 */
+ (NSArray <XLFormOptionsObject *>*)createTrackMethodList;

/**
 返回默认追踪方式
 */
+ (XLFormOptionsObject *)defaultTrackMethod;
@end

NS_ASSUME_NONNULL_END
