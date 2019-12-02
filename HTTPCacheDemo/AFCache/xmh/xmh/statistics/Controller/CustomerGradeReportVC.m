//
//  CustomerGradeReportVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerGradeReportVC.h"
#import "TJDataTbSectionView.h"
#import "TJSelectView.h"
#import "CustomerGradeCell.h"
#import "RolesTools.h"
#import <WebKit/WebKit.h>
#import "TJRequest.h"
#import "CustomerGradeListModel.h"
#import "TJGradeListModel.h"
#import "TJParamModel.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "CustomerGradeDetailVC.h"
#import "XMHRefreshGifHeader.h"
@interface CustomerGradeReportVC ()<UITableViewDelegate,UITableViewDataSource, WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)TJDataTbSectionView * dataTbSectionView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)TJSelectView * tJSelectView;
@property (nonatomic, strong)UISegmentedControl * segmentControl;
/** 数据选择数组 */
@property (nonatomic, strong) NSArray * selectDataArr;
@property (nonatomic, strong)WKWebView * webView;
/** 排序 最高 最低 */
@property (nonatomic, copy) NSString * sort;
/** 数据选择 */
@property (nonatomic, copy) NSString * type;
/** 层级 */
@property (nonatomic, copy) NSString * level;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation CustomerGradeReportVC
{
    /** 加载更多 */
    BOOL _isMore;
    /** 页码 */
    NSInteger _page;
    NSArray * _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /** 初始化数据 */
    _dataSource = [[NSMutableArray alloc] init];
    /** 默认非加载更多 */
    _isMore = NO;
    _page = 1;
    _sort = @"1";
    _type = @"all";
    _level = @"cj";
    [self initSubViews];
    [self requestListData];
    [self requestCustomerGradeData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"顾客等级" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.tbView];
    self.tJSelectView.hidden = NO;
    
}
- (UISegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        if ([RolesTools getUserMainRole] == 1) {
            _titles = @[@"层级",@"门店",@"员工"];
        }
        if ([RolesTools getUserMainRole] == 3||[RolesTools getUserMainRole] == 3||[RolesTools getUserMainRole] == 4||[RolesTools getUserMainRole] == 5||[RolesTools getUserMainRole] == 6||[RolesTools getUserMainRole] == 7) {
            _titles = @[@"层级",@"员工"];
        }
        _segmentControl = [[UISegmentedControl alloc] initWithItems:_titles];
        _segmentControl.frame = CGRectMake((SCREEN_WIDTH - 75 * 3)/2, Heigh_Nav+ 20, 75 * 3, 25);
        _segmentControl.tintColor = kColorTheme;
        [_segmentControl addTarget:self action:@selector(valueTap:) forControlEvents:UIControlEventValueChanged];
    }
    _segmentControl.selectedSegmentIndex = 0;
    return _segmentControl;
}
- (void)valueTap:(UISegmentedControl *)sc
{
    if (_titles.count == 2) {
        if (sc.selectedSegmentIndex == 0) {
            _level = @"cj";
        }
        if (sc.selectedSegmentIndex == 1) {
            _level = @"yg";
        }
    }
    if (_titles.count == 3) {
        if (sc.selectedSegmentIndex == 0) {
            _level = @"cj";
        }
        if (sc.selectedSegmentIndex == 1) {
            _level = @"md";
        }
        if (sc.selectedSegmentIndex == 2) {
            _level = @"yg";
        }
    }
    _isMore = NO;
    _page = 1;
    [self requestListData];
}
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = NO;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@statistics/vipGrade.html",SERVER_H5]]]];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"CustomerGradeMore"];
    }
    return _webView;
}
- (TJSelectView *)tJSelectView
{
    WeakSelf
    if (!_tJSelectView) {
        _tJSelectView = [[TJSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) timeBlock:^(NSString *startTime, NSString *endTime, NSString *title) {
        }];
        /** 数据选择 */
        _tJSelectView.TJSelectViewDataBlock = ^(TJParamModel *model) {
            weakSelf.type = model.type;
            [weakSelf.dataTbSectionView updateTJDataTbSectionViewTItle:model.name];
            [weakSelf refreshTbData];
        };
    }
    return _tJSelectView;
}
- (TJDataTbSectionView *)dataTbSectionView
{
    WeakSelf
    if (!_dataTbSectionView) {
        _dataTbSectionView = loadNibName(@"TJDataTbSectionView");
        _dataTbSectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 48);
        /** 最高100  最低101 */
        _dataTbSectionView.TJDataTbSectionViewBlock = ^(NSInteger tag) {
            if (tag == 100) {
                _sort = @"1";
            }
            if (tag == 101) {
                _sort = @"2";
            }
            [weakSelf refreshTbData];
        };
        _dataTbSectionView.TJDataTbSectionViewTapBlock = ^{
            [weakSelf tapData];
        };
        
    }
    return _dataTbSectionView;
}
/** 数据选择 */
- (void)tapData
{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    [self.tJSelectView updateTJSelectViewModelArr:_selectDataArr type:@"数据"];
    [_tJSelectView updateTJSelectViewSectionTitle:@"请选择"];
    [keyWindow addSubview:self.tJSelectView];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _segmentControl.bottom + 20, SCREEN_WIDTH, SCREEN_HEIGHT - _segmentControl.bottom - 20) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorF5F5F5;
        _tbView.estimatedRowHeight = 75;
        _tbView.tableHeaderView = self.webView;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestMoreData];
        }];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            [self refreshTbData];
        }];
    }
    return _gifHeader;
}
- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestListData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestListData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
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
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * framId = _framId?_framId:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * jsStr = [NSString stringWithFormat:@"CustomerGradeTopCallIOS('%@','%@','%@')",joinCode,infomodel.data.token,framId];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................页面加载失败时调用");
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"CustomerGradeMore"]) {
        CustomerGradeDetailVC * customerGradeDetailVC = [[CustomerGradeDetailVC alloc] init];
        [self.navigationController pushViewController:customerGradeDetailVC animated:NO];
    }
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kCustomerGradeCell = @"kCustomerGradeCell";
    CustomerGradeCell * customerGradeCell = [tableView dequeueReusableCellWithIdentifier:kCustomerGradeCell];
    if (!customerGradeCell) {
        customerGradeCell =  [[CustomerGradeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomerGradeCell];
    }
    [customerGradeCell updateCustomerGradeCellModel:_dataSource[indexPath.row]];
    return customerGradeCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.dataTbSectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerGradeReportVC * customerGradeVC = [[CustomerGradeReportVC alloc] init];
    CustomerGradeModel * model = _dataSource[indexPath.row];
    customerGradeVC.framId = model.fram_id;
    /** 员工层不能跳转 */
    if ([model.main_role isEqualToString:@"11"]||[model.main_role isEqualToString:@"8"]||[model.main_role isEqualToString:@"9"]||[model.main_role isEqualToString:@"10"]) {
        return;
    }
    [self.navigationController pushViewController:customerGradeVC animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSource.count > 0) {
         CustomerGradeModel * model = _dataSource[0];
        if (model.list.count > 0) {
            CGFloat H = 0.0f;
            if (model.list.count %2 == 0) {
                H = model.list.count /2 * 20;
            }else{
                H = (model.list.count /2 + 1) * 20;
            }
            return  75+ H;
        }
    }
    return 75.0f;
}
/** 列表数据 */
- (void)requestListData
{
    NSString * framId = _framId?_framId:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:_level?_level:@"" forKey:@"level"];
    [param setValue:_type?_type:@"all" forKey:@"type"];
    [param setValue:_sort?_sort:@"" forKey:@"sort"];
    [param setValue:page?page:@"1" forKey:@"page"];
    [TJRequest requestTJCustomerGradeDataParam:param resultBlock:^(CustomerGradeListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.next];
            /** 标识数据选择 */
            for (int i = 0; i < _dataSource.count; i++) {
                CustomerGradeModel * model = _dataSource[i];
                model.type = _type;
            }
            if (model.next.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }
        [_tbView reloadData];
    }];
}
/** 数据选择顾客等级 */
- (void)requestCustomerGradeData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSMutableArray * tempArr = [[NSMutableArray alloc] init];
     TJParamModel * paramModelFirst = [TJParamModel createParamModelName:@"总顾客数" type:@"all"];
    [tempArr addObject:paramModelFirst];
    [TJRequest requestTJGradeDataParam:param resultBlock:^(TJGradeListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            for (int i = 0; i < model.list.count; i++) {
                TJGradeModel * gradeModel = model.list[i];
                TJParamModel * paramModel = [TJParamModel createParamModelName:gradeModel.name type:gradeModel.key];
                [tempArr addObject:paramModel];
            }
            _selectDataArr = [[NSMutableArray alloc] initWithArray:tempArr];
        }else{}
    }];
}
@end
