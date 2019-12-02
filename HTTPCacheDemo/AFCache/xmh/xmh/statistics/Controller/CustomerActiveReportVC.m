//
//  CustomerActiveReportVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/10.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerActiveReportVC.h"
#import "TJSelectView.h"
#import "TJDataView.h"
#import "TJDateView.h"
#import "TJDataTbSectionView.h"

#import "TJParamModel.h"
#import "TJStoreListModel.h"
#import "TJCustomerActiveListModel.h"

#import "CustomerReportCell.h"

#import "ShareWorkInstance.h"
#import "TJRequest.h"

#import "CustomerActiveDetailVC.h"
#import "XMHRefreshGifHeader.h"
#define kCustomerActiveReportVCMargin 45
@interface CustomerActiveReportVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)TJDataView * tjDataView;
@property (nonatomic, strong)TJDateView * tjDateView;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)TJDataTbSectionView * dataTbSectionView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)TJSelectView * tJSelectView;
@property (nonatomic, strong)TJDateView * storeView;
/** 排序 最高 最低 */
@property (nonatomic, copy) NSString * sort;
/** 数据选择 */
@property (nonatomic, copy) NSString * type;
/** 层级 */
@property (nonatomic, copy) NSString * level;
/** 开始时间 */
@property (nonatomic, copy) NSString * startTime;
/** 结束时间 */
@property (nonatomic, copy) NSString * endTime;

/** 时间类型 */
@property (nonatomic, copy) NSString * time_type;
/** 数据选择数组 */
@property (nonatomic, strong) NSArray * selectDataArr;
/** 日期选择数组 */
@property (nonatomic, strong) NSArray * selectDateArr;
/** 门店数组 */
@property (nonatomic, strong) NSMutableArray * selectStoreArr;
@property (nonatomic, copy) NSString * storeCode;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation CustomerActiveReportVC
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
    _type = @"1";
    _storeCode = @"all";
    _selectStoreArr = [[NSMutableArray alloc] init];
    _selectDataArr = @[[TJParamModel createParamModelName:@"消费金额" type:@"1"],[TJParamModel createParamModelName:@"消耗金额" type:@"2"],[TJParamModel createParamModelName:@"耗卡单价" type:@"3"],[TJParamModel createParamModelName:@"消耗项目数" type:@"4"],[TJParamModel createParamModelName:@"消费次数" type:@"5"],[TJParamModel createParamModelName:@"到店次数" type:@"6"]];
    _selectDateArr = @[[TJParamModel createParamModelName:@"今日"],[TJParamModel createParamModelName:@"本周"],[TJParamModel createParamModelName:@"本月"],[TJParamModel createParamModelName:@"上月"],[TJParamModel createParamModelName:@"历史"]];
    [self initSubViews];
    
    [self requestStoreData];
    [self requestTopData];
    [self requestListData];
    
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"顾客活跃报表" backBtnShow:YES];
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav + 45);
    self.logoView.image = UIImageName(@"stgkgl_ditu");
    [self.view addSubview:self.tjDateView];
    [self.view addSubview:self.storeView];
    [self.view addSubview:self.tbView];
    self.tJSelectView.hidden = NO;
}
- (TJDataView *)tjDataView
{
    WeakSelf
    if (!_tjDataView) {
        _tjDataView = loadNibName(@"TJDataView");
        _tjDataView.backgroundColor = kColorF5F5F5;
        _tjDataView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 30, 130 + 50);
        _tjDataView.TJDataViewMoreBlock = ^(BOOL isMore) {
            if (isMore) {
                weakSelf.tjDataView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 30, 350 + 50);
                weakSelf.tbView.tableHeaderView = weakSelf.tjDataView;
            }else{
                weakSelf.tjDataView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 30, 130 + 50);
                weakSelf.tbView.tableHeaderView = weakSelf.tjDataView;
            }
        };
    }
    return _tjDataView;
}
- (TJDateView *)tjDateView
{
    WeakSelf
    if (!_tjDateView) {
        _tjDateView = loadNibName(@"TJDateView");
        _tjDateView.frame = CGRectMake(15, Heigh_Nav, (SCREEN_WIDTH - kCustomerActiveReportVCMargin)*17/33 , 35);
        _tjDateView.TJDateViewTapBlock = ^{
            [weakSelf tapDateView];
        };
    }
    return _tjDateView;
}
- (void)tapDateView
{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    [self.tJSelectView updateTJSelectViewModelArr:_selectDateArr type:@"日期"];
    [keyWindow addSubview:self.tJSelectView];
    [_tJSelectView updateTJSelectViewSectionTitle:@"请选择日期"];
}
- (void)tapStoreView
{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    [self.tJSelectView updateTJSelectViewModelArr:_selectStoreArr type:@"门店"];
    [keyWindow addSubview:self.tJSelectView];
    [_tJSelectView updateTJSelectViewSectionTitle:@"请选择"];
}

- (TJDateView *)storeView
{
    WeakSelf
    if (!_storeView) {
        _storeView = loadNibName(@"TJDateView");
        [_storeView updateTJDateViewTitle:@"全部门店"];
        _storeView.frame = CGRectMake(_tjDateView.right + 15, Heigh_Nav, (SCREEN_WIDTH - kCustomerActiveReportVCMargin)*16/33 , 35);
        _storeView.TJDateViewTapBlock = ^{
            [weakSelf tapStoreView];
        };
        
    }
    return _storeView;
}
- (TJSelectView *)tJSelectView
{
    WeakSelf
    if (!_tJSelectView) {
        _tJSelectView = [[TJSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) timeBlock:^(NSString *startTime, NSString *endTime, NSString *title) {
            weakSelf.startTime = startTime;
            weakSelf.endTime = endTime;
            [weakSelf.tjDateView updateTJDateViewTitle:title];
        }];
        /** 数据选择 */
        _tJSelectView.TJSelectViewDataBlock = ^(TJParamModel *model) {
            weakSelf.type = model.type;
            [weakSelf.dataTbSectionView updateTJDataTbSectionViewTItle:model.name];
            [weakSelf refreshTbData];
        };
        /** 日期选择 */
//        _tJSelectView.TJSelectViewDateBlock = ^(NSString *startTime, NSString *endTime, NSString *title) {
//            weakSelf.startTime = startTime;
//            weakSelf.endTime = endTime;
//            [weakSelf requestListData];
//            [weakSelf requestTopData];
//            [weakSelf.tjDateView updateTJDateViewTitle:title];
//        };
        _tJSelectView.TJSelectViewDateCustomerActiveBlock = ^(NSString *startTime, NSString *endTime, NSString *title, NSString *time_type) {
            weakSelf.startTime = startTime;
            weakSelf.endTime = endTime;
            weakSelf.time_type = time_type;
            [weakSelf requestListData];
            [weakSelf requestTopData];
            [weakSelf.tjDateView updateTJDateViewTitle:title];
        };
        /** 门店选择 */
        _tJSelectView.TJSelectViewStoreBlock = ^(TJParamModel *model) {
            weakSelf.storeCode = model.storeCode;
            [weakSelf.storeView updateTJDateViewTitle:model.name];
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
    [keyWindow addSubview:self.tJSelectView];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _tjDateView.bottom + 10, SCREEN_WIDTH, SCREEN_HEIGHT - _tjDateView.bottom - 10) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableHeaderView = self.tjDataView;
        _tbView.backgroundColor = kColorE;
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
    [self requestTopData];
    [self requestListData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kCustomerReportCell = @"kCustomerReportCell";
    CustomerReportCell * customerReportCell = [tableView dequeueReusableCellWithIdentifier:kCustomerReportCell];
    if (!customerReportCell) {
        customerReportCell = loadNibName(@"CustomerReportCell");
    }
    [customerReportCell updateCustomerReportCellCustomerActiveModel:_dataSource[indexPath.row]];
    return customerReportCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerActiveDetailVC * customerActiveDetailVC = [[CustomerActiveDetailVC alloc] init];
    customerActiveDetailVC.customerActiveModel = _dataSource[indexPath.row];
    customerActiveDetailVC.startTime = _startTime;
    customerActiveDetailVC.endTime = _endTime;
    [self.navigationController pushViewController:customerActiveDetailVC animated:NO];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}
#pragma mark ------网络请求------
/** 八筒数据 */
- (void)requestTopData
{
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:_startTime?_startTime:@"" forKey:@"start_time"];
    [param setValue:_endTime?_endTime:@"" forKey:@"end_time"];
    [param setValue:_storeCode?_storeCode:@"" forKey:@"store_code"];
     [param setValue:_time_type?_time_type:@"0" forKey:@"time_type"];
    [TJRequest requestTJCustomerActiveTopeDataParam:param resultBlock:^(TJCustomerActiveTopModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_tjDataView updateTJDataViewCustomerActiveModel:model];
        }else{}
    }];

}
/** 列表数据 */
- (void)requestListData
{
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:_startTime?_startTime:@"" forKey:@"start_time"];
    [param setValue:_endTime?_endTime:@"" forKey:@"end_time"];
    [param setValue:_type?_type:@"1" forKey:@"type"];
    [param setValue:_sort?_sort:@"" forKey:@"sort"];
    [param setValue:page?page:@"1" forKey:@"page"];
    [param setValue:_storeCode?_storeCode:@"all" forKey:@"store_code"];
    
    [TJRequest requestTJCustomerActiveListDataParam:param resultBlock:^(TJCustomerActiveListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            [self endRefreshing];
            if (isSuccess) {
                if (!_isMore) {
                    [_dataSource removeAllObjects];
                }
                [_dataSource addObjectsFromArray:model.list];
                /** 标识数据选择 */
                for (int i = 0; i < _dataSource.count; i++) {
                    TJCustomerActiveModel * model = _dataSource[i];
                    model.type = _type;
                }
                if (model.list.count == 0) {
                    [_tbView.mj_footer endRefreshingWithNoMoreData];
                }
                [_tbView reloadData];
            }
    }];
}
/** 门店数据 */
- (void)requestStoreData
{
    [_selectStoreArr removeAllObjects];
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    TJParamModel * firstModel =  [TJParamModel createParamModelName:@"全部门店" storeCode:@"all"];
    [_selectStoreArr addObject:firstModel];
    [TJRequest requestTJCustomerStoreDataParam:param resultBlock:^(TJStoreListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        for (int i = 0; i < model.list.count; i++) {
            TJStoreModel * storeModel = model.list[i];
            TJParamModel * paramModel = [TJParamModel createParamModelName:storeModel.name storeCode:storeModel.code];
            [_selectStoreArr addObject:paramModel];
        }
    }];
}
@end
