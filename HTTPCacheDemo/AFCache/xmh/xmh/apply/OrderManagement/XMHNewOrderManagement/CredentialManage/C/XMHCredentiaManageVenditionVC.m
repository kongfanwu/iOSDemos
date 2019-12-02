//
//  XMHCredentiaManageVenditionVC.m
//  xmh
//
//  Created by KFW on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaManageVenditionVC.h"
#import "XMHSelectDateView.h"
#import "LDatePickView.h"
#import "XMHCredentiaManageSearchView.h"
#import "XMHCredentiaManageVenditionTableView.h"
#import "XMHCredentiaItemView.h"
#import "XMHCredentialManageRequest.h"
#import "XMHCredentiaModel.h"
#import "XMHExperienceOrderRecordVC.h"
#import "XMHCredentiaSalesOrderMdoel.h"
#import "XMHCredentiaServiceOrderMdoel.h"
#import "XMHComputeOrderLastVC.h"
#import "XMHNewMzzJiSuanViewController.h"
#import "SLRequest.h"
#import "MzzCustomerDetailsController.h"
#import "RolesTools.h"
#import "XMHSalesOrderVC.h"
#import "XMHCustomerInfoView.h"
#import "XMHCredentiaXiaoFeiDetailVC.h"
#import "XMHCredentiaSalesYeJiVC.h"
#import "XMHCredentiaRefundVC.h"
#import "XMHBuYeJiVC.h"
#import "XMHOrderSaleBuYeJiVC.h"
#import "XMHSaleOrderRequest.h"
#import "XMHServiceRequest.h"
#import "GKGLCustomerDetailVC.h"
#import "XMHSharedAlertVC.h"
#import "SalePerformanceViewController.h"

@interface XMHCredentiaManageVenditionVC() <XMHCredentiaManageVenditionTableViewDelegate>
/** <##> */
@property (nonatomic, strong) UIView *topBgView;
/** <##> */
@property (nonatomic, strong) UIImageView *logoView;
/** <##> */
@property (nonatomic, strong) XMHSelectDateView *selectDateView;
/** <##> */
@property (nonatomic, strong) LDatePickView *datePickView;
@property (nonatomic, strong) XMHCredentiaManageSearchView *searchView;
/** <##> */
@property (nonatomic, copy) NSString *searchText;
/** <##> */
@property (nonatomic, strong) XMHCredentiaManageVenditionTableView *tableView;
@property (nonatomic) NSInteger page;
@property (nonatomic, strong) XMHCredentiaItemView *credentiaItemView;
/** 搜索的开始 结束时间 */
@property (nonatomic, copy) NSString *startDate, *endDate;
/** 凭证管理下状态数据源 */
@property (nonatomic, strong) XMHCredentiaModel *credentiaModel;
@property (nonatomic, strong) NSMutableArray *dataArray;
/** <#type#> */
@property (nonatomic, copy) void (^didChangeOrderTypeTableViewBlcok)();
/** 需求变更,首页展示全部数据 */
@property (nonatomic, assign) BOOL defalutStartTime;
@end

@implementation XMHCredentiaManageVenditionVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = 1;
    }
    return self;
}

- (void)viewDidLoad {
    
    if (self.shopModel) {
        self.fram_id = self.shopModel.fram_id;
    }
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 118 + KNaviBarHeight)];
    self.topBgView = topBgView;
    topBgView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:topBgView];
    
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    
    [self.navView setNavViewTitle:@"订单管理" backBtnShow:YES];
    
    _logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navView.bottom - 44, SCREEN_WIDTH, 138)];
    _logoView.image = UIImageName(@"toubudi");
    [self.view insertSubview:_logoView belowSubview:self.navView];
    
    // 时间选择器
    [self.view addSubview:self.datePickView];
    
    // top view
    [self createTopView];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topBgView.height);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    self.credentiaModel = XMHCredentiaModel.new;
    _credentiaModel.type = XMHCredentiaItemViewTypeVendition;
    _defalutStartTime = YES;
    _startDate = @"2018-05-01";
    [self getDataBlock:nil];
}

/**
 销售 服务 八统
 */
- (void)getTopData {
    LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"fram_id"] = self.fram_id;
    params[@"inId"] = userModel.data.account;
    params[@"startTime"] = _startDate;
    params[@"endTime"] = _endDate;
    [XMHCredentialManageRequest requestSalesServiceTongJiParams:params resultBlock:^(NSArray<XMHCredentiaItemModel *> * _Nonnull salesModelArray, NSArray<XMHCredentiaItemModel *> * _Nonnull serviceModelArray, BOOL isSuccess) {
        if (!isSuccess) return;
        _credentiaItemView.venditionDataArray = salesModelArray;
        _credentiaItemView.serviceDataArray = serviceModelArray;
        [self.tableView reloadData];
    }];
}

/**
 获取列表
 */
- (void)getDataBlock:(void(^)())block {
    if (_credentiaModel.type == XMHCredentiaItemViewTypeVendition) {
        [self getSaleDataBlock:block];
    } else {
        [self getServiceDataBlock:block];
    }
}

/**
 获取数量
 */
- (void)getNumData {
    if (_credentiaModel.type == XMHCredentiaItemViewTypeVendition) {
        [self getSaleNumData];
    } else {
        [self getServiceNUmData];
    }
}


/**
 获取销售列表
 */
- (void)getSaleDataBlock:(void(^)())block {
    LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
    
    NSMutableArray *bagesArr = [NSMutableArray array];
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *inId =  model.data.account;
    NSString    *token = model.data.token;
    
    Join_Code *join_Code =  [ShareWorkInstance shareInstance].share_join_code;
    NSString *join_code = join_Code.code;
    [params1 setValue:token forKey:@"token"];
    [params1 setValue:join_code forKey:@"join_code"];
    [params1 setValue:inId forKey:@"inId"];
    params1[@"fram_id"] = self.fram_id;
    params1[@"inId"] = userModel.data.account;
    params1[@"startTime"] = _startDate;
    params1[@"endTime"] = _endDate;
    
    [XMHSaleOrderRequest requestSalesListNumParams:params1 resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            NSString *ywcNum = [result safeObjectForKey:@"ywc"];
            NSString *whqNum = [result safeObjectForKey:@"whq"];
            NSString *yskNum = [result safeObjectForKey:@"ysk"];
            NSString *dfkNum = [result safeObjectForKey:@"dfk"];
            NSString *qbNum = [result safeObjectForKey:@"qb"];
            [bagesArr safeAddObject:qbNum];
            [bagesArr safeAddObject:dfkNum];
            [bagesArr safeAddObject:yskNum];
            [bagesArr safeAddObject:whqNum];
            [bagesArr safeAddObject:ywcNum];
            _credentiaModel.badgeArr  = bagesArr;
        }
        // 当前订单状态
        XMHCredentiaOrderStateItemModel *credentiaOrderStateItemModel = [_credentiaModel currentOrderModel];
        
        NSMutableDictionary *params = NSMutableDictionary.new;
        params[@"fram_id"] = self.fram_id;
        params[@"inId"] = userModel.data.account;
        params[@"startTime"] = _startDate;
        params[@"endTime"] = _endDate;
        params[@"order_type"] = @(credentiaOrderStateItemModel.tag);
        params[@"page"] = @(_page);
        params[@"q"] = _searchText;
        [XMHCredentialManageRequest requestSaleListParams:params resultBlock:^(NSArray<XMHCredentiaSalesOrderMdoel *> * _Nonnull modelArray, BOOL isSuccess) {
            if (self.didChangeOrderTypeTableViewBlcok) self.didChangeOrderTypeTableViewBlcok();
            
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            if (!isSuccess) return;
            _tableView.mj_footer.hidden = !modelArray.count;
            if (_page == 1) {
                self.dataArray = [modelArray mutableCopy];
            } else {
                [self.dataArray addObjectsFromArray:modelArray];
            }
            self.tableView.credentiaModel = _credentiaModel;
            self.tableView.dataArray = self.dataArray;
            [_tableView reloadData];
        }];
        
    }];
}

/**
 获取服务列表
 */
- (void)getServiceDataBlock:(void(^)())block {
    NSMutableArray *bagesArr = [NSMutableArray array];
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    NSString *inId =  model.data.account;

    Join_Code *join_Code =  [ShareWorkInstance shareInstance].share_join_code;
    NSString *join_code = join_Code.code;
    [params1 setValue:token forKey:@"token"];
    [params1 setValue:self.fram_id forKey:@"fram_id"];
    [params1 setValue:_startDate forKey:@"startTime"];
    [params1 setValue:_endDate forKey:@"endTime"];
    [params1 setValue:join_code forKey:@"join_code"];
    [params1 setValue:inId forKey:@"inId"];
    [params1 setValue:@([ShareWorkInstance shareInstance].share_join_code.fram_id) forKey:@"fram_id"];
    
    [XMHServiceRequest requestSeverListNumParams:params1 resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            NSString *ywcNum = [result safeObjectForKey:@"ywc"];
            NSString *yjsNum = [result safeObjectForKey:@"yjs"];
            NSString *djsNum = [result safeObjectForKey:@"djs"];
            NSString *qbNum = [result safeObjectForKey:@"qb"];
            [bagesArr safeAddObject:qbNum];
            [bagesArr safeAddObject:djsNum];
            [bagesArr safeAddObject:yjsNum];
            [bagesArr safeAddObject:ywcNum];
            _credentiaModel.badgeArr  = bagesArr;
        }
       
        LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
        XMHCredentiaOrderStateItemModel *credentiaOrderStateItemModel = [_credentiaModel currentOrderModel];
        
        NSMutableDictionary *params = NSMutableDictionary.new;
        params[@"fram_id"] = self.fram_id;
        params[@"inId"] = userModel.data.account;
        params[@"startTime"] = _startDate;
        params[@"endTime"] = _endDate;
        params[@"zt"] = @(credentiaOrderStateItemModel.tag);
        params[@"page"] = @(_page);
        params[@"q"] = _searchText;
        
        [XMHCredentialManageRequest requestServiceListParams:params resultBlock:^(NSArray<XMHCredentiaServiceOrderMdoel *> * _Nonnull modelArray, BOOL isSuccess) {
            if (self.didChangeOrderTypeTableViewBlcok) self.didChangeOrderTypeTableViewBlcok();
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            if (!isSuccess) return;
            _tableView.mj_footer.hidden = !modelArray.count;
            if (_page == 1) {
                self.dataArray = [modelArray mutableCopy];
            } else {
                [self.dataArray addObjectsFromArray:modelArray];
            }
            self.tableView.credentiaModel = _credentiaModel;
            self.tableView.dataArray = self.dataArray;
            [_tableView reloadData];
        }];
    }];
}

- (void)getSaleNumData
{
    NSMutableArray *bagesArr = [NSMutableArray array];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *inId =  model.data.account;
    NSString    *token = model.data.token;
    LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
    Join_Code *join_Code =  [ShareWorkInstance shareInstance].share_join_code;
    NSString *join_code = join_Code.code;
    [params setValue:token forKey:@"token"];
    [params setValue:join_code forKey:@"join_code"];
    [params setValue:inId forKey:@"inId"];
    params[@"fram_id"] = self.fram_id;
    params[@"inId"] = userModel.data.account;
    params[@"startTime"] = _startDate;
    params[@"endTime"] = _endDate;
    
    [XMHSaleOrderRequest requestSalesListNumParams:params resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            NSString *ywcNum = [result safeObjectForKey:@"ywc"];
            NSString *whqNum = [result safeObjectForKey:@"whq"];
            NSString *yskNum = [result safeObjectForKey:@"ysk"];
            NSString *dfkNum = [result safeObjectForKey:@"dfk"];
            NSString *qbNum = [result safeObjectForKey:@"qb"];
            [bagesArr safeAddObject:qbNum];
            [bagesArr safeAddObject:dfkNum];
            [bagesArr safeAddObject:yskNum];
            [bagesArr safeAddObject:whqNum];
            [bagesArr safeAddObject:ywcNum];
          
            [self.tableView reloadData];
        }
    }];
}

- (void)getServiceNUmData
{
    
}
- (void)createTopView {
    self.selectDateView = XMHSelectDateView.new;
    [self.view addSubview:_selectDateView];
    [_selectDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNaviBarHeight + 5);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(54);
    }];
    __weak typeof(self) _self = self;
    // 选择日期
    [_selectDateView setSelectDateBlock:^(XMHSelectDateView * _Nonnull selectDateView) {
        __strong typeof(_self) self = _self;
        self.datePickView.hidden = NO;
        [self.datePickView show];
        self.defalutStartTime = YES;
    }];
    // 近段时间回调
    [_selectDateView setDateBlock:^(XMHSelectDateView * _Nonnull selectDateView, NSString * _Nonnull startDate, NSString * _Nonnull endDate) {
        __strong typeof(_self) self = _self;
        self.startDate = startDate;
        self.endDate = endDate;
        [self getTopData];

        [self getDataBlock:nil];
    }];
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_selectDateView.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(59);
    }];
}

- (void)didSelectItem:(XMHCredentiaItemModel *)model {
    // 销售业绩
    if ([model.serviceKey isEqualToString:@"count_a"]) {
        XMHCredentiaSalesYeJiVC *vc = XMHCredentiaSalesYeJiVC.new;
        vc.startDate = self.startDate;
        vc.endDate = self.endDate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    // 退款金额
    else if ([model.serviceKey isEqualToString:@"count_t"]) {
        XMHCredentiaRefundVC *vc = XMHCredentiaRefundVC.new;
        vc.startDate = self.startDate;
        vc.endDate = self.endDate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    // 配合消费
    else if ([model.serviceKey isEqualToString:@"count_ph"]) {
        XMHCredentiaXiaoFeiDetailVC *vc = XMHCredentiaXiaoFeiDetailVC.new;
        vc.type = XMHCredentiaXiaoFeiDetailVCTypeXiaoFei;
        vc.startDate = self.startDate;
        vc.endDate = self.endDate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    // 配合耗卡
    else if ([model.serviceKey isEqualToString:@"peihe"]) {
        XMHCredentiaXiaoFeiDetailVC *vc = XMHCredentiaXiaoFeiDetailVC.new;
        vc.type = XMHCredentiaXiaoFeiDetailVCTypeHaoKa;
        vc.startDate = self.startDate;
        vc.endDate = self.endDate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    // 回款单数
    else if ([model.serviceKey isEqualToString:@"count_h"]) {
        SalePerformanceViewController * next = [[SalePerformanceViewController alloc] init];
        next.startTime = self.startDate;
        next.endTime = self.endDate;
        next.fromStr = @"回款";
        [self.navigationController pushViewController:next animated:YES];
    }
    
}

- (LDatePickView *)datePickView {
    if (_datePickView) return _datePickView;
    __weak typeof(self) _self = self;
    _datePickView = [[LDatePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) dateBlock:^(NSString *start, NSString *end) {
        __strong typeof(_self) self = _self;
        if (self.defalutStartTime) {
            self.startDate = start;
        }else{
            self.startDate = @"2018-05-01";
        }
        self.endDate = end;
        [self getTopData];
        [self getDataBlock:nil];
        
        // 选择时间后，将时间段的按钮选中状态取消掉
        self.selectDateView.selectButton.selected = NO;
    }];
    
    [_datePickView setRemoveBlock:^(LDatePickView *datePickView){
        datePickView.hidden = YES;
    }];
    
    _datePickView.hidden = YES;
    return _datePickView;
}

- (XMHCredentiaManageSearchView *)searchView {
    if (_searchView) return _searchView;
    
    _searchView = XMHCredentiaManageSearchView.new;
    _searchView.placeholder = @"输入顾客姓名或手机号";
    _searchView.backgroundColor = kBtn_Commen_Color;
    
    __weak typeof(self) _self = self;
    _searchView.searchBlock = ^(XMHCredentiaManageSearchView * _Nonnull searchView, NSString * _Nonnull text) {
        __strong typeof(_self) self = _self;
        self.searchText = text;
        [self getDataBlock:nil];
    };
    
    _searchView.clearSearchTextBlock = ^(XMHCredentiaManageSearchView * _Nonnull searchView) {
        __strong typeof(_self) self = _self;
        self.searchText = nil;
        [self getDataBlock:nil];
    };
    return _searchView;
}

- (XMHCredentiaManageVenditionTableView *)tableView {
    if (_tableView) return _tableView;
    
    self.tableView = [[XMHCredentiaManageVenditionTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = kColorF5F5F5;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    _tableView.adelegate = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;
    _tableView.emptyEnable = YES;
    
    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(_self) self = _self;
        self.page = 1;
        [self getDataBlock:nil];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(_self) self = _self;
        self.page++;
        [self getDataBlock:nil];
    }];
    
    //  tableHeaderView
    self.credentiaItemView = [[XMHCredentiaItemView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, XMHCredentiaItemView_MaxHeight)];
    _credentiaItemView.type = _credentiaModel.type;
    _tableView.tableHeaderView = _credentiaItemView;
    
    _credentiaItemView.didChangeHeightBlock = ^{
        __strong typeof(_self) self = _self;
        self.tableView.tableHeaderView = self.credentiaItemView;
    };
    
    _credentiaItemView.didSelectItemAtIndexPathBlock = ^(XMHCredentiaItemView * _Nonnull searchView, NSIndexPath * _Nonnull indexPath, XMHCredentiaItemModel * _Nonnull model) {
        __strong typeof(_self) self = _self;
        [self didSelectItem:model];
    };
    // 销售 服务凭证切换回调
    _credentiaItemView.didChangeCredentiaTypeBlock = ^(XMHCredentiaItemView * _Nonnull searchView) {
        __strong typeof(_self) self = _self;
        self.credentiaModel.type = searchView.type;
        
        self.page = 1;
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
        [self getDataBlock:nil];
    };
    
    return _tableView;
}

/**
 撤销
 */
- (void)repealType:(NSInteger)type ID:(NSString *)ID {
    NSString *typeName = type == 0 ? @"服务单" : @"销售服务单";
    [[[MzzHud alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"确定要撤销已开好的%@吗？撤销后将不可恢复！",typeName] leftButtonTitle:@"取消" rightButtonTitle:@"确定撤销" click:^(NSInteger index) {
        if (index ==1) {
            NSMutableDictionary * params = [NSMutableDictionary dictionary];
            params[@"id"] = ID;
            [SLRequest requestServDelParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (model.code == 1) {
                    [MzzHud toastWithTitle:@"提示" message:@"撤销成功" complete:^{
                        [self getDataBlock:nil];
                    }];
                }else{
                    [MzzHud toastWithTitle:@"提示" message:@"撤销失败"];
                }
            }];
        }
    }]show];
}

/**
 补齐项目
 */
- (void)buYeJiOrderSaleModel:(XMHCredentiaSalesOrderMdoel *)orderModel {
    if ([RolesTools orderReverseFlowPush]) {
        XMHSalesOrderVC *vc = [[XMHSalesOrderVC alloc]init];
        //已选顾客
        CustomerModel *customer = [[CustomerModel alloc]init];
        customer.mobile = orderModel.inper;
        customer.uid = [orderModel.user_id integerValue];
        customer.uname = orderModel.user_name;
        vc.selectModel = customer;
        //商家编码
        vc.storeCode = orderModel.store_code;
        //应付金额、订单编码
        vc.yingfuPrice = orderModel.heji;
        vc.ordernum = orderModel.ordernum;
        [self.navigationController pushViewController:vc animated:NO];
    }else{
        //弹窗
        [XMHProgressHUD showOnlyText:@"您没有制单权限，请进行其他操作"];
    }
}

#pragma mark - XMHCredentiaManageVenditionTableViewDelegate

/**
 订单状态切换回调
 */
- (void)didChangeOrderTypeTableView:(XMHCredentiaManageVenditionTableView *)tableview {
    self.page = 1;
    [self.tableView reloadData];
    
    // 目的：订单状态切换后，请求数据成功后，移除上个状态的数据。解决在切换请求数据时候显示默认图问题
    __weak typeof(self) _self = self;
    self.didChangeOrderTypeTableViewBlcok = ^{
        __strong typeof(_self) self = _self;
        [self.dataArray removeAllObjects];
        self.didChangeOrderTypeTableViewBlcok = nil;
    };
    
    [self getDataBlock:nil];
}

/**
 点击工具按钮回调
 
 @param type 类型
 @param model cell model
 */
- (void)didSelectToolActionTableView:(XMHCredentiaManageVenditionTableView *)tableview type:(XMHCredentiaItemViewType)type model:(id)model toolItemModel:(XMHCredentiaOrderStateItemModel *)toolItemModel {
    // 销售凭证
    if (type == XMHCredentiaItemViewTypeVendition) {
        XMHCredentiaSalesOrderMdoel *salesModel = (XMHCredentiaSalesOrderMdoel *)model;
        switch (toolItemModel.tag) {
            // 支付
            case XMHOrderFunctionTypePay: {
                XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc] init];
                [vc setOrderNum:salesModel.ordernum andYemianStyle:YemianJieSuan andType:[salesModel.type integerValue] andUid:salesModel.user_id withName:@"结算"];
                vc.entrance = 1;
                [self.navigationController pushViewController:vc animated:NO];
                break;
            }
            // 查看账单
            case XMHOrderFunctionTypeLookZhangDan: {
                
                GKGLCustomerDetailVC * customerDetailVC = [[GKGLCustomerDetailVC alloc] init];
                customerDetailVC.userID = salesModel.user_id;
               [self.navigationController pushViewController:customerDetailVC animated:YES];
                
                
//                MzzCustomerDetailsController *detailVc = [UIStoryboard storyboardWithName:@"MzzCustomerDetails" bundle:nil].instantiateInitialViewController;
//                detailVc.user_id = salesModel.user_id;
//                detailVc.store_code = salesModel.store_code;
//                [self.navigationController pushViewController:detailVc animated:YES];
                break;
            }
            // 撤销
            case XMHOrderFunctionTypeCheXiao: {
                [self repealType:[salesModel.type integerValue] ID:salesModel.ID];
                break;
            }
            // 补齐项目
            case XMHOrderFunctionTypeBuQiXiangMu: {
                [self buYeJiOrderSaleModel:salesModel];
                break;
            }
            // 补齐业绩
            case XMHOrderFunctionTypeBuQiYeJi: {
//                XMHComputeOrderLastVC *vc = XMHComputeOrderLastVC.new;
//                vc.customTitle = [salesModel newTypeName];
//                vc.ordernum = salesModel.ordernum;
//                [self.navigationController pushViewController:vc animated:NO];
                
//                XMHBuYeJiVC *vc = XMHBuYeJiVC.new;
//                vc.type = XMHBuYeJiVCTypeSalesOrder;
//                vc.ordernum = salesModel.ordernum;
//                [self.navigationController pushViewController:vc animated:YES];
                
                XMHOrderSaleBuYeJiVC *vc= [[XMHOrderSaleBuYeJiVC alloc]init];
                vc.ordernum = salesModel.ordernum;
                
                CustomerModel *customer = [[CustomerModel alloc]init];
                customer.mobile = salesModel.user_mobile;
                customer.uid = [salesModel.user_id integerValue];
                customer.uname = salesModel.user_name;
                vc.customer = customer;
                
                [self.navigationController pushViewController:vc animated:NO];
                break;
            }
            // 终止
            case XMHOrderFunctionTypeZhongZhi: {
                XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc] init];
                [vc setOrderNum:salesModel.ordernum andYemianStyle:YemianZhongZhi andType:[salesModel.type integerValue] andUid:salesModel.user_id withName:@"终止"];
                [self.navigationController pushViewController:vc animated:NO];
                break;
            }
            // 还款
            case XMHOrderFunctionTypeHuanKuan: {
                XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc] init];
                [vc setOrderNum:salesModel.ordernum andYemianStyle:YemianHuanKuan andType:[salesModel.type integerValue] andUid:salesModel.user_id withName:@"还款"];
                [self.navigationController pushViewController:vc animated:NO];
                break;
            }
            // 服务记录
            case XMHOrderFunctionTypeFuWuJiLu: {
                XMHExperienceOrderRecordVC * next = [[XMHExperienceOrderRecordVC alloc] init];
                next.ordernum = salesModel.ordernum;
                [self.navigationController pushViewController:next animated:YES];
                break;
            }
            // 分享
            case XMHOrderFunctionTypeShare:{
                XMHSharedAlertVC *shareVC = XMHSharedAlertVC.new;
                shareVC.shareUrl = salesModel.share_url;
                [self presentViewController:shareVC animated:YES completion:nil];
                [shareVC setShareResultBlock:^(BOOL cuccess) {
                    [[[MzzHud alloc]initWithTitle:@"" message:cuccess ? @"分享成功" : @"分享失败" centerButtonTitle:@"确认" click:^(NSInteger index) {
                    }]show];
                }];
                break;
            }
            default:
                break;
        }
    }
    // 服务凭证
    else if (type == XMHCredentiaItemViewTypeService) {
        XMHCredentiaServiceOrderMdoel *serviceModel = (XMHCredentiaServiceOrderMdoel *)model;
        switch (toolItemModel.tag) {
                // 查看账单
            case XMHOrderFunctionTypeLookZhangDan: {
                GKGLCustomerDetailVC * customerDetailVC = [[GKGLCustomerDetailVC alloc] init];
                customerDetailVC.userID = serviceModel.user_id;
                [self.navigationController pushViewController:customerDetailVC animated:YES];
//                MzzCustomerDetailsController *detailVc = [UIStoryboard storyboardWithName:@"MzzCustomerDetails" bundle:nil].instantiateInitialViewController;
//                detailVc.user_id = serviceModel.user_id;
//                detailVc.store_code = serviceModel.store_code;
//                [self.navigationController pushViewController:detailVc animated:YES];
                break;
            }
                // 撤销
            case XMHOrderFunctionTypeCheXiao: {
                [self repealType:[serviceModel.type integerValue] ID:serviceModel.ID];
                break;
            }
                // 补齐业绩
            case XMHOrderFunctionTypeBuQiYeJi: {
//                XMHComputeOrderLastVC *vc = XMHComputeOrderLastVC.new;
//                vc.customTitle = [serviceModel.type isEqualToString:@"0"] ? @"服务单" : @"销售服务单";
//                vc.ordernum = serviceModel.ordernum;
//                [self.navigationController pushViewController:vc animated:NO];
                XMHBuYeJiVC *vc = XMHBuYeJiVC.new;
                vc.ordernum = serviceModel.ordernum;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                // 结算
            case XMHOrderFunctionTypeJieSuan: {
                XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc] init];
                [vc setOrderNum:serviceModel.ordernum andZt:@"2"];
                vc.entrance = 1;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                // 服务记录
            case XMHOrderFunctionTypeFuWuJiLu: {
                XMHExperienceOrderRecordVC * next = [[XMHExperienceOrderRecordVC alloc] init];
                next.ordernum = serviceModel.ordernum;
                [self.navigationController pushViewController:next animated:YES];
                break;
            }
            default:
                break;
        }
    }
}

- (void)tableView:(XMHCredentiaManageVenditionTableView *)tableView didSelectModel:(id)model
{
    if ([model isKindOfClass:[XMHCredentiaSalesOrderMdoel class]]) {
        XMHCredentiaSalesOrderMdoel *saleModel = (XMHCredentiaSalesOrderMdoel *)model;
        
        XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc]init];
        [vc setOrderNum:saleModel.ordernum andYemianStyle:YemianXiangQing andType:[saleModel.type intValue] andUid:[NSString stringWithFormat:@"%ld",saleModel.uid] withName:@""];
        [self.navigationController pushViewController:vc animated:NO];
    } else if ([model isKindOfClass:[XMHCredentiaServiceOrderMdoel class]]) {

        XMHCredentiaServiceOrderMdoel *severModel = (XMHCredentiaServiceOrderMdoel *)model;
        XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc]init];
        [vc setOrderNum:severModel.ordernum andZt:@"1"];
        [self.navigationController pushViewController:vc animated:NO];
    }
    
}
@end
