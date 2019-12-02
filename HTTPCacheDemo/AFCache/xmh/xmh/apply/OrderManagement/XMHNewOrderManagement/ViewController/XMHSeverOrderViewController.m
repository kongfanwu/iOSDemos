//
//  XMHSeverOrderViewController.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSeverOrderViewController.h"
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
#import "SLRequest.h"
#import "XMHBuYeJiVC.h"
#import "XMHServiceRequest.h"
#import "XMHCredentiaServiceOrderMdoel.h"
#import "XMHCredentiaManageVenditionServiceCell.h"
#import "GKGLCustomerDetailVC.h"
#import "XMHBaseTableView.h"
#import "XMHRefreshGifHeader.h"
@interface XMHSeverOrderViewController ()<UITableViewDelegate,UITableViewDataSource,ABSegmentTitleViewDelegate>
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

@implementation XMHSeverOrderViewController

- (void)dealloc
{
    MzzLog(@"XMHSeverOrderViewController dealloc");
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
    [self creatHeadView];
    _tableView = [[XMHBaseTableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, self.frame.size.height - 44) style:UITableViewStylePlain];
    _tableView.backgroundColor = kBackgroundColor;
    _tableView.emptyEnable = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100.f;
    [self.view addSubview:_tableView];
//    [_tableView registerNib:[UINib nibWithNibName:@"XMHOrderListBaseCell" bundle:nil] forCellReuseIdentifier:@"XMHOrderListBaseCell"];
  
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
    NSMutableArray *segmentTitleArr = [NSMutableArray arrayWithObjects:@"全部",@"待结算",@"已结算",@"已完成", nil];
    self.titleView = [[ABSegmentTitleView alloc]initWithFrame:headView.bounds titles:[segmentTitleArr copy] delegate:self];
    self.titleView.titleNormalColor = kLabelText_Commen_Color_6;
    self.titleView.titleSelectColor = kBtn_Commen_Color;
    self.titleView.indicatorColor = kBtn_Commen_Color;
    self.titleView.selectIndex = 0;
    self.titleView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:self.titleView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleView.bottom, SCREEN_WIDTH, 10)];
    lineView.backgroundColor = RGBColor(241,241,241);
    [headView addSubview:lineView];
    [self.view addSubview:headView];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHCredentiaServiceOrderMdoel *model = _dataArr[indexPath.row];
    XMHCredentiaManageVenditionServiceCell *cell = [XMHCredentiaManageVenditionServiceCell createCellWithTable:tableView];
    [cell configureWithModel:model];
    __weak typeof(self) _self = self;
    cell.didSelectClickBlock = ^(XMHCredentiaManageVenditionServiceCell * _Nonnull cell, XMHCredentiaOrderStateItemModel *credentiaOrderStateItemModel) {
        __strong typeof(_self) self = _self;
        [self didSelectToolActionTableView:self.tableView type:1 model:model toolItemModel:credentiaOrderStateItemModel];
    };
    return cell;

}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XMHCredentiaServiceOrderMdoel *severModel =  [self.dataArr safeObjectAtIndex:indexPath.row];
    if (_didSelectSeverModel) {
        _didSelectSeverModel(severModel);
    }
}

#pragma mark -- ABSegmentTitleViewDelegate
- (void)ABSegmentTitleView:(ABSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
   //服务凭证列表状态： 0全部，1待结算，2已结算，3已完成
    _order_type = endIndex;
    self.listPageIndex = 1;
    [self.dataArr removeAllObjects];
    [self requestListData];
}

#pragma mark -- cell上按钮对应事件

/**
 点击工具按钮回调
 
 @param type 类型
 @param model cell model
 */
- (void)didSelectToolActionTableView:(UITableView *)tableview type:(XMHCredentiaItemViewType)type model:(id)model toolItemModel:(XMHCredentiaOrderStateItemModel *)toolItemModel {
    XMHCredentiaServiceOrderMdoel *serviceModel = (XMHCredentiaServiceOrderMdoel *)model;
    switch (toolItemModel.tag) {
            // 查看账单
        case XMHOrderFunctionTypeLookZhangDan: {
            [self orderDetailOrderModel:serviceModel];
            break;
        }
            // 撤销
        case XMHOrderFunctionTypeCheXiao: {
            [self repealOrderModel:serviceModel];
            break;
        }
            // 补齐业绩
        case XMHOrderFunctionTypeBuQiYeJi: {
            [self buYeJiOrderModel:serviceModel];
            break;
        }
            // 结算
        case XMHOrderFunctionTypeJieSuan: {
            [self computeOrderModel:serviceModel];
            break;
        }
            // 服务记录
        case XMHOrderFunctionTypeFuWuJiLu: {
            [self serverRecordOrderModel:serviceModel];
            break;
        }
        default:
            break;
    }
}

/**
 账单
 */
- (void)orderDetailOrderModel:(XMHCredentiaServiceOrderMdoel *)orderModel {
    
    GKGLCustomerDetailVC * customerDetailVC = [[GKGLCustomerDetailVC alloc] init];
    customerDetailVC.userID = orderModel.user_id;
    [self.severOrderNavigationController pushViewController:customerDetailVC animated:YES];
}

/**
 撤销
 */
- (void)repealOrderModel:(XMHCredentiaServiceOrderMdoel *)orderModel {
   
    [[[MzzHud alloc]initWithTitle:@"确认撤销" message:[NSString stringWithFormat:@"确定要撤销已开好的单据吗？撤销后将不可恢复"] leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
        if (index ==1) {
            NSMutableDictionary * params = [NSMutableDictionary dictionary];
            params[@"id"] = orderModel.ID;
            [SLRequest requestServDelParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (model.code == 1) {
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
- (void)computeOrderModel:(XMHCredentiaServiceOrderMdoel *)orderModel {
    XMHNewMzzJiSuanViewController *vc = [[XMHNewMzzJiSuanViewController alloc] init];
    [vc setOrderNum:orderModel.ordernum andZt:@"2"];
    [self.severOrderNavigationController pushViewController:vc animated:NO];
}


/**
 服务记录
 */
- (void)serverRecordOrderModel:(XMHCredentiaServiceOrderMdoel *)orderModel {
    XMHExperienceOrderRecordVC * next = [[XMHExperienceOrderRecordVC alloc] init];
    next.ordernum = orderModel.ordernum;
    [self.severOrderNavigationController pushViewController:next animated:NO];
}

/**
 补齐业绩
 */
- (void)buYeJiOrderModel:(XMHCredentiaServiceOrderMdoel *)orderModel {
 
    XMHBuYeJiVC *vc = XMHBuYeJiVC.new;
    vc.type = XMHBuYeJiVCTypeServiceOrderAndSalesServiceOrder;
    vc.ordernum = orderModel.ordernum;
    [self.severOrderNavigationController pushViewController:vc animated:YES];
}

#pragma mark - request
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
    NSString *inId =  LolUserInfoModelmodel.data.account;;
    [SaleListRequest requestOrderListSeverFram_id:fram_id startTime:startTime endTime:endTime join_code:join_code inId:inId zt:_order_type page:_listPageIndex searchText:nil resultBlock:^(NSArray *modelArr, BOOL isSuccess, NSDictionary *errorDic) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        if (isSuccess) {
            [weakSlef.tableView.mj_footer endRefreshing];
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
