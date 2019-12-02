//
//  XMHTaskModel.h
//  xmh
//
//  Created by kfw on 2019/6/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 日常任务model
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 根据追踪方式创建相应的section tag
extern NSString *const XMHTaskModel_trackMethodSectionTag;
// 日历section tag
extern NSString *const XMHTaskModel_calendarSectionTag;
// 追踪时间类型;
extern NSString *const XMHTaskModel_time_type;
// 追踪规则类型;
extern NSString *const XMHTaskModel_rules_type;
// 结束方式类型;
extern NSString *const XMHTaskModel_end_type;
// 追踪用户ID 1,2,3;
extern NSString *const XMHTaskModel_track_user_ids;
// 任务名称;
extern NSString *const XMHTaskModel_name;
// 追踪方式
extern NSString *const XMHTaskModel_track_method;
// 日历
extern NSString *const XMHTaskModel_calendar;
// 追踪话术
extern NSString *const XMHTaskModel_track_msg;
// 具体发送时间
extern NSString *const XMHTaskModel_send_date;
// 选择优惠券
extern NSString *const XMHTaskModel_coupon_list;
// 每人发送几张优惠券
extern NSString *const XMHTaskModel_person_send;


// 追踪的天 月数据
@interface XMHTrackDayMonthModel : NSObject
/** 追踪天、月 时间戳，单位秒。 track_type 为 1 2时  */
@property (nonatomic, copy) NSString *date;
/** 发送时间，24小时以内，具体什么待定 */
@property (nonatomic, copy) NSString *send_date;
/** 追踪方式 1 消息 2 优惠券 3 预约 */
@property (nonatomic, copy) NSString *track_method;
/** 追踪话术 */
@property (nonatomic, copy) NSString *track_msg;
/** 每人发送几张优惠券 */
@property (nonatomic, copy) NSString *person_send;
/** 优惠券集合，集合里的键值对取决于优惠券接口返回内容 */
@property (nonatomic, strong) NSArray *coupon_list;
/** 是否已经保存 默认NO 未保存 */
@property (nonatomic) BOOL isSaveState;
/**
 校验当前追踪方式下，数据是否完整
 
 @return YES：完整
 */
- (BOOL)checkDataFull;
@end

// 追踪时间model
@interface XMHTrackDateModel : NSObject
/** 追踪时间 1 按天追踪 2 按月追踪 3 按次追踪 */
@property (nonatomic, copy) NSString *track_type;
/** 选择的天、月、次集合 */
@property (nonatomic, strong) NSArray *list;
@end

// 任务model
@interface XMHTaskModel : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 任务名 */
@property (nonatomic, copy) NSString *name;
/** 追踪顾客 数组下的字典是用户信息，键值对取决于顾客接口返回内容 */
@property (nonatomic, strong)NSArray   *track_user;
/** 追踪规则设置 1 每次相同 2 每次不相同 */
@property (nonatomic, copy) NSString *rules_type;
/** 追踪时间  */
@property (nonatomic, strong) XMHTrackDateModel *track_date;
/** 追踪时间 */
@property (nonatomic, copy) NSString *time_type;
/** 结束方式 1 追踪时间到期 2 顾客消费 3 顾客消耗 */
@property (nonatomic, copy) NSString *end_type;

/** 商家code */
@property (nonatomic, copy) NSString *join_code;
/** 技师账号 */
@property (nonatomic, copy) NSString *account;
/** 追踪的总人数 */
@property (nonatomic, copy) NSString *track_user_num;
/** 追踪用户的ID  "1,2,3", */
@property (nonatomic, copy) NSString *track_user_ids;
/** 选择的天、月、次集合 */
@property (nonatomic, strong) NSArray <XMHTrackDayMonthModel *>*list;
/** 剩余追踪用户的ID */
@property (nonatomic, copy) NSString *remain_user_ids;

/**
 获取已选天集合，最小一天model

 */
- (XMHTrackDayMonthModel *)minDayModel;

/**
 将string array 包装成 XLFormOptionsObject Array
 
 @param array string array
 @return XLFormOptionsObject Array
 */
+ (NSArray *)formOptionsObjectArrayFromArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
