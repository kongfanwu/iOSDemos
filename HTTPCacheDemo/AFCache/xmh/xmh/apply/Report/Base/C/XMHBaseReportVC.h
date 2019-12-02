//
//  XMHBaseReportVC.h
//  xmh
//
//  Created by kfw on 2019/7/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
#import "XMHMonthAndWeekModel.h"
#import "XMHPickerView.h"
NS_ASSUME_NONNULL_BEGIN

extern NSString *const XMHReportH5MethodName_ResultsSource;
extern NSString *const XMHReportH5MethodName_EmployeeDetails;

@interface XMHBaseReportVC : BaseCommonViewController <WKScriptMessageHandler>
/** 报表类型。 默认：XMHBaseReportVCTypeYeJi */
@property (nonatomic) XMHBaseReportVCType reportType;
/** 日期类型。 默认： XMHBaseReportVCDateTypeDay */
@property (nonatomic) XMHBaseReportVCDateType dateType;

@property (nonatomic, strong, readonly) XMHPickerView *pickerView;
@property (nonatomic, strong, readonly) WKWebView *webView;
/** 选中日期集合 */
@property (strong, nonatomic, readonly) NSArray <XMHMonthAndWeekModel *> *selectedDates;
/** 选中日期时间戳集合 */
@property (strong, nonatomic, readonly) NSArray <NSDictionary *> *selectedTimestampTs;

#pragma mark - 子类调用的方法
/**
 加载web url
 */
- (void)loadWebViewUrl:(NSURL *)url;

/**
 加载报表 url
 */
- (void)loadWebViewReportUrl:(NSURL *)url;

/**
 报表全屏显示
 */
- (void)showReportFullView;

/**
 报表全屏隐藏
 */
- (void)hiddenReportFullView;

#pragma mark - 子类重写的方法
/**
 子类获取选择时间确定事件
 */
- (void)sureClick;
/**
 周报库（sender.tag == 100）、月报库（sender.tag == 101）事件
 */
- (void)dateBtnClick:(UIButton *)sender;

/**
 注册js调用OC方法。viewWillDisappear: 记得移除
 */
- (void)addScriptMessage;

/**
 移除注册的方法
 注意： 此方法已经废弃。通过runtime已经打破循环引用
 */
- (void)removeScriptMessage;

/**
 OC调用JavaScript方法
 
 @param jsStr 方法字符串，如 @"setType('123')" 或 @"setType"
 @param completionHandler 回调
 */
- (void)evaluateJavaScript:(NSString *)jsStr completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;

/**
 选中日期回调
 
 @param model 日期model
 */
- (void)didSelectItemModel:(XMHMonthAndWeekModel *)model;

#pragma mark - WKScriptMessageHandler
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
/**
 js调用OC代理方法
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

/**
 交互。可输入的文本。
 
 @param webView webView
 @param prompt js调用的方法名字
 @param defaultText js 的传参
 @param frame frame
 @param completionHandler OC返回参数
 */
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler;
/** 枚举 转 字符串 */
- (NSString *)typeenumToStringtype;
@end

NS_ASSUME_NONNULL_END
