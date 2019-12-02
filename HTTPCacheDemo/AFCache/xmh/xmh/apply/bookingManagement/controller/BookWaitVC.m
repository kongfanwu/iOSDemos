//
//  BookWaitVC.m
//  xmh
//
//  Created by ald_ios on 2018/10/20.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookWaitVC.h"
/** 网路请求 */
#import "BookRequest.h"
/** 通用 */
#import "LNavView.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
/** 自定义Cell */
#import "BookWaitCell.h"
/** 自定义View */
#import "BookWaitTbHeader.h"
/** VC */
#import "BookFastVC.h"
/** 模型 */
#import "DaiYuYueListModel.h"
#import "BookParamModel.h"
#import "DaiYuYueModel.h"
#import "XMHRefreshGifHeader.h"
@interface BookWaitVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)BookWaitTbHeader * tbHeader;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation BookWaitVC
{
    DaiYuYueListModel *_dyyListModel;
    NSMutableArray * _dataSource;
    NSInteger _currentPage;
    /** 搜索关键字 */
    NSString * _searchText;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    _dataSource = [[NSMutableArray alloc] init];
    _currentPage = 0;
    [self.navView setNavViewTitle:@"待预约" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:self.tbView];
    [self requestWaitListData];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.backgroundColor = [UIColor clearColor];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableHeaderView  = self.tbHeader;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestMoreData];
        }];
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
- (void)requestMoreData
{
    _currentPage ++;
    [self requestWaitListData];
}
- (void)refreshTbData
{
    _currentPage = 0;
    [_dataSource removeAllObjects];
    [self requestWaitListData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (BookWaitTbHeader *)tbHeader
{
    WeakSelf
    if (!_tbHeader) {
        _tbHeader = loadNibName(@"BookWaitTbHeader");
        __weak NSMutableArray * weakDataSource = _dataSource;
        _tbHeader.BookWaitTbHeaderBlock = ^(NSString *selectStr) {
            _searchText = selectStr;
            [weakDataSource removeAllObjects];
            [weakSelf requestWaitListData];
        };
    }
    return _tbHeader;
}
#pragma mark ------UITableViewDelegate------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kWaitCell = @"kWaitCell";
    BookWaitCell * waitCell = [tableView dequeueReusableCellWithIdentifier:kWaitCell];
    DaiYuYueModel * model = _dataSource[indexPath.row];
    if (!waitCell) {
        waitCell = loadNibName(@"BookWaitCell");
        /** 跳转到生成预约 */
        waitCell.BookWaitCellBlock = ^(NSString * userID){
            BookFastVC * bookFastVC= [[BookFastVC alloc] init];
            BookParamModel * paramModel = [BookParamModel createBookParamModelVCTitle:@"修改预约" type:@"xgyy" orderNum:nil userID:model.user_id];
            bookFastVC.paramModel = paramModel;
            [self.navigationController pushViewController:bookFastVC animated:YES];
        };
    }
    [waitCell updateBookWaitCellModel:_dataSource[indexPath.row]];
    return waitCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108.0f;
}
#pragma mark ------网络请求------
/** 请求待预约列表数据 */
- (void)requestWaitListData
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:infomodel.data.account?infomodel.data.account:@"" forKey:@"inId"];
    [params setValue:@(_currentPage)?@(_currentPage):@"" forKey:@"page"];
    [params setValue:_searchText?_searchText:@"" forKey:@"q"];
    
    [BookRequest requestDaiYuYueParams:params resultBlock:^(DaiYuYueListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (listModel.list.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }else{
                
            }
            [_dataSource addObjectsFromArray:listModel.list];
            [_tbView reloadData];
        }else{
            
        }
       
    }];
}
@end
