//
//  XMHBuYeJiVC.m
//  xmh
//
//  Created by KFW on 2019/4/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBuYeJiVC.h"
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
#import "XMHNormalOrderManagementVC.h"
#import "XMHServiceOrderListVC.h"
#import "XMHShoppingCartManager.h"
#import "XMHExperienceOrderVC.h"
#import "XMHServiceOrderVC.h"
#import "XMHServiceGoodsModel.h"

@interface XMHBuYeJiVC() <XMHComputeOredrTableViewDelegate>
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
@property (nonatomic, strong)FWDAleartVIew * alertView;
/** 选择用户model */
@property (nonatomic, strong) CustomerModel *selectUserModel;
/** 订单详情 */
@property (nonatomic, strong) NSDictionary *orderDic;
@end

@implementation XMHBuYeJiVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = XMHBuYeJiVCTypeServiceOrderAndSalesServiceOrder;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;
    
    [self.navView setNavViewTitle:@"服务制单" backBtnShow:YES];
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
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(69);
    }];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundImage:[UIImage imageWithColor:kBtn_Commen_Color size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [submitBtn setTitle:@"确认信息" forState:UIControlStateNormal];
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
    _tableView.isBuYeJi = YES;
    _tableView.remarkTextViewUserInteractionEnabled = NO;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNaviBarHeight);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.equalTo(submitBtn.mas_top).offset(-10);
    }];
    
    [self createSelectView];
    
    [self getData];
}

- (void)createSelectView
{
    FWDSelectView * select = [[FWDSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    select.FWDSelectViewBlock = ^(LSelectBaseModel *model) {
        // 业绩
        if ([model isKindOfClass:[FWDYeJGuiShuModel class]]) {
            self.computeOrderAchievementModel.yeJGuiShuModel = (FWDYeJGuiShuModel *)model;
            [_tableView reloadData];
        }
        // 店长
        if ([model isKindOfClass:[SLManagerModel class]]) {
            self.computeOrderAchievementModel.dianZhangModel = (SLManagerModel *)model;
            [_tableView reloadData];
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

#pragma mark - GetData

- (void)getData {
    if (_type == XMHBuYeJiVCTypeServiceOrderAndSalesServiceOrder) {
        [self getServiceData];
    } else {
        [self getSalesData];
    }
}

/**
 // 服务单 体验制单（销售服务单）
 */
- (void)getServiceData {
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"ordernum"] = _ordernum;
    [XMHExperienceOrderRequest requestServInfoParam:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (!isSuccess) return;
        self.orderDic = model.data;
        // 顾客信息
        self.selectUserModel = CustomerModel.new;
        self.selectUserModel.uid = (NSInteger)model.data[@"user_id"];
        self.selectUserModel.mobile = model.data[@"mobile"];
        self.selectUserModel.uname = model.data[@"user_name"];
        _tableView.selectUserModel = _selectUserModel;
        
        NSMutableArray *jishiList = [self createJisShiArray:self.orderDic[@"ye_jis"]]; // MLJiShiModel
        
        // 商品信息
        self.computeOredrModel = XMHComputeOredrModel.new;
//        self.computeOredrModel.modelArray = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[XMHServiceGoodsModel class] json:_orderDic[@"pro_list"]];
        
        NSMutableArray *modelArray = NSMutableArray.new;
        for (NSDictionary *json in _orderDic[@"pro_list"]) {
            XMHServiceGoodsModel *model = [XMHServiceGoodsModel yy_modelWithJSON:json];
            model.selectCount = [NSString stringWithFormat:@"%@", json[@"num"]].integerValue;// 购买的数量映射给selectCount
            [modelArray addObject:model];
        }
        self.computeOredrModel.modelArray = modelArray;
        
        self.computeOredrModel.shiChang = [NSString stringWithFormat:@"%@", _orderDic[@"z_shichang"]];
        self.computeOredrModel.price = [NSString stringWithFormat:@"%@", _orderDic[@"z_price"]];
        self.computeOredrModel.tikaPrice = [self computeTiKaPrice];
        self.computeOredrModel.jiShiList = jishiList;
        
        // 后置填写model
        self.computeOrderAchievementModel = XMHComputeOrderAchievementModel.new;
        // 技师集合
        self.computeOrderAchievementModel.jiShiList = jishiList;//[self jishiArrayFromModelArray:self.computeOredrModel.modelArray];
        
        // 服务单类型0：服务单，1销售服务单
        if ([self.orderDic[@"type"] integerValue] == 0) {
            _tableView.createOrderType = XMHCreateOrderTypeService;
        } else if ([self.orderDic[@"type"] integerValue] == 1) {
            _tableView.createOrderType = XMHCreateOrderTypeExperience;
        }
        _tableView.dataArray = @[self.computeOredrModel, self.computeOrderAchievementModel];
        [_tableView reloadData];
        
        _tableView.remarkText =  _orderDic[@"k_content"];
        
        [self requestGuiShuData];
    }];
}

//- (BOOL)isCunzaiJishi:(NSArray *)accountArray account:(NSString *)account {
//    for (NSString *aaccount in accountArray) {
//        if ([aaccount isEqualToString:account]) {
//            return YES;
//        }
//    }
//    return NO;
//}
//
//- (NSMutableArray *)createJisShiArray:(NSArray *)jiShiArray {
//    NSMutableArray *accountArray = NSMutableArray.new;
//
//    for (NSDictionary *jishiDic in jiShiArray) {
//        NSString *account = jishiDic[@"account"];
//        
//        BOOL bl = [self isCunzaiJishi:accountArray account:account];
//        if (!bl) {
//            [accountArray addObject:account];
//        }
//    }
//    
//    NSMutableArray *modelArray = NSMutableArray.new;
//    for (NSString *account in accountArray) {
//        for (NSDictionary *jishiDic in jiShiArray) {
//            NSString *aaccount = jishiDic[@"account"];
//            if ([account isEqualToString:aaccount]) {
//                [modelArray addObject:[MLJiShiModel yy_modelWithJSON:jishiDic]];
//                break;
//            }
//        }
//    }
//    return modelArray;
//}

/**
 销售单数据
 */
- (void)getSalesData {
    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"ordernum"] = _ordernum;
    [XMHExperienceOrderRequest requestSalesInfoParams:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess) {
        if (!isSuccess) return;
        self.orderDic = model.data;
        // 顾客信息
        self.selectUserModel = CustomerModel.new;
        self.selectUserModel.uid = (NSInteger)model.data[@"user_id"];
        self.selectUserModel.mobile = model.data[@"user_mobile"];
        self.selectUserModel.uname = model.data[@"user_name"];
        _tableView.selectUserModel = _selectUserModel;
        
        /*
         XMHServiceGoodsModel *amodel = (XMHServiceGoodsModel *)model;
         numLabel.text = @(amodel.selectCount).stringValue;
         typeLabel.text = [amodel stringFromType];
         */
        
        // 商品信息
        self.computeOredrModel = XMHComputeOredrModel.new;
        self.computeOredrModel.modelArray = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[XMHServiceGoodsModel class] json:_orderDic[@"cart_data"]];
        self.computeOredrModel.shiChang = [NSString stringWithFormat:@"%@", _orderDic[@"z_shichang"]];
        self.computeOredrModel.price = [NSString stringWithFormat:@"%@", _orderDic[@"amount"]];
        
        // 后置填写model
        self.computeOrderAchievementModel = XMHComputeOrderAchievementModel.new;
        // 技师集合
        NSMutableArray *jishiList = [self createJisShiArray:self.orderDic[@"ye_jis"]]; // MLJiShiModel
        self.computeOrderAchievementModel.jiShiList = jishiList;// [self jishiArrayFromModelArray:self.computeOredrModel.modelArray];
        
        _tableView.dataArray = @[self.computeOredrModel, self.computeOrderAchievementModel];
        [_tableView reloadData];
        
        _tableView.remarkText =  _orderDic[@"content"];
        
        [self requestGuiShuData];
    }];
}

- (BOOL)isCunzaiJishi:(NSArray *)accountArray account:(NSString *)account {
    for (NSString *aaccount in accountArray) {
        if ([aaccount isEqualToString:account]) {
            return YES;
        }
    }
    return NO;
}

- (NSMutableArray *)createJisShiArray:(NSArray *)jiShiArray {
    NSMutableArray *accountArray = NSMutableArray.new;
    
    for (NSDictionary *jishiDic in jiShiArray) {
        NSString *account = jishiDic[@"account"];
        
        BOOL bl = [self isCunzaiJishi:accountArray account:account];
        if (!bl) {
            [accountArray addObject:account];
        }
    }
    
    NSMutableArray *modelArray = NSMutableArray.new;
    for (NSString *account in accountArray) {
        for (NSDictionary *jishiDic in jiShiArray) {
            NSString *aaccount = jishiDic[@"account"];
            if ([account isEqualToString:aaccount]) {
                [modelArray addObject:[MLJiShiModel yy_modelWithJSON:jishiDic]];
                break;
            }
        }
    }
    return modelArray;
}

/**
 获取技师集合
 */
- (NSMutableArray *)jishiArrayFromModelArray:(NSArray<XMHServiceGoodsModel *> *)modelArray {
    NSMutableArray *jishiArray = NSMutableArray.new;
    for (XMHServiceGoodsModel *serviceGoodsModel in modelArray) {
        [jishiArray addObjectsFromArray:serviceGoodsModel.jiShiList];
    }
    return jishiArray;
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


/**
 计算提卡价格
 */
- (CGFloat)computeTiKaPrice {
    CGFloat allTikaPrice = 0;
    NSArray *proList = self.orderDic[@"pro_list"];
    for (NSDictionary *proDic in proList) {
        NSString *type = proDic[@"type"];
        if ([type isEqualToString:@"card_time"] || [type isEqualToString:@"stored_card"] || [type isEqualToString:@"card_num"]) {
            CGFloat tikaPrice = [proDic[@"price"] floatValue] * [proDic[@"num"] integerValue];
            allTikaPrice += tikaPrice;
        }
    }
    return allTikaPrice;
}

#pragma mark - Event

- (void)submitBtnClick:(UIButton *)sender {
    // 选择业绩归属，校验以下信息
    if (!_computeOrderAchievementModel.yeJGuiShuModel) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择业绩归属"];
        return;
    }
//    if (!_computeOrderAchievementModel.dianZhangModel) {
//        [MzzHud toastWithTitle:@"提示" message:@"请选择店长归属"];
//        return;
//    }
    
    if (![_computeOrderAchievementModel checkInputGuiShu]) {
        [MzzHud toastWithTitle:@"提示" message:@"请分配员工归属"];
        return;
    }
    
    NSString *payPriceStr = _orderDic[@"z_price"];
    if (!IsEmpty(payPriceStr)) {
        CGFloat payPrice = [payPriceStr floatValue];
        if (![_computeOrderAchievementModel checkJiShiPriceAllPrice:payPrice]) {
//            [MzzHud toastWithTitle:@"提示" message:[NSString stringWithFormat:@"员工归属总计与销售服务总计(%ld元)不符，请重新分配", payPrice]];
            [MzzHud toastWithTitle:@"提示" message:@"员工归属总计与销售服务总计不符，请重新分配"];
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
