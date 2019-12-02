//
//  XMHCredentiaSalesYeJiVC.m
//  xmh
//
//  Created by KFW on 2019/4/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaSalesYeJiVC.h"
#import "LDatePickView.h"
#import "UIView+FTCornerdious.h"
#import "XMHCredentiaManageVenditionStateView.h"
#import "XMHCredentiaManageSearchView.h"
#import "XMHCredentialManageRequest.h"
#import "XMHCredentiaSalesOrderMdoel.h"
#import "XMHCredentialSalesTableView.h"
#import "NSString+Costom.h"
#import "XMHNewMzzJiSuanViewController.h"
@interface XMHCredentiaSalesYeJiVC ()<XMHCredentialSalesTableViewDelegate>
/** <##> */
@property (nonatomic, strong) UIView *dateBgView, *numberBgView, *searchBgView;
@property (nonatomic, strong) LDatePickView *datePickView;
/** <##> */
@property (nonatomic, strong) XMHCredentiaManageVenditionStateView *segmentView;
/** <##> */
@property (nonatomic, strong) NSArray <XMHCredentiaOrderStateItemModel *> *segmentList;
/** 销售服务单数 */
@property (nonatomic, strong) UILabel *salesNumberLabel, *salesNumberValueLabel;
/** 总金额 */
@property (nonatomic, strong) UILabel *allPriceLabel, *allPriceValueLabel;
@property (nonatomic, strong) XMHCredentiaManageSearchView *searchView;

@property (nonatomic, copy) NSString *searchText;
@property (nonatomic) NSInteger page;
///** 搜索的开始 结束时间 */
//@property (nonatomic, copy) NSString *startDate, *endDate;
/** 0销售付款 1分期回款营收 2销售服务营收 */
@property (nonatomic) NSInteger is_fq;
/** <##> */
@property (nonatomic, strong) XMHCredentialSalesTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation XMHCredentiaSalesYeJiVC

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
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.navView setNavViewTitle:@"销售业绩" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    [self createDateView];
    [self createSegmentView];
    [self createNumberView];
    [self createSearchView];
    
    self.tableView = [[XMHCredentialSalesTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.emptyEnable = YES;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;
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
    
    [self getData];
}

- (void)createDateView {
    self.dateBgView = [[UIView alloc] initWithFrame:CGRectMake(15, KNaviBarHeight + 10, self.view.width - 30, 44)];
    _dateBgView.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:_dateBgView];
    
    // 时间选择器
    __weak typeof(self) _self = self;
//    _datePickView = [[LDatePickView alloc] initWithFrame:_dateBgView.bounds dateBlock:^(NSString *start, NSString *end) {
//        __strong typeof(_self) self = _self;
//        self.startDate = start;
//        self.endDate = end;
//        [self getData];
//    }];
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
        self.is_fq = credentiaOrderStateItemModel.tag;
        
        /** 0销售付款 1分期回款营收 2销售服务营收 */
        if (_is_fq == 0) {
            self.salesNumberLabel.text = @"销售单数（个）：";
            self.page = 1;
        } else if (_is_fq == 1) {
            self.salesNumberLabel.text = @"分期单数（个）：";
            self.page = 1;
        }
        else if (_is_fq == 2) {
            self.salesNumberLabel.text = @"销售服务单数（个）：";
            self.page = 1;
        }
        
        [self getData];
    };
}

- (void)createNumberView {
    self.numberBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _segmentView.bottom, self.view.width, 53)];
    _numberBgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_numberBgView];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kColorE5E5E5;
    [_numberBgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kSeparatorHeight);
        make.left.right.top.mas_equalTo(0);
    }];
    
    self.salesNumberLabel = UILabel.new;
    _salesNumberLabel.font = FONT_SIZE(13);
    _salesNumberLabel.textColor = kColor6;
    _salesNumberLabel.text = @"销售单数（个）：";
    [_numberBgView addSubview:_salesNumberLabel];
    [_salesNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(45);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(18);
    }];
    
    self.salesNumberValueLabel = UILabel.new;
    _salesNumberValueLabel.font = FONT_SIZE(15);
    _salesNumberValueLabel.textColor = kColor6;
    _salesNumberValueLabel.text = @"0";
    _salesNumberValueLabel.textAlignment = NSTextAlignmentRight;
    [_numberBgView addSubview:_salesNumberValueLabel];
    [_salesNumberValueLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_salesNumberLabel);
        make.left.equalTo(_salesNumberLabel.mas_right);
        make.right.mas_equalTo(-45);
        make.height.equalTo(_salesNumberLabel);
    }];

    self.allPriceLabel = UILabel.new;
    _allPriceLabel.font = FONT_SIZE(13);
    _allPriceLabel.textColor = kColor6;
    _allPriceLabel.text = @"总金额（元）：";
    [_numberBgView addSubview:_allPriceLabel];
    [_allPriceLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(_salesNumberLabel);
        make.top.equalTo(_salesNumberLabel.mas_bottom).offset(5);
        make.height.equalTo(_salesNumberLabel);
    }];
    
    self.allPriceValueLabel = UILabel.new;
    _allPriceValueLabel.font = FONT_SIZE(15);
    _allPriceValueLabel.textColor = kColor6;
    _allPriceValueLabel.text = @"0";
    _allPriceValueLabel.textAlignment = NSTextAlignmentRight;
    [_numberBgView addSubview:_allPriceValueLabel];
    [_allPriceValueLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_allPriceLabel);
        make.left.equalTo(_allPriceLabel.mas_right);
        make.right.equalTo(_salesNumberValueLabel);
        make.height.equalTo(_salesNumberLabel);
    }];
}

- (void)createSearchView {
    self.searchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _numberBgView.bottom, self.view.width, 73)];
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
    // tag与接口字段一样 is_fq    是    int    0销售付款 1分期回款营收 2销售服务营收
    NSMutableArray *array = NSMutableArray.new;
    _segmentList = array;
    XMHCredentiaOrderStateItemModel *model;
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"销售营收";
    model.tag = 0;
    model.selcet = YES;
    [array addObject:model];
    self.is_fq = model.tag;
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"分期回款营收";
    model.tag = 1;
    [array addObject:model];
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"销售服务营收";
    model.tag = 2;
    [array addObject:model];
    return array;
}

- (void)getData {
    LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
    
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"fram_id"] = @([ShareWorkInstance shareInstance].share_join_code.fram_id);
    params[@"inId"] = userModel.data.account;
    params[@"startTime"] = _startDate;
    params[@"endTime"] = _endDate;
    params[@"page"] = @(_page);
    params[@"q"] = _searchText;
    params[@"is_fq"] = @(_is_fq);
    
    [XMHCredentialManageRequest requestSalesYeJiListParams:params resultBlock:^(BaseModel *model, BOOL isSuccess) {
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
        self.salesNumberValueLabel.text = [NSString stringWithFormat:@"%@", model.data[@"sales_num"]];
        self.allPriceValueLabel.text = [NSString formatFloat:[model.data[@"sales_amount"] floatValue]];

    }];
}
#pragma mark --XMHCredentialSalesTableViewDelegate
/**
点击cell

@param tableView XMHCredentiaManageVenditionTableView
@param model model
*/
- (void)tableView:(XMHCredentialSalesTableView *)tableView didSelectModel:(id)model
{
    XMHCredentiaSalesOrderMdoel *salesOrderMdoel = model;
    if (_is_fq == 2) {
        XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc]init];
        [vc setOrderNum:salesOrderMdoel.ordernum andZt:@"1"];
        [self.navigationController pushViewController:vc animated:NO];
    }else{
       
        
        XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc]init];
        [vc setOrderNum:salesOrderMdoel.ordernum andYemianStyle:YemianXiangQing andType:[salesOrderMdoel.type integerValue] andUid:[NSString stringWithFormat:@"%ld",(long)salesOrderMdoel.uid]withName:@""];
        [self.navigationController pushViewController:vc animated:NO];
    }
}
@end
