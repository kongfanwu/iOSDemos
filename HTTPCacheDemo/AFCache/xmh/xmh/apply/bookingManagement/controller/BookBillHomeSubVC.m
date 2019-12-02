//
//  BookBillHomeSubVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookBillHomeSubVC.h"
#import "GKGLDiscountCouponCell.h"
#import "BookWaitTbHeader.h"
#import "BookDoneCell.h"
#import "BookWaitCell.h"
#import "DaiYuYueModel.h"
#import "BookFastVC.h"
#import "BookParamModel.h"
#import "BookDetailVC.h"
#import "SaleServiceViewController.h"
#import "YiYuYueModel.h"
#import "ShareWorkInstance.h"
#import "BookRequest.h"
#import "UserManager.h"
#import "YiYuYueListModel.h"
#import "DaiYuYueListModel.h"
#import "XMHRefreshGifHeader.h"
#import "XMHServiceOrderVC.h"
#import "CustomerListModel.h"
@interface BookBillHomeSubVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger isMore;
@property (nonatomic, strong)BookWaitTbHeader * tbHeader;
@property (nonatomic, copy)NSString * searchText;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation BookBillHomeSubVC
- (void)dealloc
{
    NSLog(@"BookBillHomeSubVC dealloc");
}
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
        _tbView.tableHeaderView  = self.tbHeader;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        __weak typeof(self) _self = self;
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestMoreData];
        }];
        [_tbView.mj_header beginRefreshing];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                __strong typeof(_self) self = _self;
                [self refreshTbData];
            });
        }];
    }
    return _gifHeader;
}
- (BookWaitTbHeader *)tbHeader
{
    WeakSelf
    if (!_tbHeader) {
        _tbHeader = loadNibName(@"BookWaitTbHeader");
//        __weak NSMutableArray * weakDataSource = _dataSource;
        _tbHeader.BookWaitTbHeaderBlock = ^(NSString *selectStr) {
            weakSelf.searchText = selectStr;
            [weakSelf refreshTbData];
            [weakSelf requestListData];
        };
    }
    return _tbHeader;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tbView.frame = self.view.bounds;
}

- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestListData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 1;
    [self requestListData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kDoneCell = @"kDoneCell";
    static NSString * kWaitCell = @"kWaitCell";
    if (_tag == 0) {
        BookWaitCell * waitCell = [tableView dequeueReusableCellWithIdentifier:kWaitCell];
        DaiYuYueModel * model = _dataSource[indexPath.row];
        if (!waitCell) {
            waitCell = loadNibName(@"BookWaitCell");
            /** 跳转到生成预约 */
            __weak typeof(self) _self = self;
            waitCell.BookWaitCellBlock = ^(NSString * userID){
                __strong typeof(_self) self = _self;
                BookFastVC * bookFastVC= [[BookFastVC alloc] init];
                BookParamModel * paramModel = [BookParamModel createBookParamModelVCTitle:@"修改预约" type:@"xgyy" orderNum:nil userID:model.user_id];
                bookFastVC.paramModel = paramModel;
                [self.navigationController pushViewController:bookFastVC animated:YES];
            };
        }
        [waitCell updateBookWaitCellModel:_dataSource[indexPath.row]];
        return waitCell;
    }else if (_tag == 1){
        BookDoneCell * doneCell = [tableView dequeueReusableCellWithIdentifier:kDoneCell];
        if (!doneCell) {
            doneCell = loadNibName(@"BookDoneCell");
            [doneCell updateBookDoneCellModel:_dataSource[indexPath.row]];
            /** 跳转 */
            __weak typeof(self) _self = self;
            doneCell.BookDoneCellBlock = ^(YiYuYueModel *model, NSInteger tag) {
                __strong typeof(_self) self = _self;
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
                    CustomerModel * servermodel = [[CustomerModel alloc] init];
                    servermodel.uid = model.user_id.integerValue;
                    servermodel.mobile = model.user_mobile;
                    servermodel.uname = model.user_name;
                    
                    XMHServiceOrderVC * next = [[XMHServiceOrderVC alloc] init];
                    [next confitSelectUserModel:servermodel];
                    [self.navigationController pushViewController:next animated:YES];
                }
            };
        }
        return doneCell;
    }else{
        BookDoneCell * doneCell = [tableView dequeueReusableCellWithIdentifier:kDoneCell];
        if (!doneCell) {
            doneCell = loadNibName(@"BookDoneCell");
            [doneCell updateCellParam:_dataSource[indexPath.row]];
            /** 跳转 */
            doneCell.BookDoneCellBlock = ^(YiYuYueModel *model, NSInteger tag) {
//                /** 跳转修改预约----详情页 */
//                if (tag == 100) {
//                    BookDetailVC * bookDetail = [[BookDetailVC alloc] init];
//                    BookParamModel * paramModel = [BookParamModel createBookParamModelVCTitle:@"修改预约" type:@"xgyy" orderNum:model.ordernum userID:model.user_id];
//                    bookDetail.paramModel = paramModel;
//                    [self.navigationController pushViewController:bookDetail animated:YES];
//                }
//                /** 跳转生成服务----服务单 */
//                if (tag == 101) {
//                    SaleServiceViewController * serviceVC = [[SaleServiceViewController alloc] init];
//                    [serviceVC setUser_id:model.user_id.integerValue];
//                    [serviceVC setName:model.user_name];
//                    [serviceVC setMobile:model.user_mobile];
//                    [serviceVC setStore_code:model.store_code];
//                    [serviceVC setIsSale:NO];
//                    [serviceVC setBillType:1];
//                    [self.navigationController pushViewController:serviceVC animated:YES];
//                }
            };
        }
        return doneCell;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//        return 10;
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
    if (_tag == 0) {
        return 108.f;
    }else if(_tag == 1){
        return 150.0f;
    }else if(_tag == 2){
        return 130.0f;
    }
    return 90.0f;
}

- (void)setTag:(NSInteger)tag
{
    _tag = tag;
    [_tbView.mj_header beginRefreshing];
}
#pragma mark ------网络请求------
- (void)requestListData
{
    /** 组织参数 */
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * type = [NSString stringWithFormat:@"%ld",_tag + 1];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    NSString * q = _searchText;
    /** 组装参数 */
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:type?type:@"" forKey:@"type"];
    [param setValue:q?q:@"" forKey:@"q"];
    [param setValue:page?page:@"" forKey:@"page"];
    
    [BookRequest requestCommonUrl:kBOOK_BOOKBILL_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            if (_tag == 0) {
                DaiYuYueListModel *listModel  = [DaiYuYueListModel yy_modelWithDictionary:resultDic];
                 [_dataSource addObjectsFromArray:listModel.list];
                if (listModel.list.count == 0) {
                    [_tbView.mj_footer endRefreshingWithNoMoreData];
                }
            }else if (_tag == 1){
                YiYuYueListModel *listModel  = [YiYuYueListModel yy_modelWithDictionary:resultDic];
                [_dataSource addObjectsFromArray:listModel.list];
                if (listModel.list.count == 0) {
                    [_tbView.mj_footer endRefreshingWithNoMoreData];
                }
            }else if (_tag == 2){
                [_dataSource addObjectsFromArray:resultDic[@"list"]];
                if ([resultDic[@"list"] count] == 0) {
                    [_tbView.mj_footer endRefreshingWithNoMoreData];
                }
            }else{}
            if (_BookBillHomeSubVCCountBlock) {
                _BookBillHomeSubVCCountBlock(resultDic[@"count1"],resultDic[@"count2"],resultDic[@"count3"]);
            }
            [_tbView reloadData];
        }
    }];
}


@end
