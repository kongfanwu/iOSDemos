//
//  XMHOrderSearchCustomerVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOrderSearchCustomerVC.h"
#import "customNav.h"
#import "JasonSearchView.h"
#import "ShareWorkInstance.h"
#import "MzzCustomerRequest.h"
#import "CustomerListModel.h"
#import "OrderSaleSearchCell.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "XMHBillRecoveryOrderRequest.h"
#import "XMHSuccessAlertView.h"
@interface XMHOrderSearchCustomerVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSString *_searchKeyWordStr;
    NSInteger _page;
    BOOL _isSearch;
   
}
@property (nonatomic, strong) JasonSearchView *searchNavView;
@property (nonatomic, strong) UIView *navBgView;
@property (strong, nonatomic) UIButton *searchButton;
@property (nonatomic, strong) UITableView *tablView;
@property (nonatomic, strong) CustomerListModel *customerListModel;
@property (nonatomic, strong) NSMutableArray *arrSource;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *noDataLab;
@property (nonatomic, strong) CustomerModel *model;

@end

@implementation XMHOrderSearchCustomerVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.navView.backgroundColor = kBtn_Commen_Color;

    for (UIButton *btn in self.navView.subviews) {
        
        [btn removeFromSuperview];
    }
    _arrSource = [NSMutableArray array];
    [self creatSubviews];
    [self createTablView];
    [self noDataView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tablView reloadData];
}
#pragma mark -- UI
- (void)creatSubviews
{
    self.navBgView = [[UIView alloc]initWithFrame:CGRectMake(0, StatusBarHeight, SCREEN_WIDTH, 44)];
    self.navBgView.backgroundColor = kBtn_Commen_Color;
    [self.navView addSubview:self.navBgView];
    [self.navBgView addSubview:[self searchView]];
    [self.navBgView addSubview:self.searchButton];
}
- (UIView *)searchView{
    UIView *searchBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60 , 44)];
    searchBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:searchBgView];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:UIImageName(@"order_search")];
    leftView.frame = CGRectMake(10, 0, 16, 17);
    
    UIView *leftBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16 + 20, 17)];
    [leftBGView addSubview:leftView];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, (SCREEN_WIDTH - 60) - 2 * 14, 33)];
    _textField.placeholder = @"请选择顾客的姓名或手机号";
    _textField.leftView = leftBGView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.layer.cornerRadius = 2;
    _textField.layer.masksToBounds = YES;
    _textField.returnKeyType = UIReturnKeyDefault;
    _textField.delegate = self;
    _textField.backgroundColor = RGBColor(250, 250, 250);
    _textField.textColor = kLabelText_Commen_Color_9;
    _textField.font = FONT_SIZE(13);
    [_textField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [searchBgView addSubview:_textField];
    return searchBgView;
}

- (void)createTablView
{
    _tablView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBgView.bottom ,SCREEN_WIDTH , SCREEN_HEIGHT - self.navBgView.bottom) style:UITableViewStylePlain];
    _tablView.backgroundColor = RGBColor(241,241,241);
    _tablView.delegate = self;
    _tablView.dataSource = self;
    _tablView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_tablView setSeparatorInset: UIEdgeInsetsZero];
    _tablView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tablView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tablView];
    _tablView.hidden = YES;
    WeakSelf
    _tablView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
   
}

#pragma mark -- tablView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *OrderSaleSearchCellindentifier = @"OrderSaleSearchCellindentifier";
    OrderSaleSearchCell *cell;
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderSaleSearchCell" owner:nil options:nil] firstObject];
    }else{
        cell  = [tableView dequeueReusableCellWithIdentifier:OrderSaleSearchCellindentifier];
    }
    if (indexPath.row<_arrSource.count) {
        CustomerModel *model = _arrSource[indexPath.row];
        [cell freshOrderSaleSearchCell:model];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_selectedCustomer) {
        CustomerModel *model = [_arrSource safeObjectAtIndex:indexPath.row];
        _isSearch = NO;
        self.model = model;
        [self loadSidebarSData];
       
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

- (void)noDataView
{
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"未查找到您要搜索的顾客";
    lab.textColor = kLabelText_Commen_Color_6;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    lab.frame = CGRectMake(0, self.navBgView.bottom + 25, SCREEN_WIDTH, 100);
    self.noDataLab = lab;
    self.noDataLab.hidden = YES;
}
#pragma mark -- 请求

- (void)requestMoreNetData{
    _page++;
    [self requestData];
}
- (void)requestData{
   
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *token = model.data.token;
    NSMutableDictionary *parmsDic = [[NSMutableDictionary alloc]init];
    [parmsDic setValue:[NSString stringWithFormat:@"%ld",(long)_page] forKey:@"page"];
    [parmsDic setValue:token forKey:@"token"];
    [parmsDic setValue:[ShareWorkInstance shareInstance].join_code forKey:@"join_code"];

    
    if (self.textField.text.length > 0) {
        [parmsDic setValue:_searchKeyWordStr forKey:@"q"];
    }
    WeakSelf
    [MzzCustomerRequest requestCustomerListParams:parmsDic resultBlock:^(CustomerListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        _customerListModel = listModel;
        if (isSuccess) {
            if (_customerListModel.list.count > 0) {
                [_arrSource safeAddObjectsFromArray:_customerListModel.list];
            }else{
                _page--;
            }
        }
        [weakSelf.tablView.mj_footer endRefreshing];
        [weakSelf.tablView reloadData];
        if (!_arrSource.count) {
            weakSelf.noDataLab.hidden = NO;
             weakSelf.tablView.hidden = YES;
        }else{
            weakSelf.noDataLab.hidden = YES;
            weakSelf.tablView.hidden = NO;
        }
    }];
}
/**
 获取侧边栏数据
 */
- (void)loadSidebarSData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_fromRecoverBill ) {
        [params setValue:@"2" forKey:@"type"];
        [params setValue:@(self.model.uid) forKey:@"user_id"];
        [XMHBillRecoveryOrderRequest requestBillRecoverySidebarParams:params resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
            
            if (isSuccess) {
                if (!resultArr.count && self.model) {
                      [[[XMHSuccessAlertView alloc]initWithTitle:@"该用户没有任何可以回收的商品"]show];
                }else{
                  
                    _selectedCustomer(self.model);
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }
            
        }];
    }else{
            _selectedCustomer(self.model);
    
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}
#pragma mark -- layzer

- (UIButton *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _searchButton.frame =CGRectMake(SCREEN_WIDTH-80, 0, 80, 44);
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
   
}

- (void)searchButtonAction{
    
    if ([self.searchButton.currentTitle isEqualToString:@"取消"]) {
        _isSearch = NO;
        [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else {
        _page = 1;
        [self.arrSource removeAllObjects];
        [self requestData];
        [self.searchButton setTitle:@"取消" forState:UIControlStateNormal];
    }
}

#pragma mark -------UITextFieldDelegate---------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (!textField.text.length) {
        _isSearch = NO;
        self.tablView.hidden = YES;
        [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    }else{
        _page = 1;
        [self.arrSource removeAllObjects];
        [self requestData];
        [self.searchButton setTitle:@"取消" forState:UIControlStateNormal];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!textField.text.length) {
        self.noDataLab.hidden = YES;
        self.tablView.hidden = YES;
        [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    }
}
-(void)textFieldTextChange:(UITextField *)textField{
    _isSearch = YES;
    _searchKeyWordStr = textField.text;
    if (_searchKeyWordStr == nil || _searchKeyWordStr.length <= 0) {
        _textField.textColor = kLabelText_Commen_Color_9;
       
    }else{
        _textField.textColor = kColor3;
    }
}

@end
