//
//  XMHTraceDiscountCouponVC.m
//  xmh
//
//  Created by ald_ios on 2019/6/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTraceDiscountCouponVC.h"
#import "XMHTraceDiscountCouponCell.h"
#import "XMHCouponListModel.h"
#import "XMHCouponModel.h"
@interface XMHTraceDiscountCouponVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)XMHBaseTableView * tbView;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger isMore;
@property (nonatomic, strong)NSMutableArray * selectData;
@end

@implementation XMHTraceDiscountCouponVC

@synthesize rowDescriptor = _rowDescriptor;

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    [self initSubViews];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"优惠券" backBtnShow:YES];
    
    XMHBaseTableView * tbView = [[XMHBaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tbView.backgroundColor = [UIColor clearColor];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.emptyEnable = YES;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbView = tbView;
    [self.view addSubview:tbView];
    [tbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestMoreData];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"XMHTraceDiscountCouponCell";
    XMHTraceDiscountCouponCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = loadNibName(@"XMHTraceDiscountCouponCell");
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestServerBillsData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestServerBillsData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark - XMHFormTaskNextVCProtocol

/**
 配置参数
 */
- (void)configParams:(NSDictionary *)params {
    NSArray *couponList = params[@"couponList"];
    _selectData = [[NSMutableArray alloc] initWithArray:couponList];
}
/** 优惠券数据 */
- (void)requestServerBillsData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    [params setValue:joinCode forKey:@"join_code"];
    [params setValue:@"all" forKey:@"type"];
    [params setValue:@"" forKey:@"name"];
    [params setValue:@"all" forKey:@"status"];
    [params setValue:@"asc" forKey:@"sore"];
    [params setValue:@(1) forKey:@"page"];
    //    [params setValue:@(20) forKey:@"page_size"];
    [YQNetworking postWithUrl:[XMHHostUrlManager url:@"v5.Ticket_coupon/getList"] refreshRequest:NO cache:YES params:params progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            XMHCouponListModel *model = [XMHCouponListModel yy_modelWithDictionary:obj.data];
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.list];
            if (_selectData.count > 0) {
                [self comparisonData];
            }
            if (model.list.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{
            
        }
    }];
}
- (void)comparisonData
{
    [_selectData enumerateObjectsUsingBlock:^(NSString * uid, NSUInteger idx, BOOL * _Nonnull stop) {
        [_dataSource enumerateObjectsUsingBlock:^(XMHCouponModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([uid isEqualToString:model.uid]) {
                [_dataSource addObject:model];
            }
        }];
    }];
}
@end
