//
//  TJGuKeViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJGuKeViewController.h"
#import "LDatePickView.h"
#import "organizationalStructureView.h"
#import "FuZhaiTopView.h"
#import <WebKit/WebKit.h>
#import "TJFuZhaiCell.h"
#import "TJRequest.h"
#import "ShareWorkInstance.h"
#import "TJGuKeTopModel.h"
#import "TJYeJiListModel.h"
#import "UserManager.h"
#import "TJGuKeTotalView.h"
#import "TJGuKeNumCell.h"
#import "TJGuKeWebCell.h"
#import "TJGuKeShouHouCell.h"
#import "TJGuKeClassCell.h"
#import "TJAlertView.h"
#import "TJGuKeCardSelectCell.h"
#import "TJGuKeListModel.h"
@interface TJGuKeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJGuKeViewController
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
    TJGuKeTopModel * _topModel;
    NSString *  _token;
    
    
    NSInteger _pageType;
    NSArray * _dataSource;
    TJGuKeNumCell * _numCell;
    TJGuKeWebCell * _webCell;
    TJGuKeCardSelectCell * _selectCell;
    NSString * _urlStr;
    TJGuKeListModel * _listModel;
    NSString * _cardType;
    NSString * _orderType;
    LDatePickView * _datePickView;
    BOOL _isFirst;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [TJRequest requestGukeTopOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId joinCode:_joinCode startTime:cstartTime endTime:cendTime resultBlock:^(TJGuKeTopModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _topModel = model;
            _pageType = model.type;
            NSString * urlSubStr = @"";
            if (_pageType ==1) {
                urlSubStr = @"statistics/chart_dzhu.html";
            }else if (_pageType ==2){
                urlSubStr = @"statistics/zhu.html";
            }else if (_pageType ==3){
                urlSubStr = @"statistics/guke.html";
            }else if (_pageType ==4){
                urlSubStr = @"statistics/tuoke.html";
            }else{
                urlSubStr = @"statistics/client.html";
            }
            _urlStr = [NSString stringWithFormat:@"%@%@",SERVER_H5,urlSubStr];
            [_tb reloadData];
        }
    }];
}
- (void)requestListData
{
    [TJRequest requestGukeListOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId joinCode:_joinCode startTime:cstartTime endTime:cendTime cardType:_cardType orderType:_orderType resultBlock:^(TJGuKeListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _listModel = model;
            [_tb reloadData];
        }
    }];
}
- (void)initParams
{
    _cardType = @"";
    _orderType = @"";
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
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"顾客统计" withleftImageStr:@"back" withRightStr:nil];
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
        cjoin_code = join_code;
        coneClick = oneClick;
        ctwoClick = twoClick;
        ctwoListId = twoListId;
        cinId = inId;
        [weakSelf requestTopData];
        [weakSelf refreshWebView];
        [weakSelf initParams];
        [weakSelf requestListData];
    };
    [view addSubview:_organizationHeader];
    _topView = view;
    _topView.hidden = YES;
}
- (void)refreshWebView
{
    _webCell.model = [StructureModel initWithOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId startTime:cstartTime endTime:cendTime urlStr:_urlStr token:_token joinCode:_joinCode type:_pageType] ;
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
        [weakSelf refreshWebView];
        [weakSelf initParams];
        if (!_isFirst) {
            [weakSelf requestListData];
        }
        _isFirst = NO;
    }];
    [self.view addSubview:_datePickView];
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
#pragma mark  ----TableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"TJGuKeNumCell";
    static NSString * cell2Web = @"cell2Web";
    static NSString * cell3Commen3 = @"cell3Commen3";
    static NSString * cell3Commen5 = @"cell3Commen5";
    __weak UITableView * weakTable = _tb;
    WeakSelf
    if (indexPath.row ==0) {
        if (!_numCell) {
            _numCell = [[TJGuKeNumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        _numCell.model = _topModel;
        return _numCell;
    }else if(indexPath.row ==1){
        if (!_webCell) {
            _webCell = [[TJGuKeWebCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2Web];
        }
        _webCell.TJGuKeWebCellBlock = ^(TJGuKeListModel *model) {
            _listModel = model;
            [weakTable reloadData];
        };
        return _webCell;
    }else if(indexPath.row ==2){
        if (!_selectCell) {
            _selectCell = [[[NSBundle mainBundle]loadNibNamed:@"TJGuKeCardSelectCell" owner:nil options:nil]lastObject];
        }
        _selectCell.topModel = _topModel;
        _selectCell.TJGuKeCardSelectCellBlock = ^(NSString *index) {
            if (_topModel.type ==3) {
                _cardType = index;
            }else{
                _orderType = index;
            }
            [weakSelf requestListData];
        };
        return _selectCell;
    }else{
        if (_pageType ==3) {
            TJGuKeShouHouCell * cell = [tableView dequeueReusableCellWithIdentifier:cell3Commen3];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"TJGuKeShouHouCell" owner:nil options:nil]lastObject];
            }
            cell.model = _listModel.list[indexPath.row - 3];
            if (indexPath.row <=6) {
                cell.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"xunzhang%ld",indexPath.row - 3 + 1]];
            }
            return cell;
        }else{
            TJGuKeClassCell * cell = [tableView dequeueReusableCellWithIdentifier:cell3Commen5];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"TJGuKeClassCell" owner:nil options:nil]lastObject];
            }
            cell.model = _listModel.list[indexPath.row - 3];
            if (indexPath.row <=6) {
                cell.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"xunzhang%ld",indexPath.row - 3 + 1]];
            }
            return cell;
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_pageType ==1) {//售前美容师
        return 2;
    }else if(_pageType == 2){//售中美容师
        return 2;
    }else if (_pageType ==3){//售后美容师
      return _listModel.list.count + 2;
        return 6;
    }else if (_pageType == 4){//售前店长
        return 2;
    }else{//门店级别以上
        return _listModel.list.count + 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return 160.f;
    }else if (indexPath.row == 1) {
        if (_pageType ==1) {
            return 320;
        }else if (_pageType ==2){
            return 280;
        }else if (_pageType ==3){
            return 360;
        }else if (_pageType ==4){
            return 320;
        }else{
            return 690;
        }
    }else if (indexPath.row == 2) {
        return 44;
    }else{
        if (_pageType ==3) {
            return 95;
        }else{
            return 195;
        }
    }
}
@end
