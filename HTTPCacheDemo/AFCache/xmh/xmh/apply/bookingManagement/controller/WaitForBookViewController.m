//
//  WaitForBookViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "WaitForBookViewController.h"
#import "SearchView.h"
#import "BookRequest.h"
#import "DaiYuYueListModel.h"
#import "ProjectWaitForBookTableViewCell.h"
#import "ChuFangWaitForBookTableViewCell.h"
#import "BookDetailsViewController.h"
#import "ShareBookInstance.h"
#import "DaiYuYueModel.h"
#import "JasonSearchView.h"
static NSString * cellName = @"BookDoneCell";
@interface WaitForBookViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@end

@implementation WaitForBookViewController{
    //列表
    UITableView * _tb;
    //数据源
    NSMutableArray * _dataArr;
    //sc 选择
    NSInteger _scSelectIndex;
    //加载页数
    NSInteger _page;
    //搜索
    SearchView * _search;
    // 类型
    NSString * _type;
    JasonSearchView * _searchView;
    NSString * _q;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    // Do any additional setup after loading the view.
    _scSelectIndex = 0;
    _page = 1;
    [self initSubViews];
    [self requestNetData];
}
- (void)initSubViews{
    [self creatNav];
    [self createHeaderView];
    [self createTableView];
}
- (void)creatNav{
    customNav* nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"待预约" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createHeaderView{
    
    UIView * tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 50 + 74)];
    tableHeaderView.backgroundColor = kBackgroundColor;
    
//    _search = [[SearchView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 50) cancelBtn:YES];
//    _search.bar.delegate = self;
//    [_search.btnCancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    if (!_searchView) {
        _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)withPlaceholder:@"姓名/手机号"];
    }
    _searchView.line1.hidden = YES;
    WeakSelf
    _searchView.searchBar.btnRightBlock = ^{
        [weakSelf requestNetData];
    };
    [_searchView updateFrame];
    [tableHeaderView addSubview:_searchView];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, _searchView.bottom, SCREEN_WIDTH, 74)];
    view.backgroundColor = kBackgroundColor;
    [tableHeaderView addSubview:view];
    
    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:@[@"项目待预约",@"处方待预约"]];
    [segment addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    segment.frame = CGRectMake(15,  20, SCREEN_WIDTH - 15 - 15, 33);
    segment.selectedSegmentIndex = 0;
    segment.backgroundColor = [UIColor whiteColor];
    segment.tintColor = kBtn_Commen_Color;
    [view addSubview:segment];
    
    [self.view addSubview:tableHeaderView];
}
- (void)createTableView{
    
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 50 + 74 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 50 - 74) style:UITableViewStylePlain];
    _tb.backgroundColor = [UIColor whiteColor];
    _tb.delegate = self;
    _tb.dataSource = self;
    [self.view addSubview:_tb];
    
    WeakSelf;
    _tb.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestNetData];
    }];
    _tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
    
}
- (void)requestNetData{
    
    _page = 1;
    [self getDataType];
    BookRequest * request = [[BookRequest alloc] init];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:_type forKey:@"type"];
    [params setValue:_paramModel.oneClick forKey:@"oneClick"];
    [params setValue:_paramModel.twoClick forKey:@"twoClick"];
    [params setValue:_paramModel.twoListId forKey:@"twoListId"];
    [params setValue:_paramModel.inId forKey:@"inId"];
    [params setValue:[NSString stringWithFormat:@"%ld",_page] forKey:@"page"];
    [params setValue:_paramModel.joinCode forKey:@"join_code"];
    [params setValue:_searchView.searchBar.text forKey:@"q"];
    [request requestDaiYuYueParams:params resultBlock:^(DaiYuYueListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self endRefreshing];
            _dataArr = listModel.list;
            [_tb reloadData];
        }else{
            
        }
    }];
}
- (void)getDataType{
    if (_scSelectIndex == 0) {
        _type = @"pro";
    }else{
        _type = @"pres";
    }
}
- (void)requestMoreNetData{
    _page ++;
    [self getDataType];
    BookRequest * request = [[BookRequest alloc] init];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:_type forKey:@"type"];
    [params setValue:_paramModel.oneClick forKey:@"oneClick"];
    [params setValue:_paramModel.twoClick forKey:@"twoClick"];
    [params setValue:_paramModel.twoListId forKey:@"twoListId"];
    [params setValue:_paramModel.inId forKey:@"inId"];
    [params setValue:[NSString stringWithFormat:@"%ld",_page] forKey:@"page"];
    [request requestDaiYuYueParams:params resultBlock:^(DaiYuYueListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self endRefreshing];
            if (listModel.list.count ==0) {
//                [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionBottom title:@"没有更多数据了"];
                [XMHProgressHUD showOnlyText:@"没有更多数据了"];
            }else{
                [_dataArr addObjectsFromArray:listModel.list];
            }
            [_tb reloadData];
        }else{
//#warning TODO: 弹出toast 失败了
        }
        
    }];
}
- (void)endRefreshing{
    [_tb.mj_header endRefreshing];
    [_tb.mj_footer endRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ProjectCell = @"ProjectCell";
    static NSString * ChuFangCell = @"ChuFangCell";
    WeakSelf;
    if (_scSelectIndex == 0) {
        ProjectWaitForBookTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ProjectCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectWaitForBookTableViewCell" owner:nil options:nil] lastObject];
        }
        cell.btn1.tag = indexPath.row ;
        [cell updateProjectWaitForBookTableViewCell:_dataArr[indexPath.row]];
        cell.projectWaitForBookTableViewCellBlock = ^(UIButton *btn) {
            BookDetailsViewController * detail = [[BookDetailsViewController alloc] init];
            detail.dModel = _dataArr[indexPath.row];
            [weakSelf.navigationController pushViewController:detail animated:NO];
        };
        return cell;
    }else if(_scSelectIndex == 1){
        ChuFangWaitForBookTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ChuFangCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChuFangWaitForBookTableViewCell" owner:nil options:nil] lastObject];
        }
        cell.btn.tag = indexPath.row;
        [cell updateChuFangWaitForBookTableViewCell:_dataArr[indexPath.row]];
        
        cell.chuFangWaitForBookTableViewCellBlock = ^(UIButton *btn) {
            BookDetailsViewController * detail = [[BookDetailsViewController alloc] init];
            detail.dModel = _dataArr[indexPath.row];
            [weakSelf.navigationController pushViewController:detail animated:NO];
        };
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_scSelectIndex == 0) {
        return 88.0f;
    }else if(_scSelectIndex == 1){
        return 124.0f;
    }
    return 0;
}
- (void)valueChange:(UISegmentedControl *)sc{
    _scSelectIndex = sc.selectedSegmentIndex;
    
    [self requestNetData];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [_search.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_search.btnCancel setTitle:@"确定" forState:UIControlStateNormal];
    [_search.bar resignFirstResponder];
    NSLog(@".......%@",searchBar.text);
    [self getDataType];
    BookRequest * request = [[BookRequest alloc] init];
    NSMutableDictionary * params = [@{@"token":@"5d91d3738a315b4739587b171bda277c",@"type":_type,@"q":searchBar.text}mutableCopy];
    [request requestDaiYuYueParams:params resultBlock:^(DaiYuYueListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self endRefreshing];
            _dataArr = listModel.list;
            [_tb reloadData];
        }else{
//#warning TODO: 弹出toast 失败了
        }
    }];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [_search.btnCancel setTitle:@"确定" forState:UIControlStateNormal];
}
- (void)cancel{
    [_search.bar resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
