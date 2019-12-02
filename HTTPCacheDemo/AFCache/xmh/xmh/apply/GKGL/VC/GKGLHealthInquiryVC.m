//
//  GKGLHealthInquiryVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLHealthInquiryVC.h"
#import "GKGLHealthInquiryCell.h"
#import "GKGLHealthTbUserHeader.h"
#import "GKGLHealthTbSearchHeader.h"
#import "GKGLHealthInquirySearchVC.h"
#import "GKGLHealthInquiryDetailVC.h"
#import "MzzCustomerRequest.h"
#import "GKGLHomeCustomerListModel.h"
#import "XMHRefreshGifHeader.h"
@interface GKGLHealthInquiryVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)GKGLHealthTbSearchHeader * tbSearchHeader;
@property (nonatomic, strong)GKGLHealthTbUserHeader * tbUserHeader;
@property (nonatomic, strong)GKGLHomeCustomerModel * customerModel;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation GKGLHealthInquiryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _dataSource = [[NSMutableArray alloc] init];
    [self.navView setNavViewTitle:@"健康问诊" backBtnShow:YES];
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 108);
    self.logoView.backgroundColor = kColorTheme;
    self.logoView.image = nil;
    [self.view addSubview:self.tbSearchHeader];
    [self.view addSubview:self.tbUserHeader];
    [self.view addSubview:self.tbView];
    if (_isFromGKGL) {
        _tbView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav);
        [_tbView.mj_header beginRefreshing];
    }else{
        
    }
    [self requestCustomerData];
}
- (GKGLHealthTbUserHeader *)tbUserHeader
{
    WeakSelf
    if (!_tbUserHeader) {
        _tbUserHeader = loadNibName(@"GKGLHealthTbUserHeader");
        _tbUserHeader.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 110);
        _tbUserHeader.hidden = YES;
        _tbUserHeader.GKGLHealthTbUserHeaderDelBlock = ^{
            weakSelf.tbSearchHeader.hidden = NO;
            weakSelf.tbUserHeader.hidden = YES;
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.tbView reloadData];
        };
    }
    return _tbUserHeader;
}
- (GKGLHealthTbSearchHeader *)tbSearchHeader
{
    WeakSelf
    if (!_tbSearchHeader) {
        _tbSearchHeader = loadNibName(@"GKGLHealthTbSearchHeader");
        _tbSearchHeader.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 110);
        _tbSearchHeader.GKGLHealthTbSearchHeaderTapBlock = ^{
            GKGLHealthInquirySearchVC * searchVC = [[GKGLHealthInquirySearchVC alloc] init];
            searchVC.GKGLHealthInquirySearchVCBlock = ^(GKGLHomeCustomerModel * _Nonnull model) {
                weakSelf.customerModel = model;
                weakSelf.userid = model.uid;
                [weakSelf requestCustomerData];
                weakSelf.tbUserHeader.hidden = NO;
                weakSelf.tbSearchHeader.hidden = YES;
                [weakSelf.tbUserHeader updateGKGLHealthTbUserHeaderModel:model];
            };
            [weakSelf.navigationController pushViewController:searchVC animated:NO];
        };
    }
    return _tbSearchHeader;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 110) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.backgroundColor = [UIColor clearColor];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
//        if (_userid && _userid.length > 0) {
            _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//                [self requestCustomerData];
//            }];
//        }
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                __strong typeof(_self) self = _self;
                [self requestCustomerData];
            });
        }];
    }
    return _gifHeader;
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLHealthInquiryCell = @"kGKGLHealthInquiryCell";
    GKGLHealthInquiryCell * healthInquiryCell = [tableView dequeueReusableCellWithIdentifier:kGKGLHealthInquiryCell];
    if (!healthInquiryCell) {
        healthInquiryCell =  loadNibName(@"GKGLHealthInquiryCell");
    }
    [healthInquiryCell updateCellParam:_dataSource[indexPath.row]];
    return healthInquiryCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!(_userid && _userid.length > 0)) {
        [XMHProgressHUD showOnlyText:@"请先选择顾客"];
        return;
    }
    GKGLHealthInquiryDetailVC * healthInquiryDetailVC = [[GKGLHealthInquiryDetailVC alloc] init];
    healthInquiryDetailVC.userid = _userid;
    healthInquiryDetailVC.param = _dataSource[indexPath.row];
    [self.navigationController pushViewController:healthInquiryDetailVC animated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
#pragma mark ------网络请求------
- (void)requestCustomerData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_HEADLTHINQUIRY_ITEM_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if ([resultDic[@"list"] count] > 0) {
                [_dataSource removeAllObjects];
                [_dataSource addObjectsFromArray:resultDic[@"list"]];
            }
            [_tbView reloadData];
        }else{}
    }];
}
@end
