//
//  XMHReportConst.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#ifndef XMHReportConst_h
#define XMHReportConst_h

/**
 挂零类型
 */
typedef NS_ENUM(NSInteger, XMHZeroType) {
    XMHZeroTypeStore, // 门店
    XMHZeroTypeEmployee // 员工
};

/**
 排名详情类型
 */
typedef NS_ENUM(NSInteger, XMHRankContentType) {
    XMHRankContentTypeSale, // 销售
    XMHRankContentTypExpend // 消耗
};

/**
 日期类型
 */
typedef NS_ENUM(NSInteger, XMHBaseReportVCDateType) {
    XMHBaseReportVCDateTypeDay,   // 天
    XMHBaseReportVCDateTypeWeek,  // 周
    XMHBaseReportVCDateTypeMonth, // 月
};

/**
 报表类型
 */
typedef NS_ENUM(NSInteger, XMHBaseReportVCType) {
    XMHBaseReportVCTypeYeJi,       // 业绩报表
    XMHBaseReportVCTypeXiaoHao,    // 消耗报表
    XMHBaseReportVCTypeYuanGong,   // 员工报表
    XMHBaseReportVCTypeGuKeBaoYou, // 顾客保有报表
    XMHBaseReportVCTypeGuKeDengJi, // 顾客等级报表
    XMHBaseReportVCTypeGuKeHuoYue, // 顾客活跃报表
    XMHBaseReportVCTypeShouYin,    // 收银报表
};

#endif /* XMHReportConst_h */
