//
//  XMHSalesOrderContentVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSalesOrderContentVC.h"
#import "XMHSalesOrderSever.h"
#import "XMHSalesOrderTableView.h"
#import "SASaleListModel.h"
#import "XMHBillRecDetailView.h"
#import "MzzCustomerRequest.h"
#import "XMHSaleOrderRequest.h"
#import "MzzStoreModel.h"
#import "XMHShoppingCartManager.h"
#import "XMHOrderContentSearchView.h"
#import "XMHSaleOrderDetailAlertVC.h"
@interface XMHSalesOrderContentVC ()
@property (nonatomic, copy)NSString *userId;//用户id
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong) XMHSalesOrderTableView *tableView;
@property (nonatomic, strong) SaleModel *saleModel;
@property (nonatomic, strong) UIWindow *alertwWindow;
@property (nonatomic, strong) NSMutableArray *dataArr; //数据源

@end

@implementation XMHSalesOrderContentVC

- (instancetype)initUserId:(NSString *)userId type:(NSString *)type name:(NSString *)name
{
    if (self = [super init]) {
        self.userId = userId;
        self.type = type;
        self.name = name;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSearchView];
    [self addTabView];

    
}

- (void)addSearchView {

    if (!self.searchView) {
        self.searchView = [[XMHOrderContentSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 100, 53)];
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
//            if (self.endSearchBlock) self.endSearchBlock();
            self.tableView.isSearch = self.isSearch;
            self.tableView.dataArr = self.dataArr;
            [self.tableView reloadData];
        }];

    }
}

- (void)addTabView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(53);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

 - (XMHSalesOrderTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[XMHSalesOrderTableView alloc]init];
        _tableView.cardType = self.type;
        _tableView.cardName = self.name;
    }
    return _tableView;
}
- (void)showDetailAlertView
{
    WeakSelf
    XMHSaleOrderDetailAlertVC *vc = [[XMHSaleOrderDetailAlertVC alloc]initWithFrame:[UIScreen mainScreen].bounds cardType:self.type detailModel:self.saleModel userId:self.userId storeCode:self.storeCode];
    vc.selectedSaleModel = ^(SaleModel * _Nonnull model) {
        weakSelf.saleModel = model;
        [weakSelf shoppingCartModel];

    };
   vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [[[[UIApplication sharedApplication]keyWindow] rootViewController] presentViewController:vc animated:YES completion:nil];
}

#pragma mark -- 添加购物车
- (void)shoppingCartModel
{
    XMHShoppingCartManager *manager = [XMHShoppingCartManager sharedInstance];
    [manager addModel:self.saleModel];

}
#pragma mark --request

- (void)setStoreCode:(NSString *)storeCode
{
    _storeCode = storeCode;
    [self requestData];
}
- (void)requestData{
    XMHSalesOrderSever *sever = [[XMHSalesOrderSever alloc]initUserId:self.userId type:self.type storeCode:self.storeCode];
    WeakSelf
    self.tableView.cellH = sever.cellHeight;
    self.tableView.didSelectModel = ^(SaleModel * _Nonnull model) {
        weakSelf.saleModel = model;
        [weakSelf showDetailAlertView];
    };
    sever.saleOrderSeverDataArr = ^(NSMutableArray * _Nonnull dataArr) {
        self.tableView.dataArr = dataArr;
        self.searchDataArray = dataArr;
        self.dataArr = dataArr;
        [self.tableView reloadData];
    };
    
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
    self.tableView.isSearch = self.isSearch;
    self.tableView.dataArr = [self.searchResultArray mutableCopy];
    [self.tableView reloadData];
}
- (void)dealloc
{
    [XMHShoppingCartManager.sharedInstance clear];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
