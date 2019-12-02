//
//  GKGLCustomerCFSubVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerCFSubVC.h"
#import "GKGLCustomerCFCell.h"
#import "MzzCustomerRequest.h"
#import "ChuFangDetailViewController.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ReportBJController.h"
#import "XMHRefreshGifHeader.h"
#import "BeautyCFDetailVC.h"
#import "BeautyCFReportWriteVC.h"
#import "BeautyCFReportVC.h"
@interface GKGLCustomerCFSubVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger isMore;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation GKGLCustomerCFSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isMore = NO;
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
        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self refreshTbData];
        }];
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
    [self requestCFData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestCFData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    static NSString * kGKGLCustomerCFCell = @"kGKGLCustomerCFCell";
    GKGLCustomerCFCell * customerCFCell = [tableView dequeueReusableCellWithIdentifier:kGKGLCustomerCFCell];
    if (!customerCFCell) {
        customerCFCell =  loadNibName(@"GKGLCustomerCFCell");
    }
    [customerCFCell updateCellParam:_dataSource[indexPath.row] cellType:_tag];
    /** 跳转处方报告 */
    customerCFCell.GKGLCustomerCFCellTapBlock = ^(NSDictionary * _Nonnull param) {
        /** 判断是否填写了处方执行报告 和 处方执行建议 */
        if ([param[@"presentation"] isEqual:[NSNull null]] || [param[@"proposal"] isEqual:[NSNull null]] || !param[@"presentation"] || !param[@"proposal"]) {
            /** 跳转填写处方报告界面 */
            BeautyCFReportWriteVC * next = [[BeautyCFReportWriteVC alloc] init];
            next.param = [[NSMutableDictionary alloc] initWithDictionary:param];
            [weakSelf.navigationController pushViewController:next animated:NO];
        }else{
            /** 跳转处方报告*/
            BeautyCFReportVC * next = [[BeautyCFReportVC alloc] init];
            next.param = [[NSMutableDictionary alloc] initWithDictionary:param];
            [weakSelf.navigationController pushViewController:next animated:NO];
        }
    };
    return customerCFCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    BeautyCFDetailVC * next = [[BeautyCFDetailVC alloc] init];
    next.gkglBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
   
    NSMutableDictionary * param = _dataSource[indexPath.row];
    [param setValue:@"1" forKey:@"come"];
    next.param = _dataSource[indexPath.row];
    [self.navigationController pushViewController:next animated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}
#pragma mark ------网络请求------
/** 销售订单数据 */
- (void)requestCFData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    [param setValue:page?page:@"1" forKey:@"page"];
    NSString * zt = @"";
    if (_tag == 0) {
        zt = @"1";
    }
    if (_tag == 1) {
        zt = @"3";
    }
    [param setValue:zt?zt:@"" forKey:@"zt"];
    [MzzCustomerRequest requestGKGLCustomerCFDataParam:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (_GKGLCustomerCFSubVCBlock) {
                _GKGLCustomerCFSubVCBlock(resultDic[@"count"]);
            }
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            if ([resultDic[@"list"] count] == 0){
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{}
    }];
}
@end
