//
//  BeautyCustomersVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCustomersVC.h"
#import "choiseCustomerHeader.h"
#import "TheOneCustomerViewController.h"
#import "BeautyRequest.h"
#import "JasonSearchView.h"
#import "MzzCustomerRequest.h"
#import "CustomerListModel.h"
#import "ShareWorkInstance.h"
#import "BeautyCustomerCommonCell.h"
#import "UserManager.h"
#import "BeautyWZVC.h"
#import "BeautyBillDetailVC.h"
#import "XMHRefreshGifHeader.h"
#import "BeautyProgressView.h"
@interface BeautyCustomersVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)BeautyProgressView * beautyProgressView;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
/** <##> */
@property (nonatomic, copy) NSString *searchQ;;
@end

@implementation BeautyCustomersVC
{
    __block UITableView *_tbView;
    choiseCustomerHeader *_tbHeaderView;
    BeautyRequest       *_guKeRequest;
    NSIndexPath         *_lastindexPath;
    JasonSearchView     *_searchView;
    CustomerListModel *_customerListModel;
    
    //数据源
    NSMutableArray  *_sourceArr;
    NSInteger   page;
    BOOL _firstRequest;
//    NSString *_searchQ;
    
    UIView *header;
}
- (BeautyProgressView *)beautyProgressView
{
    if (!_beautyProgressView) {
        _beautyProgressView = loadNibName(@"BeautyProgressView");
        _beautyProgressView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 100);
    }
    return _beautyProgressView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    _guKeRequest = [[BeautyRequest alloc]init];
    _sourceArr = [[NSMutableArray alloc]init];
    _searchQ = @"";
    page = 1;
    [self creatNav];
    [self initSubviews];
}
- (void)creatNav{
//    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"选择顾客" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
//    nav.backgroundColor = kBtn_Commen_Color;
//    nav.lbTitle.textColor = [UIColor whiteColor];
//    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nav];
    [self.navView setNavViewTitle:@"选择顾客" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
}
- (void)initSubviews{
    
    _tbHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"choiseCustomerHeader" owner:nil options:nil] firstObject];
    _tbHeaderView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 100);
    [_tbHeaderView reFreshchoiseCustomerHeader:1];
//    [self.view addSubview:_tbHeaderView];
    [self.view addSubview:self.beautyProgressView];
    [_beautyProgressView updateBeautyProgressViewIndex:1];
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _beautyProgressView.bottom + 10,SCREEN_WIDTH,SCREEN_HEIGHT - _beautyProgressView.bottom - 10) style:UITableViewStylePlain];
    _tbView.separatorColor = [UIColor clearColor];
    _tbView.backgroundColor = Color_NormalBG;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    
    WeakSelf;
    _tbView.mj_header = self.gifHeader;
//    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf refreshData];
//    }];
    _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
    [self refreshData];
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                __strong typeof(_self) self = _self;
                [self refreshData];
            });
        }];
    }
    return _gifHeader;
}
- (void)refreshData{
    page = 1;
    _firstRequest = YES;
    [self requestNetData];
}
- (void)requestNetData{
    //顾客列表
    
    NSMutableDictionary *parmsDic = [[NSMutableDictionary alloc]init];
    NSString *oneClick = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    [parmsDic setValue:oneClick forKey:@"fram_id"];
    [parmsDic setValue:account forKey:@"account"];
    
    [parmsDic setValue:[ShareWorkInstance shareInstance].join_code?[ShareWorkInstance shareInstance].join_code:@"" forKey:@"join_code"];
    [parmsDic setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [parmsDic setValue:_searchQ forKey:@"q"];
    [MzzCustomerRequest requestBeautyCustomerListParams:parmsDic resultBlock:^(CustomerListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        _customerListModel = listModel;
        if (isSuccess) {
            if (_firstRequest) {
                [_sourceArr removeAllObjects];
                [_sourceArr addObjectsFromArray:_customerListModel.list];
                [_tbView reloadData];
            }else{
                if (_customerListModel.list.count == 0) {
                    page--;
                }else{
                    [_sourceArr addObjectsFromArray:_customerListModel.list];
                    [_tbView reloadData];
                }
            }
            //            [_orginsourceArr addObjectsFromArray:_customerListModel.list];
            
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kBeautyCustomerCommonCell = @"kBeautyCustomerCommonCell";
    BeautyCustomerCommonCell * customerCell = [tableView dequeueReusableCellWithIdentifier:kBeautyCustomerCommonCell];
    if (!customerCell) {
        customerCell = loadNibName(@"BeautyCustomerCommonCell");
    }
    [customerCell updateBeautyCustomerCommonCellModel:_sourceArr[indexPath.row]];
    return customerCell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (!header) {
        header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 63)];
        header.backgroundColor = [UIColor whiteColor];
        _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH- 60, 39)withPlaceholder:@"输入顾客姓名或手机号"];
        _searchView.layer.cornerRadius = 3;
        _searchView.layer.masksToBounds = YES;
//        UILabel * lb = [[UILabel alloc] init];
//        lb.text = @"搜索";
//        lb.font = FONT_SIZE(15);
//        lb.textColor = kLabelText_Commen_Color_6;
//        lb.frame = CGRectMake(_searchView.right - 15, 0, 60, 63);
//        lb.textAlignment = NSTextAlignmentCenter;
        [header addSubview:_searchView];
//        [header addSubview:lb];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(15);
        btn.frame = CGRectMake(_searchView.right - 15, 0, 60, 63);
        __weak typeof(self) _self = self;
        [btn bk_whenTapped:^{
            __strong typeof(_self) self = _self;
            [self refreshData];
        }];
        [header addSubview:btn];
    }
    _searchView.line1.hidden = YES;
    WeakSelf;
    __weak JasonSearchView    *tempsearchView = _searchView;
    __weak typeof(self) _self = self;
    _searchView.searchBar.btnRightBlock = ^{
        __strong typeof(_self) self = _self;
        //搜索
        self.searchQ = tempsearchView.searchBar.text;
        [weakSelf refreshData];
    };
    _searchView.searchBar.btnleftBlock = ^{
        __strong typeof(_self) self = _self;
        self.searchQ = @"";
        [weakSelf refreshData];
    };
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 0.6)];
    line.backgroundColor = kColorE5E5E5;
    [header addSubview:line];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sourceArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomerModel * model = _sourceArr[indexPath.row];
    [ShareWorkInstance shareInstance].uid = model.uid;
    BeautyWZVC * next = [[BeautyWZVC alloc] init];
    [ShareWorkInstance shareInstance].store_code = model.store_code;
    [self.navigationController pushViewController:next animated:NO];
    /** 测试入口 */
//    BeautyBillDetailVC * next = [[BeautyBillDetailVC alloc]init];
//    next.userID = [NSString stringWithFormat:@"%ld",model.uid];
//    [self.navigationController pushViewController:next animated:NO];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
