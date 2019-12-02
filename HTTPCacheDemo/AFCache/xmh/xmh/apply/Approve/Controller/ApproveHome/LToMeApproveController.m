//
//  LToMeApproveController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  抄送我的

#import "LToMeApproveController.h"
#import "LApproveFilterView.h"
#import "LApproveSearchAndFilterView.h"
#import "JasonSearchView.h"
#import "LApproveFilterBtnView.h"
#import "LApproveCellType1.h"
#import "LApproveCellType2.h"
#import "LApproveCellType3.h"
#import "LApproveCellType4.h"
#import "LApproveCellType5.h"
#import "LApproveCellType6.h"
#import "LApproveCellType7.h"
#import "LApproveCellType8.h"
#import "LApproveCellType9.h"
#import "LApproveCellType10.h"
#import "LApproveCommonModel.h"
#import "ApproveRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
@interface LToMeApproveController ()
//////////<UITableViewDataSource,UITableViewDelegate>
/** <##> */
@property (nonatomic, copy) NSString * keyword;
/** <##> */
@property (nonatomic, strong) JasonSearchView * searchView;
/** <##> */
@property (nonatomic, strong) UIButton * selectBtn;
@end

@implementation LToMeApproveController
{
    UILabel * _lb;
    UIView * _header;
    LApproveSearchAndFilterView * _searchAndFilterView;
//    JasonSearchView * _searchView;
//    NSString * _keyword;
    LApproveFilterBtnView * _filterBtnView;
//    UIButton * _selectBtn;
//    UITableView * _tb;
    LApproveCommonModel * _approveCommonModel;
//    NSString * _joincode;
//    NSString * _accountId;
    NSString * _ptype;
    NSInteger _unReadPage;
    NSInteger _allPage;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
        _from = @"1";
    self.view.backgroundColor = kBackgroundColor;
//    [self loadinitData];
    _unReadPage = 0;
    _allPage = 0;
    [self initSubViews];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshApprove) name:Approve_refreshListData object:nil];
    WeakSelf;
    _tb.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestNetData];
    }];
    
    _tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
}
- (void)requestNetData{
     _unReadPage = 0;
    _allPage = 0;
    _filterBtnView.pState = @"";
    _filterBtnView.ptype = @"";
    [_dataSource removeAllObjects];
    [self refreshApprove];
}
- (void)requestMoreNetData{
    _unReadPage ++;
    _allPage ++;
    [self refreshApprove];
}
- (void)endRefreshing{
    [_tb.mj_header endRefreshing];
    [_tb.mj_footer endRefreshing];
}
//- (void)loadinitData
//{
//    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
//    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
//    NSString * joincode = [ShareWorkInstance shareInstance].join_code;
//    _joincode = joincode;
//    _accountId = accountId;
//}
- (void)refreshApprove
{
    if (_selectBtn.tag ==0) {
        [self loadUnReadeData];
    }else{
        [self loadAllData];
    }
}
- (void)initSubViews
{
    [self createNav];
    [self createTitleSelectView];
    [self createApproveFilterView];
    [self createSearchView];
    [self createTableView1];
    [self createFilterView];
}
- (void)createNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"抄送我的" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    nav.backgroundColor = kColorTheme;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [self.view addSubview:nav];
}
- (void)createApproveFilterView
{
    LApproveSearchAndFilterView * view = [[[NSBundle mainBundle]loadNibNamed:@"LApproveSearchAndFilterView" owner:nil options:nil]lastObject];
    [view.btnFilter addTarget:self action:@selector(searchAndFilterClick:) forControlEvents:UIControlEventTouchUpInside];
    [view.btnSearch addTarget:self action:@selector(searchAndFilterClick:) forControlEvents:UIControlEventTouchUpInside];
    _searchAndFilterView = view;
    view.frame = CGRectMake(0, _header.bottom, SCREEN_WIDTH, 44);
    [self.view addSubview:view];
}
- (void)createFilterView
{
    _filterBtnView = [[LApproveFilterBtnView alloc]initWithFrame:CGRectMake(0, _header.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _header.bottom)];
    [_filterBtnView.btnSure addTarget:self action:@selector(btnSure) forControlEvents:UIControlEventTouchUpInside];
    _filterBtnView.hidden = YES;
    _filterBtnView.isContainType = YES;
    [self.view addSubview:_filterBtnView];
}
- (void)createTitleSelectView
{
    
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 45)];
    header.backgroundColor = kBackgroundColor;
    _header = header;
    UIView * containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [header addSubview:containerView];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kColorE5E5E5;
    [containerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kSeparatorHeight);
        make.right.bottom.left.equalTo(containerView);
    }];
    
    NSArray * arr = @[@"未读",@"全部"];
    for (int i = 0; i < arr.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(SCREEN_WIDTH/2 * i, 0, SCREEN_WIDTH/2, 43);
        [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
        [btn setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(15);
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [containerView addSubview:btn];
        if (i == 0) {
            [self click:btn];
        }
    }
    _lb = [[UILabel alloc] init];
    _lb.backgroundColor = kBtn_Commen_Color;
    CGFloat width = SCREEN_WIDTH/2;
    _lb.frame = CGRectMake((width - 40) / 2, 43, 40, 2);
    [containerView addSubview:_lb];
    containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:header];
}
- (void)createTableView1
{
//    _tb.frame = CGRectMake(0, Heigh_Nav + 65 + 44 + 1, SCREEN_WIDTH, Heigh_View_normal - 65 - 44);
    _tb.frame = CGRectMake(0, _searchAndFilterView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _searchAndFilterView.bottom - kSafeAreaBottom);
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)click:(UIButton *)btn
{
    _allPage = 0;
    _unReadPage = 0;
    _selectBtn.selected = NO;
    _ptype = @"";
    btn.selected = YES;
    _selectBtn = btn;
    
//    _lb.frame = CGRectMake(btn.left + 20, btn.bottom, btn.width - 40, 2);
    CGFloat width = SCREEN_WIDTH/2;
    CGFloat btnGap = (width - 40) / 2;
    _lb.frame = CGRectMake(btn.left + btnGap, btn.bottom, 40, 2);
    
    _keyword = @"";
    [_dataSource removeAllObjects];
    if (btn.tag ==0) {
        [self loadUnReadeData];
    }else{
        [self loadAllData];
    }
}
- (void)loadUnReadeData
{
    NSString * page = [NSString stringWithFormat:@"%ld",_unReadPage];
    [ApproveRequest requestDuplicateApproveJoinCode:_joincode accountId:_accountId pageNum:page pageSize:0 ptype:_ptype keyword:_keyword isAll:@"0" resultBlock:^(LApproveCommonModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self endRefreshing];
            _approveCommonModel = model;
            if (_approveCommonModel.list.count == 0) {
                [_tb.mj_footer endRefreshingWithNoMoreData];
            }else{
                [_dataSource addObjectsFromArray:_approveCommonModel.list];
                NSString * num = [NSString stringWithFormat:@"%ld",model.noReadNum];
                [_selectBtn setTitle:[NSString stringWithFormat:@"未读(%@)",num] forState:UIControlStateNormal];
            }
            [_tb reloadData];
        }
    }];
}
- (void)loadAllData
{
    NSString * page = [NSString stringWithFormat:@"%ld",_allPage];
    [ApproveRequest requestDuplicateApproveJoinCode:_joincode accountId:_accountId pageNum:page pageSize:@"10" ptype:_ptype keyword:_keyword isAll:@"1" resultBlock:^(LApproveCommonModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self endRefreshing];
            _approveCommonModel = model;
            if (_approveCommonModel.list.count == 0) {
                [_tb.mj_footer endRefreshingWithNoMoreData];
                [_tb reloadData];
            }else{
                [_dataSource addObjectsFromArray:_approveCommonModel.list];
                [_tb reloadData];
            }
            [_tb reloadData];
        }
    }];
}
- (void)searchAndFilterClick:(UIButton *)btn
{
    if (btn.tag == 1) {//搜索
        [_searchView.searchBar becomeFirstResponder];
        [self HidenSearchFilterViewShowSearchView];
    }else{
        _filterBtnView.hidden = NO;
        _searchAndFilterView.hidden = YES;
    }
}
- (void)HidenSearchFilterViewShowSearchView
{
    _searchView.hidden = NO;
    _searchAndFilterView.hidden = YES;
}
- (void)showSearchFilterViewHidenSearchView
{
    _searchView.hidden = YES;
    _searchAndFilterView.hidden = NO;
}
- (void)btnSure
{
     [_dataSource removeAllObjects];
    _filterBtnView.hidden = YES;
    _searchAndFilterView.hidden = NO;
    //筛选操作
    if (_ptype != _filterBtnView.ptype) { //切换筛选条件
        _unReadPage = 0;
        _allPage = 0;
    }
    _ptype = _filterBtnView.ptype;
    if (_selectBtn.tag ==0) {
        [self loadUnReadeData];
    }else{
        [self loadAllData];
    }
}
- (void)createSearchView
{
    WeakSelf
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, _header.bottom, SCREEN_WIDTH, 44)withPlaceholder:@"输入审批名称/审批编号"];
    [_searchView updateShenPiFrame];
    __weak  NSMutableArray * weakdataSource = _dataSource;
    _searchView.searchBar.btnRightBlock = ^{
        //搜索
        weakSelf.keyword = weakSelf.searchView.searchBar.text;
        [weakdataSource removeAllObjects];
        if (weakSelf.selectBtn.tag == 0) {
            [weakSelf loadUnReadeData];
        }else{
            [weakSelf loadAllData];
        }
        [weakSelf HidenSearchFilterViewShowSearchView];
        
    };
    _searchView.hidden = YES;
    [_searchView.searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _searchView.searchBar.btnleftBlock = ^{
        [weakSelf showSearchFilterViewHidenSearchView];
    };
    [self.view addSubview:_searchView];
}
- (void)textFieldDidChange:(UITextField *)tf
{
    
}
@end
