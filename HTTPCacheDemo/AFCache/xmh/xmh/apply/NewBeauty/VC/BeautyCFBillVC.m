//
//  BeautyCFBillVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFBillVC.h"
#import "BeautyCFBillSubVC.h"
#import "SPPageMenu.h"
#import "BookWaitTbHeader.h"
#import "JasonSearchView.h"
#import "BeautyCFCell.h"
#import "BeautyCFDetailVC.h"
#import "BookRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "BeautyRequest.h"
#import "BeautyCFReportWriteVC.h"
#import "BeautyCFReportVC.h"
#import "ShareWorkInstance.h"
#import "XMHRefreshGifHeader.h"
#define pageMenuH 44
#define scrollViewHeight (SCREEN_HEIGHT - Heigh_Nav - pageMenuH)
@interface BeautyCFBillVC ()<SPPageMenuDelegate, UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) SPPageMenu *pageMenu;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)BOOL isMore;
@property (nonatomic, assign)NSInteger page;
/** 0 进行中  1 已完成 */
@property (nonatomic, assign)NSInteger stateIndex;
@property (nonatomic, copy)NSString * q;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation BeautyCFBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self.navView setNavViewTitle:@"顾客总处方" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    _dataSource = [[NSMutableArray alloc] init];
    _dataArr = @[@"进行中",@"已完成"];
    _isMore = NO;
    _page = 1;
    _stateIndex  = 0;
    [self initSubViews];
    
}
- (UIView *)topView
{
    WeakSelf
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, pageMenuH + Heigh_Nav + 10, SCREEN_WIDTH, 63)];
        JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, (_topView.height - 34)/2, SCREEN_WIDTH - 15 - 55, 34) withPlaceholder:@"姓名/手机号"];
        search.line1.hidden = YES;
        search.searchBar.frame = search.bounds;
        [_topView addSubview:search];
        search.searchBar.layer.cornerRadius = 3;
        search.searchBar.layer.masksToBounds = YES;
        search.searchBar.textColor = kColor9;
        
        __weak JasonSearchView * weakSearchView = search;
        search.searchBar.btnRightBlock = ^{
            weakSelf.q = weakSearchView.searchBar.text;
            [weakSelf refreshTbData];
        };
        //    search.userInteractionEnabled = NO;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(15);
        [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        btn.frame = CGRectMake(search.right, 0, 55, _topView.height);
        btn.userInteractionEnabled = NO;
        [_topView addSubview:btn];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (void)initSubViews
{
    [self createPageMenu];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tbView];

}
- (void)createPageMenu
{
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLine];
    pageMenu.selectedItemTitleColor = kColorTheme;
    pageMenu.dividingLineHeight = 0;
    pageMenu.unSelectedItemTitleColor = kColor6;
    pageMenu.selectedItemTitleFont = FONT_BOLD_SIZE(15);
    pageMenu.unSelectedItemTitleFont = FONT_SIZE(15);
    pageMenu.trackerWidth = 40;
    pageMenu.tracker.backgroundColor = kColorTheme;
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}
#pragma mark - SPPageMenu的代理方法
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
}
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    _stateIndex = toIndex;
    [self refreshTbData];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _topView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _topView.bottom)];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        //        _tbView.tableHeaderView = self.tbHeader;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        __weak typeof(self) _self = self;
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestMoreData];
        }];
        [_tbView.mj_header beginRefreshing];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                __strong typeof(_self) self = _self;
                [self refreshTbData];
            });
        }];
    }
    return _gifHeader;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshTbData];
}
- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestCFData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestCFData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLMemberBenefitsCell = @"kGKGLMemberBenefitsCell";
    BeautyCFCell * cell = [tableView dequeueReusableCellWithIdentifier:kGKGLMemberBenefitsCell];
    if (!cell) {
        cell =  loadNibName(@"BeautyCFCell");
    }
    /** 结束处方 */
    __weak typeof(self) _self = self;
    cell.BeautyCFCellEndCFBlock = ^(NSMutableDictionary * _Nonnull param) {
        [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"您确定您要将此处方作废吗？此操作将不可恢复，请谨慎操作" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
            __strong typeof(_self) self = _self;
            if (index == 1) {
                /** 校验是否有未结算的情况 */
                [self requestEndCFParam:param];
            }
        }]show];
    };
    /** 处方报告 */
    cell.BeautyCFCellCFReportBlock = ^(NSMutableDictionary * _Nonnull param) {
        __strong typeof(_self) self = _self;
        /** 判断是否填写了处方执行报告 和 处方执行建议 */
        
        if ([param[@"presentation"] isEqual:[NSNull null]] || [param[@"proposal"] isEqual:[NSNull null]] || !param[@"presentation"] || !param[@"proposal"]) {
            /** 跳转填写处方报告界面 */
            BeautyCFReportWriteVC * next = [[BeautyCFReportWriteVC alloc] init];
            next.param = param;
            [self.navigationController pushViewController:next animated:NO];
        }else{
            /** 跳转处方报告*/
            BeautyCFReportVC * next = [[BeautyCFReportVC alloc] init];
            next.param = param;
            [self.navigationController pushViewController:next animated:NO];
        }
    };
    [cell updateCellParam:_dataSource[indexPath.row] index:_stateIndex];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    /** 跳转处方详情 */
    BeautyCFDetailVC * next = [[BeautyCFDetailVC alloc] init];
    __weak typeof(self) _self = self;
    next.beautyZCFBlock = ^{
        __strong typeof(_self) self = _self;
        [weakSelf.navigationController popToViewController:self animated:NO];
    };
    next.param = _dataSource[indexPath.row];
    [self.navigationController pushViewController:next animated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _stateIndex ==0 ? 110.0f : 130.0f;
}

#pragma mark ------网络请求------
/** 处方数据 */
- (void)requestCFData
{
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = infomodel.data.account;
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    NSString * zt = [NSString stringWithFormat:@"%ld",_stateIndex + 1];
    NSString * q = _q;
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    /** 页码 */
    [param setValue:page?page:@"" forKey:@"page"];
    /** 技师account */
    [param setValue:account?account:@"" forKey:@"account"];
    /** 1:进行中，2：已完成 */
    [param setValue:zt?zt:@"" forKey:@"zt"];
    /** 顾客姓名 */
    [param setValue:q?q:@"" forKey:@"q"];
    /** fram_id */
    [param setValue:framId?framId:@"" forKey:@"fram_id"];

    [BookRequest requestCommonUrl:kBEAUTY_ALLCF_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            if ([resultDic[@"list"] count] == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{}
    }];
}
/** 终止处方 */
- (void)requestEndCFParam:(NSMutableDictionary *)param;
{
    NSString * ordernum = param[@"ordernum"];
    NSString * storeCode = param[@"store_code"];
    [[BeautyRequest alloc] requestChuFangJieShuordernum:ordernum store_code:storeCode resultBlock:^(id obj, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            /** 跳转填写处方报告界面 */
            BeautyCFReportWriteVC * next = [[BeautyCFReportWriteVC alloc] init];
            next.param = param;
            next.from = 2;
            [self.navigationController pushViewController:next animated:NO];
        }else{
            [XMHProgressHUD showOnlyText:errorDic[@"error"]];
        }
    }];
}

@end
