//
//  XMHOrderSaleBuYeJiVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOrderSaleBuYeJiVC.h"
#import "XMHSaleOrderRequest.h"
#import "SaleServiceCommitHeader.h"
#import "MzzJisuantongjiView.h"
#import "CustomerListModel.h"
#import "MzzAwardView.h"
#import "SASaleListModel.h"
#import "MzzYejihuafenView.h"
#import "FWDCommentCell.h"
#import "XMHOrderSaleBuYeJiTableView.h"
#import "SASaleListModel.h"
#import "XMHAwardContentVC.h"
#import "XMHComputeOredrModel.h"
#import "FWDSelectView.h"
#import "FWDYeJGuiShuModel.h"
#import "XMHComputeOrderAchievementModel.h"
#import "ShareWorkInstance.h"
#import "MzzCustomerRequest.h"
#import "SLRequest.h"
#import "XMHSalesOrderJishiSelectorVC.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "XMHSaleOrderRequest.h"
#import "XMHNormalOrderManagementVC.h"
#import "XMHSalesOrderVC.h"
#import "XMHShoppingCartManager.h"
#import "SaleListRequest.h"
#import "XMHNewMzzJiSuanViewController.h"
@interface XMHOrderSaleBuYeJiVC ()<XMHOrderSaleBuYeJiTableViewDelegate>

@property (nonatomic, strong) NSMutableArray <SaleModel *>*saleModelList;// 购物车数组
@property (nonatomic,copy)NSString *store_code;
@property (nonatomic, strong) UIView *bottomBgView;
@property (nonatomic, strong) XMHOrderSaleBuYeJiTableView *tableView;
@property (nonatomic, strong) NSMutableArray <SaleModel *>*saleModelArr;
@property (nonatomic, strong) NSMutableArray <SaleModel *>*awardModelArr;
@property (nonatomic, strong) XMHComputeOredrModel *computeOredrModel;

@property (nonatomic ,strong)FWDSelectView * yeJiView;
@property (nonatomic, copy) NSString *selectYejiguishu;
@property (nonatomic, strong)MzzStoreModel *selectStoreModel;
@property (nonatomic, strong)SLManagerModel *selectManagerModel;
@property (nonatomic, strong)MLJiShiModel *selectJiShiModel;
@property (nonatomic, strong)NSMutableArray <MLJiShiModel *>*yuangongArrays;
@property (nonatomic, strong) NSArray *yejiguishuArr;
@property (nonatomic, strong) NSArray *mendianshuArr;
@property (nonatomic ,strong)MzzStoreList *storeList;
/** 已选技师数组 */
@property (nonatomic, strong) NSMutableArray *jishiArr;
//业绩划分数据
@property (nonatomic, strong) XMHComputeOrderAchievementModel *computeOrderAchievementModel;
/** 店长集合 */
@property (nonatomic, strong) NSArray <SLManagerModel *>*dianZhangList;
/** 备注信息 */
@property (nonatomic, copy) NSString *textViewContent;
///** 提交订单编码 */
//@property (nonatomic, copy) NSString *orderNum;
/** 应付金额,在补齐项目中变成订单金额 */
@property (nonatomic, assign)CGFloat totalPrice;

/** 备注内容 */
@property (nonatomic, copy) NSString *remarkText;
@end

@implementation XMHOrderSaleBuYeJiVC

- (void)requestData
{
    WeakSelf
    self.saleModelList = [NSMutableArray array];
    [XMHSaleOrderRequest requestSalesInfoOrderNum:self.ordernum resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        NSDictionary *dic = result;
        self.remarkText = dic[@"content"];
        NSArray *cart_data = [dic safeObjectForKey:@"cart_data"];//商品数组
        for (int i = 0; i < cart_data.count; i ++) {
            NSDictionary *dic = cart_data[i];
            SaleModel *model = [[SaleModel alloc]init];
            model.uid = [dic[@"id"] integerValue];
            NSString *type = dic[@"type"];
            if ([type isEqualToString:@"pro"]) {
                model.name = dic[@"name"];
                model.num = [dic[@"num"] integerValue];
                model.addnum = [dic[@"num"] integerValue];
                model.code = dic[@"code"];
                model.ciShu = dic[@"pro_num"];
                model.type = (XMHServiceOrderType)dic[@"type"];
                model.inputPrice = dic[@"price"];
                model.sastoreCardModel.code = dic[@"store_card"];
                model.totalPrice = dic[@"price"];
                model.selectCount = [dic[@"num"] integerValue];
            }else {
                model.name = dic[@"name"];
                model.num = [dic[@"num"] integerValue];
                model.addnum = [dic[@"num"] integerValue];
                model.totalPrice = dic[@"price"];
                model.code = dic[@"code"];
                model.type = (XMHServiceOrderType)dic[@"type"];
                model.inputPrice = dic[@"price"];
                model.selectCount = [dic[@"num"] integerValue];
            }
            [self.saleModelList safeAddObject:model];
        }
        
        [weakSelf initValue];
        _tableView.saleData = self.saleModelArr;
        _tableView.awardData = self.awardModelArr;
        _tableView.remarkText = self.remarkText;
        [weakSelf.tableView reloadData];
    }];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_NormalBG;
    [self requestData];
    [self createSubViews];
    [self createYeJiSelectView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTotalPrice:) name:@"YINGFUJINERERNotification" object:nil];
}
- (void)createSubViews
{
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.navView setNavViewTitle:@"结算统计" backBtnShow:YES];
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
    [submitBtn setTitle:@"确认信息" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = FONT_SIZE(17);
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    [_bottomBgView addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(sureBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(44);
        make.centerY.equalTo(_bottomBgView);
    }];
    WeakSelf
    self.tableView = [[XMHOrderSaleBuYeJiTableView alloc] initWithFrame:CGRectMake(10, KNaviBarHeight, self.view.width - 20, SCREEN_HEIGHT - KNaviBarHeight - 54) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.saleData = self.saleModelArr;
    _tableView.awardData = self.awardModelArr;
    _tableView.aDelegate = self;
    _tableView.buYeJi = YES;
    _tableView.remarkTextViewUserInteractionEnabled = YES;
    _tableView.addAwardClick = ^{
        [weakSelf addAwardClick];
    };
    _tableView.textViewContent = ^(NSString * _Nonnull text) {
        weakSelf.textViewContent = text;
    };
    [self.view addSubview:_tableView];
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(KNaviBarHeight);
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.bottom.equalTo(submitBtn.mas_top).offset(-10);
//    }];
    _tableView.selectUserModel = self.customer;
}

- (void)initValue
{
    self.jishiArr = [NSMutableArray array];
    self.yuangongArrays = [NSMutableArray array];
    self.saleModelArr = [NSMutableArray array];
    self.awardModelArr = [NSMutableArray array];
    
    
    SaleModel *model = [[SaleModel alloc]init];
    model.name = @"商品名称";
    [self.saleModelArr safeAddObject:model];
    [self.saleModelArr safeAddObjectsFromArray:self.saleModelList];
    
    // 获取奖增数据,自定义一个假数据,方便UI布局
    SaleModel *model1 = [[SaleModel alloc]init];
    model1.name = @"奖增内容";
    [self.awardModelArr safeAddObject:model1];
    
    XMHComputeOrderAchievementModel *computeOrderAchievementModel = XMHComputeOrderAchievementModel.new;
    self.computeOrderAchievementModel = computeOrderAchievementModel;
    [self requestMendian];
}
- (void)createYeJiSelectView
{
    FWDSelectView * select = [[FWDSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    select.FWDSelectViewBlock = ^(LSelectBaseModel *model) {
        // 业绩
        if ([model isKindOfClass:[FWDYeJGuiShuModel class]]) {
            self.computeOrderAchievementModel.yeJGuiShuModel = (FWDYeJGuiShuModel *)model;
            
        }
        
        // 店长
        if ([model isKindOfClass:[MzzStoreModel class]]) {
            //             self.computeOrderAchievementModel.menDianModel = (MzzStoreModel *)model;
        }
        
        if ([model isKindOfClass:[SLManagerModel class]]) {
            self.computeOrderAchievementModel.dianZhangModel = (SLManagerModel *)model;
        }
        
        //        if ([model isKindOfClass:[MLJiShiModel class]]) {
        //            [self.jishiArr safeAddObject:(MLJiShiModel *)model];
        //            _tableView.computeOrderAchievementModel.jiShiList = self.jishiArr;
        //        }
        _tableView.computeOrderAchievementModel =  self.computeOrderAchievementModel;
        [_tableView reloadData];
    };
    self.yeJiView = select;
    select.hidden = YES;
    [self.view addSubview:select];
    
    
}
#pragma mark -- 获取数据


#pragma mark - XMHOrderSaleBuYeJiTableViewDelegate

/**
 归属回调
 @param tag 1 业绩 2 门店 3 店长
 */
- (void)guiShutableView:(XMHOrderSaleBuYeJiTableView *)tableView tag:(NSInteger)tag {
    if (tag == 1) {
        self.yeJiView.hidden = NO;
        self.yeJiView.listModel = self.yejiguishuArr;
    } else if (tag == 2) {
        //        self.yeJiView.hidden = NO;
        //        self.yeJiView.listModel = self.mendianshuArr;
    } else if (tag == 3) {
        self.yeJiView.hidden = NO;
        self.yeJiView.listModel = _dianZhangList;
    }else if (tag == 4){
        WeakSelf
        XMHSalesOrderJishiSelectorVC *vc = [[XMHSalesOrderJishiSelectorVC alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        vc.selectBlock = ^(XMHSalesOrderJishiSelectorVC * _Nonnull vc, MLJiShiModel * _Nonnull jiShiModel) {
            [vc dismissViewControllerAnimated:YES completion:nil];
            self.selectJiShiModel = jiShiModel;
            BOOL have = NO;
            for (MLJiShiModel *jishiModel in weakSelf.jishiArr) {
                if (jishiModel.ID == _selectJiShiModel.ID) {
                    have = YES;
                }
            }
            if (have) {
                [MzzHud toastWithTitle:@"提示" message:@"已添加该技师"];
            }else{
                [self.jishiArr safeAddObject:self.selectJiShiModel];
            }
            self.computeOrderAchievementModel.jiShiList = self.jishiArr;
            _tableView.computeOrderAchievementModel = self.computeOrderAchievementModel;
            [_tableView reloadData];
        };
        
    }
}
#pragma mark -- 业绩划分数据
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

- (void)requestDianZhangData
{
    //店长
    NSString * _joinCode = [ShareWorkInstance shareInstance].join_code;
    NSMutableDictionary *DZparms = [[NSMutableDictionary alloc]init];
    [DZparms setValue:_joinCode?_joinCode:@"" forKey:@"join_code"];
    MzzStoreModel * model = _storeList.list[0];
    [DZparms setValue:model.store_code forKey:@"store_code"];
    [SLRequest  requesSearchManagerParams:DZparms resultBlock:^(SLSearchManagerModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            self.dianZhangList = model.list;
        }
    }];
}
- (void )requestMendian{
    
    WeakSelf;
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    if (join_code) {
        [parms setValue:join_code forKey:@"join_code"];
    }
    
    //门店归属
    [MzzCustomerRequest requestStoreListParams:parms resultBlock:^(MzzStoreList *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _storeList = listModel;
            _selectStoreModel = _storeList.list[0];
            weakSelf.computeOrderAchievementModel.menDianModel = _selectStoreModel;
            _tableView.computeOrderAchievementModel =  weakSelf.computeOrderAchievementModel;
            [weakSelf.tableView reloadData];
            [weakSelf requestDianZhangData];
        }
    }];
    
}
#pragma mark -- event
- (void)addAwardClick
{
    WeakSelf
    XMHAwardContentVC *vc = [[XMHAwardContentVC alloc]init];
    vc.store_code = self.store_code;
    vc.user_id = self.customer.uid;
    [self presentViewController:vc animated:YES completion:nil];
    vc.selectedAward = ^(SaleModel * _Nonnull model) {
        [weakSelf.awardModelArr safeAddObject:model];
        weakSelf.tableView.awardData = weakSelf.awardModelArr;
        [weakSelf.tableView reloadData];
    };
}
- (void)sureBtClick:(id)sender
{
   //销售单单号
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.ordernum forKey:@"ordernum"];
    // 业绩归属
    [dic setValue:self.computeOrderAchievementModel.yeJGuiShuModel.belong ? self.computeOrderAchievementModel.yeJGuiShuModel.belong :@"" forKey:@"belong"];
    //店长归属 传电话号
    [dic setValue:self.computeOrderAchievementModel.dianZhangModel.account forKey:@"dianzhang"];
    // 备注
    [dic setValue:self.textViewContent ? self.textViewContent :@"" forKey:@"content"];
    // inper
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * inper = infomodel.data.account;
    [dic setValue:inper forKey:@"inper"];
    
    //员工业绩归属
    NSMutableArray *guishuArr = [NSMutableArray array];
    float allBfb = 0.0;
    for (int i = 0; i < self.jishiArr.count; i++) {
        MLJiShiModel *jishiModel = [self.jishiArr objectAtIndex:i];
        NSMutableDictionary *gsDic2 = [[NSMutableDictionary alloc]init];
        [gsDic2 setValue:jishiModel.account?jishiModel.account:@"" forKey:@"acc"];
        [gsDic2 setValue:[NSString stringWithFormat:@"%.2f",jishiModel.bfb]?[NSString stringWithFormat:@"%.2f",jishiModel.bfb]:@"" forKey:@"bfb"];
        allBfb += jishiModel.bfb;
        [guishuArr addObject:gsDic2];
    }
    [dic setValue:guishuArr forKey:@"guishu"];

    // 厂家业绩 厂家业绩 0不算 1算
    if (self.computeOrderAchievementModel.changJiaYeji == YES) {
        [dic setValue:@"1" forKey:@"changjia"];
    }else{
        [dic setValue:@"0" forKey:@"changjia"];
    }
    
    NSString *str = dic.jsonData;
    
    // 提示框
    if ([self.computeOrderAchievementModel.yeJGuiShuModel.belong integerValue]) {
        
      
        //技师业绩总额和应付金额做对比
        if (allBfb > self.totalPrice ||allBfb < self.totalPrice) {
            [MzzHud toastWithTitle:@"提示" message:@"业绩归属总计不等于应付金额，请重新分配" ];
            return;
        }
    }
    
    NSMutableDictionary *parmsdic = [[NSMutableDictionary alloc]init];
    [parmsdic setValue:str forKey:@"result"];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    [parmsdic setValue:model.data.token?model.data.token:@"" forKey:@"token"];
    
//    [XMHSaleOrderRequest requestSalesInfoOrderNum:self.ordernum resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
//        
//    }];
    
    [XMHSaleOrderRequest requestbuYeJiMuSubmmitParams:parmsdic resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            [self showAleartView];
        };
    }];
}

- (void)showAleartView
{
    MzzHud *hud = [[MzzHud alloc] initWithTitle:@"温馨提示" message:@"开单成功，请耐心等待后续人员的操作" leftButtonTitle:@"返回列表" rightButtonTitle:@"继续开单" click:^(NSInteger index) {
        if (index ==0) {
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[XMHNormalOrderManagementVC class]]) {
                    [self.navigationController popToViewController:temp animated:NO];
                }
            }
        }else{
            // 清空购物车
            [XMHShoppingCartManager.sharedInstance clear];
            XMHSalesOrderVC *vc = [[XMHSalesOrderVC alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
            //                        for (UIViewController *temp in self.navigationController.viewControllers) {
            //                            if ([temp isKindOfClass:[XMHSalesOrderVC class]]) {
            //                                XMHSalesOrderVC *vc =  (XMHSalesOrderVC *)temp;
            //                                // 清空购物车
            //                                [XMHShoppingCartManager.sharedInstance clearSaleOrderModel];
            //                                vc.selectModel = nil;
            //                                [self.navigationController popToViewController:vc animated:NO];
            //                            }
            //                        }
        }
    }];
    hud.contentTipView.btnCancel.hidden = YES;
    [hud show];
    
}

#pragma mark -Notifi
- (void)changeTotalPrice:(NSNotification *)notification
{
    self.totalPrice = [notification.userInfo[@"totalPrice"] floatValue];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
