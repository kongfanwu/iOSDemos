//
//  XMHSaleOrderViewController.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSaleOrderViewController.h"
#import "XMHOrderListBaseCell.h"
#import "ABSegmentTitleView.h"
#import "MzzCustomerDetailsController.h"
#import "SaleListRequest.h"
#import "XMHNewMzzJiSuanViewController.h"
#import "XMHExperienceOrderRecordVC.h"
#import "RolesTools.h"
#import "XMHSalesOrderVC.h"
#import "XMHOrderSaleBuYeJiVC.h"
#import "MzzCustomerRequest.h"
#import "MzzStoreModel.h"
#import "XMHSaleOrderRequest.h"
#import "XMHSuccessAlertView.h"
#import "XMHCredentiaManageVenditionSaleCell.h"
#import "XMHCredentiaSalesOrderMdoel.h"
#import "GKGLCustomerDetailVC.h"
#import "XMHBaseTableView.h"
#import "XMHRefreshGifHeader.h"
#import "XMHSharedAlertVC.h"

@interface XMHSaleOrderViewController ()<UITableViewDelegate,UITableViewDataSource,ABSegmentTitleViewDelegate>
{
    NSInteger _order_type;//列表状态：0=>'全部' 1=>'待付款',10=>'已收款',5=>'未付清','6'=>'已完成'
}

@property(nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy) NSString *storeCode;// 门店编码
@property (nonatomic, assign) NSInteger listPageIndex;
@property (nonatomic, assign) CGRect frame;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;

@end

@implementation XMHSaleOrderViewController

- (void)dealloc
{
    MzzLog(@"XMHSaleOrderViewController dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatHeadView];
    _tableView = [[XMHBaseTableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, self.frame.size.height - 44) style:UITableViewStylePlain];
    _tableView.emptyEnable = YES;
    _tableView.backgroundColor = kBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100.f;
    [self.view addSubview:_tableView];

    __weak typeof(self) _self = self;

    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(_self) self = _self;
        self.listPageIndex++;
        [self requestListData];
    }];
    _tableView.mj_header = self.gifHeader;
    _listPageIndex = 1;//默认1
    [self requestListData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestfirstPageListData) name:@"GengXinOrderData" object:nil];
}

-(void)creatHeadView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    // 添加字段view
    NSMutableArray *segmentTitleArr = [NSMutableArray arrayWithObjects:@"全部",@"待付款",@"已收款",@"未还清",@"已完成", nil];
    self.titleView = [[ABSegmentTitleView alloc]initWithFrame:headView.bounds titles:[segmentTitleArr copy] delegate:self];
    self.titleView.titleNormalColor = kLabelText_Commen_Color_6;
    self.titleView.titleSelectColor = kLabelText_Commen_Color_ea007e;
    self.titleView.indicatorColor = kBtn_Commen_Color;
    self.titleView.selectIndex = 0;
    self.titleView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:self.titleView];
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleView.bottom, SCREEN_WIDTH, 10)];
//    lineView.backgroundColor = RGBColor(241,241,241);
//    [headView addSubview:lineView];
    [self.view addSubview:headView];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XMHCredentiaSalesOrderMdoel * model = _dataArr[indexPath.row];
    
    XMHCredentiaManageVenditionSaleCell *cell = [XMHCredentiaManageVenditionSaleCell createCellWithTable:tableView];
    [cell configureWithModel:model];
    __weak typeof(self) _self = self;
    cell.didSelectClickBlock = ^(XMHCredentiaManageVenditionSaleCell * _Nonnull cell, XMHCredentiaOrderStateItemModel *credentiaOrderStateItemModel) {
        __strong typeof(_self) self = _self;
        [self didSelectToolActionTableView:self.tableView type:0 model:model toolItemModel:credentiaOrderStateItemModel];
    };
    return cell;
    
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XMHCredentiaSalesOrderMdoel *saleModel =  [self.dataArr safeObjectAtIndex:indexPath.row];
    if (_didSelectSaleModel) {
        _didSelectSaleModel(saleModel);
    }
    
}

#pragma mark -- cell上按钮对应事件

/**
 点击工具按钮回调
 
 @param type 类型
 @param model cell model
 */
- (void)didSelectToolActionTableView:(UITableView *)tableview type:(XMHCredentiaItemViewType)type model:(id)model toolItemModel:(XMHCredentiaOrderStateItemModel *)toolItemModel {
    
    XMHCredentiaSalesOrderMdoel *salesModel = (XMHCredentiaSalesOrderMdoel *)model;
    switch (toolItemModel.tag) {
            // 支付
        case XMHOrderFunctionTypePay: {
            [self computeOrderSaleModel:salesModel];
            break;
        }
            // 查看账单
        case XMHOrderFunctionTypeLookZhangDan: {
            [self orderDetailOrderSaleModel:salesModel];
            break;
        }
            // 撤销
        case XMHOrderFunctionTypeCheXiao: {
            [self repealOrdeSalerModel:salesModel];
            break;
        }
            // 补齐项目
        case XMHOrderFunctionTypeBuQiXiangMu: {
            [self buXiangMuOrderSaleModel:salesModel];
            break;
        }
            // 补齐业绩
        case XMHOrderFunctionTypeBuQiYeJi: {
           
            [self buYeJiOrderSaleModel:salesModel];
            break;
        }
            // 终止
        case XMHOrderFunctionTypeZhongZhi: {
            [self zhongzhiOrderModel:salesModel];
            break;
        }
            // 还款
        case XMHOrderFunctionTypeHuanKuan: {
            [self rePayOrderModel:salesModel];
            break;
        }
            // 分享
        case XMHOrderFunctionTypeShare:{
            XMHSharedAlertVC *shareVC = XMHSharedAlertVC.new;
            shareVC.shareUrl = salesModel.share_url;
            [kApp.window.rootViewController presentViewController:shareVC animated:YES completion:nil];
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

/**
 账单
 */

- (void)orderDetailOrderSaleModel:(XMHCredentiaSalesOrderMdoel *)orderModel{
    
    GKGLCustomerDetailVC * customerDetailVC = [[GKGLCustomerDetailVC alloc] init];
    customerDetailVC.userID = orderModel.user_id;
    [self.saleOrderNavigationController pushViewController:customerDetailVC animated:NO];
    NSLog(@"");
}

/**
 撤销
 */

- (void)repealOrdeSalerModel:(XMHCredentiaSalesOrderMdoel *)orderModel {
    
    [[[MzzHud alloc]initWithTitle:@"确认撤销" message:[NSString stringWithFormat:@"确定要撤销已开好的单据吗？撤销后将不可恢复"] leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
        if (index ==1) {
            [SaleListRequest requestDelSalesId:[NSString stringWithFormat:@"%@",orderModel.ID] resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    [MzzHud toastWithTitle:@"提示" message:@"撤销成功" complete:^{
                        [self.dataArr removeAllObjects];
                        _listPageIndex = 1;
                        [self requestListData];
                    }];
                }else{
                    [MzzHud toastWithTitle:@"提示" message:@"撤销失败"];
                }
            }];
        }
    } hiddenCancelBtn:YES]show];
}

/**
 结算
 */

- (void)computeOrderSaleModel:(XMHCredentiaSalesOrderMdoel *)orderModel {
    XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc] init];
    [vc setOrderNum:orderModel.ordernum andYemianStyle:YemianJieSuan andType:[orderModel.type integerValue] andUid:[NSString stringWithFormat:@"%ld",orderModel.uid]withName:@"结算"];
    [self.saleOrderNavigationController pushViewController:vc animated:NO];
}
/**
 服务记录
 */
- (void)serverRecordOrderModel:(XMHCredentiaSalesOrderMdoel *)orderModel {
    XMHExperienceOrderRecordVC * next = [[XMHExperienceOrderRecordVC alloc] init];
    next.ordernum = orderModel.ordernum;
    [self.saleOrderNavigationController pushViewController:next animated:NO];
}

/**
 补齐项目
 */

- (void)buXiangMuOrderSaleModel:(XMHCredentiaSalesOrderMdoel *)orderModel {
    if ([RolesTools orderReverseFlowPush]) {
        XMHSalesOrderVC *vc = [[XMHSalesOrderVC alloc]init];
        //已选顾客
        CustomerModel *customer = [[CustomerModel alloc]init];
        customer.mobile = orderModel.user_mobile;
        customer.uid = [orderModel.user_id integerValue];
        customer.uname = orderModel.user_name;
        vc.selectModel = customer;
        //商家编码
        vc.storeCode = self.storeCode;
        //应付金额、订单编码
        vc.yingfuPrice = orderModel.amount;
        vc.ordernum = orderModel.ordernum;
        [self.saleOrderNavigationController pushViewController:vc animated:NO];
    }else{
        //弹窗
        [XMHProgressHUD showOnlyText:@"您没有制单权限，请进行其他操作"];
    }
}

/**
 补齐业绩
 */
- (void)buYeJiOrderSaleModel:(XMHCredentiaSalesOrderMdoel *)orderModel
{
    XMHOrderSaleBuYeJiVC *vc= [[XMHOrderSaleBuYeJiVC alloc]init];
    vc.ordernum = orderModel.ordernum;
    CustomerModel *customer = [[CustomerModel alloc]init];
    customer.mobile = orderModel.user_mobile;
    customer.uid = [orderModel.user_id integerValue];
    customer.uname = orderModel.user_name;
    vc.customer = customer;
    vc.ordernum = orderModel.ordernum;
    [self.saleOrderNavigationController pushViewController:vc animated:NO];
}
/**
 终止
 */
- (void)zhongzhiOrderModel:(XMHCredentiaSalesOrderMdoel *)orderModel
{
    XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc] init];
    [vc setOrderNum:orderModel.ordernum andYemianStyle:YemianZhongZhi andType:[orderModel.type integerValue] andUid:[NSString stringWithFormat:@"%ld",(long)orderModel.uid]withName:@"终止"];
    [self.saleOrderNavigationController pushViewController:vc animated:NO];
}
/**
 还款
 */
- (void)rePayOrderModel:(XMHCredentiaSalesOrderMdoel *)orderModel
{
    XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc] init];
    [vc setOrderNum:orderModel.ordernum andYemianStyle:YemianHuanKuan andType:[orderModel.type integerValue] andUid:[NSString stringWithFormat:@"%ld",(long)orderModel.uid]withName:@"还款"];
    [self.saleOrderNavigationController pushViewController:vc animated:NO];
}


#pragma mark -- ABSegmentTitleViewDelegate
- (void)ABSegmentTitleView:(ABSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    [self.dataArr removeAllObjects];
    //销售凭证列表状态：0=>'全部' 1=>'待付款',10=>'已收款',5=>'未付清','6'=>'已完成'
    //服务凭证列表状态： 0全部，1待结算，2已结算，3已完成
    _order_type = endIndex;
    self.listPageIndex = 1;
    
    switch (endIndex) {
        case 0:
            _order_type = endIndex;
            break;
        case 1:
            _order_type = endIndex;
            break;
        case 2:
            _order_type = 10;
            break;
        case 3:
            _order_type = 5;
            break;
        case 4:
            _order_type = 6;
            break;
        default:
            break;
    }
    
    
    [self.dataArr removeAllObjects];
    _listPageIndex = 1;
    [self requestListData];
    
}
#pragma mark --请求

-(void)requestfirstPageListData
{
    _listPageIndex = 1;
    [self requestListData];
}

- (void)requestListData
{
    
  
    //默认显示今天
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *start = [dateFormatter stringFromDate:[NSDate date]];
    NSString *end = start;
    
    __weak typeof(self)weakSlef = self;
    Join_Code *join_Code =  [ShareWorkInstance shareInstance].share_join_code;
    NSInteger fram_id = join_Code.fram_id;
    NSString *startTime = start;
    NSString *endTime = end;
    NSString *join_code = join_Code.code;
    LolUserInfoModel *LolUserInfoModelmodel = [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *inId =  LolUserInfoModelmodel.data.account;
    
    [SaleListRequest requestOrderListSaleFram_id:fram_id startTime:startTime endTime:endTime join_code:join_code inId:inId order_type:_order_type page:_listPageIndex searchText:nil resultBlock:^(NSArray *modelArr, BOOL isSuccess, NSDictionary *errorDic) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            _tableView.mj_footer.hidden = !modelArr.count;
            if (_listPageIndex == 1) {
                self.dataArr = [modelArr mutableCopy];
            } else {
                [weakSlef.dataArr safeAddObjectsFromArray:modelArr];
            }
          
            [weakSlef.tableView reloadData];
        }
    }];
    
}

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
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestfirstPageListData];
        }];
    }
    return _gifHeader;
}
@end
