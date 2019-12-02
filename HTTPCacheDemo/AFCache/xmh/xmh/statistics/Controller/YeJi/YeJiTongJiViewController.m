//
//  YeJiTongJiViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "YeJiTongJiViewController.h"
#import "organizationalStructureView.h"
#import "YeJiView.h"
#import <WebKit/WebKit.h>
#import "YeJiTongJiCell.h"
#import "TJRequest.h"
#import "ShareWorkInstance.h"
#import "TJTopModel.h"
#import "TJYeJiListModel.h"
#import "UserManager.h"
#import "LDatePickView.h"
#import "RolesTools.h"
#import "TJSubCell.h"
@interface YeJiTongJiViewController ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end

@implementation YeJiTongJiViewController
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
    YeJiView * _yeji;
    TJTopModel * _topModel;
    TJYeJiListModel * _listModel;
    NSString *  _token;
    LDatePickView * _datePickView;
    UIView * _header;
    BOOL _isFirst;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _isFirst = YES;
    [self initSubViews];
    [self initBaseData];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
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
    
    YeJiView * yeji = [[[NSBundle mainBundle]loadNibNamed:@"YeJiView" owner:nil options:nil]lastObject];
    _yeji = yeji;
    yeji.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    
    UIView * header = [[UIView alloc] init];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 530);
    [header addSubview:yeji];
    _header = header;
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, yeji.bottom , SCREEN_WIDTH, 370)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@statistics/yeji.html",SERVER_H5]]]];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"yejiListResult"];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"typeList"];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"TJHEIGHT"];
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
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"业绩统计" withleftImageStr:@"back" withRightStr:nil];
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
- (void)createDateView
{
    WeakSelf
    _datePickView = [[LDatePickView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 44) dateBlock:^(NSString *start, NSString *end) {
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
#pragma mark    ------Refresh------
- (void)refreshUIHeight:(CGFloat)height
{
    _webView.frame = CGRectMake(0, _yeji.bottom, SCREEN_WIDTH, height);
    _header.frame = CGRectMake(0, 0, SCREEN_WIDTH, _webView.bottom);
    _tb.tableHeaderView = _header;
}
- (void)refreshTopView
{
    _yeji.model = _topModel;
}
#pragma mark    ------DATA------
- (void)requestData
{
    [self requestTopData];
    [_webView reload];
}
- (void)initBaseData
{
    _joinCode = [ShareWorkInstance shareInstance].join_code;
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _token = infomodel.data.token;
}
- (void)requestTopData
{
    WeakSelf
    [TJRequest requestYejiTopOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId joinCode:_joinCode startTime:cstartTime endTime:cendTime resultBlock:^(TJTopModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _topModel = model;
            [weakSelf refreshTopView];
        }
    }];
}
#pragma mark  ----TableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger mainRole = [RolesTools getUserMainRole];
    static NSString * highCell =  @"YeJiTongJiCell";
    static NSString * lowCell =  @"TJSubCell";
    if (mainRole > 7) {
        TJSubCell * cell = [tableView dequeueReusableCellWithIdentifier:lowCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TJSubCell" owner:nil options:nil]lastObject];
        }
        cell.model = _listModel.list[indexPath.row];
        return cell;
    }else{
        YeJiTongJiCell * cell = [tableView dequeueReusableCellWithIdentifier:highCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"YeJiTongJiCell" owner:nil options:nil]lastObject];
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
    //获取高度
    WeakSelf
    [_webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
        _webView.frame = CGRectMake(0,_yeji.bottom , SCREEN_WIDTH, heightStr.floatValue);
        [weakSelf updateUIFrameByWebViewH:heightStr.floatValue];
    }];
    
    [XMHProgressHUD dismiss];
}
- (void)updateUIFrameByWebViewH:(CGFloat)webViewH
{
    _webView.frame = CGRectMake(0,_yeji.bottom , SCREEN_WIDTH, webViewH);
    _header.frame = CGRectMake(0, 0, SCREEN_WIDTH, _yeji.height + webViewH);
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
    if ([message.name isEqualToString:@"typeList"]) {
        [_webView reload];
    }else if([message.name isEqualToString:@"yejiListResult"]){
        MzzLog(@"..........%@...%@",message.name,[message.body class]);
        NSData * jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSError * err;
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if (err) {
            NSLog(@"解析失败");
        }
        TJYeJiListModel * model = [TJYeJiListModel yy_modelWithJSON:dic];
        _listModel = model;
        if (model.list.count ==0) {
//            [SVProgressHUD showSuccessWithStatus:@"没有数据"];
        }else{
            [_tb reloadData];
        }
    }else{
        NSString * heightStr = (NSString *)message.body;
        if ([message.name isEqualToString:@"TJHEIGHT"]) {
            [self refreshUIHeight:heightStr.floatValue];
        }
    }
    
}
@end
