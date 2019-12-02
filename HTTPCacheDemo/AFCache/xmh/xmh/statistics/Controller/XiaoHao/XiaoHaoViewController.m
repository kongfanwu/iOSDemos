//
//  XiaoHaoViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/26.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "XiaoHaoViewController.h"
#import "organizationalStructureView.h"
#import <WebKit/WebKit.h>
#import "TJXiaoHaoCell.h"
#import "TJRequest.h"
#import "ShareWorkInstance.h"
#import "XiaoHaoTopModel.h"
#import "TJYeJiListModel.h"
#import "UserManager.h"
#import "XiaoHaoTopView.h"
#import "LDatePickView.h"
#import "RolesTools.h"
#import "TJXiaoHaoSubCell.h"
@interface XiaoHaoViewController ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end

@implementation XiaoHaoViewController
{
    organizationalStructureView * _organizationHeader;
    UITableView * _tb;
    UIView * _topView;
    WKWebView * _webView;
    
    //参数
    NSString *cjoin_code;
    NSString *coneClick;
    NSString *ctwoClick;
    NSString *ctwoListId;
    NSString *cinId;
    NSString *cstartTime;
    NSString *cendTime;
    NSString * _joinCode;
    XiaoHaoTopView * _xiaoHaoTopView;
    XiaoHaoTopModel * _topModel;
    TJYeJiListModel * _listModel;
    NSString *  _token;
    LDatePickView * _datePickView;
    UIView * _header;
    BOOL _isFirst;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isFirst = YES;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    [self initBaseData];
}
#pragma mark    ------DATA------
- (void)initBaseData
{
    _joinCode = [ShareWorkInstance shareInstance].join_code;
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _token = infomodel.data.token;
    
}
- (void)requestTopData
{
    WeakSelf
    [TJRequest requestXiaoHaoTopOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId joinCode:_joinCode startTime:cstartTime endTime:cendTime resultBlock:^(XiaoHaoTopModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _topModel = model;
            [weakSelf refreshTopView];
        }
    }];
}
- (void)refreshTopView
{
    _xiaoHaoTopView.model = _topModel;
}
#pragma mark    ------UI------
- (void)initSubViews
{
    [self creatNav];
    [self createDateView];
    [self createStructureView];
    [self createTableView];
}
- (void)createTableView
{
    UIView * line = [[UIView alloc] init];
    line.frame = CGRectMake(0, _datePickView.bottom, SCREEN_WIDTH, 10);
    line.backgroundColor = kBackgroundColor;
    [self.view addSubview:line];
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, line.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - line.bottom) style:UITableViewStylePlain];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tb];
    
    XiaoHaoTopView * yeji = [[[NSBundle mainBundle]loadNibNamed:@"XiaoHaoTopView" owner:nil options:nil]lastObject];
    _xiaoHaoTopView = yeji;
    yeji.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    
    UIView * header = [[UIView alloc] init];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 515);
    [header addSubview:yeji];
    _header = header;
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, yeji.bottom , SCREEN_WIDTH, 350)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@statistics/xiaohao.html",SERVER_H5]]]];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"yejiListResult"];
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
        }];
    [header addSubview:_webView];
    
    _tb.tableHeaderView = header;
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"消耗统计" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)createStructureView
{
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, _datePickView.bottom, SCREEN_WIDTH, 69);
    view.backgroundColor = kBackgroundColor;
    [self.view addSubview:view];
    WeakSelf
    _organizationHeader = [[organizationalStructureView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 49)];
    _organizationHeader.organizationalStructureViewBlock = ^(NSString *join_code, NSString *oneClick, NSString *twoClick, NSString *twoListId, NSString *inId,NSInteger level,NSInteger mainrole,List*listInfo) {
        
        cjoin_code = join_code;
        coneClick = oneClick;
        ctwoClick = twoClick;
        ctwoListId = twoListId;
        cinId = inId;
        [weakSelf requestData];
    };
    [view addSubview:_organizationHeader];
    _topView = view;
    _topView.hidden = YES;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)createDateView
{
    WeakSelf
    _datePickView = [[LDatePickView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 44) dateBlock:^(NSString *start, NSString *end) {
        cstartTime = start;
        cendTime = end;
        
        if (!_isFirst) {
            [weakSelf requestData];
        }else{
            _isFirst = NO;
        }
    }];
    [self.view addSubview:_datePickView];
}
- (void)requestData
{
    [self requestTopData];
    [_webView reload];
}
#pragma mark  ----TableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger mainRole = [RolesTools getUserMainRole];
    static NSString * highCell =  @"TJXiaoHaoCell";
    static NSString * lowCell =  @"TJXiaosHaoSubCell";
    if (mainRole > 7) {
        TJXiaoHaoSubCell * cell = [tableView dequeueReusableCellWithIdentifier:lowCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TJXiaoHaoSubCell" owner:nil options:nil]lastObject];
        }
        cell.model = _listModel.list[indexPath.row];
        return cell;
    }else{
        TJXiaoHaoCell * cell = [tableView dequeueReusableCellWithIdentifier:highCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TJXiaoHaoCell" owner:nil options:nil]lastObject];
        }
        cell.model = _listModel.list[indexPath.row];
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listModel.list.count;
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger mainRole = [RolesTools getUserMainRole];
    if (mainRole > 7) {
        return 150.f;
    }else{
        return 170.f;
    }
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD showGifImage];
    MzzLog(@"...................页面开始加载时调用11");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................当内容开始返回时调用11");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载完成之后调用11");
    NSString * mainRole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    NSString * jsStr = [NSString stringWithFormat:@"yejitongjilist('%@','%@','%@','%@','%@','%@','%@','%@','%@')",_token,coneClick,ctwoClick,ctwoListId,cinId,_joinCode,cstartTime,cendTime,mainRole];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
    //
    //    [MBProgressHUD hideHUDForView:self.view];
    WeakSelf
    [_webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
        [weakSelf updateUIFrameByWebViewH:heightStr.floatValue];
    }];
    [XMHProgressHUD dismiss];
}
- (void)updateUIFrameByWebViewH:(CGFloat)webViewH
{
    _webView.frame = CGRectMake(0,_xiaoHaoTopView.bottom , SCREEN_WIDTH, webViewH);
    _header.frame = CGRectMake(0, 0, SCREEN_WIDTH, _xiaoHaoTopView.height + webViewH);
    _tb.tableHeaderView = _header;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载失败时调用11");
}
//wk被terminate时调用
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    MzzLog(@"..........%@...%@",message.name,[message.body class]);
    NSData * jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        NSLog(@"解析失败");
    }
    TJYeJiListModel * model = [TJYeJiListModel yy_modelWithJSON:dic];
    _listModel = model;
    [_tb reloadData];
}
@end
