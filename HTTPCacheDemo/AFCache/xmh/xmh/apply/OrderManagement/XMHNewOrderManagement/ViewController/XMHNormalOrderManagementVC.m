//
//  XMHNormalOrderManagementVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHNormalOrderManagementVC.h"
#import "XMHOrderIconCollectionView.h"
#import "ABSegmentTitleView.h"
#import "XMHOrderListBaseCell.h"
#import "SaleListRequest.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "XMHExperienceOrderVC.h"
#import "XMHBillRecoveryVC.h"
#import "XMHOrderExamineDetailWebView.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "XMHSalesOrderVC.h"
#import "XMHExperienceOrderRecordVC.h"
#import "FWDDetailViewController.h"
#import "XMHComputeOrderLastVC.h"
#import "SLRequest.h"
#import "MzzJiSuanViewController.h"
#import "XMHServiceOrderVC.h"
#import "XMHServiceOrderDetailWebViewVC.h"
#import "XMHNewMzzJiSuanViewController.h"
#import "MzzCustomerDetailsController.h"
#import "RolesTools.h"
#import "CustomerListModel.h"
#import "MzzCustomerRequest.h"
#import "MzzStoreModel.h"
#import "XMHCustomerInfoView.h"
#import "XMHCredentiaManageVenditionVC.h"
#import "OrderReverseViewController.h"
#import "SaleListRequest.h"
#import "XMHBuYeJiVC.h"
#import "XMHOrderSaleBuYeJiVC.h"

#import "XMHSaleOrderViewController.h"
#import "XMHSeverOrderViewController.h"
#import "XMHSaleOrderRequest.h"
#import "XMHServiceRequest.h"
#import "XMHSuccessAlertView.h"
#import "XMHCredentiaSalesOrderMdoel.h"
#import "XMHCredentiaServiceOrderMdoel.h"

@interface XMHNormalOrderManagementVC ()<UIScrollViewDelegate>
{
    NSInteger _order_type;//列表状态：0=>'全部' 1=>'待付款',10=>'已收款',5=>'未付清','6'=>'已完成'
    NSInteger _listPageIndex;
}
@property(nonatomic, strong) NSMutableArray *dataArr;

@property(nonatomic, assign) NSInteger listPageIndex;
/** <##> */
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, copy) NSString *storeCode;// 门店编码
/** <##> */
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) XMHSaleOrderViewController *saleVc;
@property (nonatomic, strong) XMHSeverOrderViewController *severVc;
@property (nonatomic, strong) XMHSuccessAlertView *alertView;
@end

@implementation XMHNormalOrderManagementVC

- (void)dealloc
{
    MzzLog(@"XMHNormalOrderManagementVC dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.navView setNavViewTitle:@"订单管理" backBtnShow:YES];
    _listPageIndex = 1;//默认1
    self.dataArr = [NSMutableArray array];

    [self getCustomerStoreCode];
    [self createSubViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestNumsList];
    [self requestAccessAlert];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"GengXinOrderData" object:nil];
}
- (void)requestAccessAlert
{
    Join_Code *join_Code =  [ShareWorkInstance shareInstance].share_join_code;
    NSString *join_code = join_Code.code;
    LolUserInfoModel *LolUserInfoModelmodel = [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *inId =  LolUserInfoModelmodel.data.account;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    [params setValue:token forKey:@"token"];
    [params setValue:join_code forKey:@"join_code"];
    [params setValue:@(1) forKey:@"type"];
    [params setValue:inId forKey:@"inId"];
    
    [XMHSaleOrderRequest requestSalesListAccessAlertParams:params resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            NSInteger count = [result[@"count"] integerValue];
            if (count > 0) {
                if (!_alertView) {
                    _alertView = [[XMHSuccessAlertView alloc]initWithTitle:@" 您有未补齐的订单请去凭证管理里进行补齐"];
                    [_alertView show];
                }
            }
        }
    }];
    
   
    [params setValue:@(2) forKey:@"type"];
    [XMHSaleOrderRequest requestSalesListAccessAlertParams:params resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            NSInteger count = [result[@"count"] integerValue];
            if (count > 0) {
                if (!_alertView) {
                    _alertView = [[XMHSuccessAlertView alloc]initWithTitle:@" 您有未补齐的订单请去凭证管理里进行补齐"];
                    [_alertView show];
                }
//                [[[XMHSuccessAlertView alloc]initWithTitle:@" 您有未补齐的订单请去凭证管理里进行补齐"]show];
            }
        }
    }];
    
}
- (void)requestNumsList
{
    //默认显示今天
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *start = [dateFormatter stringFromDate:[NSDate date]];
    NSString *end = start;

    Join_Code *join_Code =  [ShareWorkInstance shareInstance].share_join_code;
    NSInteger fram_id = join_Code.fram_id;
    NSString *startTime = start;
    NSString *endTime = end;
    NSString *join_code = join_Code.code;
    LolUserInfoModel *LolUserInfoModelmodel = [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *inId =  LolUserInfoModelmodel.data.account;
    // 全部-待付款-已收款-未还清-已完成
    NSMutableArray *bagesArr = [NSMutableArray array];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    [params setValue:token forKey:@"token"];
    [params setValue:@(fram_id) forKey:@"fram_id"];
    [params setValue:startTime forKey:@"startTime"];
    [params setValue:endTime forKey:@"endTime"];
    [params setValue:join_code forKey:@"join_code"];
    [params setValue:inId forKey:@"inId"];
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
            self.saleVc.titleView.bagesArr = bagesArr;
            [self.saleVc.tableView reloadData];
        }
    }];
    
    NSMutableArray *bagesArr1 = [NSMutableArray array];
    [XMHServiceRequest requestSeverListNumParams:params resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        NSString *ywcNum = [result safeObjectForKey:@"ywc"];
        NSString *yjsNum = [result safeObjectForKey:@"yjs"];
        NSString *djsNum = [result safeObjectForKey:@"djs"];
        NSString *qbNum = [result safeObjectForKey:@"qb"];
        [bagesArr1 safeAddObject:qbNum];
        [bagesArr1 safeAddObject:djsNum];
        [bagesArr1 safeAddObject:yjsNum];
        [bagesArr1 safeAddObject:ywcNum];
        self.severVc.titleView.bagesArr = bagesArr1;
       [self.severVc.tableView reloadData];
    }];
    
    
    
}
- (void)createSubViews
{
    WeakSelf
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 90)];
    // 添加菜单
    NSArray *images = @[@"order_SalesVoucher",@"order_fuwuzhidan",@"order_tiyanzhidan",@"order_BillRecycling",@"order_zhidanguanli"];
    NSArray *titles = @[@"销售制单",@"服务制单",@"体验制单",@"账单回收",@"制单管理"];//@"快速开单",只有前台才能快速开单,,@"order-kuaisukaidan"
    // 主角色 - 1管理层，2财务人员，3店经理，4技术店长，5销售店长，6售前店长，7前台，8售后美容师，9售前美容师，10售中美容师，11导购
    
    if([RolesTools orderReverseFlowPush]){
        titles = @[@"账单回收",@"制单管理"];//@"快速开单", 测试bug称: 这期不上
        images = @[@"order_BillRecycling",@"order_zhidanguanli"];//@"order-kuaisukaidan",
    }
    //菜单栏
    XMHOrderIconCollectionView *headerIconView = [[XMHOrderIconCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90) images:images titles:titles];
    headerIconView.menViewClickTitle = ^(NSString *title) {
        [weakSelf menViewClickTitle:title];
    };
    headerIconView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:headerIconView];
    [self.view addSubview:headView];
    
    //segmentView
    UIView *segmentView = [[UIView alloc]initWithFrame:CGRectMake(0, headerIconView.bottom +10 + Heigh_Nav, SCREEN_WIDTH, 64)];
    segmentView.backgroundColor = [UIColor whiteColor];
    NSArray *array = [NSArray arrayWithObjects:@"今日销售制单",@"今日服务制单", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    self.segment = segment;
    //设置frame
    segment.frame = CGRectMake(80, 15, SCREEN_WIDTH - 2 * 80, 34);
    segment.selectedSegmentIndex = 0;
    segment.tintColor = kBtn_Commen_Color;
    segment.layer.masksToBounds = YES;
    segment.layer.cornerRadius = 5;
    segment.layer.borderWidth = 1;
    segment.layer.borderColor = kBtn_Commen_Color.CGColor; // 边框颜色
    [segment addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
    [segmentView addSubview:segment];
    [self.view addSubview:segmentView];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = Separator_LineColor;
    [segmentView addSubview:line];
    
    //内容
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,segmentView.bottom  ,SCREEN_WIDTH , self.view.frame.size.height - segmentView.bottom)];
    [self.view addSubview:_contentScrollView];
    _contentScrollView.delegate = self;
    _contentScrollView.scrollsToTop = NO;
    _contentScrollView.scrollEnabled = NO;
    _saleVc = [[XMHSaleOrderViewController alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height - segmentView.bottom)];
    _saleVc.saleOrderNavigationController = self.navigationController;
    _saleVc.didSelectSaleModel = ^(XMHCredentiaSalesOrderMdoel * _Nonnull saleModel) {
        XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc]init];
        [vc setOrderNum:saleModel.ordernum andYemianStyle:YemianXiangQing andType:[saleModel.type integerValue] andUid:[NSString stringWithFormat:@"%ld",(long)saleModel.uid]withName:@""];
        [weakSelf.navigationController pushViewController:vc animated:NO];
    };
    _severVc = [[XMHSeverOrderViewController alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.view.frame.size.height - segmentView.bottom)];
    _severVc.severOrderNavigationController = self.navigationController;
       _severVc.didSelectSeverModel = ^(XMHCredentiaServiceOrderMdoel * _Nonnull severModel) {
        XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc]init];
        [vc setOrderNum:severModel.ordernum andZt:@"1"];
        [weakSelf.navigationController pushViewController:vc animated:NO];
       };
    NSMutableArray *contentArr = [NSMutableArray array];
    [contentArr addObject:_saleVc.view];
    [contentArr addObject:_severVc.view];

    for (int i = 0; i < contentArr.count; i ++) {
        UIView *view = contentArr[i];
        view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, self.view.frame.size.height - segmentView.bottom);
        [_contentScrollView addSubview:view];
    }
    _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, _contentScrollView.height);
    _contentScrollView.pagingEnabled = YES;
}

-(void)changeSegment:(UISegmentedControl *)sender
{
    [_contentScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * sender.selectedSegmentIndex , 0) animated:NO];
}

#pragma mark -- 头部菜单事件

-(void)menViewClickTitle:(NSString *)title{
    if ([title isEqualToString:@"销售制单"]) {
        XMHSalesOrderVC *vc = [[XMHSalesOrderVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"服务制单"]){
        XMHServiceOrderVC *vc = XMHServiceOrderVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"快速开单"]){
        OrderReverseViewController *vc = [[OrderReverseViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }else if ([title isEqualToString:@"体验制单"]){
        XMHExperienceOrderVC *vc = XMHExperienceOrderVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"账单回收"]){
        XMHBillRecoveryVC *recoverVC = [[XMHBillRecoveryVC alloc]init];
        [self.navigationController pushViewController:recoverVC animated:YES];
    }else if ([title isEqualToString:@"制单管理"]){
        XMHCredentiaManageVenditionVC *vc = XMHCredentiaManageVenditionVC.new;
        vc.fram_id = @([ShareWorkInstance shareInstance].share_join_code.fram_id).stringValue;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - request
/**
 获取门店编码
 */
-(void)getCustomerStoreCode
{
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    //门店归属
    [MzzCustomerRequest requestStoreListParams:parms resultBlock:^(MzzStoreList *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            MzzStoreList *storeList = listModel;
            MzzStoreModel *selectStoreModel = storeList.list[0];
            self.storeCode = selectStoreModel.store_code;
        }
    }];
}
#pragma mark - Public

/**
 切换制单

 @param index 0 销售制单 1 服务制单
 */
- (void)selectedSegmentIndex:(NSInteger)index {
    if (index > 1) return;
    self.segment.selectedSegmentIndex = index;
}
#pragma mark -- UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取滚动位置
    //页码
    int page= scrollView.contentOffset.x/scrollView.frame.size.width;
    self.segment.selectedSegmentIndex = page;
}
@end
