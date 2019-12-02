//
//  XMHComputeOredrVC.m
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHComputeOredrVC.h"
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
#import "XMHSuccessAlertView.h"
@interface XMHComputeOredrVC() <XMHComputeOredrTableViewDelegate>
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


@end

@implementation XMHComputeOredrVC

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
    
    if (_createOrderType == XMHCreateOrderTypeExperience) {
        [self.navView setNavViewTitle:@"体验制单" backBtnShow:YES];
    } else if(_createOrderType == XMHCreateOrderTypeService) {
        [self.navView setNavViewTitle:@"服务制单" backBtnShow:YES];
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
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
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
    _tableView.createOrderType = _createOrderType;
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.aDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNaviBarHeight);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.equalTo(submitBtn.mas_top).offset(-10);
    }];
    
    [self createSelectView];
    
    [self getData];
    [self requestGuiShuData];
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

#pragma mark - GetData

- (void)getData {
    _tableView.selectUserModel = _selectUserModel;
    
    XMHComputeOredrModel *computeOredrModel = XMHComputeOredrModel.new;
    self.computeOredrModel = computeOredrModel;
    computeOredrModel.modelArray = _modelArray;
    computeOredrModel.shiChang = _shiChang;
    
    XMHComputeOrderAchievementModel *computeOrderAchievementModel = XMHComputeOrderAchievementModel.new;
    self.computeOrderAchievementModel = computeOrderAchievementModel;
    computeOrderAchievementModel.modelArray = _modelArray;
    
    _tableView.dataArray = @[computeOredrModel, computeOrderAchievementModel];
    [_tableView reloadData];
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
    if (_computeOrderAchievementModel.yeJGuiShuModel) {
//        if (!_computeOrderAchievementModel.dianZhangModel) {
//            [MzzHud toastWithTitle:@"提示" message:@"请选择店长归属"];
//            return;
//        }
        
        if (![_computeOrderAchievementModel checkInputGuiShu]) {
            [MzzHud toastWithTitle:@"提示" message:@"请分配员工归属"];
            return;
        }
        
        if (![_computeOrderAchievementModel checkJiShiPrice]) {
            [MzzHud toastWithTitle:@"提示" message:@"员工归属总计与销售服务总计不符，请重新分配"];
            return;
        }
    }
    
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    
    NSMutableDictionary *params = NSMutableDictionary.new;
    if (_computeOrderAchievementModel.yeJGuiShuModel) {
        params[@"belong"] = @([_computeOrderAchievementModel.yeJGuiShuModel.belong integerValue]); // 业绩归属（1售前 2售中 3售后）
        params[@"dianzhang"] = _computeOrderAchievementModel.dianZhangModel.account; // 店长归属
        params[@"xiaohao"] = _computeOrderAchievementModel.xiaohao ? @(1) : @(0); // 是否算耗卡：0否，1是
        params[@"guishu"] = [_computeOrderAchievementModel guiShuArray]; // 员工归属
        params[@"changjia"] = _computeOrderAchievementModel.changJiaYeji ? @(1) : @(0); // changjia（厂家业绩：0不算，1算）
    }

    params[@"token"] = model.data.token;
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    params[@"z_shichang"] = @([_shiChang integerValue]); // 设置的总时长
    params[@"store_code"] = [ShareWorkInstance shareInstance].share_join_code.store_code;//_computeOrderAchievementModel.menDianModel.store_code; // 门店归属
    params[@"content"] = _tableView.remarkTextView.text; // 备注信息
    params[@"user_id"] = @(_selectUserModel.uid); // 顾客id
    
    // 体验服务
    if (_createOrderType == XMHCreateOrderTypeExperience) {
        params[@"pro"] = [_computeOredrModel getProjectParamList]; // 项目服务
        params[@"goods"] = [_computeOredrModel getGoodsParamList]; // 产品服务
        params[@"serv_type"] = @(1); // 制单类型：0服务单，1销售服务单
        params[@"course_exper"] = [_computeOredrModel getExperienceParamList]; // 体验服务
    }
    // 服务单
    else if (_createOrderType == XMHCreateOrderTypeService) {
        params[@"serv_type"] = @(0); // 制单类型：0服务单，1销售服务单
        params[@"pres"] = [_computeOredrModel getChuFangParamList]; // 处方
        params[@"stored_card"] = [_computeOredrModel getStoredCardParamList]; // 提卡服务-储值卡
        params[@"card_num"] = [_computeOredrModel getNumCardParamList]; // 提卡服务-任选卡
        params[@"card_time"] = [_computeOredrModel getTimeCardParamList]; // 提卡服务-时间卡
        params[@"rec_pro"] = [_computeOredrModel getServiceProjectParamList]; // 项目服务
        params[@"rec_goods"] = [_computeOredrModel getServiceGoodsParamList]; // 产品服务
    }
    
    NSMutableDictionary *newParams = [@{@"data" : params.jsonData} mutableCopy];
    MzzLog(@"%@", [params yy_modelToJSONString]);
    WeakSelf
    [XMHExperienceOrderRequest requestCreateOrderParam:newParams resultBlock:^(SLOrderNumModel * _Nonnull orderNumModel, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (!isSuccess) return;
        
        [[[XMHSuccessAlertView alloc]initWithTitle:@"创建订单成功!" cancelButtonTitle:@"返回首页" otherButtonTitles:@"服务记录" click:^(NSInteger index) {
            if (index ==0) {
              
                BOOL contains = NO;
                for (UIViewController *temp in weakSelf.navigationController.viewControllers) {
                    if ([temp isKindOfClass:[XMHNormalOrderManagementVC class]]) {
                        contains = YES;
                        [weakSelf.navigationController popToViewController:temp animated:NO];
                    }
                }
                if (contains == NO) {//由预约管理生成的单子,可能没有XMHNormalOrderManagementVC当前控制器
                    XMHNormalOrderManagementVC *vc = [[XMHNormalOrderManagementVC alloc]init];
                    [self.navigationController pushViewController:vc animated:NO];
                }
                
            }else{
                XMHExperienceOrderRecordVC * next = [[XMHExperienceOrderRecordVC alloc] init];
                next.ordernum = orderNumModel.ordernum;
                [weakSelf.navigationController pushViewController:next animated:YES];
            }
        }] show];
        
        // 顾客没有归属技师
        if (![_selectUserModel isUserExistJishi]) {
            // 顾客属于技师归属门店
            NSString *store_code = [ShareWorkInstance shareInstance].share_join_code.store_code;
            if ([store_code isEqualToString:_selectUserModel.store_code]) {
                [[[XMHSuccessAlertView alloc]initWithTitle:@"是否绑定该顾客？" cancelButtonTitle:@"是" otherButtonTitles:@"否" click:^(NSInteger index) {
                    if (index == 0) {
                        NSMutableDictionary *params = NSMutableDictionary.new;
                        params[@"token"] = model.data.token;
                        params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
                        params[@"store_code"] = store_code; // 门店归属
                        params[@"user_id"] = @(_selectUserModel.uid).stringValue;
                        [XMHExperienceOrderRequest requestBangJisParams:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess) {
                            [SVProgressHUD setInfoImage:UIImageName(@"1")];
                            [SVProgressHUD showInfoWithStatus:isSuccess ? @"绑定成功" : @"绑定失败"];
                        }];
                    }
                }] show];
            }
        }
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
