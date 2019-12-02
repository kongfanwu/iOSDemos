//
//  XMHSaleOrderStatisticVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/29.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSaleOrderStatisticVC.h"
#import "SaleServiceCommitHeader.h"
#import "MzzJisuantongjiView.h"
#import "CustomerListModel.h"
#import "MzzAwardView.h"
#import "SASaleListModel.h"
#import "MzzYejihuafenView.h"
#import "FWDCommentCell.h"
#import "XMHSaleOrderStatisticTableView.h"
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
#import "XMHSuccessAlertView.h"
#import "XMHExperienceOrderRequest.h"
#import "XMHSharedAlertVC.h"

@interface XMHSaleOrderStatisticVC ()<XMHSaleOrderStatisticTableViewDelegate>

@property (nonatomic, strong) UIView *bottomBgView;
@property (nonatomic, strong) XMHSaleOrderStatisticTableView *tableView;
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
@end

@implementation XMHSaleOrderStatisticVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_NormalBG;
    
    [self initValue];
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
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(69);
        make.bottom.mas_equalTo(-kSafeAreaBottom);
    }];
    
    UIButton *onlineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [onlineBtn setBackgroundImage:[UIImage imageWithColor:kBtn_Commen_Color size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [onlineBtn setTitle:@"线上结算" forState:UIControlStateNormal];
    onlineBtn.titleLabel.font = FONT_SIZE(17);
    onlineBtn.layer.cornerRadius = 3;
    onlineBtn.layer.masksToBounds = YES;
    [_bottomBgView addSubview:onlineBtn];
    [onlineBtn addTarget:self action:@selector(onlineBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundImage:[UIImage imageWithColor:kBtn_Commen_Color size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [submitBtn setTitle:@"门店结算" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = FONT_SIZE(17);
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    [_bottomBgView addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    NSArray *submitList = @[onlineBtn, submitBtn];
    [submitList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.centerY.equalTo(_bottomBgView);
    }];
    
    [submitList mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:15 tailSpacing:15];
    
    WeakSelf
    self.tableView = [[XMHSaleOrderStatisticTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.saleData = self.saleModelArr;
    _tableView.awardData = self.awardModelArr;
    _tableView.aDelegate = self;
    _tableView.remarkTextViewUserInteractionEnabled = YES;
    _tableView.yingfuPrice = self.yingfuPrice;
    _tableView.addAwardClick = ^{
        [weakSelf addAwardClick];
    };
    _tableView.textViewContent = ^(NSString * _Nonnull text) {
        weakSelf.textViewContent = text;
    };
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNaviBarHeight);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.equalTo(submitBtn.mas_top).offset(-10);
    }];
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
    __weak typeof(self) _self = self;
    select.FWDSelectViewBlock = ^(LSelectBaseModel *model) {
        __strong typeof(_self) self = _self;
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
         self.tableView.computeOrderAchievementModel =  self.computeOrderAchievementModel;
        [self.tableView reloadData];
    };
    self.yeJiView = select;
    select.hidden = YES;
    [self.view addSubview:select];
    
    
}
#pragma mark -- 获取数据


#pragma mark - XMHComputeOredrTableViewDelegate

/**
 归属回调
 @param tag 1 业绩 2 门店 3 店长
 */
- (void)guiShutableView:(XMHSaleOrderStatisticTableView *)tableView tag:(NSInteger)tag {
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
        __weak typeof(self) _self = self;
        vc.selectBlock = ^(XMHSalesOrderJishiSelectorVC * _Nonnull vc, MLJiShiModel * _Nonnull jiShiModel) {
            __strong typeof(_self) self = _self;
            [vc dismissViewControllerAnimated:YES completion:nil];
            self.selectJiShiModel = jiShiModel;
            BOOL have = NO;
            for (MLJiShiModel *jishiModel in weakSelf.jishiArr) {
                if (jishiModel.ID == self.selectJiShiModel.ID) {
                    have = YES;
                }
            }
            if (have) {
                [MzzHud toastWithTitle:@"提示" message:@"已添加该技师"];
            }else{
                [self.jishiArr safeAddObject:self.selectJiShiModel];
            }
//            [self.jishiArr safeAddObject:self.selectJiShiModel];
            self.computeOrderAchievementModel.jiShiList = self.jishiArr;
            self.tableView.computeOrderAchievementModel = self.computeOrderAchievementModel;
            [self.tableView reloadData];
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
- (void)submitBtnClick:(id)sender
{
    /*处理数据获取单号
     1.结算数据
     
    */
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    // 业绩归属
    [dic setValue:self.computeOrderAchievementModel.yeJGuiShuModel.belong ? self.computeOrderAchievementModel.yeJGuiShuModel.belong :@"" forKey:@"belong"];
    //店长归属 传电话号
    [dic setValue:self.computeOrderAchievementModel.dianZhangModel.account forKey:@"dianzhang"];
    // 备注
    [dic setValue:self.textViewContent ? self.textViewContent :@"" forKey:@"content"];
     Join_Code *join_Code =  [ShareWorkInstance shareInstance].share_join_code;
    [dic setValue:join_Code forKey:@"fram_id"];
    
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
    
    if (self.yingfuPrice) { //补齐项目.必选业绩归属,必选员工归属
        
        // 提示框
        
        if(![self.computeOrderAchievementModel.yeJGuiShuModel.belong integerValue]){
           // [MzzHud toastWithTitle:@"提示" message:@"请选择业绩归属" ];
            [[[XMHSuccessAlertView alloc]initWithTitle:@"业绩归属未填写"]show];
            return;
        }
        if ([self.computeOrderAchievementModel.yeJGuiShuModel.belong integerValue]) {
            
            if (!guishuArr.count) {
//                [MzzHud toastWithTitle:@"提示" message:@"请选择员工归属" ];
                [[[XMHSuccessAlertView alloc]initWithTitle:@"员工归属未填写"]show];
                return;
            }
            //技师业绩总额和应付金额做对比
            if (allBfb != self.totalPrice) {
                [[[XMHSuccessAlertView alloc]initWithTitle:@"业绩归属总计不等于应付金额，请重新分配"]show];
//                [MzzHud toastWithTitle:@"提示" message:@"业绩归属总计不等于应付金额，请重新分配" ];
                return;
            }
        }
    }else{ //选业绩归属,则必选员工归属
        // 提示框
        if ([self.computeOrderAchievementModel.yeJGuiShuModel.belong integerValue]) {
            
            if (!guishuArr.count) {
                [[[XMHSuccessAlertView alloc]initWithTitle:@"业绩归属未填写"]show];
//                [MzzHud toastWithTitle:@"提示" message:@"请选择员工归属" ];
                return;
            }
            //技师业绩总额和应付金额做对比
            if (allBfb != self.totalPrice) {
                [[[XMHSuccessAlertView alloc]initWithTitle:@"业绩归属总计不等于应付金额，请重新分配" ]show];
//                [MzzHud toastWithTitle:@"提示" message:@"业绩归属总计不等于应付金额，请重新分配" ];
                return;
            }
        }
    }
    // 奖赠 转换成符合接口的格式
    //奖赠数据里有一个假数据,因此必须先删除
    if (_awardModelArr.count >= 1) {
         [_awardModelArr removeObjectAtIndex:0];
    }
    NSMutableArray *awardList = [NSMutableArray array];
    for (SaleModel *model in _awardModelArr) {
        NSMutableDictionary *modeldic = [NSMutableDictionary dictionary];
        [modeldic setObject:model.code?model.code:@"" forKey:@"code"];
        [modeldic setObject:[NSString stringWithFormat:@"%ld",(long)model.uid]?[NSString stringWithFormat:@"%ld",(long)model.uid]:@"" forKey:@"id"];
        [modeldic setObject:model.name?model.name:@"" forKey:@"name"];
        [modeldic setObject:[NSString stringWithFormat:@"%ld",(long)model.mzzAwardCount]?[NSString stringWithFormat:@"%ld",(long)model.mzzAwardCount]:@"" forKey:@"num"];
        [modeldic setObject:[NSString stringWithFormat:@"%ld",(long)model.mzzAwardTotlePrice]?:@"" forKey:@"price"];
        [modeldic setObject:model.type?model.cardType:@"" forKey:@"type"];
        [modeldic setObject:model.unit?model.unit:@"" forKey:@"uint"];
        [awardList safeAddObject:modeldic];
    }
    [dic setValue:awardList forKey:@"award"];
    // inper
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * inper = infomodel.data.account;
    [dic setValue:inper forKey:@"inper"];
    
    
    //当前用户的门店code
    [dic setValue:[ShareWorkInstance shareInstance].share_join_code.store_code ? [ShareWorkInstance shareInstance].share_join_code.store_code :@""  forKey:@"store_code"];
    //当前登陆人的fram_id
    [dic setValue:@(join_Code.fram_id) forKey:@"fram_id"];
    //用户ID
    [dic setValue:@(self.customer.uid) forKey:@"user_id"];
    
    // 厂家业绩 厂家业绩 0不算 1算
    if (self.computeOrderAchievementModel.changJiaYeji == YES) {
         [dic setValue:@"1" forKey:@"changjia"];
    }else{
          [dic setValue:@"0" forKey:@"changjia"];
    }
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    [dic setValue:model.data.token?model.data.token:@"" forKey:@"token"];
    //cart array 购买内容数组
    NSMutableArray *cartArr = [NSMutableArray array];
    NSInteger gai_price_pro = 0;
    for (SaleModel *model in self.saleModelList) {
        if (model.gai_price) {
            gai_price_pro = 1;
            break;
        }
    }
   
    for (SaleModel *model in self.saleModelList) {
        
        NSString *longshouStr = [NSString stringWithFormat:@"%.2f",[model.lingshouMoney floatValue]];
        
        NSMutableDictionary *ticket = [NSMutableDictionary dictionary];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name?model.name:@"" forKey:@"name"];
        [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:model.ciShu?model.ciShu:@"" forKey:@"pro_num"];
        [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
        [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
        [dic setValue:model.inputPrice?model.inputPrice:@"" forKey:@"q_money"];
        [dic setValue:model.sastoreCardModel.code?model.sastoreCardModel.code:@"" forKey:@"store_card"];
        if ([model.cardType isEqualToString:@"pro"]) {// 项目
            /**默认传0，使用会员优惠：cp_discount不是0 传1 否则传2 ，要是改价格传3 =======2019.5.8新添*/
            NSInteger price_type = 0;
            if (model.sastoreCardModel && model.sastoreCardModel.xm_discount != 0) {
                price_type = 1;
            }
            if (model.sastoreCardModel && model.sastoreCardModel.xm_discount == 0) {
                 price_type = 2;
            }
            if (model.gai_price == 1) {
                  price_type = 3;
            }
            
            //单次零售价
            NSMutableArray *coursePriceArr = [NSMutableArray array];
            [coursePriceArr safeAddObject:model.price_list.pro_11.price];
            //疗程成交价
            NSArray *lingShouArr = [model.price_list.pro_21.price componentsSeparatedByString:@","];
            [coursePriceArr safeAddObjectsFromArray:lingShouArr];
            NSString *singlePrice = [coursePriceArr safeObjectAtIndex:model.courseIndex];
            
            CGFloat yPrice = [singlePrice floatValue] * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
            
            if (model.staicketModel.type == 1) {
                [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",(long)model.staicketModel.uid]:@"0" forKey:@"ticket"];
            }else{
                [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",(long)model.staicketModel.uid]:@"" forKey:@"ticket_coupon_id"];
            }
            
            [ticket setValue:model.staicketModel.code forKey:@"code"];
            [ticket setValue:model.staicketModel.price forKey:@"money"];
            [ticket setValue:model.staicketModel.name forKey:@"name"];
            [dic setValue:ticket forKey:@"ticketArray"];
          
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"goods"]){
            /**默认传0，使用会员优惠：cp_discount不是0 传1 否则传2 ，要是改价格传3 =======2019.5.8新添*/
            NSInteger price_type = 0;
            if (model.sastoreCardModel && model.sastoreCardModel.cp_discount != 0) {
                price_type = 1;
            }
            if (model.sastoreCardModel && model.sastoreCardModel.cp_discount == 0) {
                price_type = 2;
            }
            if (model.gai_price == 1) {
                price_type = 3;
            }
            NSString *singlePrice = model.price_list.pro_11.price;
            CGFloat yPrice = [singlePrice floatValue] * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
           
            if (model.staicketModel.type == 1) {
                [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",(long)model.staicketModel.uid]:@"" forKey:@"ticket"];
            }else{
                [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",(long)model.staicketModel.uid]:@"" forKey:@"ticket_coupon_id"];
            }
            [ticket setValue:model.staicketModel.code forKey:@"code"];
            [ticket setValue:model.staicketModel.price forKey:@"money"];
            [ticket setValue:model.staicketModel.name forKey:@"name"];
            [dic setValue:ticket forKey:@"ticketArray"];
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"card_course"]){
            [dic removeAllObjects];
            /**默认传0，使用会员优惠：cp_discount不是0 传1 否则传2 ，要是改价格传3 =======2019.5.8新添*/
            NSInteger price_type = 0;
        
            if (model.gai_price == 1) {
                price_type = 3;
            }
            NSString *singlePrice = model.price_list.pro_11.price;
            CGFloat yPrice = [singlePrice floatValue] * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
            
            [dic setValue:model.name forKey:@"name"];
            [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
            [dic setValue:model.code?model.code:@"" forKey:@"code"];
            [dic setValue:@"0" forKey:@"award_xf"];
            [dic setValue:longshouStr?longshouStr:@"" forKey:@"q_money"];
            
            NSMutableArray *rangArr = [[NSMutableArray alloc]init];
            NSDictionary *rootDic = [model.baohanJsonStr dictionaryWithJsonString:model.baohanJsonStr];
            NSArray *arr1 = rootDic[@"guding"];
            NSArray *arr2 = rootDic[@"daixuan"];
            if (arr1.count) {
                for (NSMutableDictionary *dic in arr1) {
                    [dic removeObjectForKey:@"rights"];
                    dic[@"group_map"] = @"";
                    [rangArr addObject:dic];
                }
            }
            if (arr2.count) {
                for (NSMutableDictionary *dic in arr2) {
                    [dic removeObjectForKey:@"rights"];
                    dic[@"group_map"] = @"";
                    [rangArr addObject:dic];
                }
            }
            [dic setValue:rangArr forKey:@"range"];
            [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
            [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
            
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"card_time"]){// 时间卡
            [dic removeAllObjects];
            NSInteger price_type = 0;
            
            if (model.gai_price == 1) {
                price_type = 3;
            }
            NSString *singlePrice = model.price_list.pro_11.price;
            CGFloat yPrice = [singlePrice floatValue] * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
            [dic setValue:model.name forKey:@"name"];
            [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
            [dic setValue:model.code?model.code:@"" forKey:@"code"];
            [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
            [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
            [dic setValue:longshouStr?longshouStr:@"" forKey:@"q_money"];
            [dic setValue:model.sastoreCardModel.code?model.sastoreCardModel.code:@"" forKey:@"store_card"];
            [dic setValue:@(0) forKey:@"price_type"];
            [dic setValue:@([model computeTotalPrice]) forKey:@"y_price"];
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"card_num"] || [model.cardType isEqualToString:@"stored_card"]){//任选卡||储值卡
            
            [dic removeAllObjects];
            NSInteger price_type = 0;
            
            if (model.gai_price == 1) {
                price_type = 3;
            }
            
            CGFloat singlePrice = [model.price_list.pro_11.price floatValue];
            if ([model.cardType isEqualToString:@"stored_card"]) {
                singlePrice = [model.price_list.pro_10.price floatValue];
            }
            CGFloat yPrice = singlePrice * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
            
            [dic setValue:model.name forKey:@"name"];
            [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
            [dic setValue:model.code?model.code:@"" forKey:@"code"];
            [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
            [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
            [dic setValue:longshouStr?longshouStr:@"" forKey:@"q_money"];
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"ticket"]){// 票券
            [dic removeAllObjects];
            NSInteger price_type = 0;
            if (model.gai_price == 1) {
                price_type = 3;
            }
            
            CGFloat singlePrice = [model.price_list.pro_11.price floatValue];
            CGFloat yPrice = singlePrice * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
            
            [dic setValue:model.name forKey:@"name"];
            [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
            [dic setValue:model.code?model.code:@"" forKey:@"code"];
            [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
            [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
            [dic setValue:longshouStr?longshouStr:@"" forKey:@"q_money"];
            
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"skxk"]){//续卡充值
            
            [dic removeAllObjects];
            [dic setValue:@(0) forKey:@"price_type"];//后台确认
            [dic setValue:model.name forKey:@"name"];
            [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
            [dic setValue:model.code?model.code:@"" forKey:@"code"];
            [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
            [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
            

            [cartArr addObject:dic];
        }
    }
    
    [dic setValue:@(gai_price_pro)?@(gai_price_pro):@"0" forKey:@"gai_price"];
     //补齐项目,则再添加以下参数,走另一个请求
    if (self.yingfuPrice) {
        [dic setValue:self.ordernum ? self.ordernum:@"" forKey:@"ordernum"];
        [dic setValue:[NSString stringWithFormat:@"%.2f",[self.yingfuPrice  floatValue]] forKey:@"shifujine"];
        [dic setValue:[ShareWorkInstance shareInstance].join_code ? [ShareWorkInstance shareInstance].join_code:@"" forKey:@"join_code"];
        //门店code
        [dic setValue:self.store_code ? self.store_code :@""  forKey:@"store_code"];
    }
    [dic setValue:[ShareWorkInstance shareInstance].join_code ? [ShareWorkInstance shareInstance].join_code:@"" forKey:@"join_code"];
    [dic setValue:cartArr forKey:@"cart"];

    NSString *str = dic.jsonData;

    NSMutableDictionary *parmsdic = [[NSMutableDictionary alloc]init];
    [parmsdic setValue:str forKey:@"result"];
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    [parmsdic setValue:joinCode forKey:@"join_code"];
    if (self.yingfuPrice) {
        LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
        [parmsdic setValue:model.data.token?model.data.token:@"" forKey:@"token"];
        NSString *yingfuPriceStr = [NSString stringWithFormat:@"%.2f",[self.yingfuPrice floatValue]];
        if (self.totalPrice == [yingfuPriceStr floatValue]) {
//            [SaleListRequest requestKuaiSubmitCartParams:parmsdic resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
//                if (isSuccess) {
//                    [self showAleartView];
//                }
//            }];
            
            //后台更换接口,不用旧接口
            [XMHSaleOrderRequest requestniXiangBuXiangMuSubmitCartParams:parmsdic resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                if (isSuccess) {
                  [self showAleartView];
                }
            }];
        }else{
            if ([yingfuPriceStr floatValue] < self.totalPrice) {
                NSMutableArray *typeArray = [NSMutableArray array];
                for (NSDictionary *tempDic in cartArr) {
                    if ([[tempDic objectForKey:@"type"]isEqualToString:@"goods"]) {
                        [typeArray addObject:@"goods"];
                    }
                    if ([[tempDic objectForKey:@"type"]isEqualToString:@"card_course"]) {
                        [typeArray addObject:@"card_course"];
                    }
                    if ([[tempDic objectForKey:@"type"]isEqualToString:@"card_time"]) {
                        [typeArray addObject:@"card_time"];
                    }
                    if ([[tempDic objectForKey:@"type"]isEqualToString:@"ticket"]) {
                        [typeArray addObject:@"ticket"];
                    }
                }
                if (typeArray.count>0) {
                     [[[XMHSuccessAlertView alloc]initWithTitle:@"您的订单里包含不能分期商品，请重新下单"]show];
//                    [MzzHud toastWithTitle:@"提示" message:@"您的订单里包含不能分期商品，请重新下单"];
                }else{

                     [dic setValue:model.data.token?model.data.token:@"" forKey:@"token"];
                    //跳转到支付界面
                    XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc]init];
                    vc.customer = self.customer;
                    [vc setOrderDic:dic withType:6 andYemianStyle:YemianFenQi wiTitle:@"支付"];
                    [self.navigationController pushViewController:vc animated:NO];
                }
                
            }else{
                [[[XMHSuccessAlertView alloc]initWithTitle:@"订单金额不能小于应付金额"]show];
//                [MzzHud toastWithTitle:@"提示" message:@"订单金额不能小于应付金额"];
            }
        }
    }else{
      
        [XMHSaleOrderRequest summitSaleOrderParams:parmsdic resultBlock:^(NSDictionary *dic, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
            if (isSuccess) {
                self.ordernum = [dic safeObjectForKey:@"ordernum"];; //只用于形成一个订单,获取到的订单号在首页会用
                
                [self showAleartView];
                // 顾客没有归属技师
                if (![_customer isUserExistJishi]) {
                    // 顾客属于技师归属门店
                    NSString *store_code = [ShareWorkInstance shareInstance].share_join_code.store_code;
                    if ([store_code isEqualToString:_customer.store_code]) {
                        [[[XMHSuccessAlertView alloc]initWithTitle:@"是否绑定该顾客？" cancelButtonTitle:@"是" otherButtonTitles:@"否" click:^(NSInteger index) {
                            if (index == 0) {
                                LolUserInfoModel *model = [UserManager getObjectUserDefaults:userLogInInfo];
                                
                                NSMutableDictionary *params = NSMutableDictionary.new;
                                params[@"token"] = model.data.token;
                                params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
                                params[@"store_code"] = store_code; // 门店归属
                                params[@"user_id"] = @(_customer.uid).stringValue;
                                [XMHExperienceOrderRequest requestBangJisParams:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess) {
                                    [SVProgressHUD setInfoImage:UIImageName(@"1")];
                                    [SVProgressHUD showInfoWithStatus:isSuccess ? @"绑定成功" : @"绑定失败"];
                                }];
                            }
                        }] show];
                    }
                }
            };
        }];
    }
}

// 线上结算
- (void)onlineBtnClick:(UIButton *)sender {
    // 创建订单
    __weak typeof(self) _self = self;
    [self jieSuanComplete:^(NSDictionary *dic) {
        __strong typeof(_self) self = _self;
        NSString *shareUrl = [dic safeObjectForKey:@"share_url"];
        // 分享订单
        XMHSharedAlertVC *shareVC = XMHSharedAlertVC.new;
        shareVC.shareUrl = shareUrl;
        [self presentViewController:shareVC animated:YES completion:nil];
        [shareVC setShareResultBlock:^(BOOL cuccess) {
            __strong typeof(_self) self = _self;
            [[[MzzHud alloc]initWithTitle:@"" message:cuccess ? @"分享成功" : @"分享失败" centerButtonTitle:@"确认" click:^(NSInteger index) {
                // 返回首页
                [self backHomeVC];
            }]show];
        }];
    }];
}

/**
 线上结算提交订单

 @param complete 结算业务逻辑完回调
 */
- (void)jieSuanComplete:(void(^)(NSDictionary *dic))complete {
    /*处理数据获取单号
     1.结算数据
     
     */
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    // 业绩归属
    [dic setValue:self.computeOrderAchievementModel.yeJGuiShuModel.belong ? self.computeOrderAchievementModel.yeJGuiShuModel.belong :@"" forKey:@"belong"];
    //店长归属 传电话号
    [dic setValue:self.computeOrderAchievementModel.dianZhangModel.account forKey:@"dianzhang"];
    // 备注
    [dic setValue:self.textViewContent ? self.textViewContent :@"" forKey:@"content"];
    Join_Code *join_Code =  [ShareWorkInstance shareInstance].share_join_code;
    [dic setValue:join_Code forKey:@"fram_id"];
    
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
    
    //选业绩归属,则必选员工归属
    // 提示框
    if ([self.computeOrderAchievementModel.yeJGuiShuModel.belong integerValue]) {
        
        if (!guishuArr.count) {
            [[[XMHSuccessAlertView alloc]initWithTitle:@"业绩归属未填写"]show];
            //                [MzzHud toastWithTitle:@"提示" message:@"请选择员工归属" ];
            return;
        }
        //技师业绩总额和应付金额做对比
        if (allBfb != self.totalPrice) {
            [[[XMHSuccessAlertView alloc]initWithTitle:@"业绩归属总计不等于应付金额，请重新分配" ]show];
            //                [MzzHud toastWithTitle:@"提示" message:@"业绩归属总计不等于应付金额，请重新分配" ];
            return;
        }
    }
    
    // 奖赠 转换成符合接口的格式
    //奖赠数据里有一个假数据,因此必须先删除
    if (_awardModelArr.count >= 1) {
        [_awardModelArr removeObjectAtIndex:0];
    }
    NSMutableArray *awardList = [NSMutableArray array];
    for (SaleModel *model in _awardModelArr) {
        NSMutableDictionary *modeldic = [NSMutableDictionary dictionary];
        [modeldic setObject:model.code?model.code:@"" forKey:@"code"];
        [modeldic setObject:[NSString stringWithFormat:@"%ld",(long)model.uid]?[NSString stringWithFormat:@"%ld",(long)model.uid]:@"" forKey:@"id"];
        [modeldic setObject:model.name?model.name:@"" forKey:@"name"];
        [modeldic setObject:[NSString stringWithFormat:@"%ld",(long)model.mzzAwardCount]?[NSString stringWithFormat:@"%ld",(long)model.mzzAwardCount]:@"" forKey:@"num"];
        [modeldic setObject:[NSString stringWithFormat:@"%ld",(long)model.mzzAwardTotlePrice]?:@"" forKey:@"price"];
        [modeldic setObject:model.cardType?model.cardType:@"" forKey:@"type"];
        [modeldic setObject:model.unit?model.unit:@"" forKey:@"uint"];
        [awardList safeAddObject:modeldic];
    }
    [dic setValue:awardList forKey:@"award"];
    // inper
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * inper = infomodel.data.account;
    [dic setValue:inper forKey:@"inper"];
    
    
    //当前用户的门店code
    [dic setValue:[ShareWorkInstance shareInstance].share_join_code.store_code ? [ShareWorkInstance shareInstance].share_join_code.store_code :@""  forKey:@"store_code"];
    //当前登陆人的fram_id
    [dic setValue:@(join_Code.fram_id) forKey:@"fram_id"];
    //用户ID
    [dic setValue:@(self.customer.uid) forKey:@"user_id"];
    
    // 厂家业绩 厂家业绩 0不算 1算
    if (self.computeOrderAchievementModel.changJiaYeji == YES) {
        [dic setValue:@"1" forKey:@"changjia"];
    }else{
        [dic setValue:@"0" forKey:@"changjia"];
    }
    
    //cart array 购买内容数组
    NSMutableArray *cartArr = [NSMutableArray array];
    NSInteger gai_price_pro = 0;
    for (SaleModel *model in self.saleModelList) {
        if (model.gai_price) {
            gai_price_pro = 1;
            break;
        }
    }
    
    for (SaleModel *model in self.saleModelList) {
        
        NSString *longshouStr = [NSString stringWithFormat:@"%.2f",[model.lingshouMoney floatValue]];
        
        NSMutableDictionary *ticket = [NSMutableDictionary dictionary];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.name?model.name:@"" forKey:@"name"];
        [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
        [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
        [dic setValue:model.code?model.code:@"" forKey:@"code"];
        [dic setValue:model.ciShu?model.ciShu:@"" forKey:@"pro_num"];
        [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
        [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
        [dic setValue:model.inputPrice?model.inputPrice:@"" forKey:@"q_money"];
        [dic setValue:model.sastoreCardModel.code?model.sastoreCardModel.code:@"" forKey:@"store_card"];
        if ([model.cardType isEqualToString:@"pro"]) {// 项目
            /**默认传0，使用会员优惠：cp_discount不是0 传1 否则传2 ，要是改价格传3 =======2019.5.8新添*/
            NSInteger price_type = 0;
            if (model.sastoreCardModel && model.xm_discount != 0) {
                price_type = 1;
            }
            if (model.sastoreCardModel && model.xm_discount == 0) {
                price_type = 2;
            }
            if (model.gai_price == 1) {
                price_type = 3;
            }
            
            //单次零售价
            NSMutableArray *coursePriceArr = [NSMutableArray array];
            [coursePriceArr safeAddObject:model.price_list.pro_11.price];
            //疗程成交价
            NSArray *lingShouArr = [model.price_list.pro_21.price componentsSeparatedByString:@","];
            [coursePriceArr safeAddObjectsFromArray:lingShouArr];
            NSString *singlePrice = [coursePriceArr safeObjectAtIndex:model.courseIndex];
            
            CGFloat yPrice = [singlePrice floatValue] * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
            
            if (model.staicketModel.type == 1) {
                [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",(long)model.staicketModel.uid]:@"0" forKey:@"ticket"];
            }else{
                [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",(long)model.staicketModel.uid]:@"" forKey:@"ticket_coupon_id"];
            }
            
            [ticket setValue:model.staicketModel.code forKey:@"code"];
            [ticket setValue:model.staicketModel.price forKey:@"money"];
            [ticket setValue:model.staicketModel.name forKey:@"name"];
            [dic setValue:ticket forKey:@"ticketArray"];
            
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"goods"]){
            /**默认传0，使用会员优惠：cp_discount不是0 传1 否则传2 ，要是改价格传3 =======2019.5.8新添*/
            NSInteger price_type = 0;
            if (model.sastoreCardModel && model.cp_discount != 0) {
                price_type = 1;
            }
            if (model.sastoreCardModel && model.cp_discount == 0) {
                price_type = 2;
            }
            if (model.gai_price == 1) {
                price_type = 3;
            }
            NSString *singlePrice = model.price_list.pro_11.price;
            CGFloat yPrice = [singlePrice floatValue] * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
            
            if (model.staicketModel.type == 1) {
                [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",(long)model.staicketModel.uid]:@"" forKey:@"ticket"];
            }else{
                [dic setValue:model.staicketModel.code?[NSString stringWithFormat:@"%ld",(long)model.staicketModel.uid]:@"" forKey:@"ticket_coupon_id"];
            }
            [ticket setValue:model.staicketModel.code forKey:@"code"];
            [ticket setValue:model.staicketModel.price forKey:@"money"];
            [ticket setValue:model.staicketModel.name forKey:@"name"];
            [dic setValue:ticket forKey:@"ticketArray"];
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"card_course"]){
            [dic removeAllObjects];
            /**默认传0，使用会员优惠：cp_discount不是0 传1 否则传2 ，要是改价格传3 =======2019.5.8新添*/
            NSInteger price_type = 0;
            
            if (model.gai_price == 1) {
                price_type = 3;
            }
            NSString *singlePrice = model.price_list.pro_11.price;
            CGFloat yPrice = [singlePrice floatValue] * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
            
            [dic setValue:model.name forKey:@"name"];
            [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
            [dic setValue:model.code?model.code:@"" forKey:@"code"];
            [dic setValue:@"0" forKey:@"award_xf"];
            [dic setValue:longshouStr?longshouStr:@"" forKey:@"q_money"];
            
            NSMutableArray *rangArr = [[NSMutableArray alloc]init];
            NSDictionary *rootDic = [model.baohanJsonStr dictionaryWithJsonString:model.baohanJsonStr];
            NSArray *arr1 = rootDic[@"guding"];
            NSArray *arr2 = rootDic[@"daixuan"];
            if (arr1.count) {
                for (NSMutableDictionary *dic in arr1) {
                    [dic removeObjectForKey:@"rights"];
                    dic[@"group_map"] = @"";
                    [rangArr addObject:dic];
                }
            }
            if (arr2.count) {
                for (NSMutableDictionary *dic in arr2) {
                    [dic removeObjectForKey:@"rights"];
                    dic[@"group_map"] = @"";
                    [rangArr addObject:dic];
                }
            }
            [dic setValue:rangArr forKey:@"range"];
            [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
            [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
            
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"card_time"]){// 时间卡
            [dic removeAllObjects];
            NSInteger price_type = 0;
            
            if (model.gai_price == 1) {
                price_type = 3;
            }
            NSString *singlePrice = model.price_list.pro_11.price;
            CGFloat yPrice = [singlePrice floatValue] * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
            [dic setValue:model.name forKey:@"name"];
            [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
            [dic setValue:model.code?model.code:@"" forKey:@"code"];
            [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
            [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
            [dic setValue:longshouStr?longshouStr:@"" forKey:@"q_money"];
            [dic setValue:model.sastoreCardModel.code?model.sastoreCardModel.code:@"" forKey:@"store_card"];
            [dic setValue:@(0) forKey:@"price_type"];
            [dic setValue:@([model computeTotalPrice]) forKey:@"y_price"];
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"card_num"] || [model.cardType isEqualToString:@"stored_card"]){//任选卡||储值卡
            
            [dic removeAllObjects];
            NSInteger price_type = 0;
            
            if (model.gai_price == 1) {
                price_type = 3;
            }
            
            CGFloat singlePrice = [model.price_list.pro_11.price floatValue];
            if ([model.cardType isEqualToString:@"stored_card"]) {
                singlePrice = [model.price_list.pro_10.price floatValue];
            }
            CGFloat yPrice = singlePrice * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
            
            [dic setValue:model.name forKey:@"name"];
            [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
            [dic setValue:model.code?model.code:@"" forKey:@"code"];
            [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
            [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
            [dic setValue:longshouStr?longshouStr:@"" forKey:@"q_money"];
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"ticket"]){// 票券
            [dic removeAllObjects];
            NSInteger price_type = 0;
            if (model.gai_price == 1) {
                price_type = 3;
            }
            
            CGFloat singlePrice = [model.price_list.pro_11.price floatValue];
            CGFloat yPrice = singlePrice * model.selectCount;
            NSString *yPriceStr = [NSString stringWithFormat:@"%.2f",yPrice];
            [dic setValue:@(price_type) forKey:@"price_type"];
            [dic setValue:yPriceStr forKey:@"y_price"];
            
            [dic setValue:model.name forKey:@"name"];
            [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
            [dic setValue:model.code?model.code:@"" forKey:@"code"];
            [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
            [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
            [dic setValue:longshouStr?longshouStr:@"" forKey:@"q_money"];
            
            [cartArr addObject:dic];
        }else if ([model.cardType isEqualToString:@"skxk"]){//续卡充值
            
            [dic removeAllObjects];
            [dic setValue:@(0) forKey:@"price_type"];//后台确认
            [dic setValue:model.name forKey:@"name"];
            [dic setValue:@([model computeTotalPrice])?@([model computeTotalPrice]):@"" forKey:@"price"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"count"];
            [dic setValue:[NSString stringWithFormat:@"%@",@(model.selectCount)] forKey:@"num"];
            [dic setValue:model.code?model.code:@"" forKey:@"code"];
            [dic setValue:model.cardType?model.cardType:@"" forKey:@"type"];
            [dic setValue:model.type_name?model.type_name:@"" forKey:@"typeName"];
            
            
            [cartArr addObject:dic];
        }
    }
    
    [dic setValue:@(gai_price_pro)?@(gai_price_pro):@"0" forKey:@"gai_price"];
    [dic setValue:[ShareWorkInstance shareInstance].join_code ? [ShareWorkInstance shareInstance].join_code:@"" forKey:@"join_code"];
    [dic setValue:cartArr forKey:@"cart"];
    dic[@"share"] = @"1"; // share 是否是分享单，1 是 0 不是 默认 0
    
    NSString *str = dic.jsonData;
    
    NSMutableDictionary *parmsdic = [[NSMutableDictionary alloc]init];
    [parmsdic setValue:str forKey:@"result"];
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    [parmsdic setValue:joinCode forKey:@"join_code"];
    
    [XMHSaleOrderRequest summitSaleOrderParams:parmsdic resultBlock:^(NSDictionary *dic, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            self.ordernum = [dic safeObjectForKey:@"ordernum"]; //只用于形成一个订单,获取到的订单号在首页会用
            
//            [self showAleartView];
            // 顾客没有归属技师
            if (![_customer isUserExistJishi]) {
                // 顾客属于技师归属门店
                NSString *store_code = [ShareWorkInstance shareInstance].share_join_code.store_code;
                if ([store_code isEqualToString:_customer.store_code]) {
                    [[[XMHSuccessAlertView alloc]initWithTitle:@"是否绑定该顾客？" cancelButtonTitle:@"是" otherButtonTitles:@"否" click:^(NSInteger index) {
                        if (index == 0) {
                            LolUserInfoModel *model = [UserManager getObjectUserDefaults:userLogInInfo];
                            
                            NSMutableDictionary *params = NSMutableDictionary.new;
                            params[@"token"] = model.data.token;
                            params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
                            params[@"store_code"] = store_code; // 门店归属
                            params[@"user_id"] = @(_customer.uid).stringValue;
                            [XMHExperienceOrderRequest requestBangJisParams:params resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess) {
                                [SVProgressHUD setInfoImage:UIImageName(@"1")];
                                [SVProgressHUD showInfoWithStatus:isSuccess ? @"绑定成功" : @"绑定失败"];
                            }];
                        }
                        if (complete) complete(dic);
                    }] show];
                } else {
                    if (complete) complete(dic);
                }
            } else {
                if (complete) complete(dic);
            }
        };
    }];
}

- (void)backHomeVC {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[XMHNormalOrderManagementVC class]]) {
            [self.navigationController popToViewController:temp animated:NO];
        }
    }
}

- (void)showAleartView
{
    [[[XMHSuccessAlertView alloc]initWithTitle:@"创建订单成功!" cancelButtonTitle:@"返回首页" otherButtonTitles:@"查看详情" click:^(NSInteger index) {
        [XMHShoppingCartManager.sharedInstance clear];
        if (index ==0) {
            [self backHomeVC];
        }else{
           
            for (UIViewController *temp in self.navigationController.viewControllers) {
//                if ([temp isKindOfClass:[XMHSalesOrderVC class]]) {
//                    XMHSalesOrderVC *vc =  (XMHSalesOrderVC *)temp;
//                    vc.selectModel = self.customer;
//
//                    [self.navigationController popToViewController:vc animated:NO];
//                }
                if ([temp isKindOfClass:[XMHNormalOrderManagementVC class]]) {

                    [XMHSaleOrderRequest requestSalesInfoOrderNum:self.ordernum resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                        NSDictionary *dic = result;
                        XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc]init];
                        [vc setOrderNum:self.ordernum andYemianStyle:YemianXiangQing andType:[dic[@"order_type"] integerValue]  andUid:dic[@"user_id"] withName:@""];
                        __weak typeof(self) _self = self;
                        vc.popToOrderMainPageVC = ^{
                            __strong typeof(_self) self = _self;
                            [self.navigationController popToViewController:temp animated:NO];
                        };
                        [self.navigationController pushViewController:vc animated:NO];
                    }];
                }
            }
        }
    }] show];

}

#pragma mark -Notifi
- (void)changeTotalPrice:(NSNotification *)notification
{
    self.totalPrice = [notification.userInfo[@"totalPrice"] floatValue];
}
@end
