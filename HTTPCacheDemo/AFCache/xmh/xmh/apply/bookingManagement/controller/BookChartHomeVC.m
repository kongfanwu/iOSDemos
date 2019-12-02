//
//  BookChartVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookChartHomeVC.h"
#import "JasonSearchView.h"
#import "BookCommonCell2.h"
#import "BookChartTbHeader.h"
#import "BookChartCell.h"
#import "BookRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "BookChartVC.h"
#import "XMHRefreshGifHeader.h"
@interface BookChartHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)BookChartTbHeader * tbHeader;
@property (nonatomic, assign)BOOL isMore;
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic, copy)NSString * searchStore;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation BookChartHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;
    _currentPage = 1;
    _isMore = YES;
    _dataSource = [[NSMutableArray alloc] init];
    [self initSubViews];
}

//- (void)loadView
//{
//    [super loadView];
//    if (_storeParam) {
//        BookChartVC * nextVC = [[BookChartVC alloc] init];
//        nextVC.storeParam = _storeParam;
//        [self.navigationController pushViewController:nextVC animated:NO];
//    }
//}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"预约表" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.tbView];
}
- (BookChartTbHeader *)tbHeader
{
    WeakSelf
    if (!_tbHeader) {
        _tbHeader = loadNibName(@"BookChartTbHeader");
        _tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 85);
        _tbHeader.BookChartTbHeaderSearchBlock = ^(NSString * _Nonnull searchKey) {
            weakSelf.searchStore = searchKey;
            [weakSelf requestStoreData];
        };
    }
    return _tbHeader;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableHeaderView = self.tbHeader;
        _tbView.backgroundColor = kColorF5F5F5;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestMoreData];
        }];
        [_tbView.mj_header beginRefreshing];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self refreshTbData];
            });
        }];
    }
    return _gifHeader;
}
#pragma mark ------UITableViewDelegate------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kBookCommonCell2 = @"kBookCommonCell2";
    BookChartCell * cell = [tableView dequeueReusableCellWithIdentifier:kBookCommonCell2];
    if (!cell) {
        cell = loadNibName(@"BookChartCell");
    }
    [cell updateCellParam:_dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookChartVC * nextVC = [[BookChartVC alloc] init];
    nextVC.storeParam = _dataSource[indexPath.row];
    [self.navigationController pushViewController:nextVC animated:NO];
}
#pragma mark ------Action------
- (void)searchTap:(UITapGestureRecognizer *)tap
{
   
}
- (void)requestMoreData
{
    _isMore = YES;
    _currentPage ++;
    [self requestStoreData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _currentPage = 1;
    [self requestStoreData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------网络请求------
/** 获取门店数据 */
- (void)requestStoreData
{
    NSString * framID = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * store = _searchStore;
    NSString * page = [NSString stringWithFormat:@"%ld",_currentPage];
//    NSString * size = @"";
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framID?framID:@"" forKey:@"fram_id"];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:store?store:@"" forKey:@"store"];
    [param setValue:page?page:@"" forKey:@"page"];
//    [param setValue:size?size:@"" forKey:@"size"];
    [BookRequest requestCommonUrl:kBOOK_CHART_STORES_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            if ([resultDic[@"list"] count]==  0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{}
    }];
}
@end
