//
//  TJCardViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJCardViewController.h"
#import "LDatePickView.h"
#import "organizationalStructureView.h"
#import "FuZhaiTopView.h"
#import <WebKit/WebKit.h>
#import "TJFuZhaiCell.h"
#import "TJRequest.h"
#import "ShareWorkInstance.h"
#import "TJCardTopModel.h"
#import "UserManager.h"
#import "TJGuKeTotalView.h"
#import "TJGuKeNumCell.h"
#import "TJGuKeWebCell.h"
#import "TJCardCell.h"
#import "TJGuKeClassCell.h"
#import "TJAlertView.h"
#import "TJCardSearchAndSelectCell.h"
#import "StructureModel.h"
#import "TJCardListModel.h"
#import "TJCardSearchViewController.h"
@interface TJCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJCardViewController
{
    organizationalStructureView * _organizationHeader;
    UITableView * _tb;
    UIView * _topView;
    WKWebView * _webView;
    
    //参数
    NSString *cjoin_code;
    NSString *coneClick;
    NSString *ctwoClick;
    NSString *ctwoListId;
    NSString *cinId;
    NSString *cstartTime;
    NSString *cendTime;
    NSString * _joinCode;
    FuZhaiTopView * _fuZhaiTopView;
    TJCardTopModel * _topModel;
    NSString *  _token;
    
    
    NSInteger _pageType;
    NSArray * _dataSource;
    TJGuKeNumCell * _numCell;
    TJGuKeWebCell * _webCell;
    TJCardSearchAndSelectCell * _selectCell;
    TJCardListModel * _listModel;
    TJCardTopSubModel * _selectTopModel;
    NSString * _sort;
    NSString * _categoryId;
    NSString * _selectPaiXu;
    LDatePickView * _datePickView;
    BOOL _isFirst;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _isFirst = YES;
    [self initSubViews];
    [self initBaseData];

}
#pragma mark    ------DATA------
- (void)initBaseData
{
    _joinCode = [ShareWorkInstance shareInstance].join_code;
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _token = infomodel.data.token;
}
- (void)requestTopData
{
    [TJRequest requestCardTopOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId joinCode:_joinCode startTime:cstartTime endTime:cendTime resultBlock:^(TJCardTopModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _topModel = model;
            //            _pageType = model.type;
            [_tb reloadData];
        }
    }];
}
- (void)reuqestListData
{
    if (!_selectTopModel) {
        _categoryId = _topModel.list[0].uid;
    }else{
        _categoryId = _selectTopModel.uid;
    }
    if (!_selectPaiXu) {
        _sort = @"0";
    }else{
        _sort = _selectPaiXu;
    }
    [TJRequest requestCardListOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId joinCode:_joinCode startTime:cstartTime endTime:cendTime sort:_sort categoryId:_categoryId resultBlock:^(TJCardListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _listModel = model;
            [_tb reloadData];
        }
    }];
}
#pragma mark    ------UI------
- (void)initSubViews
{
    [self creatNav];
    [self createDateView];
    [self createStructureView];
    [self createTableView];
}
- (void)createTotalView
{
    TJGuKeTotalView * totalView = [[[NSBundle mainBundle]loadNibNamed:@"TJGuKeTotalView" owner:nil options:nil]lastObject];
    totalView.frame = CGRectMake(0, _topView.bottom, SCREEN_WIDTH, 90);
    [self.view addSubview:totalView];
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"卡项统计" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)createStructureView
{
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, _datePickView.bottom, SCREEN_WIDTH, 69);
    view.backgroundColor = kBackgroundColor;
    [self.view addSubview:view];
    WeakSelf
    _organizationHeader = [[organizationalStructureView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 49)];
    _organizationHeader.organizationalStructureViewBlock = ^(NSString *join_code, NSString *oneClick, NSString *twoClick, NSString *twoListId, NSString *inId,NSInteger level,NSInteger mainrole,List*listInfo) {
        cstartTime =
        cjoin_code = join_code;
        coneClick = oneClick;
        ctwoClick = twoClick;
        ctwoListId = twoListId;
        cinId = inId;
        [weakSelf initParams];
        [weakSelf requestTopData];
        [weakSelf reuqestListData];
        [weakSelf refreshWebView];
    };
    [view addSubview:_organizationHeader];
    _topView = view;
    _topView.hidden = YES;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)createDateView
{
    WeakSelf
    _datePickView = [[LDatePickView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 44) dateBlock:^(NSString *start, NSString *end) {
        cstartTime = start;
        cendTime = end;
        if (!_isFirst) {
            [weakSelf initParams];
            [weakSelf requestTopData];
            [weakSelf reuqestListData];
        }else{
            _isFirst = NO;
        }
    }];
    [self.view addSubview:_datePickView];
}
- (void)refreshWebView
{
    _webCell.model = [StructureModel initWithOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId startTime:cstartTime endTime:cendTime urlStr:[NSString stringWithFormat:@"%@statistics/kaxiang.html",SERVER_H5] token:_token joinCode:_joinCode type:0] ;
}
- (void)initParams
{
    _categoryId = _topModel.list[0].uid;
    _sort = @"0";
    [_selectCell.btn3 setTitle:@"项目" forState:UIControlStateNormal];
}
- (void)createTableView
{
    UIView * line = [[UIView alloc] init];
    line.frame = CGRectMake(0, _datePickView.bottom, SCREEN_WIDTH, 10);
    line.backgroundColor = kBackgroundColor;
    [self.view addSubview:line];
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, line.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - line.bottom)
                                       style:UITableViewStylePlain];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tb];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"TJGuKeNumCell";
    static NSString * cell2Web = @"cell2Web";
    static NSString * cell3Commen3 = @"cell3Commen3";
    if (indexPath.row ==0) {
        if (!_numCell) {
            _numCell = [[TJGuKeNumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        _numCell.cardTopModel = _topModel;
        return _numCell;
    }else if(indexPath.row ==1){
        if (!_webCell) {
            _webCell = [[TJGuKeWebCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2Web];
            _webCell.model = [StructureModel initWithOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId startTime:cstartTime endTime:cendTime urlStr:[NSString stringWithFormat:@"%@statistics/kaxiang.html",SERVER_H5] token:_token joinCode:_joinCode type:1] ;
        }
        return _webCell;
    }else if(indexPath.row ==2){
        WeakSelf;
        if (!_selectCell) {
            _selectCell = [[[NSBundle mainBundle]loadNibNamed:@"TJCardSearchAndSelectCell" owner:nil options:nil]lastObject];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchClick)];
            [_selectCell.viewSearch addGestureRecognizer:tap ];
        }
        _selectCell.model = _listModel;
        _selectCell.cardTopModel = _topModel;
        _selectCell.TJCardBlock = ^(TJCardTopSubModel *model) {
            _selectTopModel = model;
            [weakSelf reuqestListData];
        };
        _selectCell.TJPaiXuBlock = ^(NSString *index) {
            _selectPaiXu = index;
            [weakSelf reuqestListData];
        };
        return _selectCell;
    }else{
        TJCardCell * cell = [tableView dequeueReusableCellWithIdentifier:cell3Commen3];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TJCardCell" owner:nil options:nil]lastObject];
        }
        cell.model = _listModel.list[indexPath.row - 3];
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3 + _listModel.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) { 
        return 160.f;
    }
    if (indexPath.row == 1) {
        return 320;
    }
    if (indexPath.row == 2) {
        return 310;
    }else{
        return 170;
    }
}
- (void)searchClick
{
    TJCardSearchViewController * next = [[TJCardSearchViewController alloc] init];
    next.model = [StructureModel initWithOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId startTime:cstartTime endTime:cendTime urlStr:nil token:_token joinCode:_joinCode type:0];
    [self.navigationController pushViewController:next animated:NO];
}
@end
