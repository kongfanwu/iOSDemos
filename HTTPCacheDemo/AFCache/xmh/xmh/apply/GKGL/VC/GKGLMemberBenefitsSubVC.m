//
//  GKGLMemberBenefitsSubVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLMemberBenefitsSubVC.h"
#import "GKGLMemberBenefitsCell.h"
#import "GKGLMemberBenefitsTbHeader.h"
#import "MzzCustomerRequest.h"
#import "GKGLMemberBenefitsDetailVC.h"
#import "XMHRefreshGifHeader.h"
@interface GKGLMemberBenefitsSubVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)GKGLMemberBenefitsTbHeader * tbHeader;
@property (nonatomic, assign)BOOL isMore;
@property (nonatomic, assign)BOOL page;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation GKGLMemberBenefitsSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tbView];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        _tbView.tableHeaderView = self.tbHeader;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        [_tbView.mj_header beginRefreshing];
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
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tbView.frame = self.view.bounds;
}
- (GKGLMemberBenefitsTbHeader *)tbHeader
{
    if (!_tbHeader) {
        _tbHeader = loadNibName(@"GKGLMemberBenefitsTbHeader");
        _tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 25);
    }
    return _tbHeader;
}
- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestCustomerBenefitsData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestCustomerBenefitsData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLMemberBenefitsCell = @"kGKGLMemberBenefitsCell";
    GKGLMemberBenefitsCell * benefitsCell = [tableView dequeueReusableCellWithIdentifier:kGKGLMemberBenefitsCell];
    if (!benefitsCell) {
        benefitsCell =  loadNibName(@"GKGLMemberBenefitsCell");
    }
    [benefitsCell updateCellParam:_dataSource[indexPath.row] cellType:_tag];
    return benefitsCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GKGLMemberBenefitsDetailVC * memberBenefitsDetailVC = [[GKGLMemberBenefitsDetailVC alloc] init];
    memberBenefitsDetailVC.param = _dataSource[indexPath.row];
    [self.navigationController pushViewController:memberBenefitsDetailVC animated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0f;
}
#pragma mark ------网络请求------
- (void)requestCustomerBenefitsData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString * status = @"";
    if (_tag == 0) {
        status = @"1";
    }
    if (_tag == 1) {
        status = @"2";
    }
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    [param setValue:status?status:@"1" forKey:@"status"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_EBENEFITS_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (_GKGLMemberBenefitsSubVCBlock) {
                _GKGLMemberBenefitsSubVCBlock([NSString stringWithFormat:@"%ld",[resultDic[@"list"] count]]);
            }
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            if ([resultDic[@"list"] count] == 0 ) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{}
    }];
}
@end
