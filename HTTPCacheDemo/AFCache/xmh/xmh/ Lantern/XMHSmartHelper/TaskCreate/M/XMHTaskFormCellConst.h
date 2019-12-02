//
//  XMHTaskFormCellConst.h
//  xmh
//
//  Created by kfw on 2019/6/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 统一列出所有cell样式

#import <Foundation/Foundation.h>
#import "XMHFormTaskInputCell.h"
#import "XLFormRowDescriptor+XMHXLFormRowDescriptor.h"
#import "XMHFormValueTransformer.h"

/**
 日历类型
 注意：与页面追踪时间值相对应，不可随意更改值。
 - XMHFormCellCalendarTypeDay: 天
 - XMHFormCellCalendarTypMonth: 月
 */
typedef NS_ENUM(NSInteger,XMHFormCellCalendarType ) {
    XMHFormCellCalendarTypeDay = 1,
    XMHFormCellCalendarTypMonth = 2,
};

//
/**
 创建类型
 注意：类型值与H5绑定，不可随意更改值。
 */
typedef NS_ENUM(NSInteger, XMHFormTaskCreateVCType) {
    XMHFormTaskCreateVCTypeCreate = 1, // 创建
    XMHFormTaskCreateVCTypeSystemEdit = 2, // 系统类型编辑
    //    XMHFormTaskCreateVCTypeDetail, // 详情
};

extern NSString *const XMHFormTaskInputCellTextFieldMaxNumberOfCharacters;

// 左title 右 按钮样式 例如： 追踪时间， 结束方式，规则是否统一
extern NSString * const XLFormRowDescriptorTypeXMHFormTaskButtonsCell;
// 日历天cell
extern NSString * const XLFormRowDescriptorTypeXMHFormTaskCalendarCell;
// 日历月cell
extern NSString * const XLFormRowDescriptorTypeXMHFormTaskCalendarMonthCell;
// 输入cell
extern NSString * const XLFormRowDescriptorTypeXMHFormTaskInputCell;
// 追踪话术
extern NSString * const XLFormRowDescriptorTypeXMHFormTaskTrackMsgCell;
// 追踪顾客、优惠券、具体发送时间
extern NSString * const XLFormRowDescriptorTypeXMHFormTaskSelectCell;
// 与框架 XLFormButtonCell 一样。只是修改了 update 方法
extern NSString * const XLFormRowDescriptorTypeXMHXLFormButtonCell;
// 输入cell，中间输入，右侧有输入规格
extern NSString * const XLFormRowDescriptorTypeXMHFormTaskInputRightPointCell;
// 与框架 XLFormSelectorCell 一样。只是修改了功能
extern NSString * const XLFormRowDescriptorTypeXMHXLFormSelectorCell;
// 文本查看cell
extern NSString * const XLFormRowDescriptorTypeXMHFormTaskTextCell;
