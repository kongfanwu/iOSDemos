//
//  RefundAmountViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "RefundAmountViewController.h"
#import "DateHeaderView.h"
#import "DatePickerView.h"
#import "JasonSearchView.h"
#import "tempModel.h"
#import "OrderServiceCell.h"
#import "SaleListRequest.h"
#import "SATuiKuanListModel.h"
#import "LDatePickView.h"
#import "LOrderDetailCell.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ApproveDetailModel.h"
#import "ApproveDetailController.h"
@interface RefundAmountViewController (){
//    DateHeaderView * _dateHeaderView;
//    DatePickerView * _dp;
    NSString *cstartTime;
    NSString *cendTime;
    JasonSearchView    *_searchView;
    
    __weak IBOutlet UITableView *tbView;
    NSMutableArray *_arrSource;
    SATuiKuanListModel * _modelList;
    LDatePickView * _dateHeader;
    NSString * _start;
    NSString * _end;
    NSString * _q;
    NSString * _page;
    NSString * _token;
}

@end

@implementation RefundAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    
    [self creatNav];
    [self initSubViews];
    [self loadListData];
    _arrSource = [[NSMutableArray alloc]init];
}
- (void)loadListData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_model.oneClick?_model.oneClick:@"" forKey:@"oneClick"];
    [param setValue:_model.twoClick?_model.twoClick:@"" forKey:@"twoClick"];
    [param setValue:_model.twoListId?_model.twoListId:@"" forKey:@"twoListId"];
    [param setValue:_model.inId?_model.inId:@"" forKey:@"inId"];
    [param setValue:_model.joinCode?_model.joinCode:@"" forKey:@"join_code"];
    [param setValue:_start?_start:@"" forKey:@"start_time"];
    [param setValue:_end?_end:@"" forKey:@"end_time"];
    [param setValue:_q?_q:@"" forKey:@"q"];
    [param setValue:_page?_page:@"1" forKey:@"page"];
    [SaleListRequest requestTuiKuanParam:param resultBlock:^(SATuiKuanListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _modelList = model;
        [_arrSource removeAllObjects];
        for (NSInteger i = 0; i<model.list.count; i++) {
            tempModel *model = [[tempModel alloc]init];
            [_arrSource addObject:model];
        }
        _lb1.text = [NSString stringWithFormat:@"退款单数:%ld",model.sales_num];
        _lb2.text = [NSString stringWithFormat:@"总金额:%ld",model.sales_amount];
        [tbView reloadData];
    }];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"退款金额" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lineImageView.hidden = YES;
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)initSubViews{
    WeakSelf
    _dateHeader = [[LDatePickView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 44) dateBlock:^(NSString *start, NSString *end) {
        _start = start;
        _end = end;
        [weakSelf loadListData];
    }];
    _dateHeader.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_dateHeader];
    if (!_searchView) {
        _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, _dateHeader.bottom+10, SCREEN_WIDTH, 45)withPlaceholder:@"姓名/手机号"];
        [self.view addSubview:_searchView];
    }
    [_searchView updateFrame];
    __block JasonSearchView    *tempsearchView = _searchView;
    _searchView.searchBar.btnRightBlock = ^{
        _q = tempsearchView.searchBar.text;
        [weakSelf loadListData];
    };
    
    _searchView.searchBar.btnleftBlock = ^{
        _q = @"";
        [weakSelf loadListData];
    };
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *OrderServiceCellindentifier = @"OrderServiceCellindentifier";
    LOrderDetailCell *cell;
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LOrderDetailCell" owner:nil options:nil] firstObject];
    }else{
        cell  = [tableView dequeueReusableCellWithIdentifier:OrderServiceCellindentifier];
    }
    cell.v1.tag = indexPath.row;
    UITapGestureRecognizer * tap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDown:)];
    [cell.v1 addGestureRecognizer: tap];
    if (indexPath.row < _arrSource.count) {
        tempModel *model = _arrSource[indexPath.row];
        [cell refreshLOrderDetailCell:model];
    }
    cell.tuiKuanModel = _modelList.list[indexPath.row];
    return cell;
}
- (void)tapDown:(UITapGestureRecognizer *)gesture
{
    UIView * view = gesture.view;
    if (view.tag < _arrSource.count) {
        tempModel *model = _arrSource[view.tag];
        model.isShow = !model.isShow;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:view.tag inSection:0];
    [tbView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    if (indexPath.row<_arrSource.count) {
        tempModel *model = _arrSource[indexPath.row];
        return 55 + 155 *model.isShow;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SATuiKuanModel * model = _modelList.list[indexPath.row];
    NSString * navTitle = @"清卡审批";
    NSString * accountId = [NSString stringWithFormat:@"%ld",model.account_id];
    NSString * urlStr = [NSString stringWithFormat:@"%@approval/qingka.html",SERVER_H5];
    ApproveDetailModel * detailModel = [ApproveDetailModel initWithToken:_token joinCode:_model.joinCode code:model.code accountId:accountId url:urlStr navTitle:navTitle from:@"1" ordernum:@"" fromList:NO];
    ApproveDetailController * next = [[ApproveDetailController alloc] init];
    //        ClearCardDetailController * next = [[ClearCardDetailController alloc] init];
    next.detailModel = detailModel;
    [self.navigationController pushViewController:next animated:NO];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
