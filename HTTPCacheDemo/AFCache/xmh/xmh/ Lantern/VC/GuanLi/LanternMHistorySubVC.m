//
//  LanternMHistorySubVC.m
//  xmh
//
//  Created by ald_ios on 2019/2/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMHistorySubVC.h"
#import "LanternMSearchCell.h"
#import "UserManager.h"
#import "LanternRequest.h"
#import "LanternMSearchHistoryToastView.h"
#import "XMHRefreshGifHeader.h"
@interface LanternMHistorySubVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger isMore;
@property (nonatomic, strong)LanternMSearchHistoryToastView * historyToastView;
@property (nonatomic, strong)UIView * toastView;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation LanternMHistorySubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isMore = NO;
    [self.view addSubview:self.tbView];
    self.toastView.hidden = YES;
    _dataSource = [[NSMutableArray alloc] init];
    
//    [self requestHistoryData];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.layer.cornerRadius = 5;
        _tbView.layer.masksToBounds = YES;
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
          [self refreshTbData];
      
        }];
    }
    return _gifHeader;
}
- (LanternMSearchHistoryToastView *)historyToastView
{
    WeakSelf
    if (!_historyToastView) {
        _historyToastView = loadNibName(@"LanternMSearchHistoryToastView");
        _historyToastView.center = [UIApplication sharedApplication].keyWindow.center;
        _historyToastView.LanternMSearchHistoryToastViewBlock = ^{
            weakSelf.toastView.hidden = YES;
            dispatch_async(dispatch_get_main_queue(), ^{//@(weakSelf.tag)
                [[NSNotificationCenter defaultCenter]postNotificationName:@"scroll" object:@{@"tag":@(weakSelf.tag),@"id":weakSelf.historyToastView.itemID}];
            });
        };
    }
    return _historyToastView;
}
- (UIView *)toastView
{
    if (!_toastView) {
        _toastView = [[UIView alloc] init];
        _toastView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        UIView * bg = [[UIView alloc] init];
        bg.alpha = 0.7;
        bg.frame = _toastView.bounds;
        bg.backgroundColor = [UIColor darkGrayColor];
        [_toastView addSubview:bg];
        [_toastView addSubview:self.historyToastView];
        _toastView.center = [UIApplication sharedApplication].keyWindow.center;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
        [_toastView addGestureRecognizer:tap];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:_toastView];
    return _toastView;
}
- (void)remove
{
    _toastView.hidden = YES;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tbView.frame = self.view.bounds;
}

- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestHistoryData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestHistoryData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kLanternMSearchCell = @"kLanternMSearchCell";
    LanternMSearchCell * searchCell = [tableView dequeueReusableCellWithIdentifier:kLanternMSearchCell];
    if (!searchCell) {
        searchCell =  loadNibName(@"LanternMSearchCell");
    }
    searchCell.LanternMSearchCellDelBlock = ^(NSDictionary * _Nonnull param) {
        [self requestDeleteHistoryItemParam:param];
    };
    [searchCell updateCellParam:_dataSource[indexPath.row]];
//    [customerBillDetailCell updateCellParam:_dataSource[indexPath.row] cellType:_tag];
    return searchCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _toastView.hidden = NO;
    [_historyToastView updateViewParam:_dataSource[indexPath.row]];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0f;
}
#pragma mark ------网络请求------
- (void)requestHistoryData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    NSString * type = [NSString stringWithFormat:@"%ld",_tag +1];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:page?page:@"" forKey:@"page"];
    [param setValue:type?type:@"" forKey:@"type"];
    [LanternRequest requestCommonUrl:kLANTERN_MANAGE_HISTORY_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
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
- (void)requestDeleteHistoryItemParam:(NSDictionary *)params;
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString * type = [NSString stringWithFormat:@"%ld",_tag +1];
    [param setValue:params[@"id"]?params[@"id"]:@"" forKey:@"id"];
    [param setValue:type?type:@"" forKey:@"type"];
    [LanternRequest requestCommonUrl:kLANTERN_MANAGE_DEL_HISTORY_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self requestHistoryData];
        }else{}
    }];
}

@end
