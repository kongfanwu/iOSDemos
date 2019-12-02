//
//  XMHFormRowDescriptor.h
//  xmh
//
//  Created by kfw on 2019/6/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 自定义row model

#import <XLForm/XLForm.h>
@class XMHTrackDayMonthModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormRowDescriptor : XLFormRowDescriptor
/** 日历类型 默认:  XMHFormCellCalendarTypeDay */
@property (nonatomic) XMHFormCellCalendarType calendarType;
/** 选择的天、月、次集合 */
@property (nonatomic, strong) NSArray <XMHTrackDayMonthModel *> *list;
/** h5 url */
@property (nonatomic, copy) NSString *url;
/** 任务类型 创建、编辑类型 默认 XMHFormTaskCreateVCTypeCreate */
@property (nonatomic) XMHFormTaskCreateVCType taskType;
@end

NS_ASSUME_NONNULL_END
