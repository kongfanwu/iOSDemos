//
//  XMHActionCenterSelectCustomerVC.m
//  xmh
//
//  Created by ald_ios on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHActionCenterSelectCustomerVC.h"
#import "JasonSearchView.h"
#import "MsgActivityCenterErrorCell.h"
#import "XMHActionCenterRequest.h"
#import "XMHCouponSendCustomerListModel.h"
@interface XMHActionCenterSelectCustomerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView * searchView;
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, copy)NSString * search;
/** 选择的顾客数组 */
@end

@implementation XMHActionCenterSelectCustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubViews];
    if (!_selectResultArr) {
        _selectResultArr = [[NSMutableArray alloc] init];
    }
}

- (void)createSubViews
{
    WeakSelf
    [self.navView setNavViewTitle:@"选择顾客" backBtnShow:YES];
    self.navView.NavViewBackBlock = ^{
        if (weakSelf.XMHActionCenterSelectCustomerVCBlock) {
            weakSelf.XMHActionCenterSelectCustomerVCBlock(weakSelf.selectResultArr);
        }
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.tbView];
}
- (UIView *)searchView
{
    WeakSelf
    if (!_searchView) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 63)];
        JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, (_searchView.height - 34)/2, SCREEN_WIDTH - 15 - 55, 34) withPlaceholder:@"请输入顾客名称或手机号"];
        search.line1.hidden = YES;
        search.searchBar.frame = search.bounds;
        [_searchView addSubview:search];
        search.searchBar.layer.cornerRadius = 3;
        search.searchBar.layer.masksToBounds = YES;
        
        __weak JasonSearchView * weakSearchView = search;
        search.searchBar.btnRightBlock = ^{
            weakSelf.search = weakSearchView.searchBar.text;
            [self requestCustomerData];
        };
        //    search.userInteractionEnabled = NO;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(15);
        [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        btn.frame = CGRectMake(search.right, 0, 55, _searchView.height);
        btn.userInteractionEnabled = NO;
        [_searchView addSubview:btn];
        _searchView.backgroundColor = [UIColor whiteColor];
    }
    return _searchView;
}

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _searchView.bottom) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
    }
    return _tbView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kMsgActivityCenterErrorCell = @"kMsgActivityCenterErrorCell";
    MsgActivityCenterErrorCell * cell = [tableView dequeueReusableCellWithIdentifier:kMsgActivityCenterErrorCell];
    if (!cell) {
        cell = loadNibName(@"MsgActivityCenterErrorCell");
    }
    [cell updateCellModel:_dataSource[indexPath.row] cellFrom:CellFromSearch];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHCouponSendCustomerModel * model = _dataSource[indexPath.row];
    if ([_selectResultArr containsObject:model]) {
        [XMHProgressHUD showOnlyText:kNOTICE_ACTIONCENTER_ADDCUSTOMER_ERROR_MSG];
    }else{
        [_selectResultArr addObject:model];
        [XMHProgressHUD showOnlyText:kNOTICE_ACTIONCENTER_ADDCUSTOMER_SUCCESS_MSG];
    }
}

#pragma mark ---网络请求
/** 获取统计头部数据 */
- (void)requestCustomerData
{
    NSString * search = _search?_search:@"";
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:search forKey:@"search"];
    [XMHActionCenterRequest requestCommonUrl:kCOUPON_SEND_SEARCHCUSTOMER_URL Param:param resultBlock:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
          XMHCouponSendCustomerListModel *model = [XMHCouponSendCustomerListModel yy_modelWithDictionary:resultDic];
            _dataSource = [[NSMutableArray alloc] initWithArray:model.list];
            [_tbView reloadData];
        }
    }];
}
@end
