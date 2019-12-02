//
//  BeautyBillDetailVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyBillDetailVC.h"
#import "CustomerDetailTbHeader.h"
#import "BeautyBillDetailCollectDataView.h"
#import "BeautyBillDetaiCell.h"
#import "BeautyCustomersVC.h"
#import "BookRequest.h"
#import "XMHRefreshGifHeader.h"
@interface BeautyBillDetailVC ()<UITableViewDelegate,UITableViewDataSource>
/** 顾客信息View */
@property (nonatomic, strong)CustomerDetailTbHeader * detailView;
/** 总负债数据View */
@property (nonatomic, strong)BeautyBillDetailCollectDataView * collectDataView;
@property (nonatomic, strong)UIView * tbHeader;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)BOOL isMore;
@property (nonatomic, assign)NSInteger page;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation BeautyBillDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    _isMore = NO;
    _page = 1;
    [self initSubViews];
    [_detailView updateCustomerDetailTbHeaderParam:_userParam];
}

- (void)initSubViews
{
    WeakSelf
    [self.navView setNavViewTitle:@"顾客账单明细" backBtnShow:YES rightBtnTitle:@"定制处方"];
    self.navView.NavViewRightBlock = ^{
        BeautyCustomersVC * next = [[BeautyCustomersVC alloc] init];
        [weakSelf.navigationController pushViewController:next animated:NO];
    };
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.tbView];
}
- (CustomerDetailTbHeader *)detailView
{
    if (!_detailView) {
        _detailView = loadNibName(@"CustomerDetailTbHeader");
        _detailView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 110);
    }
    return _detailView;
}
- (BeautyBillDetailCollectDataView *)collectDataView
{
    if (!_collectDataView) {
        _collectDataView = loadNibName(@"BeautyBillDetailCollectDataView");
        _collectDataView.frame = CGRectMake(0, _detailView.bottom , SCREEN_WIDTH, 110);
    }
    return _collectDataView;
}
- (UIView *)tbHeader
{
    if (!_tbHeader) {
        _tbHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
        _tbHeader.backgroundColor = kColorF5F5F5;
        [_tbHeader addSubview:self.detailView];
        [_tbHeader addSubview:self.collectDataView];
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
        _tbView.backgroundColor = kColorF5F5F5;
        _tbView.tableHeaderView = self.tbHeader;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
//        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            [self requestMoreData];
//        }];
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
- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestCustomerBillDetaiData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestCustomerBillDetaiData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kBeautyBillDetaiCell = @"kBeautyBillDetaiCell";
    BeautyBillDetaiCell * cell = [tableView dequeueReusableCellWithIdentifier:kBeautyBillDetaiCell];
    if (!cell) {
        cell = loadNibName(@"BeautyBillDetaiCell");
    }
    [cell updateCellParam:_dataSource[indexPath.row]];
//    [cell updatecellModel:_dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -------网络请求----------
/** 获取顾客账单明细数据 */
- (void)requestCustomerBillDetaiData
{
    NSString * userID = _userID?_userID:@"18134";
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:userID?userID:@"" forKey:@"user_id"];
    [BookRequest requestCommonUrl:kBEAUTY_BILLDETAIL_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            if ([resultDic[@"list"] count] == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_collectDataView updateViewParam:(NSMutableDictionary *)resultDic];
            [_tbView reloadData];
        }else{};
    }];
}
@end
