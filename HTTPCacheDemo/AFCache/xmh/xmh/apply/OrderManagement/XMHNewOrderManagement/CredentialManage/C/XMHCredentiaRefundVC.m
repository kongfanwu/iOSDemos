//
//  XMHCredentiaRefundVC.m
//  xmh
//
//  Created by KFW on 2019/4/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaRefundVC.h"
#import "LDatePickView.h"
#import "UIView+FTCornerdious.h"
#import "XMHCredentiaManageSearchView.h"
#import "XMHCredentialManageRequest.h"
#import "XMHCredentiaSalesOrderMdoel.h"
#import "XMHBaseTableView.h"
#import "XMHCredentiaRefundModel.h"
#import "XMHCredentialSalesRefundCell.h"
#import "NSString+Costom.h"
#import "ApproveDetailModel.h"
#import "ApproveDetailController.h"

@interface XMHCredentiaRefundVC () <UITableViewDelegate, UITableViewDataSource>
/** <##> */
@property (nonatomic, strong) UIView *dateBgView, *numberBgView, *searchBgView;
@property (nonatomic, strong) LDatePickView *datePickView;
/** <##> */
@property (nonatomic, strong) NSArray <XMHCredentiaOrderStateItemModel *> *segmentList;
/** 销售服务单数 */
@property (nonatomic, strong) UILabel *salesNumberLabel, *salesNumberValueLabel;
/** 总金额 */
@property (nonatomic, strong) UILabel *allPriceLabel, *allPriceValueLabel;
@property (nonatomic, strong) XMHCredentiaManageSearchView *searchView;

@property (nonatomic, copy) NSString *searchText;
@property (nonatomic) NSInteger page;
/** 0销售付款 1分期回款营收 2销售服务营收 */
@property (nonatomic) NSInteger is_fq;
/** <##> */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** <##> */
@property (nonatomic, strong) XMHBaseTableView *tableView;
@end

@implementation XMHCredentiaRefundVC

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
    
    [self.navView setNavViewTitle:@"退款金额" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    [self createDateView];
    [self createNumberView];
    [self createSearchView];
    
    self.tableView = [[XMHBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.emptyEnable = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kBackgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = UIView.new;
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

- (void)createNumberView {
    self.numberBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _dateBgView.bottom + 10, self.view.width, 53)];
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
    _salesNumberLabel.text = @"退款单数（个）：";
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

- (void)getData {
    LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
    
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"fram_id"] = @([ShareWorkInstance shareInstance].share_join_code.fram_id);
    params[@"inId"] = userModel.data.account;
    params[@"start_time"] = _startDate;
    params[@"end_time"] = _endDate;
    params[@"page"] = @(_page);
    params[@"q"] = _searchText;
    
    [XMHCredentialManageRequest requestSalesTuiKuanLiatParams:params resultBlock:^(BaseModel *model, BOOL isSuccess) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        if (!isSuccess) return;
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[XMHCredentiaRefundModel class] json:model.data[@"list"]];
        _tableView.mj_footer.hidden = !modelArray.count;
        if (_page == 1) {
            self.dataArray = [modelArray mutableCopy];
        } else {
            [self.dataArray addObjectsFromArray:modelArray];
        }
        [_tableView reloadData];
        
        self.salesNumberValueLabel.text = [NSString stringWithFormat:@"%@", model.data[@"sales_num"]];
        self.allPriceValueLabel.text = [NSString formatFloat:[model.data[@"sales_amount"] floatValue]];
    }];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHCredentialSalesRefundCell *cell = [XMHCredentialSalesRefundCell createCellWithTable:tableView];
    [cell configureWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMHCredentiaRefundModel *model = _dataArray[indexPath.row];
    
    NSString *ordernum = model.code;
    
    LolUserInfoModel *info =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString   *token = info.data.token;
    NSString   *navTitle =@"退款详情";
    NSString   *url =[NSString stringWithFormat:@"%@approval/tuikuan.html",SERVER_H5];;
    NSString * accountId = [NSString stringWithFormat:@"%ld",info.data.ID];
    NSString * joincode = [ShareWorkInstance shareInstance].join_code;
    ApproveDetailModel * detailModel = [ApproveDetailModel initWithToken:token joinCode:joincode code:ordernum accountId:accountId url:url navTitle:navTitle from:@"" ordernum:ordernum fromList:NO];
    ApproveDetailController * next = [[ApproveDetailController alloc] init];
    next.detailModel = detailModel;
    [self.navigationController pushViewController:next animated:NO];
    
}

@end
