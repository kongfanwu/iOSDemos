//
//  DealOnlineController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "DealOnlineController.h"
#import "LDatePickView.h"
#import "WorkChoiceView.h"
#import "organizationalStructureView.h"
#import "LDealWebCell.h"
#import "LDealProjectCell.h"
#import "LDealCountCell.h"
#import "LDealOrderDetailController.h"
#import "OnLineRequest.h"
#import "OHomeListModel.h"
#import "OTopModel.h"
#import "LDealSearchCell.h"
#import "organizationalStructureView.h"
#import "LFrameView.h"
#import "COrganizeModel.h"
#import "LDealCountView.h"
#import "JasonSearchView.h"
#import <WebKit/WebKit.h>

@interface DealOnlineController ()<
UITableViewDelegate,
UITableViewDataSource,
WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler
>
//开始时间
/** <##> */
@property (nonatomic, copy) NSString * start;
//结束时间
@property (nonatomic, copy) NSString * end;
//是否第一次
@property (nonatomic) BOOL isFirst;
//组织架构参数model
/** <##> */
@property (nonatomic, strong) COrganizeModel * organizeModel;
//搜索参数
@property (nonatomic, strong) NSString * parame;
//搜索
@property (nonatomic, strong) JasonSearchView *searchView;
@end

@implementation DealOnlineController
{
    UITableView * _tb;
    WorkChoiceView * _workChoiceview;
    organizationalStructureView *_organizationHeader;
    LDealWebCell * _webCell;
    LDealCountCell * _countCell;
    LDealSearchCell * _searchCell;
    //web高度
    CGFloat  _webHeight;
    CGFloat _choiseBegainy;
    OHomeListModel * _listModel;
    OTopModel * _topModel;
    
    
    //Cell类型
    NSInteger _cellType;
    //时间选择
    LDatePickView * _datePickView;
    
    
    //组织架构
    LFrameView * _frame;
    WKWebView * _webView;
    LDealCountView * _countView;
    UIView * _tableHeader ;
    //页码
    NSInteger _page;
    
    //数据源数组
    NSMutableArray * _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    _isFirst = YES;
    [self initSubViews];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[_webView configuration].userContentController  removeScriptMessageHandlerForName:@"getWebH"];
}

#pragma mark    ------UI------
- (void)initSubViews
{
    UIView * tableHeader = [[UIView alloc] init];
    tableHeader.backgroundColor = kBackgroundColor;
    _tableHeader = tableHeader;
    WeakSelf
    [self createNav];
    __weak typeof(self) _self = self;
    _datePickView = [[LDatePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) dateBlock:^(NSString *start, NSString *end) {
        __strong typeof(_self) self = _self;
        self.start = start;
        self.end = end;
        if (!self.isFirst) {
            [weakSelf requestNetData];
        }else{
            self.isFirst = NO;
        }
    }];
    _datePickView.backgroundColor = [UIColor whiteColor];
    
    if (!_frame) {
        __weak typeof(self) _self = self;
        _frame = [[LFrameView alloc] initWithFrame:CGRectMake(0, _datePickView.bottom + 10, SCREEN_WIDTH, 44) ParameBlock:^(COrganizeModel *model) {
            __strong typeof(_self) self = _self;
            self.organizeModel = model;
            [weakSelf requestNetData];
        }];
    }
    
    LDealCountView * countView = [[[NSBundle mainBundle]loadNibNamed:@"LDealCountView" owner:nil options:nil]lastObject];
    countView.frame = CGRectMake(0, _frame.bottom + 10, SCREEN_WIDTH, 135);
    _countView = countView;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, countView.bottom + 10, SCREEN_WIDTH, 0)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"getWebH"];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@online/chart.html",SERVER_H5]]]];
    
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, _webView.bottom, SCREEN_WIDTH,45)withPlaceholder:@"项目名称"];
    _searchView.searchBar.btnRightBlock = ^{
        __strong typeof(_self) self = _self;
        //搜索
        self.parame = self.searchView.searchBar.text;
        [weakSelf requestNetData];
    };
    [_searchView updateFrame];
    
    tableHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, _searchView.bottom + 10);
    [tableHeader addSubview:_datePickView];
    [tableHeader addSubview:_frame];
    [tableHeader addSubview:countView];
    [tableHeader addSubview:_webView];
    [tableHeader addSubview:_searchView];
    
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.tableHeaderView = tableHeader;
    _tb.tableFooterView = [[UIView alloc] init];
    _tb.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestNetData];
    }];
    _tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
    [self.view addSubview:_tb];
}
- (void)createNav
{
    WeakSelf
    [self.navView setNavViewTitle:@"线上交易" backBtnShow:YES rightBtnTitle:@"订单详情"];
    
    self.navView.NavViewRightBlock = ^{
        [weakSelf oneStep];
    };
    self.navView.backgroundColor = kColorTheme;
//    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"线上交易" withleftImageStr:@"back" withRightStr:@"订单详情"];
//    [nav.btnRight addTarget:self action:@selector(oneStep) forControlEvents:UIControlEventTouchUpInside];
//    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nav];
}
#pragma mark    ------Refresh------
- (void)refreshCellHeight:(NSString *)heightStr
{
    _webView.height = heightStr.floatValue;
    [self refreshSearchViewiSshowByType:_listModel.type];
}
- (void)refreshSearchViewiSshowByType:(NSInteger)type{
    if (type == 1) {
        _searchView.hidden = YES;
        _tableHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, _webView.bottom + 10);
        _tb.tableHeaderView = _tableHeader;
    }else if (type ==2){
        _searchView.hidden = NO;
        _searchView.frame =CGRectMake(0, _webView.bottom + 10, SCREEN_WIDTH,45);
        _tableHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, _searchView.bottom + 10);
        _tb.tableHeaderView = _tableHeader;
    }
}
#pragma mark    ------ACTION------
- (void)oneStep
{
    LDealOrderDetailController *detail = [[LDealOrderDetailController alloc] init];
    detail.origanizeModel = _organizeModel;
    [self.navigationController pushViewController:detail animated:NO];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark    ------DATA------
- (void)requestNetData{
    _page = 0;
    [OnLineRequest requestTopDataJoinCode:_organizeModel.joinCode oneClick:_organizeModel.oneClick twoClick:_organizeModel.twoClick twoListId:_organizeModel.twoListId thrClick:_organizeModel.thirdClick fouClick:_organizeModel.forthClick start:_start end:_end resultBlock:^(OTopModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _countView.topModel = model;
        }
    }];
    [_dataSource removeAllObjects];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    [OnLineRequest requestListJoinCode:_organizeModel.joinCode oneClick:_organizeModel.oneClick twoClick:_organizeModel.twoClick twoListId:_organizeModel.twoListId thrClick:_organizeModel.thirdClick fouClick:_organizeModel.forthClick start:_start end:_end param:_parame page:page resultBlock:^(OHomeListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self endRefreshing];
            [self refreshSearchViewiSshowByType:model.type];
            _listModel = model;
            [_dataSource addObjectsFromArray:model.list];
            _cellType = _listModel.type;
            [_tb reloadData];
        }
    }];
    [_webView reload];
}
- (void)requestMoreNetData{
    _page ++;
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    [OnLineRequest requestListJoinCode:_organizeModel.joinCode oneClick:_organizeModel.oneClick twoClick:_organizeModel.twoClick twoListId:_organizeModel.twoListId thrClick:_organizeModel.thirdClick fouClick:_organizeModel.forthClick start:_start end:_end param:_parame page:page resultBlock:^(OHomeListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self endRefreshing];
            if (model.list.count ==0) {
                [_tb.mj_footer endRefreshingWithNoMoreData];
                return ;
            }
            _listModel = model;
            _cellType = _listModel.type;
            [_dataSource addObjectsFromArray:model.list];
            [_tb reloadData];
        }
    }];
}
- (void)endRefreshing{
    [_tb.mj_header endRefreshing];
    [_tb.mj_footer endRefreshing];
}
#pragma mark    ------UITableViewDelegate------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * thirdCellId = @"thirdCellId";
    LDealProjectCell * cell = [tableView dequeueReusableCellWithIdentifier:thirdCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LDealProjectCell" owner:nil options:nil]lastObject];
    }
    if (_dataSource.count>0) {
        [cell updateLDealProjectCellWithModel:_dataSource[indexPath.row] type:_cellType];
    }
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"getWebH"]) {
        NSString *heightStr = (NSString *)message.body;
        [self refreshCellHeight:heightStr];
    }
}
#pragma mark    ------WKNavigationDelegate------
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面开始加载时调用");
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................当内容开始返回时调用");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * token = infomodel.data.token;
    MzzLog(@"...................页面加载完成之后调用");
    NSString * jsStr = [NSString stringWithFormat:@"beautyHomeCallJs('%@','%@','%@','%@','%@','%@','%@','%@','%@')",token,_organizeModel.joinCode,_organizeModel.oneClick,_organizeModel.twoClick,_organizeModel.twoListId,_organizeModel.thirdClick,_organizeModel.forthClick,_start,_end];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
    WeakSelf
    [_webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
        [weakSelf refreshCellHeight:heightStr];
    }];
    MzzLog(@".........%f",_webView.scrollView.contentSize.height);
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载失败时调用");
}
@end
