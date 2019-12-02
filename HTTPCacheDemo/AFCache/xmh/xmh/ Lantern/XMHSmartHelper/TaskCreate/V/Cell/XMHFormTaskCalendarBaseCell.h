//
//  XMHFormTaskCalendarBaseCell.h
//  xmh
//
//  Created by kfw on 2019/6/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
/* H5交互文档
  天日历：
  task/taskDa.html
 task/taskDayDetail.html
  月历
  task/taskMonth.html
  task/taskDayDetail.html
 
  clickDate() H5 选中日期事件： 参数日期字符串
  saveOrDelete() 保存、删除日期： 参数日期字符串，H5数组没有这个日期就保存，有这个日期就删除
  cleanAll() 清除所有的选中:
 

 1 天日历，默认选中当天。
 2 月日历，默认选中当月。时间 年-月-日
 日规则：时间是当月天+ 1.其他月是每个月1号
 
 选中所有天
 selectAll() 参数array
 
 cleanAll() 清除方法
 
 getType() 日历类型 1 创建 2 编辑
 */



#import "XMHFormTaskBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormTaskCalendarBaseCell : XMHFormTaskBaseCell <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

/**
 加载url
 */
- (void)requestUrl:(NSString *)url;

/**
 注册js调用OC方法。viewWillDisappear: 记得移除
 */
- (void)addScriptMessage;

/**
 需要注意的是addScriptMessageHandler很容易引起循环引用.因此这里要记得移除handlers
 */
- (void)removeScriptMessage;

/**
 保存、删除日期：saveOrDelete() 参数日期字符串，H5数组没有这个日期就保存，有这个日期就删除

 @param dateStr @"yyyy-MM-dd"
 */
- (void)setH5Date:(NSString *)dateStr;

/**
 选中所有日期
 
 @param dateAtrArray NSArray <NSString *>
 */
- (void)selectAllDate:(NSArray *)dateAtrArray;

/**
 清除选中所有日期
 */
- (void)setH5CleanAll;
@end

NS_ASSUME_NONNULL_END
