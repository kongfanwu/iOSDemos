//
//  BeautyCFBillSubVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFBillSubVC.h"
#import "BeautyCFCell.h"
#import "GKGLMemberBenefitsTbHeader.h"
#import "MzzCustomerRequest.h"
#import "GKGLMemberBenefitsDetailVC.h"
#import "XMHRefreshGifHeader.h"
@interface BeautyCFBillSubVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;

@property (nonatomic, copy)NSString * searchText;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation BeautyCFBillSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
//        _tbView.tableHeaderView = self.tbHeader;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////            [self requestCustomerBenefitsData];
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
               // [self requestCustomerBenefitsData];
            });
        }];
    }
    return _gifHeader;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tbView.frame = self.view.bounds;
}
//- (void)requestMoreData
//{
//    _isMore = YES;
//    _page ++;
//    [self requestCustomerData];
//}
//- (void)refreshTbData
//{
//    _isMore = NO;
//    _page = 1;
//    [self requestCustomerData];
//}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLMemberBenefitsCell = @"kGKGLMemberBenefitsCell";
    BeautyCFCell * cell = [tableView dequeueReusableCellWithIdentifier:kGKGLMemberBenefitsCell];
    if (!cell) {
        cell =  loadNibName(@"BeautyCFCell");
    }
//    cell.BeautyCFCellEndBlock = ^{
//
//    };
//    [benefitsCell updateCellParam:_dataSource[indexPath.row] cellType:_tag];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 10;
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
    return 110.0f;
}

@end
