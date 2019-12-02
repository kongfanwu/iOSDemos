//
//  GKGLCustomerDetailVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerDetailVC.h"
#import "GKGLHomeCell.h"
#import "GKGLCustomerDetailTbHeader.h"
#import "GKGLCustomerDetailView.h"
#import "GKGLCustomerPortrayalVC.h"
#import "GKGLCardPopularVC.h"
#import "GKGLCustomerCFVC.h"
#import "GKGLCustomerBillVC.h"
#import "MzzCustomerRequest.h"
#import "GKGLHomeCustomerListModel.h"
#import "GKGLCustomerInfoVC.h"
#import "BookRequest.h"
#import "CustomerMessageModel.h"
@interface GKGLCustomerDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)GKGLCustomerDetailTbHeader * detailTbHeader;
@property (nonatomic, strong)GKGLCustomerDetailView * detailViewAccount;
@property (nonatomic, strong)GKGLCustomerDetailView * detailViewBehavior;
@property (nonatomic, strong)UIView * tbFooter;
@property (nonatomic, strong)NSDictionary * dataResultDic;
@end

@implementation GKGLCustomerDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorE;
    [self.navView setNavViewTitle:@"顾客详情" backBtnShow:YES];
    self.navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tbView];
    [self.view bringSubviewToFront:self.navView];
    
    [self requestCustomerData];
    if (_userID.length > 0) {
         [self requestCustomerInfoData];
    }
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT ) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableHeaderView = self.detailTbHeader;
        _tbView.tableFooterView = self.tbFooter;
        if (@available(iOS 11.0, *)) {
            _tbView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        _tbView.backgroundColor = kColorE;
    }
    return _tbView;
}
- (GKGLCustomerDetailTbHeader *)detailTbHeader
{
    WeakSelf
    if (!_detailTbHeader) {
        _detailTbHeader = loadNibName(@"GKGLCustomerDetailTbHeader");
        _detailTbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 295);
        _detailTbHeader.GKGLCustomerDetailTbHeaderZDBlock = ^{
            GKGLCustomerBillVC * customerBillVC = [[GKGLCustomerBillVC alloc] init];
            customerBillVC.customerModel = weakSelf.customerModel;
            [weakSelf.navigationController pushViewController:customerBillVC animated:NO];
        };
        _detailTbHeader.GKGLCustomerDetailTbHeaderHXBlock = ^{
            GKGLCustomerPortrayalVC * customerPortrayalVC = [[GKGLCustomerPortrayalVC alloc] init];
            customerPortrayalVC.userid = weakSelf.customerModel.uid;
            [weakSelf.navigationController pushViewController:customerPortrayalVC animated:NO];
        };
        _detailTbHeader.GKGLCustomerDetailTbHeaderCFBlock = ^{
            GKGLCustomerCFVC * customerCFVC = [[GKGLCustomerCFVC alloc] init];
            customerCFVC.userid = weakSelf.customerModel.uid;
            [weakSelf.navigationController pushViewController:customerCFVC animated:NO];
        };
        _detailTbHeader.GKGLCustomerDetailTbHeaderPJBlock = ^{
            GKGLCardPopularVC * cardPopularVC = [[GKGLCardPopularVC alloc] init];
            cardPopularVC.userid = weakSelf.customerModel.uid;
            [weakSelf.navigationController pushViewController:cardPopularVC animated:NO];
        };
        _detailTbHeader.GKGLCustomerDetailTbHeaderIconBlock = ^{
            GKGLCustomerInfoVC * customerInfo = [[GKGLCustomerInfoVC alloc] init];
            customerInfo.userid = weakSelf.customerModel.uid;
            [weakSelf.navigationController pushViewController:customerInfo animated:NO];
        };
        
        [_detailTbHeader updateGKGLCustomerDetailTbHeaderModel:_customerModel];
    }
    return _detailTbHeader;
}
- (GKGLCustomerDetailView *)detailViewAccount
{
    if (!_detailViewAccount) {
        _detailViewAccount = loadNibName(@"GKGLCustomerDetailView");
        _detailViewAccount.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
    }
    return _detailViewAccount;
}
- (GKGLCustomerDetailView *)detailViewBehavior
{
    if (!_detailViewBehavior) {
        _detailViewBehavior = loadNibName(@"GKGLCustomerDetailView");
        _detailViewBehavior.frame = CGRectMake(0, _detailViewAccount.bottom, SCREEN_WIDTH, 250);
    }
    return _detailViewBehavior;
}
- (UIView *)tbFooter
{
    if (!_tbFooter) {
        _tbFooter = [[UIView alloc] init];
        _tbFooter.frame = CGRectMake(0, 0, SCREEN_WIDTH, 500);
        [_tbFooter addSubview:self.detailViewAccount];
        [_tbFooter addSubview:self.detailViewBehavior];
    }
    return _tbFooter;
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLHomeCell = @"kGKGLHomeCell";
    GKGLHomeCell * homeCell = [tableView dequeueReusableCellWithIdentifier:kGKGLHomeCell];
    if (!homeCell) {
        homeCell =  loadNibName(@"GKGLHomeCell");
    }
    return homeCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
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
    return 85.0f;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.navView.backgroundColor = kColorTheme;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == 0) {
        self.navView.backgroundColor = [UIColor clearColor];
    }
}
#pragma mark ------网络请求------
/** 顾客信息详情数据 */
- (void)requestCustomerData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    if (_userID.length > 0) {
        [param setValue:_userID ? _userID : @""forKey:@"user_id"];
    }else{
        [param setValue:_customerModel.uid ? _customerModel.uid : @""forKey:@"user_id"];
    }
    
    [MzzCustomerRequest requestGKGLCustomerDetail:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _dataResultDic = resultDic;
            [_detailViewAccount updateGKGLCustomerDetailViewParamDic:resultDic tag:1];
            [_detailViewBehavior updateGKGLCustomerDetailViewParamDic:resultDic tag:2];
            [_detailTbHeader updateGKGLCustomerDetailTbHeaderParamDic:resultDic];
        }else{}
    }];
}
/** 顾客基本信息数据 */
- (void)requestCustomerInfoData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_userID ? _userID : @""forKey:@"user_id"];
    [BookRequest requestCustomerMessageParams:param resultBlock:^(CustomerMessageModel *customerMessageModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            GKGLHomeCustomerModel * model = [[GKGLHomeCustomerModel alloc]init];
            model.uid = [NSString stringWithFormat:@"%ld",customerMessageModel.uid];
            model.name = customerMessageModel.uname;
            model.headimgurl = customerMessageModel.headimgurl;
            model.grade_name = customerMessageModel.grade;
            model.last_fw_time = customerMessageModel.last_fw_time;
            model.insert_time = customerMessageModel.insert_time;
            model.show = customerMessageModel.show;
            model.zt = customerMessageModel.zt;
            model.store_code = customerMessageModel.store_code;
            _customerModel = model;
            [_detailTbHeader updateGKGLCustomerDetailTbHeaderModel:model];
        }else{}
    }];
}
@end
