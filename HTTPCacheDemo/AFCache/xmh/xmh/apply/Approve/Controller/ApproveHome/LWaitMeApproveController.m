//
//  LWaitMeApproveController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LWaitMeApproveController.h"
#import "ApproveRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "LApproveFilterView.h"
//#import "LApproveCellType1.h"
//#import "LApproveCellType2.h"
//#import "LApproveCellType3.h"
//#import "LApproveCellType4.h"
//#import "LApproveCellType5.h"
//#import "LApproveCellType6.h"
//#import "LApproveCellType7.h"
//#import "LApproveCellType8.h"
//#import "LApproveCellType9.h"
//#import "LApproveCellType10.h"
#import "LApproveCommonModel.h"
#import "LApproveSearchAndFilterView.h"
#import "JasonSearchView.h"
#import "LApproveFilterBtnView.h"
#import "XMHRefreshGifHeader.h"
@interface LWaitMeApproveController ()


////////<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
/** <##> */
@property (nonatomic, strong) JasonSearchView * searchView;;
/** <##> */
@property (nonatomic, copy) NSString * keyword;;
/** <##> */
@property (nonatomic, strong) UIButton * selectBtn;;
@end

@implementation LWaitMeApproveController
{
//    UIButton * _selectBtn;
    UILabel * _lb;
    NSArray * _stateArr;
    NSArray * _typeArr;
    LApproveCommonModel * _approveCommonModel;
    LApproveSearchAndFilterView * _searchAndFilterView;
//    JasonSearchView * _searchView;
    UIView * _header;
    LApproveFilterBtnView * _filterBtnView;
//    NSString * _keyword;
    NSString * _ptype;
    
    NSInteger _unReadPage;
    NSInteger _allPage;
}

- (void)dealloc
{
    _filterBtnView = nil;
}

- (void)viewDidLoad {
     [super viewDidLoad];
//    [self loadinitData];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _from = @"-1";
    _unReadPage = 0;
    _allPage = 0;
    
    [self initSubViews];
    self.view.backgroundColor = kBackgroundColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshApprove) name:Approve_refreshListData object:nil];
    WeakSelf;

    _tb.mj_header = self.gifHeader;
//    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        [weakSelf requestNetData];
//    }];

    
    _tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestNetData];
        }];
    }
    return _gifHeader;
}
- (void)requestNetData{
    _unReadPage = 0;
    _allPage = 0;
    _filterBtnView.pState = @"";
    _filterBtnView.ptype = @"";
    [_dataSource removeAllObjects];
    [self requestApproveData];
}
- (void)requestMoreNetData{
    _unReadPage ++;
    _allPage ++;
    [self requestApproveData];
}
- (void)endRefreshing{
    [_tb.mj_header endRefreshing];
    [_tb.mj_footer endRefreshing];
}
- (void)refreshApprove
{
    [_dataSource removeAllObjects];
    if (_selectBtn.tag == 0) {
        [self loadWaitApproveData];
    }else{
        [self loadCompleteApproveData];
    }
}
- (void)requestApproveData
{
    if (_selectBtn.tag == 0) {
        [self loadWaitApproveData];
    }else{
        [self loadCompleteApproveData];
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
- (void)createNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"我审批的" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    nav.backgroundColor = kColorTheme;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [self.view addSubview:nav];
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
        make.left.right.bottom.equalTo(containerView);
    }];
    
    NSArray * arr = @[@"待我审批的(0)",@"我已审批的"];
    for (int i = 0; i < arr.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(SCREEN_WIDTH/2 * i, 0, SCREEN_WIDTH/2, 43);
        [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
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
//    [_lb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(40, 2));
//        make.bottom.equalTo(containerView);
//        make.centerX.equalTo();
//    }];
    containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:header];
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
- (void)createSearchView
{
    WeakSelf
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, _header.bottom, SCREEN_WIDTH, 44)withPlaceholder:@"输入审批名称/审批编号"];
    [_searchView updateHaoKaFrame];
    _searchView.searchBar.btnRightBlock = ^{
        //搜索
        weakSelf.keyword =  weakSelf.searchView.searchBar.text;
        if (weakSelf.selectBtn.tag == 0) {
            [weakSelf loadWaitApproveData];
        }else{
            [weakSelf loadCompleteApproveData];
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
- (void)createFilterView
{
    _filterBtnView = [[LApproveFilterBtnView alloc]initWithFrame:CGRectMake(0, _header.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _header.bottom - kSafeAreaBottom)];
    [_filterBtnView.btnSure addTarget:self action:@selector(btnSure) forControlEvents:UIControlEventTouchUpInside];
    _filterBtnView.hidden = YES;
     _filterBtnView.isContainType = YES;
    [self.view addSubview:_filterBtnView];
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
    if (_selectBtn.tag == 0) {
        [self loadWaitApproveData];
    }else{
        [self loadCompleteApproveData];
    }
}
- (void)showSearchFilterViewHidenSearchView
{
    _searchView.hidden = YES;
    _searchAndFilterView.hidden = NO;
}
- (void)HidenSearchFilterViewShowSearchView
{
    _searchView.hidden = NO;
    _searchAndFilterView.hidden = YES;
}
- (void)textFieldDidChange:(UITextField *)tf
{
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)createTableView1
{
//      _tb.frame = CGRectMake(0, Heigh_Nav + 65 + 44 + 1, SCREEN_WIDTH, Heigh_View_normal - 65 - 44);
    _tb.frame = CGRectMake(0, Heigh_Nav + 45 + 44, SCREEN_WIDTH, Heigh_View_normal - 65 - 44);
}
- (void)click:(UIButton *)btn
{
    _ptype = @"";
    _unReadPage = 0;
    _allPage = 0;
    _selectBtn.selected = NO;
    btn.selected = YES;
    _selectBtn = btn;
    
    CGFloat width = SCREEN_WIDTH/2;
    CGFloat btnGap = (width - 40) / 2;
    _lb.frame = CGRectMake(btn.left + btnGap, btn.bottom, 40, 2);
    
    _keyword = @"";
    [_dataSource removeAllObjects];
    if (btn.tag ==0) {
//        _filterBtnView.isContainType = YES;
        [self loadWaitApproveData];
        _from = @"-1,0"; //带我审批

    }else{
//        _filterBtnView.isContainType = NO;
        _from = @"-1,1"; //我审批的
        [self loadCompleteApproveData];
    }
}
- (void)loadWaitApproveData
{
    NSString * page = [NSString stringWithFormat:@"%ld",_unReadPage];
    [ApproveRequest requestWaitApproveJoinCode:_joincode accountId:_accountId pageNum:page pageSize:nil ptype:_ptype keyword:_keyword resultBlock:^(LApproveCommonModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self endRefreshing];
            _approveCommonModel = model;
            if (_approveCommonModel.list.count == 0) {
                 [_tb.mj_footer endRefreshingWithNoMoreData];
            }else{
                [_dataSource addObjectsFromArray:_approveCommonModel.list];
                [_selectBtn setTitle:[NSString stringWithFormat:@"待我审批的(%ld)",model.total] forState:UIControlStateNormal];
            }
            [_tb reloadData];
        }
    }];
}
- (void)loadCompleteApproveData
{
    NSString * page = [NSString stringWithFormat:@"%ld",_allPage];
    [ApproveRequest requestCompleteApproveJoinCode:_joincode accountId:_accountId pageNum:page pageSize:nil ptype:_ptype keyword:_keyword resultBlock:^(LApproveCommonModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _approveCommonModel = model;
             [self endRefreshing];
            for (LApproveDetailModel * detail in _approveCommonModel.list) {
                detail.isRead = YES;
            }
            if (_approveCommonModel.list.count == 0) {
                [_tb.mj_footer endRefreshingWithNoMoreData];
            }else{
                [_dataSource addObjectsFromArray:_approveCommonModel.list];
            }
            [_tb reloadData];
        }
    }];
}
@end
