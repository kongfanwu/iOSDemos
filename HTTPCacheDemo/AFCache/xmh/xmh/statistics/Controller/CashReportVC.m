//
//  CashReportVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/11.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CashReportVC.h"
/** View */
#import "TJDataView.h"
#import "LDatePickView.h"
#import "TJDataTbSectionView.h"
#import "TJDateView.h"
#import "TJSelectView.h"
/** Cell */
#import "CustomerReportCell.h"

#import "TJRequest.h"
#import "ShareWorkInstance.h"
#import "RolesTools.h"
/** Model */
#import "TJParamModel.h"
#import "TJCashListModel.h"
#import "XMHRefreshGifHeader.h"
@interface CashReportVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UISegmentedControl * segmentControl;
@property (nonatomic, strong)TJDataView * tjDataView;
@property (nonatomic, strong)TJDateView * tjDateView;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)TJDataTbSectionView * dataTbSectionView;
@property (nonatomic, strong)TJBBListModel *tJBBListModel;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)TJSelectView * tJSelectView;
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

/** 数据选择数组 */
@property (nonatomic, strong) NSArray * selectDataArr;
/** 日期选择数组 */
@property (nonatomic, strong) NSArray * selectDateArr;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation CashReportVC
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
    _level = @"cj";
    
    _selectDataArr = @[[TJParamModel createParamModelName:@"稽核收款金额" type:@"1"],[TJParamModel createParamModelName:@"回款金额" type:@"2"],[TJParamModel createParamModelName:@"应收欠款" type:@"3"],[TJParamModel createParamModelName:@"线上收款" type:@"4"],[TJParamModel createParamModelName:@"线下收款" type:@"5"],[TJParamModel createParamModelName:@"退款金额" type:@"6"]];
    _selectDateArr = @[[TJParamModel createParamModelName:@"今日"],[TJParamModel createParamModelName:@"本周"],[TJParamModel createParamModelName:@"本月"],[TJParamModel createParamModelName:@"上月"],[TJParamModel createParamModelName:@"历史"]];
    
    [self initSubViews];
    [self requestTopData];
    [self requestListData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"收银报表" backBtnShow:YES];
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav + 45);
    self.logoView.image = UIImageName(@"stgkgl_ditu");
    [self.view addSubview:self.tjDateView];
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
        _segmentControl.frame = CGRectMake((SCREEN_WIDTH - 75 * 3)/2, _tjDateView.bottom + 25, 75 * 3, 25);
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
        _tjDateView.frame = CGRectMake(15, Heigh_Nav, SCREEN_WIDTH - 30 , 35);
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
        _tJSelectView.TJSelectViewDateBlock = ^(NSString *startTime, NSString *endTime, NSString *title) {
            weakSelf.startTime = startTime;
            weakSelf.endTime = endTime;
            [weakSelf requestListData];
            [weakSelf requestTopData];
            [weakSelf.tjDateView updateTJDateViewTitle:title];
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
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _segmentControl.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _segmentControl.bottom) style:UITableViewStylePlain];
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
    [self requestListData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kCashCell = @"kCashCell";
    CustomerReportCell * cashCell = [tableView dequeueReusableCellWithIdentifier:kCashCell];
    if (!cashCell) {
        cashCell =  loadNibName(@"CustomerReportCell");
    }
    [cashCell updateCustomerReportCellCashModel:_dataSource[indexPath.row]];
    return cashCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJCashModel * model = _dataSource[indexPath.row];
    CashReportVC * cashReportVC = [[CashReportVC alloc] init];
    cashReportVC.framId = model.fram_id;
    /** 员工层不能跳转 */
    if ([model.main_role isEqualToString:@"11"]||[model.main_role isEqualToString:@"8"]||[model.main_role isEqualToString:@"9"]||[model.main_role isEqualToString:@"10"]) {
        return;
    }
    [self.navigationController pushViewController:cashReportVC animated:NO];
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
    NSString * framId = _framId?_framId:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:_startTime?_startTime:@"" forKey:@"start_time"];
    [param setValue:_endTime?_endTime:@"" forKey:@"end_time"];

    [TJRequest requestTJCashTopeDataParam:param resultBlock:^(TJCashTopModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_tjDataView updateTJDataViewCashModel:model];
        }else{}
    }];
}
/** 列表数据 */
- (void)requestListData
{
    NSString * framId = _framId?_framId:[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:_startTime?_startTime:@"" forKey:@"start_time"];
    [param setValue:_endTime?_endTime:@"" forKey:@"end_time"];
    [param setValue:_level?_level:@"" forKey:@"level"];
    [param setValue:_type?_type:@"2" forKey:@"type"];
    [param setValue:_sort?_sort:@"" forKey:@"sort"];
    [param setValue:page?page:@"1" forKey:@"page"];
    
    [TJRequest requestTJCashListDataParam:param resultBlock:^(TJCashListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.next];
            /** 标识数据选择 */
            for (int i = 0; i < _dataSource.count; i++) {
                TJCashModel * model = _dataSource[i];
                model.type = _type;
            }
            if (model.next.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }
    }];
}

@end


