//
//  GKGLDiscountCouponSubVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/16.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLDiscountCouponSubVC.h"
#import "GKGLDiscountCouponCell.h"
#import "MzzCustomerRequest.h"
#import "XMHRefreshGifHeader.h"
@interface GKGLDiscountCouponSubVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger isMore;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation GKGLDiscountCouponSubVC

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
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLDiscountCouponCell = @"kGKGLDiscountCouponCell";
    GKGLDiscountCouponCell * discountCouponCell = [tableView dequeueReusableCellWithIdentifier:kGKGLDiscountCouponCell];
    if (!discountCouponCell) {
        discountCouponCell =  loadNibName(@"GKGLDiscountCouponCell");
    }
    [discountCouponCell updateCellParam:_dataSource[indexPath.row] cellType:_tag];
    return discountCouponCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
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
    return 106.0f;
}
#pragma mark ------网络请求------
/** 优惠券数据 */
- (void)requestServerBillsData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    NSString * status = @"";
    if (_tag == 0) {
        status = @"1";
    }
    if (_tag == 1) {
        status = @"2";
    }
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    [param setValue:page?page:@"1" forKey:@"page"];
    [param setValue:status?status:@"1" forKey:@"status"];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_DISCOUNTCOUPON_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (_GKGLDiscountCouponSubVCBlock) {
                _GKGLDiscountCouponSubVCBlock([NSString stringWithFormat:@"%ld",[resultDic[@"list"] count]]);
            }
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            
            if (([[resultDic[@"list"] class] isKindOfClass:[NSArray class]])?([resultDic[@"list"] count]) : 0 == 0 ) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{}
    }];
}

@end
