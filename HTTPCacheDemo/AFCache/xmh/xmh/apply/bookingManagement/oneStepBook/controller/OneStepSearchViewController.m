//
//  OneStepSearchViewController.m
//  xmh
//
//  Created by 李晓明 on 2017/12/2.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OneStepSearchViewController.h"
#import "BeautyRequest.h"
#import "SearchView.h"
#import "OneStepUserDescripeTableViewCell.h"
#import "OneStepCustomerModel.h"
#import "JasonSearchView.h"
#import "MzzCustomerRequest.h"
#import "CustomerListModel.h"
#import "ShareWorkInstance.h"
static NSString * cellName = @"OneStepUserDescripeTableViewCell";
@interface OneStepSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@end

@implementation OneStepSearchViewController
{
    UILabel * _lb;              //提示语
    NSMutableArray * _arr;
    UITableView * _tb;
    SearchView * _search;
    //搜索view
    JasonSearchView * _searchView;
    NSInteger _page;
    NSString * _q;
}
- (void)requestNetData{
    _page = 0;
    [_arr removeAllObjects];
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arr = [[NSMutableArray alloc] init];
//    self.view.backgroundColor = kBackgroundColor;
    _page = 0;
    [self initSubViews];
}
- (void)initSubViews{
    [self createSearchView];
    [self createMarkWordsLable];
    [self createTableView];
}
- (void)createSearchView
{
//    _search = [[SearchView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 50) cancelBtn:YES];
//    _search.bar.delegate = self;
//    [_search.btnCancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_search];
//
    WeakSelf
    CGFloat height = 0;
    if(IS_IPHONE_X){
        height = 40;
    }else{
        height = 20;
    }
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 45)withPlaceholder:@"姓名/手机号"];
    _searchView.line1.hidden = YES;
    _searchView.searchBar.btnRightBlock = ^{
        if (_q.length > 0) {
            
        }else{
          [weakSelf loadData];
        }
    };
    [_searchView updateFrame];
    _searchView.searchBar.btnleftBlock = ^{
        [weakSelf cancel];
    };
    [_searchView.searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_searchView];
}
- (void)textFieldDidChange:(UITextField *) TextField
{
    [_arr removeAllObjects];
    _q = TextField.text;
    [self loadData];
}
- (void)createMarkWordsLable
{
    _lb = [[UILabel alloc] init];
    _lb.frame = CGRectMake(0, 80, SCREEN_WIDTH, 12);
//    _lb.text = @"在这里可以进行搜索";
    _lb.font = FONT_SIZE(12);
    _lb.textAlignment = NSTextAlignmentCenter;
    _lb.textColor = kLabelText_Commen_Color_6;
    [self.view addSubview:_lb];
}
- (void)cancel
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchView.bottom +10, SCREEN_WIDTH, SCREEN_HEIGHT - _searchView.bottom - 10) style:UITableViewStylePlain];
    _tb.backgroundColor =  kBackgroundColor;
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.tableFooterView = [[UIView alloc] init];
    WeakSelf;
    _tb.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestNetData];
    }];
    _tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
    }];
    [self.view addSubview:_tb];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneStepUserDescripeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OneStepUserDescripeTableViewCell" owner:nil options:nil]lastObject];
    }
    [cell updateOneStepUserDescripeTableViewCell:_arr[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_oneStepSearchViewControllerBlock) {
        _oneStepSearchViewControllerBlock(_arr[indexPath.row]);
    }
    [self cancel];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData
{
    NSString * oneClick = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * join_code = [ShareWorkInstance shareInstance].share_join_code.code;
    NSString * inId = [ShareWorkInstance shareInstance].cinId;
    NSMutableDictionary *parmsDic = [@{@"oneClick":oneClick?oneClick:@"",@"join_code":join_code?join_code:@"",@"twoListId":@"-1",
                                       @"q":_q?_q:@"",@"page":[NSString stringWithFormat:@"%ld",_page],@"inId":inId?inId:@""} mutableCopy];
    
    [ MzzCustomerRequest requestCustomerListParams:parmsDic resultBlock:^(CustomerListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_arr  addObjectsFromArray:listModel.list];
            [_tb reloadData];
            [self endRefreshing];
        }else{
            
        }
    }];
}
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    [_search.bar resignFirstResponder];
//    NSString * oneClick = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
//    NSString * join_code = [ShareWorkInstance shareInstance].share_join_code.code;
//    NSMutableDictionary *parmsDic = [@{@"oneClick":oneClick?oneClick:@"",@"join_code":join_code?join_code:@"",@"twoListId":@"-1",
//                                       @"q":@"",@"page":@"1"} mutableCopy];
//   [ MzzCustomerRequest requestCustomerListParams:parmsDic resultBlock:^(CustomerListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
//       [_arr  addObjectsFromArray:listModel.list];
//       [_tb reloadData];
//    }];
////    BeautyRequest * request = [[BeautyRequest alloc] init];
////    [request requestGukeList:0 Q:nil resultBlock:^(choiceCustomerModel *uchoiceCustomerModel, BOOL isSuccess, NSDictionary *errorDic) {
////        if (isSuccess) {
////            _arr = uchoiceCustomerModel.list;
////            [_tb reloadData];
////        }else{
////
////        }
////
////    }];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
