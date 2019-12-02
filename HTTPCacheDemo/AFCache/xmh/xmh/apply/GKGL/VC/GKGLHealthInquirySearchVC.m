//
//  GKGLHealthInquirySearchVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLHealthInquirySearchVC.h"
#import "GKGLHomeCell.h"
#import "MzzCustomerRequest.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "GKGLHomeCustomerListModel.h"
@interface GKGLHealthInquirySearchVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)JasonSearchView * searchView;
@property (nonatomic, strong)UIButton * searchBtn;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@end

@implementation GKGLHealthInquirySearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorE;
    _dataSource = [[NSMutableArray alloc] init];
    [self.navView setNavViewTitle:@"" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.searchBtn];
    [self.view addSubview:self.tbView];
}
- (JasonSearchView *)searchView
{
    WeakSelf
    if (!_searchView) {
        _searchView = [[JasonSearchView alloc] initWithFrame:CGRectMake(40, kSafeAreaTop + 7, 270, 30) withPlaceholder:@"请输入顾客姓名或者手机号进行搜索"];
        _searchView.layer.cornerRadius = 3;
        _searchView.layer.masksToBounds = YES;
        _searchView.searchBar.frame = _searchView.bounds;
        _searchView.searchBar.btnleftBlock = ^{
            [weakSelf requestCustomerData];
        };
        _searchView.searchBar.btnRightBlock = ^{
            [weakSelf requestCustomerData];
        };
        _searchView.searchBar.backgroundColor = kColorF5F5F5;
        _searchView.line1.hidden = YES;
    }
    return _searchView;
}
- (UIButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(_searchView.right, _searchView.top, SCREEN_WIDTH - 40 - _searchView.width, 30);
        _searchBtn.titleLabel.font = FONT_SIZE(15);
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _searchBtn;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav + 10 , SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 10 ) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
    }
    return _tbView;
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kGKGLHomeCell = @"kGKGLHomeCell";
    GKGLHomeCell * homeCell = [tableView dequeueReusableCellWithIdentifier:kGKGLHomeCell];
    if (!homeCell) {
        homeCell =  loadNibName(@"GKGLHomeCell");
    }
    [homeCell updateGKGLHomeCellModel:_dataSource[indexPath.row]];
    return homeCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_GKGLHealthInquirySearchVCBlock) {
        _GKGLHealthInquirySearchVCBlock(_dataSource[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}
#pragma mark ------网络请求------
/** 顾客列表数据 */
- (void)requestCustomerData
{
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * page = @"1";
    NSString * searchText = _searchView.searchBar.text;
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:page?page:@"" forKey:@"page"];
    [param setValue:@"" forKey:@"sort"];
    [param setValue:@"" forKey:@"type"];
    [param setValue:searchText?searchText:@"" forKey:@"q"];
    [MzzCustomerRequest requestGKGLHomeCustomerListParams:param resultBlock:^(GKGLHomeCustomerListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:model.list];
            [_tbView reloadData];
        }
    }];
}
@end
