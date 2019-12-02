//
//  BookAnalyzeOneCustomerVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookAnalyzeOneCustomerVC.h"
#import "BookTbSectionHeader.h"
#import "BookCommonCell2.h"
#import "BookRequest.h"
#import "LolGuKeStateModelList.h"
#import <WebKit/WebKit.h>
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
@interface BookAnalyzeOneCustomerVC ()
<
UITableViewDelegate,
UITableViewDataSource,
WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler
>
@property (nonatomic, strong)BookTbSectionHeader * bookTbSectionHeader;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)LolGuKeStateModelList *customerStateModelList;
@property (nonatomic, strong)WKWebView * oneCustomerWebView;
@property (nonatomic, copy) NSString * oneCustomerSelectDate;
@end

@implementation BookAnalyzeOneCustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorF5F5F5;
    [self initSubViews];
    [self requestOneCustomersData];
}

- (void)initSubViews
{
    [self.navView setNavViewTitle:@"预约分析" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.tbView];
}
-(WKWebView *)oneCustomerWebView
{
    if (!_oneCustomerWebView) {
        _oneCustomerWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 450)];
        _oneCustomerWebView.UIDelegate = self;
        _oneCustomerWebView.navigationDelegate = self;
        _oneCustomerWebView.scrollView.scrollEnabled = NO;
        [[_oneCustomerWebView configuration].userContentController addScriptMessageHandler:self name:@"getUserCalendar"];
        [[_oneCustomerWebView configuration].userContentController addScriptMessageHandler:self name:@"GuKeCalenderReload"];
        [_oneCustomerWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beauty/yuyue_time.html",SERVER_H5]]]];
    }
    return _oneCustomerWebView;
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
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * token = infomodel.data.token;
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    /** 1、列表点击 2、组织架构 两种情况点击到单个顾客 */
    NSString * userId = _userID;
    NSString * jsStr = [NSString stringWithFormat:@"callIos('%@','%@','%@','%@')",userId,joinCode,token,_searchDate];
    [XMHWebSignTools loadWebViewJs:webView];
    [_oneCustomerWebView evaluateJavaScript:jsStr completionHandler:nil];
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
    if ([message.name isEqualToString:@"GuKeCalenderReload"]) {
        _searchDate = message.body;
        [self requestOneCustomersData];
        [_oneCustomerWebView reload];
    }
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableHeaderView = self.oneCustomerWebView;
    }
    return _tbView;
}
#pragma mark ------UITableViewDelegate------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _customerStateModelList.list.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kBookCommonCell2 = @"kBookCommonCell2";
    BookCommonCell2 * bookCommonCell2 = [tableView dequeueReusableCellWithIdentifier:kBookCommonCell2];
    if (!bookCommonCell2) {
        bookCommonCell2 = loadNibName(@"BookCommonCell2");
    }
    [bookCommonCell2 updateBookCommonCellModel:_customerStateModelList.list[indexPath.row]];
    return bookCommonCell2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BookTbSectionHeader * bookTbSectionHeader = loadNibName(@"BookTbSectionHeader");
    [bookTbSectionHeader updateBookTbSectionHeaderOneCustomerModel:_customerStateModelList];
    return bookTbSectionHeader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}
#pragma mark ------网络请求------
/** 加载单个顾客项目 */
- (void)requestOneCustomersData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_userID?_userID:@"" forKey:@"id"];
    [param setValue:_searchDate?_searchDate:@"" forKey:@"date"];
    [BookRequest requestOneGukeListParam:param resultBlock:^(LolGuKeStateModelList *guKeListModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _customerStateModelList = guKeListModel;
            [_tbView reloadData];
        }
    }];
}
@end
