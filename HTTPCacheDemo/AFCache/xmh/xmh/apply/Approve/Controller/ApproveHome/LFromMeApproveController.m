//
//  LFromMeApproveController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  我发起的

#import "LFromMeApproveController.h"
#import "LApproveFilterView.h"
#import "LApproveFilterBtnView.h"
#import "LApproveCellType1.h"
#import "LApproveCellType2.h"
#import "LApproveCellType3.h"
#import "LApproveCellType1.h"
#import "LApproveCellType4.h"
#import "LApproveCellType5.h"
#import "LApproveCellType6.h"
#import "LApproveCellType7.h"
#import "LApproveCellType8.h"
#import "LApproveCellType9.h"
#import "LApproveCellType10.h"
#import "ApproveRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
@interface LFromMeApproveController ()
////////<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LFromMeApproveController
{
    LApproveFilterBtnView * _filterBtnView;
    LApproveCommonModel * _approveCommonModel;
    NSInteger _page;
    NSString * _ptype;
    NSString * _pstate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
      _from = @"0";
    _page = 0;
    [self initSubViews];
    [self loadData];
    WeakSelf;
    _tb.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [weakSelf requestNetData];
    }];
    _tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
}
- (void)requestNetData{
    _page = 0;
    _filterBtnView.pState = @"";
    _filterBtnView.ptype = @"";
    [_dataSource removeAllObjects];
    [self loadData];
}
- (void)requestMoreNetData{
    _page ++;
    [self loadData];
}
- (void)endRefreshing{
    [_tb.mj_header endRefreshing];
    [_tb.mj_footer endRefreshing];
}
- (void)initSubViews
{
    [self creatNav];
    [self createTableView1];
    [self createFilterView];
}
- (void)loadData
{
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    [ApproveRequest requestFaQiApproveJoinCode:_joincode accountId:_accountId pageNum:page pageSize:nil ptype:_ptype keyword:nil state:_pstate resultBlock:^(LApproveCommonModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self endRefreshing];
            _approveCommonModel = model;
            for (LApproveDetailModel * detail in _approveCommonModel.list) {
                detail.isRead = YES;
            }
            if (_approveCommonModel.list.count ==0) {
                 [_tb.mj_footer endRefreshingWithNoMoreData];
            }else{
                [_dataSource addObjectsFromArray:_approveCommonModel.list];
            }
            [_tb reloadData];
        }
    }];
}
- (void)creatNav
{

   customNav * nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"我发起的" withleftTitleStr:nil withleftImageStr:@"stgkgl_fanhui" withRightBtnImag:@"stspyy_shaixuan_whilt" withRightBtnTitle:@"筛选" commenColor:YES];
    nav.backgroundColor = kColorTheme;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [nav.btnRight addTarget:self action:@selector(filter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    
}
- (void)filter
{
    _filterBtnView.hidden = NO;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)createFilterView
{
    _filterBtnView = [[LApproveFilterBtnView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
    [_filterBtnView.btnSure addTarget:self action:@selector(btnSure) forControlEvents:UIControlEventTouchUpInside];
    _filterBtnView.hidden = YES;
    _filterBtnView.isContainType = NO;
    [self.view addSubview:_filterBtnView];
}
- (void)createTableView1
{
    _tb.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, Heigh_View_normal);
}
- (void)btnSure
{
     [_dataSource removeAllObjects];
   _filterBtnView.hidden = YES;
   
    //筛选操作
    if ((![_ptype isEqualToString:_filterBtnView.ptype]) || (![_pstate isEqualToString:_filterBtnView.pState])) {
        _page = 0;
    }
    _pstate = _filterBtnView.pState;
    _ptype = _filterBtnView.ptype;
    [self loadData];
}

@end
