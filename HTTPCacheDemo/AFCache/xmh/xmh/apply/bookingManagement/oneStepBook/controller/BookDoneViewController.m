//
//  BookDoneViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookDoneViewController.h"
#import "OneStepTableViewCell.h"
#import "SearchView.h"
#import "BookRequest.h"
#import "YiYuYueListModel.h"
#import "BookDetailsViewController.h"
#import "ShareBookInstance.h"
#import "YiYuYueModel.h"
#import "LolSkipToDetailMode.h"
#import "XMHRefreshGifHeader.h"
static NSString *cellName = @"cell";
@interface BookDoneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation BookDoneViewController
{
    UITableView * _tb;
    NSMutableArray * _dataArr;
    NSInteger _page;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _page = 1;
    [self initSubViews];
    [self loadData];
}
- (void)loadData
{
    [self requestNetData];
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"已预约" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}

- (void)initSubViews
{
    [self creatNav];
    [self createTableView];
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
    _tb.delegate = self;
    _tb.dataSource = self;
    [self.view addSubview:_tb];
    UIView * tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    tableHeaderView.backgroundColor = kBackgroundColor;
    SearchView * search = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [tableHeaderView addSubview:search];
    _tb.tableHeaderView = tableHeaderView;
    _tb.tableFooterView = [[UIView alloc] init];
    WeakSelf;
    _tb.mj_header = self.gifHeader;
//    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf requestNetData];
//    }];
    _tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            [self requestNetData];
        }];
    }
    return _gifHeader;
}
- (void)requestNetData
{
    _page = 1;
    BookRequest * request = [[BookRequest alloc] init];
    NSString * page = [NSString stringWithFormat:@"%ld",(long)_page];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:_paramModel.oneClick forKey:@"oneClick"];
    [params setValue:_paramModel.twoClick forKey:@"twoClick"];
    [params setValue:_paramModel.twoListId forKey:@"twoListId"];
    [params setValue:_paramModel.inId forKey:@"inId"];
    [params setValue:page forKey:@"page"];
    [params setValue:_paramModel.joinCode forKey:@"join_code"];
    [request requestYiYuYueParams:params resultBlock:^(YiYuYueListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _dataArr = listModel.list;
            [_tb reloadData];
            [self endRefreshing];
        }else{
            
        }
    }];
}
- (void)requestMoreNetData
{
    NSString * page = [NSString stringWithFormat:@"%ld",(long)_page ++];
    BookRequest * request = [[BookRequest alloc] init];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:_paramModel.oneClick forKey:@"oneClick"];
    [params setValue:_paramModel.twoClick forKey:@"twoClick"];
    [params setValue:_paramModel.twoListId forKey:@"twoListId"];
    [params setValue:_paramModel.inId forKey:@"inId"];
    [params setValue:page forKey:@"page"];
    [params setValue:_paramModel.joinCode forKey:@"join_code"];
    [request requestYiYuYueParams:params resultBlock:^(YiYuYueListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            if (listModel.list.count == 0) {
//#warning TODO: 弹出toast 没有数据了
            }else{
                [_dataArr addObjectsFromArray:listModel.list];
            }
            [_tb reloadData];
            [self endRefreshing];
        }else{
            
//#warning TODO: 弹出toast 失败了
            
        }
    }];
}
- (void)endRefreshing
{
    [_tb.mj_header endRefreshing];
    [_tb.mj_footer endRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneStepTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OneStepTableViewCell" owner:nil options:nil]lastObject];
    }
    [cell updateOneStepTableViewCell:_dataArr[indexPath.row]];
    cell.btn1.tag = indexPath.row;
    YiYuYueModel * model =_dataArr[indexPath.row];
    WeakSelf;
    cell.OneStepTableViewCellModifyBtnBlock = ^(UIButton *btn) {
        BookDetailsViewController * detail = [[BookDetailsViewController alloc] init];
        LolSkipToDetailMode * skipModel = [[LolSkipToDetailMode alloc]initWithType:@"yyy" orderNum:model.ordernum userId:model.user_id toGd:@""];
        detail.skipModel = skipModel;
        [weakSelf.navigationController pushViewController:detail animated:NO];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107.f;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestNetData];
}
@end
