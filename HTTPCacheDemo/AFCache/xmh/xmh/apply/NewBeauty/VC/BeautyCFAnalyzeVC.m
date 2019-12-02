//
//  BeautyCFAnalyzeVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/28.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFAnalyzeVC.h"
#import "LDatePickView.h"
#import <WebKit/WebKit.h>
#import "BeautyCFAnalyzeCell1.h"
#import "CustomerTbHeader.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "BeautyCFBiaoCell.h"
#import "BookRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "BeautyBillDetailVC.h"
#import "JasonSearchView.h"
#import "BeautyCFBiaoVC.h"
#import "DateSubViewModel.h"
#import "RolesTools.h"
#import "XMHWebSignTools.h"
#define kWebViewH           600
#define kDataViewUnfold     270
#define kDataViewFold       200
#define kMark
@interface BeautyCFAnalyzeVC ()
<
UITableViewDelegate,
UITableViewDataSource,
WKNavigationDelegate,
WKUIDelegate
//WKScriptMessageHandler
>
/** 选择日期 */
@property (nonatomic, strong)LDatePickView * datePickView;
/** 开始时间 */
@property (nonatomic, copy)NSString *startTime;
/** 结束时间 */
@property (nonatomic, copy)NSString *endTime;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)WKWebView * webView;
@property (nonatomic, strong)CustomerTbHeader * topDataView;
/** 选择器 */
@property (nonatomic, strong)UISegmentedControl * segmentedControl;
@property (nonatomic, strong)NSArray * titlesArr;
/** level */
@property (nonatomic, strong)NSDictionary * levelDic;
/** 层级 */
@property (nonatomic, copy)NSString *selectLevel;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)BOOL isMore;
/** 搜索顾客g  搜索条件 */
@property (nonatomic, copy)NSString * q;
@property (nonatomic, strong)UIView * topView;
/** 规划执行数据源 */
@property (nonatomic, strong)NSArray *ghzxArr;
/** 实际执行数据源 */
@property (nonatomic, strong)NSArray *sjzxArr;
/** 标题tag */
@property (nonatomic, assign)NSInteger titleTag;
/** 是否展开 */
@property (nonatomic, assign)BOOL isUnfold;
@end

@implementation BeautyCFAnalyzeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _levelDic = @{@"员工":@"yg",@"顾客":@"gk",@"层级":@"cj",@"门店":@"md"};
//    _pageType = BeautyPageTypeGL;
    _titleTag = 100;
    _dataSource = [[NSMutableArray alloc] init];
    _isMore = NO;
    _page = 1;
   
    if (_pageType == BeautyPageTypeDZ || _pageType == BeautyPageTypeYG) {
        _titlesArr = @[@"层级",@"顾客"];
    }else{
        _titlesArr = @[@"层级",@"门店"];
    }
    if (_pageType == BeautyPageTypeDJLandQT) {
        _selectLevel = @"md";
    }
    [self initSubViews];
    [self requestListData];
    [self requestPlanData];
    [self requestExecuteData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"处方分析" backBtnShow:YES];
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav + 45);
    self.logoView.image = UIImageName(@"stgkgl_ditu");
    [self.view addSubview:self.datePickView];
    [self.view addSubview:self.tbView];
}
#pragma mark ------DatePickView------
- (LDatePickView *)datePickView
{
    WeakSelf
    if (!_datePickView) {
        _datePickView = [[LDatePickView alloc] initWithFrame:CGRectMake(15, Heigh_Nav, SCREEN_WIDTH - 15 * 2 , 34) dateBlock:^(NSString *start, NSString *end) {
            weakSelf.startTime = start;
            weakSelf.endTime = end;
            /** 时间变化只影响八筒数据 */
            [weakSelf requestExecuteData];
            [weakSelf requestPlanData];
            
        }];
        _datePickView.backgroundColor = [UIColor whiteColor];
    }
    return _datePickView;
}
#pragma mark ------WKWebView------
-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kWebViewH)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = NO;
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
         [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_H5,kBEAUTY_HOMEWEB_URL]]]];
//            NSString * jsString = [NSString stringWithFormat:@"xhm_call_sign('%@')",kAPP_PRIVATEKEY];
//            [_webView evaluateJavaScript:jsString completionHandler:nil];
//        NSString *jsString = [NSString stringWithFormat:@"localStorage.setItem('kAPP_PRIVATEKEY', '%@')", kAPP_PRIVATEKEY];
//        [_webView evaluateJavaScript:jsString completionHandler:nil];
        
//        NSString * jsStr = [NSString stringWithFormat:@"xhm_call_sign('%@')",kAPP_PRIVATEKEY];
//        [_webView evaluateJavaScript:jsStr completionHandler:nil];
//        NSString *bundleStr = [[NSBundle mainBundle] pathForResource:@"AladdinIndex" ofType:@"html"];
//                [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:bundleStr]]];
        MzzLog(@"web............%@",[NSString stringWithFormat:@"%@%@",SERVER_H5,kBEAUTY_HOMEWEB_URL]);
    }
    return _webView;
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD showGifImage];
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD dismiss];
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * framID = _framID?_framID:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * token = infomodel.data.token;
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = _account?_account:model.data.account;
    [XMHWebSignTools loadWebViewJs:webView];
    NSString * jsStr = [NSString stringWithFormat:@"BeautyHomeWeb('%@','%@','%@','%@')",token,joinCode,framID,account];
//    [XMHWebSignTools loadWebViewJs:webView];
    
    
//    NSString * jsString = [NSString stringWithFormat:@"xhm_call_sign('%@')",kAPP_PRIVATEKEY];
//    [_webView evaluateJavaScript:jsString completionHandler:nil];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................页面加载失败时调用");
}
#pragma mark ------TableView------

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.logoView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.logoView.bottom) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorF5F5F5;
        if (_pageType == BeautyPageTypeDJLandQT) {
            _tbView.tableHeaderView = self.tbDJLHeaderView;
        }else{
            _tbView.tableHeaderView = self.tbHeaderView;
        }
        __weak typeof(self) _self = self;
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestMoreData];
        }];
    }
    return _tbView;
    
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
- (CustomerTbHeader *)topDataView
{
    WeakSelf
    if (!_topDataView) {
        _topDataView = loadNibName(@"CustomerTbHeader");
        [_topDataView updateCustomerTbHeaderTitle:@[@"规划执行",@"实际执行"]];
        _topDataView.CustomerTbHeaderTitleBlock = ^(NSInteger index) {
            if (index == 100) {
                [weakSelf.topDataView updateCustomerTbHeaderModel:weakSelf.ghzxArr];
            }else if (index == 101){
                [weakSelf.topDataView updateCustomerTbHeaderModel:weakSelf.sjzxArr];
            }
            weakSelf.titleTag = index;
            [weakSelf.topDataView updateCustomerTbHeaderStates];
        };
//        _topDataView.backgroundColor = kColorTheme;
        _topDataView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kDataViewFold);
    }
    return _topDataView;
}
- (UIView *)tbHeaderView
{
    WeakSelf
    CGFloat lineH = 10;
    UIView * tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200 + kWebViewH + 25 + 20 + lineH)];
    __weak UIView * tbHeaderViewWeak = tbHeaderView;
    tbHeaderView.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 15, 180, 25);
    self.topDataView.frame = CGRectMake(0, _segmentedControl.bottom + 5, SCREEN_WIDTH, 200);
    __weak CustomerTbHeader * weaktopDataView = _topDataView;
    self.webView.frame = CGRectMake(0, _topDataView.bottom, SCREEN_WIDTH, kWebViewH);
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, _webView.bottom, SCREEN_WIDTH, 10)];
    line.backgroundColor = kBackgroundColor;
    
    [tbHeaderView addSubview:_segmentedControl];
    [tbHeaderView addSubview:_topDataView];
    [tbHeaderView addSubview:_webView];
    [tbHeaderView addSubview:line];
    _topDataView.CustomerTbHeaderMoreBlock = ^(BOOL isSelect) {
        if (isSelect) {
            if (weakSelf.titleTag == 100) {
                weakSelf.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 15, 180, 25);
                weaktopDataView.frame = CGRectMake(0, weakSelf.segmentedControl.bottom + 5, SCREEN_WIDTH, 270);
                weakSelf.webView.frame =  CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, kWebViewH);
                line.frame = CGRectMake(0, weakSelf.webView.bottom, SCREEN_WIDTH, 10);
                tbHeaderViewWeak.frame = CGRectMake(0, 0, SCREEN_WIDTH, 270 + kWebViewH + 25 + 20 + lineH);
                weakSelf.tbView.tableHeaderView = tbHeaderViewWeak;
            }else{
                weakSelf.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 15, 180, 25);
                weaktopDataView.frame = CGRectMake(0, weakSelf.segmentedControl.bottom + 5, SCREEN_WIDTH, 320);
                weakSelf.webView.frame =  CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, kWebViewH);
                 line.frame = CGRectMake(0, weakSelf.webView.bottom, SCREEN_WIDTH, 10);
                tbHeaderViewWeak.frame = CGRectMake(0, 0, SCREEN_WIDTH, 320 + kWebViewH + 25 + 20 + lineH);
                weakSelf.tbView.tableHeaderView = tbHeaderViewWeak;
            }
        }else{
            weakSelf.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 15, 180, 25);
            weaktopDataView.frame = CGRectMake(0, weakSelf.segmentedControl.bottom + 5, SCREEN_WIDTH, 200);
            weakSelf.webView.frame =  CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, kWebViewH);
             line.frame = CGRectMake(0, weakSelf.webView.bottom, SCREEN_WIDTH, 10);
            tbHeaderViewWeak.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200 + kWebViewH + 25 + 20 + lineH);
            weakSelf.tbView.tableHeaderView = tbHeaderViewWeak;
        }
    };
    return tbHeaderView;
}
- (UIView *)tbDJLHeaderView
{
    WeakSelf
    CGFloat lineH = 10;
    UIView * tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200 + kWebViewH  + 20 + lineH)];
    tbHeaderView.backgroundColor = [UIColor whiteColor];
    self.topDataView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 200);
    __weak CustomerTbHeader * weaktopDataView = _topDataView;
    self.webView.frame = CGRectMake(0, _topDataView.bottom, SCREEN_WIDTH, kWebViewH);
    [tbHeaderView addSubview:_topDataView];
    [tbHeaderView addSubview:_webView];
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, _webView.bottom, SCREEN_WIDTH, 10)];
    line.backgroundColor = kBackgroundColor;
    _topDataView.CustomerTbHeaderMoreBlock = ^(BOOL isSelect) {
        if (isSelect) {
            if (weakSelf.titleTag == 100) {
                weaktopDataView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 270);
                weakSelf.webView.frame =  CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, kWebViewH);
                tbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 270 + kWebViewH + 20 + lineH);
                 line.frame = CGRectMake(0, weakSelf.webView.bottom, SCREEN_WIDTH, 10);
                weakSelf.tbView.tableHeaderView = tbHeaderView;
            }else{
                weaktopDataView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 320);
                weakSelf.webView.frame =  CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, kWebViewH);
                 line.frame = CGRectMake(0, weakSelf.webView.bottom, SCREEN_WIDTH, 10);
                tbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 320 + kWebViewH  + 20 + lineH);
                weakSelf.tbView.tableHeaderView = tbHeaderView;
            }
        }else{
            weaktopDataView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 200);
            weakSelf.webView.frame =  CGRectMake(0, weakSelf.topDataView.bottom, SCREEN_WIDTH, kWebViewH);
             line.frame = CGRectMake(0, weakSelf.webView.bottom, SCREEN_WIDTH, 10);
            tbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200 + kWebViewH  + 20 + lineH);
            weakSelf.tbView.tableHeaderView = tbHeaderView;
        }
    };
    return tbHeaderView;
}
- (UIView *)allCustomerTbHeaderView
{
    WeakSelf
    UIView * tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200 + 63 + 25 + 20)];
    self.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 15, 180, 25);
    self.topDataView.frame = CGRectMake(0, _segmentedControl.bottom + 5, SCREEN_WIDTH, 200);
    self.topView.frame = CGRectMake(0, _topDataView.bottom , SCREEN_WIDTH, 63);
    tbHeaderView.backgroundColor = [UIColor whiteColor];
    
    [tbHeaderView addSubview:_segmentedControl];
    [tbHeaderView addSubview:_topDataView];
    [tbHeaderView addSubview:_topView];

    _topDataView.CustomerTbHeaderMoreBlock = ^(BOOL isSelect) {
        if (isSelect) {
            if (weakSelf.titleTag == 100) {
                weakSelf.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 15, 180, 25);
                weakSelf.topDataView.frame = CGRectMake(0, weakSelf.segmentedControl.bottom + 5, SCREEN_WIDTH, 270);
                weakSelf.topView.frame = CGRectMake(0, weakSelf.topDataView.bottom , SCREEN_WIDTH, 63);
                tbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 270 + 63 + 25 + 20);
                weakSelf.tbView.tableHeaderView = tbHeaderView;
            }else{
                weakSelf.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 15, 180, 25);
                weakSelf.topDataView.frame = CGRectMake(0, weakSelf.segmentedControl.bottom + 5, SCREEN_WIDTH, 320);
                weakSelf.topView.frame = CGRectMake(0, weakSelf.topDataView.bottom , SCREEN_WIDTH, 63);
                tbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 320 + 63 + 25 + 20);
                weakSelf.tbView.tableHeaderView = tbHeaderView;
            }
        }else{
            weakSelf.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 15, 180, 25);
            weakSelf.topDataView.frame = CGRectMake(0, weakSelf.segmentedControl.bottom + 5, SCREEN_WIDTH, 200);
            weakSelf.topView.frame = CGRectMake(0, weakSelf.topDataView.bottom , SCREEN_WIDTH, 63);
            tbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200 + 63 + 25 + 20);
            weakSelf.tbView.tableHeaderView = tbHeaderView;
        }
       
    };
    return tbHeaderView;
}
- (UIView *)topView
{
    WeakSelf
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0,10, SCREEN_WIDTH, 63)];
        JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, (_topView.height - 34)/2, SCREEN_WIDTH - 15 - 55, 34) withPlaceholder:@"输入顾客姓名或手机号"];
        search.line1.hidden = YES;
        search.searchBar.frame = search.bounds;
        [_topView addSubview:search];
        search.searchBar.layer.cornerRadius = 3;
        search.searchBar.layer.masksToBounds = YES;
        
        __weak JasonSearchView * weakSearchView = search;
        search.searchBar.btnRightBlock = ^{
            weakSelf.q = weakSearchView.searchBar.text;
            [weakSelf refreshTbData];
        };
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(15);
        [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        btn.frame = CGRectMake(search.right, 0, 55, _topView.height);
        btn.userInteractionEnabled = NO;
        [_topView addSubview:btn];
        _topView.backgroundColor = [UIColor whiteColor];
        UILabel * line = [[UILabel alloc] init];
        line.frame = CGRectMake(0, _topView.height - 0.5, SCREEN_WIDTH, 0.5);
        line.backgroundColor = kColorE5E5E5;
        [_topView addSubview:line];
    }
    return _topView;
}
- (UISegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:_titlesArr];
        _segmentedControl.frame = CGRectMake((SCREEN_WIDTH - 180)/2, 25, 180, 25);
        [_segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: kBtn_Commen_Color} forState:UIControlStateNormal];
        //设置选中状态下的文字颜色和字体
        [_segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
        _segmentedControl.tintColor = kBtn_Commen_Color;
        _segmentedControl.selectedSegmentIndex = 0;
        [self segementValueChange:_segmentedControl];
        [_segmentedControl addTarget:self action:@selector(segementValueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}
- (void)segementValueChange:(UISegmentedControl *)sc
{
    [_topDataView updateCustomerTbHeaderStates];
    /** 切换时一切回到初始化 */
    _page = 1;
    _isMore = NO;
    [_dataSource removeAllObjects];
    
    NSString * title = [sc titleForSegmentAtIndex:sc.selectedSegmentIndex];
    _selectLevel = _levelDic[title];
    
    /** 如果切换到顾客 tableHeaderView 切换 */
    if ([title isEqualToString:@"顾客"]) {
        _tbView.tableHeaderView = self.allCustomerTbHeaderView;
    }else{
        _tbView.tableHeaderView = self.tbHeaderView;
    }
    
    [self requestListData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//        return 10;
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kBeautyCFAnalyzeCell1 = @"kBeautyCFAnalyzeCell1";
    static NSString * kBeautyCFBiaoCell = @"kBeautyCFBiaoCell";
    if ([_selectLevel isEqualToString:@"gk"]) {
        BeautyCFBiaoCell * cell = [tableView dequeueReusableCellWithIdentifier:kBeautyCFBiaoCell];
        if (!cell) {
            cell = loadNibName(@"BeautyCFBiaoCell");
        }
        if (_dataSource.count > indexPath.row) {
           [cell updateCellHomeParam:_dataSource[indexPath.row]];
        }
        
        return cell;
    }else{
        BeautyCFAnalyzeCell1 * cell = [tableView dequeueReusableCellWithIdentifier:kBeautyCFAnalyzeCell1];
        if (!cell) {
            cell = loadNibName(@"BeautyCFAnalyzeCell1");
            if (_dataSource.count > indexPath.row) {
                [cell updateCellParam:_dataSource[indexPath.row]];
                [cell updateCellShowByMainRole:_mainRole];
            }
            
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_selectLevel isEqualToString:@"gk"]) {
        return 124;
    }
    return 132.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_selectLevel isEqualToString:@"gk"]) {
        BeautyBillDetailVC * next = [[BeautyBillDetailVC alloc] init];
        next.userID = _dataSource[indexPath.row][@"user_id"];
        next.userParam = _dataSource[indexPath.row];
        [self.navigationController pushViewController:next animated:NO];
    }else if ([_selectLevel isEqualToString:@"md"]){
        BeautyCFBiaoVC * next = [[BeautyCFBiaoVC alloc] init];
        next.storeParam = _dataSource[indexPath.row];
        [self.navigationController pushViewController:next animated:NO];
    }else{
        BeautyCFAnalyzeVC * next = [[BeautyCFAnalyzeVC alloc] init];
        if([[_dataSource[indexPath.row] objectForKey:@"main_role"] isEqual:[NSNull null]]){
            return;
        }
        NSInteger mainRole = [_dataSource[indexPath.row][@"main_role"] integerValue];
        if (mainRole == 1 ||mainRole == 3) {
            next.pageType = BeautyPageTypeGL;
        }
        if (mainRole == 4 ||mainRole== 5 ||mainRole == 6 ||mainRole == 7) {
            next.pageType = BeautyPageTypeDZ;
        }
        if(mainRole == 3 ||mainRole == 7){
            next.pageType = BeautyPageTypeDJLandQT;
        }
        if (_mainRole == 8 || _mainRole == 9 || _mainRole == 10 ||_mainRole == 11 ) {
            return;
        }
        next.mainRole = mainRole;
        next.framID = _dataSource[indexPath.row][@"fram_id"];
        next.account = _dataSource[indexPath.row][@"account"];
        [self.navigationController pushViewController:next animated:NO];
    }
}

#pragma mark------网络请求-------
/*
    1、时间只控制八筒数据 2、segement 切换只控制列表数据
 */

/** 列表数据 */
- (void)requestListData
{   /** 美容师 account */
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = _account?_account:model.data.account;
    /** cj：层级；md：门店（店长、美容师没有门店按钮）；gk：顾客(只有店长、美容师有顾客按钮) */
    NSString * level = _selectLevel;
    /** 分页 1开始 */
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    /** 每页多少 默认10 */
    NSString * pageSize = @"10";
    /** 登录人 fram_id */
    NSString * fram_id = _framID?_framID:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    
    NSString * q = _q;
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:level?level:@"" forKey:@"level"];
    [param setValue:page?page:@"" forKey:@"page"];
    [param setValue:pageSize?pageSize:@"" forKey:@"pageSize"];
    [param setValue:fram_id?fram_id:@"" forKey:@"fram_id"];
    if ([level isEqualToString:@"gk"]) {
        [param setValue:q?q:@"" forKey:@"q"];
    }
    [BookRequest requestCommonUrl:kBEAUTY_HOMELIST_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            if ([resultDic[@"list"] isKindOfClass:[NSArray class]]) {
                [_dataSource addObjectsFromArray:resultDic[@"list"]];
                if ([resultDic[@"list"] count] == 0) {
                    [_tbView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_tbView reloadData];
        }else{};
    }];
}
/** 规划统计数据 */
- (void)requestPlanData
{
    /** 开始时间 YY-mm-dd */
    NSString * start_time = _startTime;
    /** 结束时间 YY-mm-dd */
    NSString * end_time = _endTime;
    /** 登录人 fram_id */
    NSString * fram_id = _framID?_framID:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    /** 登录人account */
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = _account?_account:model.data.account;
//    NSString * q = _q;
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:start_time?start_time:@"" forKey:@"start_time"];
    [param setValue:end_time?end_time:@"" forKey:@"end_time"];
    [param setValue:fram_id?fram_id:@"" forKey:@"fram_id"];
    [param setValue:account?account:@"" forKey:@"account"];
    [BookRequest requestCommonUrl:kBEAUTY_HOMEPLAN_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            
            DateSubViewModel * model1 = [DateSubViewModel createModelIconName:@"guihuatongji_guihuazongchufang" textName:@"规划总处方" textValue:resultDic[@"ghzcfs"]   isShow:NO];
            DateSubViewModel * model2 = [DateSubViewModel createModelIconName:@"guihuatongji_guihuazongcishu" textName:@"规划总次数" textValue:resultDic[@"ghzcs"]  isShow:NO];
            DateSubViewModel * model3 = [DateSubViewModel createModelIconName:@"guihuatongji_guihuazongjine" textName:@"规划总金额" textValue:resultDic[@"ghzje"]  isShow:NO];
            DateSubViewModel * model4 = [DateSubViewModel createModelIconName:@"guihuatongji_guihuazongxiangmushu" textName:@"规划总项目数" textValue:resultDic[@"ghzxms"]  isShow:NO];
            DateSubViewModel * model5 = [DateSubViewModel createModelIconName:@"guihuatongji_yikaichufangrenshu" textName:@"已开处方数" textValue:resultDic[@"ykcfrs"]  isShow:NO];
            DateSubViewModel * model6 = [DateSubViewModel createModelIconName:@"guihuatongji_weikaichufangrenshu" textName:@"未开处方人数" textValue:resultDic[@"wkcfrs"]  isShow:NO];
            _ghzxArr = @[model1,model2,model3,model4,model5,model6];
            if (_titleTag == 100) {
                 [_topDataView updateCustomerTbHeaderModel:_ghzxArr];
            }
            
        }else{};
    }];
}
/** 实际执行数据 */
- (void)requestExecuteData
{
    /** 开始时间 YY-mm-dd */
    NSString * start_time = _startTime;
    /** 结束时间 YY-mm-dd */
    NSString * end_time = _endTime;
    /** 登录人 fram_id */
    NSString * fram_id = _framID?_framID:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];;
    /** 登录人account */
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = _account?_account:model.data.account;
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:start_time?start_time:@"" forKey:@"start_time"];
    [param setValue:end_time?end_time:@"" forKey:@"end_time"];
    [param setValue:fram_id?fram_id:@"" forKey:@"fram_id"];
    [param setValue:account?account:@"" forKey:@"account"];
    [BookRequest requestCommonUrl:kBEAUTY_HOMEEXECUTE_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            DateSubViewModel * model1 = [DateSubViewModel createModelIconName:@"shijizhixing_chufangzhixingcishu" textName:@"处方执行次数" textValue:resultDic[@"cfzxcs"]   isShow:NO];
            DateSubViewModel * model2 = [DateSubViewModel createModelIconName:@"shijizhixing_chufangzhixingxiangmushu" textName:@"处方执行项目数" textValue:resultDic[@"cfzxxms"]  isShow:NO];
            DateSubViewModel * model3 = [DateSubViewModel createModelIconName:@"shijizhixing_chufangxiaohaojine" textName:@"处方消耗金额" textValue:resultDic[@"cfxhje"]  isShow:NO];
            DateSubViewModel * model4 = [DateSubViewModel createModelIconName:@"shijizhixing_chufangjiedairenshu" textName:@"处方接待人数" textValue:resultDic[@"cfjdrs"]  isShow:NO];
            DateSubViewModel * model5 = [DateSubViewModel createModelIconName:@"shijizhixing_guihuaneizhixing" textName:@"规划内执行" textValue:resultDic[@"ghnzx"]  isShow:NO];
            DateSubViewModel * model6 = [DateSubViewModel createModelIconName:@"shijizhixing_guihuaneiweizhixing" textName:@"规划内未执行" textValue:resultDic[@"ghnwzx"]  isShow:NO];
            DateSubViewModel * model7 = [DateSubViewModel createModelIconName:@"shijizhixing_guihuawaizhixing" textName:@"规划外执行" textValue:resultDic[@"ghwzx"]  isShow:NO];
            DateSubViewModel * model8 = [DateSubViewModel createModelIconName:@"shijizhixing_weidaodianweizhixing" textName:@"未到店未执行" textValue:resultDic[@"wddwzx"]  isShow:NO];
            _sjzxArr = @[model1,model2,model3,model4,model5,model6,model7,model8];
            
            if (_titleTag == 101) {
                 [_topDataView updateCustomerTbHeaderModel:_sjzxArr];
            }
        }else{};
    }];
}
@end
