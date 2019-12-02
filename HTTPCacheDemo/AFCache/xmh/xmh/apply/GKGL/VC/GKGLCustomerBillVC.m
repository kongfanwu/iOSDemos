//
//  GKGLCustomerBillVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerBillVC.h"
#import "GKGLCustomerBillTopView.h"
#import "GKGLCustomerBillCell.h"
#import "GKGLCardDetailVC.h"
#import "CustomerBillViewController.h"
#import "GKGLCustomerBillDetailVC.h"
#import "MzzCustomerRequest.h"
#import "GKGLHomeCustomerListModel.h"
#import "GKGLBillListModel.h"
#import "GKGLMemberBenefitsVC.h"
#import "GKGLDiscountCouponVC.h"
#import "XMHRefreshGifHeader.h"
@interface GKGLCustomerBillVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)GKGLCustomerBillTopView *billTopView;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)GKGLBillListModel * billListModel;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation GKGLCustomerBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    [self initSubViews];
//    [self requestBillData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshTbData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"顾客账单" backBtnShow:YES];
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 95);
    self.logoView.backgroundColor = kColorTheme;
    self.logoView.image = nil;
    [self.view addSubview:self.billTopView];
    [self.view addSubview:self.tbView];
    
}
- (GKGLCustomerBillTopView *)billTopView
{
    WeakSelf
    if (!_billTopView) {
        _billTopView = loadNibName(@"GKGLCustomerBillTopView");
        _billTopView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 60);
        _billTopView.GKGLCustomerBillTopViewAddBillBlock = ^{
            CustomerBillViewController * customerBillVC = [[CustomerBillViewController alloc] init];
            customerBillVC.isNewGKGL = YES;
            CustomerModel * model = [[CustomerModel alloc]init];
            model.uid = weakSelf.customerModel.uid.integerValue;
            model.store_code = weakSelf.customerModel.store_code;
            customerBillVC.customerModel = model;
            [weakSelf.navigationController pushViewController:customerBillVC animated:NO];
        };
        _billTopView.GKGLCustomerBillTopViewCustomerOrderBlock = ^{
            GKGLCustomerBillDetailVC * customerBillDetailVC = [[GKGLCustomerBillDetailVC alloc] init];
            customerBillDetailVC.userid = weakSelf.customerModel.uid;
            [weakSelf.navigationController pushViewController:customerBillDetailVC animated:NO];
        };
    }
    return _billTopView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _billTopView.bottom + 15, SCREEN_WIDTH, SCREEN_HEIGHT - _billTopView.bottom - 15)];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        //        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //            [self requestMoreData];
        //        }];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self refreshTbData];
            });
        }];
    }
    return _gifHeader;
}
//- (void)requestMoreData
//{
//    _isMore = YES;
//    _page ++;
//    [self requestCustomerData];
//}
- (void)refreshTbData
{
    [self requestBillData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    static NSString * kGKGLCustomerBillCell = @"kGKGLCustomerBillCell";
    GKGLCustomerBillCell * customerBillCell = [tableView dequeueReusableCellWithIdentifier:kGKGLCustomerBillCell];
    if (!customerBillCell) {
        customerBillCell =  loadNibName(@"GKGLCustomerBillCell");
    }
    customerBillCell.GKGLCustomerBillCellTapBlock = ^(NSDictionary * _Nonnull param, NSString * _Nonnull cardType) {
        if ([cardType isEqualToString:@"equity"]) {/** 权益包 */
            GKGLMemberBenefitsVC * memberBenefitsVC = [[GKGLMemberBenefitsVC alloc] init];
            memberBenefitsVC.userid = _customerModel.uid;
            [weakSelf.navigationController pushViewController:memberBenefitsVC animated:NO];
        }else if([cardType isEqualToString:@"ticket_coupon"]){/** 优惠券 */
            GKGLDiscountCouponVC * discountCouponVC = [[GKGLDiscountCouponVC alloc] init];
            discountCouponVC.userid = _customerModel.uid;
            [self.navigationController pushViewController:discountCouponVC animated:NO];
        }else{
            GKGLCardDetailVC * cardDetailVC = [[GKGLCardDetailVC alloc] init];
            cardDetailVC.cardType = cardType;
            cardDetailVC.param = param;
            cardDetailVC.userid = _customerModel.uid;
            [weakSelf.navigationController pushViewController:cardDetailVC animated:NO];
        }
        
    };
    if (_dataSource.count > indexPath.row) {
         [customerBillCell updateGKGLCustomerBillCellModel:_dataSource[indexPath.row]];
    }
    return customerBillCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 9;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}
#pragma mark ------网路请求------
/** 顾客账单数据 */
- (void)requestBillData
{
    [_dataSource removeAllObjects];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_customerModel.uid?_customerModel.uid:@"" forKey:@"user_id"];
    [MzzCustomerRequest requestGKGLCustomerBillDetail:param resultBlock:^(GKGLBillListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if(isSuccess){
            [_dataSource addObjectsFromArray:model.list];
            [_tbView reloadData];
        }else{}
        
    }];
}
@end
