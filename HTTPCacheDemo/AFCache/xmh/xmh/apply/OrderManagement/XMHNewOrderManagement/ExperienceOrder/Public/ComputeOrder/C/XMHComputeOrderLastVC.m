//
//  XMHComputeOrderLastVC.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHComputeOrderLastVC.h"
#import "XMHComputeOredrTableView.h"
#import "XMHComputeOredrModel.h"
#import "XMHComputeOrderAchievementModel.h"
#import "FWDYeJGuiShuModel.h"
#import "FWDSelectView.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "MzzCustomerRequest.h"
#import "SLRequest.h"
#import "XMHExperienceOrderRequest.h"
#import "FWDAleartVIew.h"
#import "FWDDetailViewController.h"
#import "SLOrderNumModel.h"
#import "XMHExperienceOrderRecordVC.h"

@interface XMHComputeOrderLastVC() <XMHComputeOredrTableViewDelegate>
/** <##> */
@property (nonatomic, strong) XMHComputeOredrTableView *tableView;
/** <##> */
@property (nonatomic, strong) NSArray *yejiguishuArr;
/** <##> */
@property (nonatomic, strong) FWDSelectView *selectView;
/** <##> */
@property (nonatomic, strong) XMHComputeOredrModel *computeOredrModel;
/** <##> */
@property (nonatomic, strong) XMHComputeOrderAchievementModel *computeOrderAchievementModel;
/** <##> */
@property (nonatomic, copy) NSString *joinCode;
/** <##> */
@property (nonatomic, strong) MzzStoreList *storeListModel;
/** 店长集合 */
@property (nonatomic, strong) NSArray <SLManagerModel *>*dianZhangList;
/** <##> */
@property (nonatomic, strong) UIView *bottomBgView;
@property (nonatomic, strong) FWDAleartVIew * alertView;
/** 选择用户model */
@property (nonatomic, strong) CustomerModel *selectUserModel;
/** 订单详情 */
@property (nonatomic, strong) NSDictionary *orderDic;

@end

@implementation XMHComputeOrderLastVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.createOrderType = XMHCreateOrderTypeExperience;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;
    
    if (self.createOrderType == XMHCreateOrderTypeExperience) {
        [self.navView setNavViewTitle:@"体验制单" backBtnShow:YES];
    } else if (self.createOrderType == XMHCreateOrderTypeService) {
        [self.navView setNavViewTitle:@"服务制单" backBtnShow:YES];
    }
    
    if (!IsEmpty(_customTitle)) {
        [self.navView setNavViewTitle:_customTitle backBtnShow:YES];
    }
    
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNaviBarHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
    self.bottomBgView = UIView.new;
    _bottomBgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_bottomBgView];
    [_bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(69);
    }];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundImage:[UIImage imageWithColor:kBtn_Commen_Color size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交结算" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = FONT_SIZE(17);
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    [_bottomBgView addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(44);
        make.centerY.equalTo(_bottomBgView);
    }];
    
    self.tableView = [[XMHComputeOredrTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.aDelegate = self;
    _tableView.isYeJi = YES;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNaviBarHeight);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.equalTo(submitBtn.mas_top).offset(-10);
    }];
    self.tableView.remarkTextViewUserInteractionEnabled = NO;
    
    [self createSelectView];
    
    [self getData];
}

- (void)createSelectView
{
    FWDSelectView * select = [[FWDSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    __weak typeof(self) _self = self;
    select.FWDSelectViewBlock = ^(LSelectBaseModel *model) {
        __strong typeof(_self) self = _self;
        // 业绩
        if ([model isKindOfClass:[FWDYeJGuiShuModel class]]) {
            self.computeOrderAchievementModel.yeJGuiShuModel = (FWDYeJGuiShuModel *)model;
            [self.tableView reloadData];
        }
        // 店长
        if ([model isKindOfClass:[SLManagerModel class]]) {
            self.computeOrderAchievementModel.dianZhangModel = (SLManagerModel *)model;
            [self.tableView reloadData];
        }
    };
    self.selectView = select;
    select.hidden = YES;
    [self.view addSubview:select];
}

- (FWDAleartVIew *)alertView
{
    if (!_alertView) {
        _alertView = loadNibName(@"FWDAleartVIew");
        _alertView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    }
    return _alertView;
}

/**
 获取技师集合
 */
- (NSMutableArray *)jishiModelArrayBaseModel:(BaseModel *)model {
    NSMutableArray *jishiArray = NSMutableArray.new;
    NSArray *proList = model.data[@"pro_list"];
    for (NSDictionary *projectDic in proList) {
        NSArray *jisList = projectDic[@"jis_list"];
        [jishiArray addObjectsFromArray:jisList];
    }
    
    NSMutableArray *newJishiArray = NSMutableArray.new;
    for (NSString *account in jishiArray) {
        if (![newJishiArray containsObject:account]) {
            [newJishiArray addObject:account];
        }
    }
    
    NSMutableArray *jishiModelArray = NSMutableArray.new;
    for (NSString *account in newJishiArray) {
        MLJiShiModel *jiShiModel = MLJiShiModel.new;
        jiShiModel.name = account;
        [jishiModelArray addObject:jiShiModel];
    }
    return jishiModelArray;
}

#pragma mark - GetData

- (void)getData {
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"ordernum"] = _ordernum;
    [XMHExperienceOrderRequest requestServInfoParam:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        self.orderDic = model.data;
        // 顾客信息
        self.selectUserModel = CustomerModel.new;
        self.selectUserModel.uid = (NSInteger)model.data[@"user_id"];
        self.selectUserModel.mobile = model.data[@"mobile"];
        self.selectUserModel.uname = model.data[@"user_name"];
        // 技师集合
        NSMutableArray *jishiList = [self jishiModelArrayBaseModel:model];
        // 后置填写model
        XMHComputeOrderAchievementModel *computeOrderAchievementModel = XMHComputeOrderAchievementModel.new;
        self.computeOrderAchievementModel = computeOrderAchievementModel;
        computeOrderAchievementModel.jiShiList = jishiList;
        
        _tableView.dataArray = @[computeOrderAchievementModel];
        _tableView.selectUserModel = _selectUserModel;
        [_tableView reloadData];
        
        _tableView.remarkText =  self.orderDic[@"k_content"];
        
        [self requestGuiShuData];
    }];
}

- (void)requestGuiShuData
{
    WeakSelf;
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
    _joinCode = join_code;
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    if (join_code) {
        [parms setValue:join_code forKey:@"join_code"];
    }
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    if (token) {
        [parms setValue:token forKey:@"token"];
    }
    NSString * framId = [NSString stringWithFormat:@"%ld",model.data.join_code[0].fram_id];
    [parms setValue:framId?framId:@"" forKey:@"fram_id"];
    //门店
    [parms setValue:_joinCode?_joinCode:@"" forKey:@"join_code"];
    [MzzCustomerRequest requestStoreListParams:parms resultBlock:^(MzzStoreList *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            self.storeListModel = listModel;
            self.computeOrderAchievementModel.menDianModel = listModel.list.firstObject;
            [self.tableView reloadData];
            [weakSelf requestDianZhangData];
        }
    }];
}

- (void)requestDianZhangData
{
    //店长
    NSMutableDictionary *DZparms = [[NSMutableDictionary alloc]init];
    [DZparms setValue:_joinCode?_joinCode:@"" forKey:@"join_code"];
    MzzStoreModel * model = _storeListModel.list[0];
    [DZparms setValue:model.store_code forKey:@"store_code"];
    [SLRequest  requesSearchManagerParams:DZparms resultBlock:^(SLSearchManagerModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            self.dianZhangList = model.list;
        }
    }];
}

- (NSArray *)yejiguishuArr {
    if (_yejiguishuArr) return _yejiguishuArr;
    FWDYeJGuiShuModel * model = [[FWDYeJGuiShuModel alloc]init];
    model.showName = @"售前业绩";
    model.belong = @"1";
//    FWDYeJGuiShuModel * model1 = [[FWDYeJGuiShuModel alloc]init];
//    model1.showName = @"售中业绩";
//    model1.belong = @"2";
    FWDYeJGuiShuModel * model2 = [[FWDYeJGuiShuModel alloc]init];
    model2.showName = @"售后业绩";
    model2.belong = @"3";
    _yejiguishuArr = @[model,model2];
    return _yejiguishuArr;
}

#pragma mark - Event

- (void)submitBtnClick:(UIButton *)sender {
    // 选择业绩归属，校验以下信息
    if (!_computeOrderAchievementModel.yeJGuiShuModel) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择业绩归属"];
        return;
    }
    if (!_computeOrderAchievementModel.dianZhangModel) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择店长归属"];
        return;
    }
    
    if (![_computeOrderAchievementModel checkInputGuiShu]) {
        [MzzHud toastWithTitle:@"提示" message:@"请分配员工归属"];
        return;
    }

    NSString *payPriceStr = _orderDic[@"pay_price"];
    if (!IsEmpty(payPriceStr)) {
        NSInteger payPrice = [payPriceStr integerValue];
        if (![_computeOrderAchievementModel checkJiShiPriceAllPrice:payPrice]) {
            [MzzHud toastWithTitle:@"提示" message:[NSString stringWithFormat:@"员工归属总计与销售服务总计(%ld元)不符，请重新分配", payPrice]];
            return;
        }
    }
    
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"token"] = model.data.token;
    params[@"ordernum"] = _ordernum; // 服务单单号
    if (_computeOrderAchievementModel.yeJGuiShuModel) {
        params[@"belong"] = @([_computeOrderAchievementModel.yeJGuiShuModel.belong integerValue]); // 业绩归属（1售前 2售中 3售后）
        params[@"dianzhang"] = _computeOrderAchievementModel.dianZhangModel.phone; // 店长归属
        params[@"xiaohao"] = _computeOrderAchievementModel.xiaohao ? @(1) : @(0); // 是否算耗卡：0否，1是
        params[@"guishu"] = [_computeOrderAchievementModel guiShuArray]; // 员工归属
        params[@"changjia"] = _computeOrderAchievementModel.changJiaYeji ? @(1) : @(0); // changjia（厂家业绩：0不算，1算）
    }
    MzzLog(@"%@", [params yy_modelToJSONString]);
    NSMutableDictionary *newParams = [@{@"data" : params.jsonData} mutableCopy];
    [XMHExperienceOrderRequest requestRepairParam:newParams resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (!isSuccess) return;
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - XMHComputeOredrTableViewDelegate

/**
 归属回调
 @param tag 1 业绩 2 门店 3 店长
 */
- (void)guiShutableView:(XMHComputeOredrTableView *)tableView tag:(NSInteger)tag {
    if (tag == 1) {
        _selectView.hidden = NO;
        _selectView.listModel = self.yejiguishuArr;
    } else if (tag == 3) {
        _selectView.hidden = NO;
        _selectView.listModel = _dianZhangList;
    }
}
@end
