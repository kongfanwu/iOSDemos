//
//  XMHFormTaskCalendarBaseCell.m
//  xmh
//
//  Created by kfw on 2019/6/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskCalendarBaseCell.h"
#import "XMHTaskModel.h"
#import "XMHFormRowDescriptor.h"

// H5 选中日期事件： 参数日期字符串
NSString *const XMHFormTaskH5MethodName_clickDate = @"clickDate";
// H5获取日历类型 1 创建 2 编辑
NSString *const XMHFormTaskH5MethodName_getType = @"getStete";
// 设置日历类型 1 创建 2 编辑
//static inline NSString * XMHFormTaskH5MethodName_setType(NSString *param) { return [NSString stringWithFormat:@"setType('%@')", param]; }
// 保存、删除日期： 参数日期字符串，H5数组没有这个日期就保存，有这个日期就删除
static inline NSString * XMHFormTaskH5MethodName_saveOrDelete(NSString *param) { return [NSString stringWithFormat:@"saveOrDelete('%@')", param]; }
// 选中所有天
static inline NSString * XMHFormTaskH5MethodName_selectAll(NSString *param) { return [NSString stringWithFormat:@"selectAll('%@')", param]; }
// 清除所有选中
NSString *const XMHFormTaskH5MethodName_cleanAll = @"cleanAll()";


@implementation XMHFormTaskCalendarBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configUI];
}

- (void)configUI {
   
}

// 这个方法是用来设置属性的 必须重写  类似于初始化的属性不变的属性进行预先配置
- (void)configure
{
    [super configure];
    [self createWebView];
    [self addScriptMessage];
}

- (void)dealloc
{
    [self removeScriptMessage];
}

- (void)createWebView
{
    self.contentView.backgroundColor = UIColor.redColor;
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [self.contentView addSubview:_webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - Public
/**
 加载url
 */
- (void)loadUrl:(NSString *)url {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

/**
 注册js调用OC方法。viewWillDisappear: 记得移除
 */
- (void)addScriptMessage {
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:XMHFormTaskH5MethodName_clickDate];
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:XMHFormTaskH5MethodName_getType];
}

- (void)removeScriptMessage {
    // 需要注意的是addScriptMessageHandler很容易引起循环引用.因此这里要记得移除handlers
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:XMHFormTaskH5MethodName_clickDate];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:XMHFormTaskH5MethodName_getType];
}

/**
 加载url
 */
- (void)requestUrl:(NSString *)url {
    MzzLog(@"H5 url:%@", url);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

/**
 保存、删除日期：saveOrDelete() 参数日期字符串，H5数组没有这个日期就保存，有这个日期就删除
 
 @param dateStr @"yyyy-MM-dd"
 */
- (void)setH5Date:(NSString *)dateStr {
    if (IsEmpty(dateStr)) return;
    NSString *jsStr = XMHFormTaskH5MethodName_saveOrDelete(dateStr);// [NSString stringWithFormat:@"%@('%@')", XMHFormTaskH5MethodName_saveOrDelete, dateStr];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable res, NSError * _Nullable error) {
        MzzLog(@"H5交互--Method:%@, Error:%@", jsStr, error);
    }];
}

/**
 选中所有日期

 @param dateAtrArray NSArray <NSString *>
 */
- (void)selectAllDate:(NSArray *)dateAtrArray {
    if (IsEmpty(dateAtrArray)) return;
    NSString *paramStr = [dateAtrArray componentsJoinedByString:@","];
    NSString *jsStr = XMHFormTaskH5MethodName_selectAll(paramStr);// [NSString stringWithFormat:@"selectAll('%@')", paramStr];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable res, NSError * _Nullable error) {
        MzzLog(@"H5交互--Method:%@, Error:%@", jsStr, error);
    }];
}

/**
 清除选中所有日期
 */
- (void)setH5CleanAll {
    NSString *jsStr = XMHFormTaskH5MethodName_cleanAll;// [NSString stringWithFormat:@"selectAll('%@')", paramStr];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable res, NSError * _Nullable error) {
        MzzLog(@"H5交互--Method:%@, Error:%@", jsStr, error);
    }];
}


#pragma mark - WKScriptMessageHandler

/**
 js调用OC代理方法
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    MzzLog(@"%@() %@", message.name, message.body);
}

#pragma mark - WKNavigationDelegate

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [XMHWebSignTools loadWebViewJs:self.webView];
    
    if ([self.rowDescriptor isKindOfClass:[XMHFormRowDescriptor class]] && ((XMHFormRowDescriptor *)self.rowDescriptor).list.count) {
        // 组织日历选中数据
        NSMutableArray *dateArray = NSMutableArray.new;
        [((XMHFormRowDescriptor *)self.rowDescriptor).list enumerateObjectsUsingBlock:^(XMHTrackDayMonthModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDate *selectDate = [NSDate dateWithTimeIntervalSince1970:[obj.date doubleValue]];
            NSString *selectDateStr = [NSDate stringFromDate:selectDate withFormat:@"yyyy-MM-dd"];
            [dateArray addObject:selectDateStr];
        }];
        // 日历选中
        [self selectAllDate:dateArray];
    }
}

// 交互。可输入的文本。
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    NSString *returnParam;
    if ([prompt isEqualToString:XMHFormTaskH5MethodName_getType]) {
        // 1 创建 2 编辑
        XMHFormTaskCreateVCType taskType = ((XMHFormRowDescriptor *)self.rowDescriptor).taskType;
        NSString *taskTypeStr = @(taskType).stringValue;
        returnParam = taskTypeStr;
        completionHandler(taskTypeStr);//这里就是要返回给JS的返回值
    }
    MzzLog(@"method:%@() param:%@ returnParam:%@", prompt, defaultText, returnParam);
}

@end
