//
//  BookChartVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookChartVC.h"
#import "BookChartSelectStoreView.h"
#import "BookTimeWeekView.h"
#import "BookDateVC.h"
#import "LolUserInfoModel.h"
#import <WebKit/WebKit.h>
#import "UserManager.h"
@interface BookChartVC ()
<
WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler
>
@property (nonatomic, strong)UIView * bgView;
@property (nonatomic, strong)BookChartSelectStoreView * storeView;
@property (nonatomic, strong)BookTimeWeekView * weekView;
@property (nonatomic, strong)WKWebView * billWebView;
@end

@implementation BookChartVC
{
    NSString * _selectDate;
    /** 参数日期 */
    NSString * _paramDate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    _paramDate = [self dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"];
}
- (void)initSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setNavViewTitle:@"预约表" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.storeView];
    [self.view addSubview:self.weekView];
    [self.view addSubview:self.billWebView];
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 77)];
        _bgView.backgroundColor = kColorTheme;
    }
    return _bgView;
}
- (BookChartSelectStoreView *)storeView
{
    WeakSelf
    if (!_storeView) {
        _storeView = loadNibName(@"BookChartSelectStoreView");
        _storeView.layer.cornerRadius = 5;
        _storeView.layer.masksToBounds = YES;
        _storeView.frame = CGRectMake(15, Heigh_Nav, SCREEN_WIDTH - 30, 40);
        [_storeView updateViewParam:_storeParam];
        _storeView.BookChartSelectStoreViewBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:NO];
        };
    }
    return _storeView;
}
- (BookTimeWeekView *)weekView
{
    WeakSelf
    if (!_weekView) {
        _weekView = loadNibName(@"BookTimeWeekView");
        _weekView.frame = CGRectMake(15, _storeView.bottom + 10, SCREEN_WIDTH - 30, 56);
        _weekView.BookTimeWeekViewMoreBlock = ^{
            BookDateVC * bookDateVC = [[BookDateVC alloc] init];
            /** 返回来年月日 */
            bookDateVC.BookDateVCBlock = ^(NSString *date) {
                _selectDate = date;
                _paramDate = date;
                [weakSelf.billWebView reload];
                [weakSelf.weekView updateBookTimeWeekViewDate:date];
            };
            [weakSelf.navigationController pushViewController:bookDateVC animated:YES];
        };
        _weekView.BookTimeWeekViewDateBlock = ^(NSString *date) {
            _paramDate = date;
            [weakSelf.billWebView reload];
        };
    }
    return _weekView;
}
-(WKWebView *)billWebView
{
    if (!_billWebView) {
        _billWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _weekView.bottom + 20, SCREEN_WIDTH, SCREEN_HEIGHT - _weekView.bottom - 20)];
        _billWebView.UIDelegate = self;
        _billWebView.navigationDelegate = self;
        [[_billWebView configuration].userContentController addScriptMessageHandler:self name:@"yuyueSelectDate"];
        [_billWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@yuyue/newy.html",SERVER_H5]]]];
    }
    return _billWebView;
}
#pragma mark ------WKWebView------
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * token = model.data.token;
    NSString * storeCode = _storeParam[@"code"];
    NSString * time = _paramDate;
    NSString * jsStr = [NSString stringWithFormat:@"BookBillIOS('%@','%@','%@')",token,storeCode,time];
    [XMHWebSignTools loadWebViewJs:webView];
    [_billWebView evaluateJavaScript:jsStr completionHandler:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................页面加载失败时调用");
}
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
@end
