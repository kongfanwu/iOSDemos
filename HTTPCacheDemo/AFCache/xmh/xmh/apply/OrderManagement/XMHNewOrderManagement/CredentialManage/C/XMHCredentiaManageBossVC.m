//
//  XMHCredentiaManageBossVC.m
//  xmh
//
//  Created by KFW on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaManageBossVC.h"
#import "XMHCredentiaManageSearchView.h"
#import "XMHCredentiaItemView.h"
#import "XMHCredentialManageRequest.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "NSDate-Helper.h"
#import "XMHCredentiaManageBossCell.h"
#import "XMHBaseTableView.h"
#import "XMHCredentiaManageVenditionVC.h"
#import "XMHCredentiaSalesYeJiVC.h"
#import "XMHCredentiaRefundVC.h"
#import "XMHCredentiaXiaoFeiDetailVC.h"
#import "SalePerformanceViewController.h"

@interface XMHCredentiaManageBossVC() <UITableViewDelegate, UITableViewDataSource>
/** <##> */
@property (nonatomic, strong) XMHCredentiaManageSearchView *searchView;
/** <##> */
@property (nonatomic, strong) XMHBaseTableView *tableView;
/** <##> */
@property (nonatomic, strong) XMHCredentiaItemView *credentiaItemView;
/** <##> */
@property (nonatomic) NSInteger page;
/** <##> */
@property (nonatomic, copy) NSString *searchText;
/** <##> */
@property (nonatomic, strong) NSMutableArray <XMHShopModel *>*dataArray;
@end

@implementation XMHCredentiaManageBossVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    
    [self.navView setNavViewTitle:@"订单管理" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    self.searchView = XMHCredentiaManageSearchView.new;
    _searchView.placeholder = @"请输入店铺名称";
    _searchView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:_searchView];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNaviBarHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(59);
    }];
    __weak typeof(self) _self = self;
    _searchView.searchBlock = ^(XMHCredentiaManageSearchView * _Nonnull searchView, NSString * _Nonnull text) {
        __strong typeof(_self) self = _self;
        self.searchText = text;
        [self getManagerList];
    };
    
    _searchView.clearSearchTextBlock = ^(XMHCredentiaManageSearchView * _Nonnull searchView) {
        __strong typeof(_self) self = _self;
        self.searchText = nil;
        [self getManagerList];
    };
    
    self.tableView = [[XMHBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.emptyEnable = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kColorF5F5F5;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    _tableView.tableFooterView = [UIView new];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(_self) self = _self;
        self.page = 1;
        [self getManagerList];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(_self) self = _self;
        self.page++;
        [self getManagerList];
    }];
    
    self.credentiaItemView = [[XMHCredentiaItemView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, XMHCredentiaItemView_MaxHeight)];
    self.tableView.tableHeaderView = _credentiaItemView;
    
    _credentiaItemView.didChangeHeightBlock = ^{
        __strong typeof(_self) self = _self;
        self.tableView.tableHeaderView = self.credentiaItemView;
    };
    
    _credentiaItemView.didSelectItemAtIndexPathBlock = ^(XMHCredentiaItemView * _Nonnull searchView, NSIndexPath * _Nonnull indexPath, XMHCredentiaItemModel * _Nonnull model) {
        __strong typeof(_self) self = _self;
        [self didSelectItem:model];
    };
    
    [self getData];
    [self getManagerList];
}

- (NSMutableArray *)dataArray {
    if (_dataArray) return _dataArray;
    _dataArray = NSMutableArray.new;
    return _dataArray;
}

- (void)getData {
    LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"fram_id"] = @([ShareWorkInstance shareInstance].share_join_code.fram_id);
    params[@"inId"] = userModel.data.account;
    params[@"startTime"] = [NSDate.new dateStringForYearMonthDay]; // 老板 传今天日期
    params[@"endTime"] = params[@"startTime"];
    [XMHCredentialManageRequest requestSalesServiceTongJiParams:params resultBlock:^(NSArray<XMHCredentiaItemModel *> * _Nonnull salesModelArray, NSArray<XMHCredentiaItemModel *> * _Nonnull serviceModelArray, BOOL isSuccess) {
        if (!isSuccess) return;
        _credentiaItemView.venditionDataArray = salesModelArray;
        _credentiaItemView.serviceDataArray = serviceModelArray;
    }];
}

- (void)getManagerList {
    LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
    
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"inId"] = userModel.data.account;
    params[@"fram_id"] = @([ShareWorkInstance shareInstance].share_join_code.fram_id);
    params[@"startTime"] = [NSDate.new dateStringForYearMonthDay];
    params[@"endTime"] = params[@"startTime"];
    params[@"q"] = _searchText;
    params[@"page"] = @(_page);
    [XMHCredentialManageRequest requestManagersListParams:params resultBlock:^(NSArray<XMHShopModel *> * _Nonnull modelArray, BOOL isSuccess) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        if (!isSuccess) return;
        if (modelArray.count) {
            _tableView.mj_footer.hidden = NO;
        } else {
            _tableView.mj_footer.hidden = YES;
        }
        if (_page == 1) {
            self.dataArray = [modelArray mutableCopy];
        } else {
            [self.dataArray addObjectsFromArray:modelArray];
        }
        [_tableView reloadData];
    }];
}

- (void)didSelectItem:(XMHCredentiaItemModel *)model {
    // 销售业绩
    if ([model.serviceKey isEqualToString:@"count_a"]) {
        XMHCredentiaSalesYeJiVC *vc = XMHCredentiaSalesYeJiVC.new;
        vc.startDate = [NSDate.new dateStringForYearMonthDay];
        vc.endDate = vc.startDate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    // 退款金额
    else if ([model.serviceKey isEqualToString:@"count_t"]) {
        XMHCredentiaRefundVC *vc = XMHCredentiaRefundVC.new;
        vc.startDate = [NSDate.new dateStringForYearMonthDay];
        vc.endDate = vc.startDate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    // 配合消费
    else if ([model.serviceKey isEqualToString:@"count_ph"]) {
        XMHCredentiaXiaoFeiDetailVC *vc = XMHCredentiaXiaoFeiDetailVC.new;
        vc.type = XMHCredentiaXiaoFeiDetailVCTypeXiaoFei;
        vc.startDate = [NSDate.new dateStringForYearMonthDay];
        vc.endDate = vc.startDate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    // 配合耗卡
    else if ([model.serviceKey isEqualToString:@"peihe"]) {
        XMHCredentiaXiaoFeiDetailVC *vc = XMHCredentiaXiaoFeiDetailVC.new;
        vc.type = XMHCredentiaXiaoFeiDetailVCTypeHaoKa;
        vc.startDate = [NSDate.new dateStringForYearMonthDay];
        vc.endDate = vc.startDate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    // 回款单数
    else if ([model.serviceKey isEqualToString:@"count_h"]) {
        SalePerformanceViewController * next = [[SalePerformanceViewController alloc] init];
        next.startTime = [NSDate.new dateStringForYearMonthDay];
        next.endTime = next.startTime;
        next.fromStr = @"回款";
        [self.navigationController pushViewController:next animated:YES];
    }
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHCredentiaManageBossCell *cell = [XMHCredentiaManageBossCell createCellWithTable:tableView];
    [cell configureWithModel:_dataArray[indexPath.section]];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
    headerView.backgroundColor = kColorF5F5F5;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHCredentiaManageVenditionVC *vc = XMHCredentiaManageVenditionVC.new;
    vc.shopModel = _dataArray[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
