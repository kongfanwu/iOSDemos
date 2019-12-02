//
//  BookDoneVC.m
//  xmh
//
//  Created by ald_ios on 2018/10/20.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookDoneVC.h"
/** 网路请求 */
#import "BookRequest.h"
/** 通用 */
#import "LNavView.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
/** 自定义Cell */
#import "BookDoneCell.h"
/** 自定义View */
#import "BookWaitTbHeader.h"
/** VC */
#import "BookDetailVC.h"
#import "SaleServiceViewController.h"
/** 模型 */
#import "COrganizeModel.h"
#import "YiYuYueListModel.h"
#import "YiYuYueModel.h"
#import "BookParamModel.h"
#import "XMHRefreshGifHeader.h"
@interface BookDoneVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)BookWaitTbHeader * tbHeader;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation BookDoneVC
{
    YiYuYueListModel * _yyyListModel;
    NSMutableArray * _dataSource;
    /** 页码 */
    NSInteger _currentPage;
    /** 搜索关键字 */
    NSString * _searchText;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /** 初始化数据 */
    self.view.backgroundColor = kBackgroundColor;
    _dataSource = [[NSMutableArray alloc] init];
    _currentPage = 0;
    [self.navView setNavViewTitle:@"已预约" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:self.tbView];
    [self requestListData];
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
    [self requestListData];
}
- (void)refreshTbData
{
    _currentPage = 0;
    [_dataSource removeAllObjects];
    [self requestListData];
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
            [weakSelf requestListData];
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
    static NSString * kDoneCell = @"kDoneCell";
    BookDoneCell * doneCell = [tableView dequeueReusableCellWithIdentifier:kDoneCell];
    if (!doneCell) {
        doneCell = loadNibName(@"BookDoneCell");
        /** 跳转 */
        doneCell.BookDoneCellBlock = ^(YiYuYueModel *model, NSInteger tag) {
            /** 跳转修改预约----详情页 */
            if (tag == 100) {
                BookDetailVC * bookDetail = [[BookDetailVC alloc] init];
                BookParamModel * paramModel = [BookParamModel createBookParamModelVCTitle:@"修改预约" type:@"xgyy" orderNum:model.ordernum userID:model.user_id];
                bookDetail.paramModel = paramModel;
                [self.navigationController pushViewController:bookDetail animated:YES];
            }
            /** 跳转生成服务----服务单 */
            if (tag == 101) {
                SaleServiceViewController * serviceVC = [[SaleServiceViewController alloc] init];
                [serviceVC setUser_id:model.user_id.integerValue];
                [serviceVC setName:model.user_name];
                [serviceVC setMobile:model.user_mobile];
                [serviceVC setStore_code:model.store_code];
                [serviceVC setIsSale:NO];
                [serviceVC setBillType:1];
                [self.navigationController pushViewController:serviceVC animated:YES];
            }
        };
    }
    [doneCell updateBookDoneCellModel:_dataSource[indexPath.row]];
    return doneCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}
#pragma mark ------网络请求------
- (void)requestListData
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:_organizeModel.oneClick?_organizeModel.oneClick:@"" forKey:@"oneClick"];
    [params setValue:_organizeModel.twoClick?_organizeModel.twoClick:@"" forKey:@"twoClick"];
    [params setValue:_organizeModel.twoListId?_organizeModel.twoListId:@"" forKey:@"twoListId"];
    [params setValue:_organizeModel.inId?_organizeModel.inId:@"" forKey:@"inId"];
    [params setValue:@(_currentPage)?@(_currentPage):@"" forKey:@"page"];
    [params setValue:_searchText?_searchText:@"" forKey:@"q"];
    [BookRequest requestYiYuYueParams:params resultBlock:^(YiYuYueListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
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
- (void)setOrganizeModel:(COrganizeModel *)organizeModel
{
    _organizeModel = organizeModel;
}
@end
