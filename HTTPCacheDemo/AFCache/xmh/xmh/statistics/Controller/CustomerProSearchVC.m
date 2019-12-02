//
//  CustomerProSearchVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerProSearchVC.h"
#import "CustomerReportCell.h"
#import "TJRequest.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "UIScrollView+EmptyDataSet.h"
@interface CustomerProSearchVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, strong)JasonSearchView * searchView;
@property (nonatomic, strong)UIButton * searchBtn;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@end

@implementation CustomerProSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorE;
    _dataSource = [[NSMutableArray alloc] init];
    [self.navView setNavViewTitle:@"" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.searchBtn];
    [self.view addSubview:self.tbView];
}
- (JasonSearchView *)searchView
{
    WeakSelf
    if (!_searchView) {
        _searchView = [[JasonSearchView alloc] initWithFrame:CGRectMake(40, 27, 270, 30) withPlaceholder:@"请输入顾客姓名或者手机号进行搜索"];
        _searchView.layer.cornerRadius = 3;
        _searchView.layer.masksToBounds = YES;
        _searchView.searchBar.frame = _searchView.bounds;
        _searchView.searchBar.btnleftBlock = ^{
            [weakSelf requestListData];
        };
        _searchView.searchBar.btnRightBlock = ^{
            [weakSelf requestListData];
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
        _searchBtn.frame = CGRectMake(_searchView.right, _searchView.top, SCREEN_WIDTH - 40 - _searchView.width, 30);
        _searchBtn.titleLabel.font = FONT_SIZE(15);
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _searchBtn;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav + 10 , SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 10 ) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        _tbView.emptyDataSetDelegate = self;
        _tbView.emptyDataSetSource = self;
    }
    return _tbView;
}
#pragma mark ------UITableView------
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kCustomerReportCell = @"kCustomerReportCell";
    CustomerReportCell * customerReportCell = [tableView dequeueReusableCellWithIdentifier:kCustomerReportCell];
    if (!customerReportCell) {
        customerReportCell = loadNibName(@"CustomerReportCell");
    }
    [customerReportCell updateCustomerReportCellProParam:_dataSource[indexPath.row]];
    return customerReportCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165.0f;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"xmhdefault_zanwutishi"];
}
#pragma mark ------网络请求------
/** 列表数据 */
- (void)requestListData
{
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * key = _searchView.searchBar.text;
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:_startTime?_startTime:@"" forKey:@"start_time"];
    [param setValue:_endTime?_endTime:@"" forKey:@"end_time"];
    [param setValue:key?key:@"" forKey:@"search_key"];
    [TJRequest requestTJDataCommonUrl:kTJ_PRO_LIST_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_dataSource removeAllObjects];
            if (resultDic[@"list"] == nil || [param[@"list"] isEqual:[NSNull null]]) {
                return ;
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            NSArray * arr = resultDic[@"list"];
            if (arr.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }
    }];
}
@end
