//
//  BeautyCFBiaoVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFBiaoVC.h"
#import "BeautyCFBiaoCell.h"
#import "BeautyCFBiaoTbHeaderView.h"
#import "BookRequest.h"
#import "BeautyCFBiaoStoreVC.h"
#import "BeautyCFBiaoSelectView.h"
#import "BeautyCFBiaoCustomerVC.h"
#import "QFDatePickerView.h"
@interface BeautyCFBiaoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)BeautyCFBiaoTbHeaderView * headerView;
@property (nonatomic, strong)BeautyCFBiaoSelectView * topSelectView;
/** 选择的日期 */
@property (nonatomic, copy)NSString * selectDate;
/** 选择的门店 */
//@property (nonatomic, strong)NSMutableDictionary * storeParam;;
@end

@implementation BeautyCFBiaoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;
    _dataSource = [[NSMutableArray alloc] init];
    NSDate * date = [NSDate date];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM"];
    _selectDate = [myDateFormatter stringFromDate:date];
    [self initSubViews];
    [self requestAllData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"处方表" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.topSelectView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tbView];
    [_topSelectView updateBeautyCFBiaoSelectViewLeftTitle:_storeParam[@"name"]];
}
- (BeautyCFBiaoSelectView *)topSelectView
{
    WeakSelf
    if (!_topSelectView) {
        _topSelectView = loadNibName(@"BeautyCFBiaoSelectView");
        _topSelectView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 44);
        [_topSelectView updateBeautyCFBiaoSelectViewDate:_selectDate];
        _topSelectView.BeautyCFBiaoSelectViewStoreBlock = ^{
            BeautyCFBiaoStoreVC *next = [[BeautyCFBiaoStoreVC alloc] init];
            next.BeautyCFBiaoStoreVCBlock = ^(NSMutableDictionary * _Nonnull storeParam) {
                weakSelf.storeParam = storeParam;
                [weakSelf.topSelectView updateBeautyCFBiaoSelectViewLeftTitle:storeParam[@"store_name"]];
                [weakSelf requestAllData];
            };
            [weakSelf.navigationController pushViewController:next animated:NO];
        };
        _topSelectView.BeautyCFBiaoSelectViewDateBlock = ^{
            QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString * date) {
                weakSelf.selectDate = date;
                [weakSelf.topSelectView updateBeautyCFBiaoSelectViewDate:date];
                [weakSelf requestAllData];
            }];
            [datePickerView show];
        };
    }
    return _topSelectView;
}

- (BeautyCFBiaoTbHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = loadNibName(@"BeautyCFBiaoTbHeaderView");
        _headerView.frame = CGRectMake(0, _topSelectView.bottom + 1, SCREEN_WIDTH, 105);
    }
    return _headerView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headerView.bottom + 10, SCREEN_WIDTH, SCREEN_HEIGHT - _headerView.bottom - 10) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorF5F5F5;
    }
    return _tbView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kBeautyCFBiaoCell = @"kBeautyCFBiaoCell";
    BeautyCFBiaoCell * cell = [tableView dequeueReusableCellWithIdentifier:kBeautyCFBiaoCell];
    if (!cell) {
        cell = loadNibName(@"BeautyCFBiaoCell");
    }
    [cell updateCellParam:_dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 124.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeautyCFBiaoCustomerVC * next = [[BeautyCFBiaoCustomerVC alloc] init];
    next.param = _dataSource[indexPath.row];
    next.jisDataSoucre = _dataSource;
    next.selectDate = _selectDate;
    [self.navigationController pushViewController:next animated:NO];
}

#pragma mark -------网络请求----------
/** 整个页面网络请求 */
- (void)requestAllData
{
    [self requestCFBiaoTopData];
    [self requestListData];
}
/** 处方表 上方 详情数据 */
- (void)requestCFBiaoTopData
{
//    NSString * storeCode = @"MD00000A";
//    NSString * date = @"2018-11-11";
    
    NSString * storeCode = _storeParam[@"store_code"];
    NSString * date = _selectDate;
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:storeCode?storeCode:@"" forKey:@"store_code"];
    [param setValue:date?date:@"" forKey:@"date"];
    [BookRequest requestCommonUrl:kBEAUTY_CFBIAOTOP_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_headerView updateViewParam:[[NSMutableDictionary alloc]initWithDictionary:resultDic]];
        }else{};
    }];
}
/** 列表数据 */
- (void)requestListData
{
//    NSString * storeCode = @"MD00000A";
//    NSString * date = @"2018-11-11";
    NSString * storeCode = _storeParam[@"store_code"];
    NSString * date = _selectDate;
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:storeCode?storeCode:@"" forKey:@"store_code"];
    [param setValue:date?date:@"" forKey:@"date"];
    [BookRequest requestCommonUrl:kBEAUTY_CFBIAOJISLIST_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_dataSource removeAllObjects];
            if([[resultDic objectForKey:@"list"] isEqual:[NSNull null]]){
                return ;
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            [_tbView reloadData];
        }else{};
    }];
}
@end
