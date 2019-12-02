//
//  GKGLMainVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/7.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLMainVC.h"
#import "GKGLHomeTopView.h"
#import "JasonSearchView.h"
#import "TJDataTbSectionView.h"
#import "GKGLHomeCell.h"
#import "GKGLAddCustomerVC.h"
#import "GKGLDataStatisticsVC.h"
#import "GKGLCustomerDetailVC.h"
#import "MzzCustomerRequest.h"
#import "GKGLHomeCustomerListModel.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "ActionSheetStringPicker.h"
#import "RolesTools.h"
#import "XMHRefreshGifHeader.h"
@interface GKGLMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)GKGLHomeTopView * homeTopView;
@property (nonatomic, strong)JasonSearchView * searchView;
@property (nonatomic, strong)UIButton * searchBtn;
@property (nonatomic, strong)UIView * whiteView;
@property (nonatomic, strong)TJDataTbSectionView * dataSelectView;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)NSArray * titlesArr;
  /** 升序降序 */
@property (nonatomic, strong)NSString * sort;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation GKGLMainVC
{
    /** 加载更多 */
    BOOL _isMore;
    /** 页码 */
    NSInteger _page;
    /** 搜索条件 */
    
    /** 排序条件 */
    NSInteger _type;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 初始化数据 */
    _dataSource = [[NSMutableArray alloc] init];
    /** 默认非加载更多 */
    _isMore = NO;
    _page = 1;
    _titlesArr = @[@"消费排序",@"消耗排序",@"活跃度排序",@"到店频次排序"];
    self.view.backgroundColor = kColorE;
    [self initSubViews];
    [self requestCustomerData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"顾客管理" backBtnShow:YES];
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 108);
    self.logoView.backgroundColor = kColorTheme;
    self.logoView.image = nil;
    [self.view addSubview:self.whiteView];
     [self.view addSubview:self.homeTopView];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.searchBtn];
    [self.view addSubview:self.dataSelectView];
    [self.view addSubview:self.tbView];
     
}
- (GKGLHomeTopView *)homeTopView
{
    WeakSelf
    if (!_homeTopView) {
        _homeTopView = loadNibName(@"GKGLHomeTopView");
        _homeTopView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 85);
        _homeTopView.GKGLHomeTopViewAddBlock = ^{
            if ([RolesTools workPushToTJGKVC]) {
                GKGLAddCustomerVC * next = [[GKGLAddCustomerVC alloc] init];
                [weakSelf.navigationController pushViewController:next animated:NO];
            }else{
                //弹窗
                [XMHProgressHUD showOnlyText:@"您没有权限使用此模块,如有疑问请联系管理员"];
            }
        };
        _homeTopView.GKGLHomeTopViewDataBlock = ^{
            GKGLDataStatisticsVC * dataStatisticsVC = [[GKGLDataStatisticsVC alloc] init];
            [weakSelf.navigationController pushViewController:dataStatisticsVC animated:NO];
        };
    }
    return _homeTopView;
}
- (JasonSearchView *)searchView
{
    WeakSelf
    if (!_searchView) {
//        _searchView = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, _homeTopView.bottom + 15, 300, 40) withPlaceholder:@"搜索会员姓名或手机号"];
        _searchView = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, _homeTopView.bottom, 300, 40) withPlaceholder:@"搜索会员姓名或手机号"];
        _searchView.layer.cornerRadius = 3;
        _searchView.layer.masksToBounds = YES;
        _searchView.searchBar.frame = _searchView.bounds;
        _searchView.searchBar.btnleftBlock = ^{
            
        };
        _searchView.searchBar.btnRightBlock = ^{
            [weakSelf requestCustomerData];
        };
        _searchView.searchBar.backgroundColor = kColorF5F5F5;
        _searchView.line1.hidden = YES;
    }
    return _searchView;
}
- (UIButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(_searchView.right, _searchView.top, SCREEN_WIDTH - 15 - _searchView.width, 40);
        _searchBtn.titleLabel.font = FONT_SIZE(15);
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    }
    return _searchBtn;
}
- (UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.frame = CGRectMake(0, self.logoView.bottom, SCREEN_WIDTH, 110);
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
- (TJDataTbSectionView *)dataSelectView
{
    WeakSelf
    if (!_dataSelectView) {
        _dataSelectView = loadNibName(@"TJDataTbSectionView");
        _dataSelectView.frame = CGRectMake(0, _whiteView.bottom + 10, SCREEN_WIDTH, 45);
        [_dataSelectView updateTJDataTbSectionViewTItle:@"排序选择"];
        [_dataSelectView updateTJDataTbSectionViewLeftBtnTitle:@"升序" rightBtnTitle:@"降序"];
        _dataSelectView.TJDataTbSectionViewTapBlock = ^{
            [ActionSheetStringPicker showPickerWithTitle:nil rows:weakSelf.titlesArr initialSelection:0 target:weakSelf successAction:@selector(animalWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:weakSelf.dataSelectView];
        };
        _dataSelectView.TJDataTbSectionViewBlock = ^(NSInteger tag) {
            if (tag == 100) {
                weakSelf.sort = @"1";
            }else if (tag == 101){
                weakSelf.sort = @"2";
            }else{}
            [weakSelf refreshTbData];
        };
    }
    return _dataSelectView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _dataSelectView.bottom , SCREEN_WIDTH, SCREEN_HEIGHT - _dataSelectView.bottom ) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
//        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        __weak typeof(self) _self = self;
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestMoreData];
        }];
//        [_tbView.mj_header beginRefreshing];
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
- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestCustomerData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestCustomerData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element {
    _type = selectedIndex.integerValue + 1;
    [_dataSelectView updateTJDataTbSectionViewTItle:_titlesArr[selectedIndex.integerValue]];
    [self refreshTbData];
}
- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLHomeCell = @"kGKGLHomeCell";
    GKGLHomeCell * homeCell = [tableView dequeueReusableCellWithIdentifier:kGKGLHomeCell];
    if (!homeCell) {
        homeCell =  loadNibName(@"GKGLHomeCell");
    }
    [homeCell updateGKGLHomeCellModel:_dataSource[indexPath.row]];
    return homeCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GKGLCustomerDetailVC * customerDetailVC = [[GKGLCustomerDetailVC alloc] init];
    customerDetailVC.customerModel = _dataSource[indexPath.row];
    [self.navigationController pushViewController:customerDetailVC animated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}
#pragma mark ------网络请求------
/** 顾客列表数据 */
- (void)requestCustomerData
{
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    NSString * type = [NSString stringWithFormat:@"%ld",_type];
    NSString * q = _searchView.searchBar.text;
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:page?page:@"" forKey:@"page"];
    [param setValue:_sort?_sort:@"1" forKey:@"sort"];
    [param setValue:type?type:@"1" forKey:@"type"];
    [param setValue:q?q:@"" forKey:@"q"];
    [MzzCustomerRequest requestGKGLHomeCustomerListParams:param resultBlock:^(GKGLHomeCustomerListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.list];
            if (model.list.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }
    }];
}
@end
