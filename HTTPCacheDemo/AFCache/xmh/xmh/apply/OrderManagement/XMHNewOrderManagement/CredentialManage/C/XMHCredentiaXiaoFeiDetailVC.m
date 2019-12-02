//
//  XMHCredentiaXiaoFeiDetailVC.m
//  xmh
//
//  Created by KFW on 2019/4/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaXiaoFeiDetailVC.h"
#import "LDatePickView.h"
#import "UIView+FTCornerdious.h"
#import "XMHCredentiaManageVenditionStateView.h"
#import "XMHCredentiaManageSearchView.h"
#import "XMHCredentialManageRequest.h"
#import "XMHCredentiaSalesOrderMdoel.h"
#import "XMHCredentialSalesTableView.h"
#import "XMHCredentialYejiShouHouView.h"
#import "NSString+Costom.h"
#import "XMHNewMzzJiSuanViewController.h"

@interface XMHCredentiaXiaoFeiDetailVC () <XMHCredentialSalesTableViewDelegate>
/** <##> */
@property (nonatomic, strong) UIView *dateBgView, *searchBgView;
@property (nonatomic, strong) LDatePickView *datePickView;
/** <##> */
@property (nonatomic, strong) XMHCredentiaManageVenditionStateView *segmentView;
/** <##> */
@property (nonatomic, strong) NSArray <XMHCredentiaOrderStateItemModel *> *segmentList;
@property (nonatomic, strong) XMHCredentiaManageSearchView *searchView;

@property (nonatomic, copy) NSString *searchText;
@property (nonatomic) NSInteger page;
/** 0本店，1店外 */
@property (nonatomic) NSInteger storeTag;
/** 1售前 2售中 3售后 */
@property (nonatomic) NSInteger yejiTag;
/** <##> */
@property (nonatomic, strong) XMHCredentialSalesTableView *tableView;
/** 全部  售前业绩  售中  售后 */
@property (nonatomic) CGFloat yeJiAll, yeJiShouQian, yeJiShouZhong, yeJiShouHou;
/** <##> */
@property (nonatomic, strong) XMHCredentialYejiShouHouView *yeJiShoHouView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation XMHCredentiaXiaoFeiDetailVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = XMHCredentiaXiaoFeiDetailVCTypeXiaoFei;
        self.page = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.navView setNavViewTitle:_type == XMHCredentiaXiaoFeiDetailVCTypeXiaoFei ? @"配合消费" : @"配合耗卡"  backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    [self createDateView];
    [self createSegmentView];
    [self createNumberView];
    [self createSearchView];
    
    self.tableView = [[XMHCredentialSalesTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.emptyEnable = YES;
    _tableView.adelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchBgView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(_self) self = _self;
        self.page = 1;
        [self getData];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(_self) self = _self;
        self.page++;
        [self getData];
    }];
    
//    XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc]init];
//    [vc setOrderNum:saleModel.ordernum andYemianStyle:YemianXiangQing andType:[saleModel.type integerValue] andUid:[NSString stringWithFormat:@"%ld",(long)saleModel.uid]withName:@""];
//    [weakSelf.navigationController pushViewController:vc animated:NO];
    
    [self getData];
}

- (void)createDateView {
    self.dateBgView = [[UIView alloc] initWithFrame:CGRectMake(15, KNaviBarHeight + 10, self.view.width - 30, 44)];
    _dateBgView.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:_dateBgView];
    
    // 时间选择器
    __weak typeof(self) _self = self;
    _datePickView = [[LDatePickView alloc]initWithFrame:_dateBgView.bounds startTime:self.startDate endTime:self.endDate dateBlock:^(NSString *start, NSString *end) {
        __strong typeof(_self) self = _self;
        self.startDate = start;
        self.endDate = end;
        [self getData];
    }];
    
    [_datePickView setRemoveBlock:^(LDatePickView *datePickView){
    }];
    
    [_dateBgView addSubview:self.datePickView];
    
    [UIView addShadowToView:_dateBgView withOpacity:0.3 shadowRadius:5 andCornerRadius:5];
}

- (void)createSegmentView {
    XMHCredentiaManageVenditionStateView *headerView = [[XMHCredentiaManageVenditionStateView alloc] initWithFrame:CGRectMake(0, _dateBgView.bottom + 10, self.view.width, 44)];
    self.segmentView = headerView;
    [self.view addSubview:_segmentView];
    headerView.stateArrray = self.segmentList;
    // 切换状态回调
    __weak typeof(self) _self = self;
    headerView.didSelectBlock = ^(XMHCredentiaManageVenditionStateView * _Nonnull view, XMHCredentiaOrderStateItemModel * _Nonnull credentiaOrderStateItemModel) {
        __strong typeof(_self) self = _self;
        self.storeTag = credentiaOrderStateItemModel.tag;
        [self getData];
    };
}

- (void)createNumberView {
    self.yeJiShoHouView = [[XMHCredentialYejiShouHouView alloc] initWithFrame:CGRectMake(0, _segmentView.bottom, self.view.width, 53)];
    [self.view addSubview:_yeJiShoHouView];
    [self getShouHouYeJiList];
    __weak typeof(self) _self = self;
    [_yeJiShoHouView setDidSelectBlock:^(XMHCredentialYejiShouHouView * _Nonnull view, XMHCredentiaOrderStateItemModel * _Nonnull credentiaOrderStateItemModel) {
        __strong typeof(_self) self = _self;
        self.yejiTag = credentiaOrderStateItemModel.tag;
        [self getData];
    }];
    
}

- (void)createSearchView {
    self.searchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _yeJiShoHouView.bottom, self.view.width, 73)];
    _searchBgView.backgroundColor = kBackgroundColor;
    [self.view addSubview:_searchBgView];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kColorF5F5F5;
    [_searchBgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.left.right.top.equalTo(_searchBgView);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = UIColor.whiteColor;
    [_searchBgView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    self.searchView = XMHCredentiaManageSearchView.new;
    _searchView.placeholder = @"输入顾客姓名或手机号";
    _searchView.backgroundColor = UIColor.whiteColor;
    [_searchView.searchBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    
    __weak typeof(self) _self = self;
    _searchView.searchBlock = ^(XMHCredentiaManageSearchView * _Nonnull searchView, NSString * _Nonnull text) {
        __strong typeof(_self) self = _self;
        self.searchText = text;
        [self getData];
    };
    
    _searchView.clearSearchTextBlock = ^(XMHCredentiaManageSearchView * _Nonnull searchView) {
        __strong typeof(_self) self = _self;
        self.searchText = nil;
        [self getData];
    };
    [contentView addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(59);
    }];
    
    UIView *lineView2 = UIView.new;
    lineView2.backgroundColor = kColorE5E5E5;
    [_searchBgView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kSeparatorHeight);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (NSArray <XMHCredentiaOrderStateItemModel *>*)segmentList {
    if (_segmentList) return _segmentList;
    // tag与接口字段一样 other    是    int    左右切换，0本店，1店外
    NSMutableArray *array = NSMutableArray.new;
    _segmentList = array;
    XMHCredentiaOrderStateItemModel *model;
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"本店配合";
    model.tag = 0;
    model.selcet = YES;
    [array addObject:model];
    self.storeTag = model.tag;
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"店外配合";
    model.tag = 1;
    [array addObject:model];
    return array;
}

- (void)getShouHouYeJiList {
    NSMutableArray *array = NSMutableArray.new;
    XMHCredentiaOrderStateItemModel *model;
    // tag与接口字段一样 yeji    是    int    0全部 1售前 2售中 3售后
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = [NSString stringWithFormat:@"全部 \n %@", [NSString formatFloat:_yeJiAll]];
    model.tag = 0;
    [array addObject:model];
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = [NSString stringWithFormat:@"售前业绩 \n %@", [NSString formatFloat:_yeJiShouQian]];
    model.tag = 1;
    [array addObject:model];
    
//    model = XMHCredentiaOrderStateItemModel.new;
//    model.title = [NSString stringWithFormat:@"售中业绩 \n %@", [NSString formatFloat:_yeJiShouZhong]];
//    model.tag = 2;
//    [array addObject:model];
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = [NSString stringWithFormat:@"售后业绩 \n %@", [NSString formatFloat:_yeJiShouHou]];
    model.tag = 3;
    [array addObject:model];
    
    // 上次选中过，标识上次选中的按钮为选中状态
    if (_yeJiShoHouView.selectMdoel) {
        for (XMHCredentiaOrderStateItemModel *aModel in array) {
            if (aModel.tag == _yeJiShoHouView.selectMdoel.tag) {
                aModel.selcet = YES;
                _yejiTag = aModel.tag;
            }
        }
    }
    // 上次未选中过，标识第一个按钮为选中状态
    else {
        XMHCredentiaOrderStateItemModel *aModel = array.firstObject;
        aModel.selcet = YES;
        _yejiTag = aModel.tag;
    }
    
    _yeJiShoHouView.dataArray = array;
}

- (void)getData {
    if (_type == XMHCredentiaXiaoFeiDetailVCTypeXiaoFei) {
        [self getSalesData];
    } else {
        [self getServiceData];
    }
}

/**
 获取配合消费
 */
- (void)getSalesData {
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"fram_id"] = @([ShareWorkInstance shareInstance].share_join_code.fram_id);
    params[@"start_time"] = _startDate;
    params[@"end_time"] = _endDate;
    params[@"page"] = @(_page);
    params[@"q"] = _searchText;
    params[@"other"] = @(_storeTag); // 左右切换，0本店，1店外
    params[@"yeji"] = @(_yejiTag);  // 0全部 1售前 2售中 3售后
    
    [XMHCredentialManageRequest requestSalesCooperateParams:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        if (!isSuccess) return;
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[XMHCredentiaSalesOrderMdoel class] json:model.data[@"list"]];
        _tableView.mj_footer.hidden = !modelArray.count;
        if (_page == 1) {
            self.dataArray = [modelArray mutableCopy];
        } else {
            [self.dataArray addObjectsFromArray:modelArray];
        }
        self.tableView.dataArray = self.dataArray;
        [_tableView reloadData];
        
        self.yeJiAll = [model.data[@"all"] floatValue];
        self.yeJiShouQian = [model.data[@"shouqian"] floatValue];
//        self.yeJiShouZhong = [model.data[@"shouzhong"] floatValue];
        self.yeJiShouHou = [model.data[@"shouhou"] floatValue];
        [self getShouHouYeJiList];
    }];
}

/**
 获取配合耗卡
 */
- (void)getServiceData {
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"fram_id"] = @([ShareWorkInstance shareInstance].share_join_code.fram_id);
    params[@"start_time"] = _startDate;
    params[@"end_time"] = _endDate;
    params[@"page"] = @(_page);
    params[@"q"] = _searchText;
    params[@"other"] = @(_storeTag); // 左右切换，0本店，1店外
    params[@"belong"] = @(_yejiTag);  // 0全部 1售前 2售中 3售后
    
    [XMHCredentialManageRequest requestServiceCooperateParams:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        if (!isSuccess) return;
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[XMHCredentiaServiceOrderMdoel class] json:model.data[@"list"]];
        _tableView.mj_footer.hidden = !modelArray.count;
        if (_page == 1) {
            self.dataArray = [modelArray mutableCopy];
        } else {
            [self.dataArray addObjectsFromArray:modelArray];
        }
        self.tableView.dataArray = self.dataArray;
        [_tableView reloadData];
        
        self.yeJiAll = [model.data[@"all"] floatValue];
        self.yeJiShouQian = [model.data[@"shouqian"] floatValue];
//        self.yeJiShouZhong = [model.data[@"shouzhong"] floatValue];
        self.yeJiShouHou = [model.data[@"shouhou"] floatValue];
        [self getShouHouYeJiList];
    }];
}

#pragma mark - XMHCredentialSalesTableViewDelegate

- (void)tableView:(XMHCredentialSalesTableView *)tableView didSelectModel:(id)model {
    
    if (_type == XMHCredentiaXiaoFeiDetailVCTypeXiaoFei) {
        XMHCredentiaSalesOrderMdoel *salesModel = model;
        XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc]init];
        [vc setOrderNum:salesModel.ordernum andYemianStyle:YemianXiangQing andType:[salesModel.type integerValue] andUid:[NSString stringWithFormat:@"%ld",(long)salesModel.uid]withName:@""];
        [self.navigationController pushViewController:vc animated:NO];
    } else {
        
    }
    
}

@end
