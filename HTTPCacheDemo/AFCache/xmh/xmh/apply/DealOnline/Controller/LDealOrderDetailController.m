//
//  LDealOrderDetailController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LDealOrderDetailController.h"
#import "LDeatailDaiFaHuoCell.h"
#import "JasonSearchView.h"
#import "OnLineRequest.h"
#import "OOrderListModel.h"
#import "LDeatailSendView.h"
@interface LDealOrderDetailController ()<
UITableViewDelegate,
UITableViewDataSource
>
//发放
/** <##> */
@property (nonatomic, copy) NSString * expnum;
//发货
@property (nonatomic, copy) NSString * express;
//搜索
@property (nonatomic, copy) NSString * parame;
/** <##> */
@property (nonatomic, strong) JasonSearchView *searchView;
@end

@implementation LDealOrderDetailController
{
    UITableView * _tb;
    UIView * _containerView;
    UILabel * _lb;
    UIButton * _selectBtn;
    
    NSString * _type;
    OOrderListModel * _listModel;
    
    //开始时间
    NSString * _start;
    //结束时间
    NSString * _end;
    
    //页码
    NSInteger _page;
    //数据源数组
    NSMutableArray * _dataSource;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    [self initSubViews];
}
#pragma mark    ------UI------
- (void)initSubViews
{
//    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"订单详情" withleftImageStr:@"back" withRightStr:nil];
//    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nav];
    
    [self.navView setNavViewTitle:@"订单详情" backBtnShow:YES rightBtnTitle:nil];

    self.navView.backgroundColor = kColorTheme;
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
    headerView.backgroundColor = kBackgroundColor;
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH,45)withPlaceholder:@"姓名/手机号"];
    WeakSelf
    _searchView.searchBar.btnRightBlock = ^{
        //搜索
        weakSelf.parame = weakSelf.searchView.searchBar.text;
        [weakSelf requestNetData];
    };
    [_searchView.searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [headerView addSubview:_searchView];
    [_searchView updateFrame];
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.tableHeaderView = headerView;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestNetData];
    }];
    _tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
    [self.view addSubview:_tb];
    [self createTabViewWithArr:@[@"全部",@"待发放",@"已完成"]];
}
- (void)createTabViewWithArr:(NSArray *)titles
{
    NSInteger count = titles.count;
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43)];
    }
    [_containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:_containerView];
    CGFloat  x =  (SCREEN_WIDTH - 55 * count)/(count + 1);
    for (int i = 0; i < count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(14);
        [btn setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
        [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
        btn.frame = CGRectMake((i + 1)* x + 55 * i, 0, 55, 42);
        btn.tag = i;
        if(i == 0){
            [self tap:btn];
        }
        [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [_containerView addSubview:btn];
    }
    _containerView.backgroundColor = [UIColor whiteColor];
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(x , 44- 1, 55, 1)];
    _lb = lb;
    lb.backgroundColor = kBtn_Commen_Color;
    [_containerView addSubview:lb];
}
- (void)tap:(UIButton *)btn
{
    _page = 0;
    [_dataSource removeAllObjects];
    if (btn.tag ==2) {
        _type = [NSString stringWithFormat:@"%ld",btn.tag + 1];
    }else{
        _type = [NSString stringWithFormat:@"%ld",btn.tag];
    }
    _selectBtn.selected = NO;
    btn.selected = YES;
    _selectBtn = btn;
    _lb.frame = CGRectMake(btn.left, btn.height - 1, 55, 1);
    [self requestNetData];
}
#pragma mark    ------DATA------
- (void)requestNetData{
    _page = 0;
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    [OnLineRequest requestOrderListJoinCode:_origanizeModel.joinCode oneClick:_origanizeModel.oneClick twoClick:_origanizeModel.twoClick twoListId:_origanizeModel.twoListId thrClick:_origanizeModel.thirdClick fouClick:_origanizeModel.forthClick start:_start end:_end Type:_type parame:_parame page:page resultBlock:^(OOrderListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [_dataSource removeAllObjects];
        if (isSuccess) {
            [_dataSource addObjectsFromArray:model.list];
            [self endRefreshing];
            [_tb reloadData];
        }
    }];
}
- (void)requestMoreNetData{
    _page ++;
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    [OnLineRequest requestOrderListJoinCode:_origanizeModel.joinCode oneClick:_origanizeModel.oneClick twoClick:_origanizeModel.twoClick twoListId:_origanizeModel.twoListId thrClick:_origanizeModel.thirdClick fouClick:_origanizeModel.forthClick start:_start end:_end Type:_type parame:_parame page:page resultBlock:^(OOrderListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
             [self endRefreshing];
            if (model.list.count ==0) {
                [_tb.mj_footer endRefreshingWithNoMoreData];
                return ;
            }
            [_dataSource addObjectsFromArray:model.list];
            [_tb reloadData];
        }
    }];
}
- (void)endRefreshing{
    [_tb.mj_header endRefreshing];
    [_tb.mj_footer endRefreshing];
}
- (void)textFieldDidChange:(UITextField *) TextField
{
    //动态搜索
}
#pragma mark    ------UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    view.backgroundColor = kBackgroundColor;
    [view addSubview:_containerView];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
//    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    static NSString * yiwanchengCell = @"yiwanchengCell";
    OOrderModel * model = _dataSource[indexPath.row];
    LDeatailDaiFaHuoCell * cell = [tableView dequeueReusableCellWithIdentifier:yiwanchengCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LDeatailDaiFaHuoCell" owner:nil options:nil]lastObject];
    }
    cell.model = model;
    cell.LDeatailDaiFaHuoCellBlock = ^(OOrderModel *model) {
        [weakSelf showSendView:model];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}
- (void)sendWithModel:(OOrderModel *)model type:(NSString *)type
{
    [[[MzzHud alloc]initWithTitle:@"确认发放吗？" message:@"" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
        if (index==1) {
            [OnLineRequest requestDeliverOrderNum:model.ordernum type:type express:_express expnum:_express resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    [XMHProgressHUD showOnlyText:@"发放成功"];
                }else{
                    [XMHProgressHUD showOnlyText:@"发放失败"];
                }
            }];
        }
    }]show];
   
}
- (void)showSendView:(OOrderModel *)model
{
    WeakSelf
    LDeatailSendView * sendView = [[LDeatailSendView alloc] initWithFrame:self.view.bounds];
    sendView.LDeatailSendViewBlock = ^(NSString *express, NSString *expnum) {
        weakSelf.expnum =expnum;
        weakSelf.express = express;
        [weakSelf sendWithModel:model type:@"2"];
    };
    [self.view addSubview:sendView];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
