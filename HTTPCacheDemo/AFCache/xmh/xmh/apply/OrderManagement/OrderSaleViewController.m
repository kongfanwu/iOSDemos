//
//  OrderSaleViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OrderSaleViewController.h"
#import "OrderBillViewController.h"
#import "JasonSearchView.h"
#import "SLRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "OrderSaleSearchCell.h"
#import "SaleServiceViewController.h"
#import "ShareWorkInstance.h"
#import "MzzCustomerRequest.h"
#import "CustomerListModel.h"
#import "XMHRefreshGifHeader.h"
@interface OrderSaleViewController ()
{
    NSString *_strTitle;
    CGFloat _searchBegainx;
    
    NSMutableArray *_arrSource;
    
    CustomerModel *_choisemodel;
    
    OrderSaleSearchCell *_cellView;
    BOOL _isHaveSource;
    NSInteger _billType;//制单的类型 1、服务单 2、销售服务单
    NSInteger page;
    CustomerListModel *_customerListModel;
    BOOL _firstRequest;
    
    NSString *_searchKeyWordStr;
    
    UIView  *_linex;
}
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIImageView *topLine;
@property (weak, nonatomic) IBOutlet UIImageView *topLine2;
@property (weak, nonatomic) IBOutlet UILabel *lbType;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLineTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTop;
@property (weak, nonatomic) IBOutlet UIButton *btnKaiDan;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneLineTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTop;



@property (strong, nonatomic)JasonSearchView    *searchView;
@property (strong, nonatomic)customNav *nav;
@property (strong, nonatomic)UIButton *searchButton;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;

@end

@implementation OrderSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchKeyWordStr = @"";
    if (IS_IPHONE_X) {
        _imageTop.constant = 88;
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initData];
    [self initSubviews];
    _tbView.hidden = YES;
    _btnKaiDan.hidden = YES;
    if ([self.from isEqualToString:@"补齐项目"]) {
        [self initViewCellView];
    }
}
- (void)initData{
    _strTitle = nil;
    if (_isService) {
        _strTitle = @"服务制单";
        _lbName.hidden = YES;
        _searchBegainx = 0;
        _lbType.text = @"请选择服务制单类型";
        _lb1.text = @"服务单";
        _lb2.text = @"销售服务单";
        [_btn1 setImage:[UIImage imageNamed:@"fuwudan"] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"kaixiaoshoufuwudan_"] forState:UIControlStateNormal];
        _btn3.hidden = YES;
        _lb3.hidden = YES;
        _btn4.hidden = YES;
        _lb4.hidden = YES;
        _tableViewTop.constant = 64;
    } else {
        _strTitle = @"销售制单";
        _lbName.hidden = YES;
        _searchBegainx = 0;
        _tableViewTop.constant = 64;
        if ([self.from isEqualToString:@"补齐项目"]) {
            _lb1.text = @"固定制单";
            _lb2.text = @"个性制单";
            [_btn1 setImage:[UIImage imageNamed:@"gudingzhidan"] forState:UIControlStateNormal];
            [_btn2 setImage:[UIImage imageNamed:@"gexingzhidan"] forState:UIControlStateNormal];
            _btn3.hidden = YES;
            _lb3.hidden = YES;
            _btn4.hidden = YES;
            _lb4.hidden = YES;
        }
    }
    _arrSource = [[NSMutableArray alloc]init];
    WeakSelf;
    _tbView.mj_header = self.gifHeader;
//    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf refreshData];
//    }];
    _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self refreshData];
            });
        }];
    }
    return _gifHeader;
}
- (void)refreshData{
    page = 0;
    _firstRequest = YES;
    [self requestNetData];
}
- (void)requestNetData{
    //顾客列表
    NSMutableDictionary *parmsDic = [[NSMutableDictionary alloc]init];
    [parmsDic setValue:[ShareWorkInstance shareInstance].coneClick?[ShareWorkInstance shareInstance].coneClick:@"" forKey:@"oneClick"];
    [parmsDic setValue:@"-1" forKey:@"twoListId"];
    [parmsDic setValue:[ShareWorkInstance shareInstance].cinId?[ShareWorkInstance shareInstance].cinId:@"" forKey:@"inId"];
    [parmsDic setValue:[ShareWorkInstance shareInstance].join_code?[ShareWorkInstance shareInstance].join_code:@"" forKey:@"join_code"];
    [parmsDic setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    if (_searchView.searchBar.text) {
        [parmsDic setValue:_searchKeyWordStr forKey:@"q"];
    }
    [MzzCustomerRequest requestCustomerListParams:parmsDic resultBlock:^(CustomerListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        _customerListModel = listModel;
        [self endRefreshing];
        if (isSuccess) {
            if (_firstRequest) {
                [_arrSource removeAllObjects];
            }else{
                if (listModel.list.count == 0) {
                    page--;
                }
            }
            if (listModel.list.count) {
                _isHaveSource = YES;
            }
            _tbView.hidden = NO;
            _topLineTop.constant = 10;

            [_arrSource addObjectsFromArray:_customerListModel.list];
            [_tbView reloadData];
        }else{
            if (!_firstRequest) {
                page--;
            }
        }
        [self endRefreshing];
    }];
}
- (void)requestMoreNetData{
    page++;
    _firstRequest = NO;
    [self requestNetData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (customNav *)nav{
    if (!_nav) {
        _nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:_strTitle withleftImageStr:@"stgkgl_fanhui" withRightStr:@"取消"];
        _nav.btnRight.hidden = YES;
        [_nav.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nav.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _nav.backgroundColor = kBtn_Commen_Color;
        _nav.lbTitle.textColor = [UIColor whiteColor];
        [_nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        [_nav.btnRight addTarget:self action:@selector(closeSechView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nav;
}
-(JasonSearchView *)searchView
{
    if (!_searchView) {
        _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(_searchBegainx, _imageTop.constant+12, SCREEN_WIDTH - _searchBegainx, 39)withPlaceholder:@"输入顾客姓名或手机号"];
        _searchView.searchBar.frame = CGRectMake(15,0, SCREEN_WIDTH - 30 - 60, 35);
    }
    return _searchView;
}
-(UIButton *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _searchButton.frame = CGRectMake(SCREEN_WIDTH-65, 0, 60, 35);
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}
- (void)initSubviews{
    [self.view addSubview:self.nav];
    [self.searchView addSubview:self.searchButton];
    [self.view addSubview:self.searchView];
//    _searchView.center = CGPointMake(_searchView.center.x, _lbName.center.y);
    _searchView.line1.hidden = YES;
    _searchView.searchBar.layer.masksToBounds = YES;
    _searchView.searchBar.layer.cornerRadius = 5;
    __block UITableView *tempTable =_tbView;
    
    WeakSelf;
    __block JasonSearchView *tmpSearch =_searchView;

    __weak NSMutableArray * weakArr = _arrSource;
    //光标选中搜索框
    if (![self.from isEqualToString:@"补齐项目"]){
        _searchView.searchBar.btnRightBlock = ^{
            //搜索
            if (tmpSearch.searchBar.text) {
                _searchKeyWordStr = tmpSearch.searchBar.text;
                [weakSelf refreshData];
            }
        };
        
        _searchView.searchBar.btnleftBlock = ^{
            tempTable.hidden = YES;
            weakSelf.nav.lbTitle.hidden = NO;
            weakSelf.nav.btnLet.hidden = NO;
            weakSelf.nav.btnRight.hidden = YES;
            weakSelf.searchButton.hidden = NO;
            [weakSelf touchCloseCellViewHidenOrNo];
            tmpSearch.frame = CGRectMake(0, _imageTop.constant+12, SCREEN_WIDTH , 39);
            tmpSearch.searchBar.frame = CGRectMake(15,0, SCREEN_WIDTH - 30 - 60, 35);
            
        };
        
        _searchView.btnSearchBlock = ^{
            weakSelf.nav.lbTitle.hidden = YES;
            weakSelf.nav.btnLet.hidden = YES;
            weakSelf.nav.btnRight.hidden = NO;
            tempTable.hidden = NO;
            weakSelf.searchButton.hidden = YES;
            tmpSearch.frame = CGRectMake(15, 28, SCREEN_WIDTH - _searchBegainx-80, 29);
            tmpSearch.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH - _searchBegainx-80, 29);
            [weakArr removeAllObjects];
            [weakSelf.tbView reloadData];
        };
    }
    _btnKaiDan.layer.cornerRadius = 5;
}
//导航栏右侧取消按钮触发事件
-(void)closeSechView
{
    _tbView.hidden = YES;
    self.nav.lbTitle.hidden = NO;
    self.nav.btnLet.hidden = NO;
    self.nav.btnRight.hidden = YES;
    self.searchButton.hidden = NO;
    [self touchCloseCellViewHidenOrNo];
    _searchView.frame = CGRectMake(0, _imageTop.constant+12, SCREEN_WIDTH , 39);
    _searchView.searchBar.frame = CGRectMake(15,0, SCREEN_WIDTH - 30-60, 35);
    [_searchView.searchBar resignFirstResponder];
    [_arrSource removeAllObjects];
    [self.tbView reloadData];
}
-(void)touchCloseCellViewHidenOrNo
{
    if (_searchKeyWordStr.length==0&&[self.from isEqualToString:@"补齐项目"]) {
        _cellView.hidden = NO;
        [self resetFrame];

    }else{
        if (_searchKeyWordStr.length==0&&!_choisemodel) {
            _cellView.hidden = YES;
        }else{
            _cellView.hidden = NO;
            [self resetFrame];

        }
    }
}
//点击搜索按钮
-(void)searchButtonAction
{
    if (![self.from isEqualToString:@"补齐项目"]) {
        _searchView.searchBar.text = @"";
        _searchKeyWordStr = @"";
        self.nav.lbTitle.hidden = YES;
        self.nav.btnLet.hidden = YES;
        self.nav.btnRight.hidden = NO;
        _tbView.hidden = NO;
        self.searchButton.hidden = YES;
        _searchView.frame = CGRectMake(15, 28, SCREEN_WIDTH - _searchBegainx-80, 29);
        _searchView.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH - _searchBegainx-80, 29);
        [_arrSource removeAllObjects];
        [self.tbView reloadData];
    }
}

- (void)initLinex{
    _linex = [[UIView alloc]initWithFrame:CGRectMake(0, _searchView.bottom+6, SCREEN_WIDTH, 0.5)];
    _linex.backgroundColor = [ColorTools colorWithHexString:@"e5e5e5"];
    [self.view insertSubview:_linex atIndex:0];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<_arrSource.count) {
        self.from = @"";
        _choisemodel = _arrSource[indexPath.row];
        _searchKeyWordStr = _choisemodel.uname;
    }
    _tbView.hidden = YES;
    _cellView.hidden = NO;
    [self closeSechView];
    [self initViewCellView];

}
//顾客View
-(void)initViewCellView{
    if (!_cellView) {
        _cellView = [[[NSBundle mainBundle] loadNibNamed:@"OrderSaleSearchCell" owner:nil options:nil] firstObject];
        _cellView.frame = CGRectMake(0, _searchView.bottom+5, SCREEN_WIDTH, 84);
        [self.view addSubview:_cellView];
        [self.view sendSubviewToBack:_cellView];
    }
    [self resetFrame];
    if ([self.from isEqualToString:@"补齐项目"]) {
        [_cellView freshOrderCell:self.Dingdanmodel];
        _searchView.searchBar.text = self.Dingdanmodel.user_name;
    }else{
        [_cellView freshOrderSaleSearchCell:_choisemodel];
        _searchView.searchBar.text = _choisemodel.uname;
    }
    [self initLinex];
}
- (void)resetFrame{
    _topLineTop.constant = 120;
    _oneLineTop.constant = 10;
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)btn1Event:(UIButton *)sender {
    if (![self.from isEqualToString:@"补齐项目"]){
        if (!_isHaveSource) {
            [MzzHud toastWithTitle:@"" message:@"请搜索顾客"];
            return;
        }
    }
    if (_isService) {
        //服务单
        SaleServiceViewController*VC = [[SaleServiceViewController alloc]init];
        VC.user_id = _choisemodel.uid;
        VC.name = _choisemodel.uname;
        VC.mobile = _choisemodel.mobile;
        VC.store_code = _choisemodel.store_code;
        VC.billType = 1;
        [self.navigationController pushViewController:VC animated:NO];
    }else{
        //固定制单
        SaleServiceViewController*VC = [[SaleServiceViewController alloc]init];
        if ([self.from isEqualToString:@"补齐项目"]) {
            VC.user_id = self.Dingdanmodel.user_id;
            VC.name = self.Dingdanmodel.user_name;
            VC.mobile = self.Dingdanmodel.user_mobile;
            VC.store_code = self.Dingdanmodel.store_code;
            VC.toPayMoney = [self.Dingdanmodel.amount floatValue];
            VC.ordernum = self.Dingdanmodel.ordernum;
        }else{
            VC.user_id = _choisemodel.uid;
            VC.name = _choisemodel.uname;
            VC.mobile = _choisemodel.mobile;
            VC.store_code = _choisemodel.store_code;
        }
        
        VC.billType = 3;
        VC.isSale = YES;
        [self.navigationController pushViewController:VC animated:NO];
    }
}
- (IBAction)btn2Event:(UIButton *)sender {
    if (![self.from isEqualToString:@"补齐项目"]){
        if (!_isHaveSource) {
            [MzzHud toastWithTitle:@"" message:@"请搜索顾客"];
            return;
        }
    }
    if (_isService) {
        //销售服务单
        SaleServiceViewController*VC = [[SaleServiceViewController alloc]init];
        VC.user_id = _choisemodel.uid;
        VC.name = _choisemodel.uname;
        VC.mobile = _choisemodel.mobile;
        VC.store_code = _choisemodel.store_code;
        VC.billType = 2;
        [self.navigationController pushViewController:VC animated:NO];
    }else{
        if ([self.from isEqualToString:@"补齐项目"]) {
            //个性制单
            SaleServiceViewController*VC = [[SaleServiceViewController alloc]init];
            VC.user_id = self.Dingdanmodel.user_id;
            VC.name = self.Dingdanmodel.user_name;
            VC.mobile = self.Dingdanmodel.user_mobile;
            VC.store_code = self.Dingdanmodel.store_code;
            VC.toPayMoney = [self.Dingdanmodel.amount floatValue];
            VC.ordernum = self.Dingdanmodel.ordernum;
            VC.billType = 5;
            VC.isSale = YES;
            [self.navigationController pushViewController:VC animated:NO];
        }else{
            //已购置换
            SaleServiceViewController*VC = [[SaleServiceViewController alloc]init];
            VC.user_id = _choisemodel.uid;
            VC.name = _choisemodel.uname;
            VC.mobile = _choisemodel.mobile;
            VC.store_code = _choisemodel.store_code;
            VC.billType = 4;
            VC.isSale = YES;
            [self.navigationController pushViewController:VC animated:NO];
        }

    }
}
- (IBAction)btn3Event:(UIButton *)sender {
    if (![self.from isEqualToString:@"补齐项目"]){
        if (!_isHaveSource) {
            [MzzHud toastWithTitle:@"" message:@"请搜索顾客"];
            return;
        }
    }
    //个性制单
    SaleServiceViewController*VC = [[SaleServiceViewController alloc]init];
    VC.user_id = _choisemodel.uid;
    VC.name = _choisemodel.uname;
    VC.mobile = _choisemodel.mobile;
    VC.store_code = _choisemodel.store_code;
    
    VC.billType = 5;
    VC.isSale = YES;
    [self.navigationController pushViewController:VC animated:NO];
}
- (IBAction)btn4Event:(UIButton *)sender {
    if (![self.from isEqualToString:@"补齐项目"]){
        if (!_isHaveSource) {
            [MzzHud toastWithTitle:@"" message:@"请搜索顾客"];
            return;
        }
    }
    //升卡续卡
    SaleServiceViewController*VC = [[SaleServiceViewController alloc]init];
    VC.user_id = _choisemodel.uid;
    VC.name = _choisemodel.uname;
    VC.mobile = _choisemodel.mobile;
    VC.store_code = _choisemodel.store_code;
    
    VC.billType = 6;
    VC.isSale = YES;
    [self.navigationController pushViewController:VC animated:NO];
}
- (IBAction)toBillEvent:(UIButton *)sender {
    
    if (![self.from isEqualToString:@"补齐项目"]){
        if (!_isHaveSource) {
            [MzzHud toastWithTitle:@"" message:@"请搜索顾客"];
            return;
        }
    }
    
    if (!_billType) {
        [MzzHud toastWithTitle:@"" message:@"请选择开单类型"];
        return;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
