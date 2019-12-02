//
//  XMHBillRecContentVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBillRecContentVC.h"
#import "JasonSearchView.h"
#import "XMHBillRecSever.h"
#import "XMHBillReListModel.h"
#import "XMHTBillRecCell.h"
#import "XMHBillRecDetailView.h"
#import "UITableView+XMHEmptyData.h"
#import "XMHBillRecDetailVC.h"
#import "XMHOrderContentSearchView.h"
#import "XMHShoppingCartManager.h"
#define leftTableW 100
@interface XMHBillRecContentVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
/** 搜索 */
@property (nonatomic, strong) XMHOrderContentSearchView *searchView;
/** 搜索数据源 searchResultArray 搜索后集合*/
@property (nonatomic, strong) NSArray *searchDataArray, *searchResultArray;
/** 是否搜索状态 */
@property (nonatomic) BOOL isSearch;

/** 开始搜索 */
@property (nonatomic, copy) void (^startSearchBlock)();
/** 结束搜索 */
@property (nonatomic, copy) void (^endSearchBlock)();
/** tablView数据源 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/** 请求结果数据源 */
@property (nonatomic, strong) NSMutableArray *resultArr;
@property (nonatomic, strong) NSMutableArray *searchSourceArr;

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) XMHBillRecDetailView *detailAlertView;

@property (nonatomic, strong) UILabel *headerLab;


@end

@implementation XMHBillRecContentVC

- (instancetype)initUserId:(NSString *)userId type:(NSString *)type name:(NSString *)name;
{
    if (self = [super init]) {
        self.type = type;
        self.user_id = userId;
        self.name = name;
        _dataArr = [NSMutableArray array];
        _searchSourceArr = [NSMutableArray array];
        // 当购物车移除商品，或修改购物车商品数量。有时UI需要更新。
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartUpdateNotification:) name:kXMHShoppingCartUpdateNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSearchView];
    [self creatTabView];
    [self requestListData];
}

- (void)addSearchView {
    
    if (!self.searchView) {
        self.searchView = [[XMHOrderContentSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - leftTableW, 57)];
        [self.view addSubview:_searchView];
        
        __weak typeof(self) _self = self;
        // 搜索回调
        [self.searchView setSearchBlock:^(XMHOrderContentSearchView * _Nonnull searchView, NSString * _Nonnull text) {
            __strong typeof(_self) self = _self;
            [self searchText:text];
        }];
        // 结束搜索
        [self.searchView setClearSearchTextBlock:^(XMHOrderContentSearchView * _Nonnull searchView) {
            __strong typeof(_self) self = _self;
            self.isSearch = NO;
            if (self.endSearchBlock) self.endSearchBlock();
            self.dataArr = self.resultArr;
            [self.tableView reloadData];
        }];
        
    }
}


- (void)creatTabView
{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 57, self.view.width, self.view.height - 57);
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_tableView setSeparatorInset: UIEdgeInsetsZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 30)];
//    headView.backgroundColor = [UIColor whiteColor];
//    UILabel *headerLab = [[UILabel alloc]init];
//    headerLab.backgroundColor = [UIColor whiteColor];
//    headerLab.textAlignment = NSTextAlignmentLeft;
//    headerLab.font = [UIFont systemFontOfSize:17];
//    headerLab.frame = CGRectMake(15, 0, headView.frame.size.width - 15, 30);
//    headerLab.textColor = kLabelText_Commen_Color_3;
//    [headView addSubview:headerLab];
//    _tableView.tableHeaderView = headView;
//    self.headerLab = headerLab;
    
}
- (void)requestListData{
    self.resultArr = [NSMutableArray array];
    self.searchDataArray = [NSMutableArray array];
    XMHBillRecSever *sever = [[XMHBillRecSever alloc]initUserId:self.user_id type:self.type];
    sever.listsBlock = ^(NSMutableArray * _Nonnull listArr, BOOL isSuccess) {
        if (isSuccess) {
            self.resultArr = self.dataArr =  listArr;
            self.searchDataArray = self.resultArr;
        }
        [_tableView reloadData];
    };
    
}

#pragma mark -- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.type isEqualToString:@"ticket"]) {
        return 85;
    }
    return 65;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearch) {
        return _searchResultArray.count;
    }
    [tableView tableViewDisplayWithMsg:@"" ifNecessaryForRowCount:_dataArr.count];
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XMHTBillRecCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XMHTBillRecCellID"];
    if (!cell) {
        cell =  [[XMHTBillRecCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMHTBillRecCellID"];
    }
    [cell resetCell];
    id model;
    if (_isSearch) {
        model = [_searchResultArray safeObjectAtIndex:indexPath.row];
    }else{
        model = [_dataArr safeObjectAtIndex:indexPath.row];
    }
    
    [cell refreshCellModel:model];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WeakSelf
    id model = [_dataArr safeObjectAtIndex:indexPath.row];
    XMHBillRecDetailVC *vc = [[XMHBillRecDetailVC alloc]init];
    vc.billRecModel = model;
    vc.selectBlock = ^(id  _Nonnull model) {
        if (weakSelf.addShoppingCartBlock) {
            weakSelf.addShoppingCartBlock(model);
        }
    };
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    if ([model isKindOfClass:[XMHBillReCardModel class]]) {
        if ([model computeShengyuPrice] > 0) {
            [self.nav presentViewController:vc animated:YES completion:nil];
        }else{
            [MzzHud toastWithTitle:@"" message:@"剩余金额和次数不足无法回收"];
        }
    }else{
        if (([XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:model] > 0) || ([model computeShengyuPrice] > 0)) {
            [self.nav presentViewController:vc animated:YES completion:nil];
        }else{
            [MzzHud toastWithTitle:@"" message:@"剩余金额和次数不足无法回收"];
        }
    }
    
//     [self.nav presentViewController:vc animated:YES completion:nil];
    

}

- (void)searchText:(NSString *)text {
    [self.view endEditing:YES];
    if (text.length <= 0) {
        return;
    }
    _isSearch = YES;
    //定义谓词
    NSString *searchStr = [NSString stringWithFormat:@"name LIKE '*%@*'", text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:searchStr];
    self.searchResultArray = [self.searchDataArray filteredArrayUsingPredicate:predicate];
    if (self.startSearchBlock) self.startSearchBlock();
    self.isSearch = self.isSearch;
    self.dataArr = [self.searchResultArray mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - Notification

- (void)shoppingCartUpdateNotification:(NSNotification *)not {
    if (self.view) {
        [self.tableView reloadData];
    }
}
@end
