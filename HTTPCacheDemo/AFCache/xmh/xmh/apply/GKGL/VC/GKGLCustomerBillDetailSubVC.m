//
//  GKGLCustomerBillDetailSubVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerBillDetailSubVC.h"
#import "GKGLCustomerBillDetailCell.h"
#import "MzzCustomerRequest.h"
#import "FWDDetailViewController.h"
#import "MzzJiSuanViewController.h"
#import "MzzBillDetailController.h"
#import "XMHRefreshGifHeader.h"
#import "XMHNewMzzJiSuanViewController.h"
@interface GKGLCustomerBillDetailSubVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger isMore;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation GKGLCustomerBillDetailSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isMore = NO;
    _page = 1;
    [self.view addSubview:self.tbView];
    _dataSource = [[NSMutableArray alloc] init];
//    [self requestPageData];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestMoreData];
        }];
        [_tbView.mj_header beginRefreshing];
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
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tbView.frame = self.view.bounds;
}

- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestPageData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestPageData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLCustomerBillDetailCell = @"kGKGLCustomerBillDetailCell";
    GKGLCustomerBillDetailCell * customerBillDetailCell = [tableView dequeueReusableCellWithIdentifier:kGKGLCustomerBillDetailCell];
    if (!customerBillDetailCell) {
        customerBillDetailCell =  loadNibName(@"GKGLCustomerBillDetailCell");
    }
    [customerBillDetailCell updateCellParam:_dataSource[indexPath.row] cellType:_tag];
    return customerBillDetailCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tag == 0) {
        XMHNewMzzJiSuanViewController *xsdDetailVC = [[XMHNewMzzJiSuanViewController alloc] init];
        [xsdDetailVC setOrderDetailNum:_dataSource[indexPath.row][@"ordernum"] andYemianStyle:YemianXiangQing];
        [self.navigationController pushViewController:xsdDetailVC animated:NO];
    }
    if (_tag == 1) {
        FWDDetailViewController * fwdDetailVC = [[FWDDetailViewController alloc] init];
        fwdDetailVC.ordernum = _dataSource[indexPath.row][@"ordernum"];
        [self.navigationController pushViewController:fwdDetailVC animated:NO];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tag == 0) {
        return 120.0f;
    }
    if (_tag == 1) {
        return 140.0f;
    }
    return 120.0f;
}
#pragma mark ------网络请求------
- (void)requestPageData
{
    if (_tag == 0) {
        [self requestSaleBillsData];
    }
    if (_tag == 1) {
        [self requestServerBillsData];
    }
}
/** 销售订单数据 */
- (void)requestSaleBillsData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    [param setValue:page?page:@"1" forKey:@"page"];
    [MzzCustomerRequest requestGKGLCustomerBillXSOrderList:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (_GKGLCustomerBillDetailSubVCBlock) {
                _GKGLCustomerBillDetailSubVCBlock(resultDic[@"count"]);
            }
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            if (![resultDic[@"list"] count]) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{}
    }];
}
/** 服务订单数据 */
- (void)requestServerBillsData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    [param setValue:page?page:@"1" forKey:@"page"];
    [MzzCustomerRequest requestGKGLCustomerBillFWOrderList:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (_GKGLCustomerBillDetailSubVCBlock) {
                _GKGLCustomerBillDetailSubVCBlock(resultDic[@"count"]);
            }
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            
            if (![resultDic[@"list"] count]) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{}
    }];
}
@end
