//
//  XMHSmartManagerEnum.h
//  xmh
//
//  Created by ald_ios on 2019/6/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#ifndef XMHSmartManagerEnum_h
#define XMHSmartManagerEnum_h
/** 页面类型 */
typedef NS_ENUM(NSUInteger, XMHTaskManagerCellType) {
    XMHTaskManagerCellEdit = 0,
    XMHTaskManagerCellLook
};

/** 追踪顾客cell类型 */
typedef NS_ENUM(NSUInteger, XMHTraceCustomerCellType) {
    XMHTraceCustomerCellTypeEdit = 0,
    XMHTraceCustomerCellTypeLook
};
/** 追踪优惠券cell类型 */
typedef NS_ENUM(NSUInteger, XMHTraceDiscountCouponCellType) {
    XMHTraceDiscountCouponCellTypeEdit = 0,
    XMHTraceDiscountCouponCellTypeLook
};

/** 工作任务提醒 - 展示形式 */
typedef NS_ENUM(NSInteger, WorkTaskScheduleType) {
    
    WorkTaskScheduleTypeRemind = 0, // 提醒
    WorkTaskScheduleTypeCheck = 1 // 查看
};

/** 智能助手消息详情 */
typedef NS_ENUM(NSInteger, XMHResultOfExecutionType) {
    
    XMHResultOfExecutionTypeStandard_Remind = 1, //标准服务流程提醒
    XMHResultOfExecutionTypeActual_Remind = 2, //工作任务提醒，实时的实际执行的统计数据
    XMHResultOfExecutionTypeNote = 3, // 短信
    XMHResultOfExecutionTypeCoupon = 4, // 优惠券
    XMHResultOfExecutionTypeSubscribe = 5, // 预约
    XMHResultOfExecutionTypeDataReport = 6, // 数据报告
   
    
};
#endif /* XMHSmartManagerEnum_h */
