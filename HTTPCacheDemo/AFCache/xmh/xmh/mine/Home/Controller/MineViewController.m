//
//  MineViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MineViewController.h"
#import "MineRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "MineTopModel.h"
#import "SettingViewController.h"
#import "MineInformationController.h"
#import "SuggestViewController.h"
#import "ShareWorkInstance.h"
#import "MzzSettingTargetController.h"
#import "MineCellModel.h"
#import "LUserInfoView.h"
#import "HomeCell.h"
#import "MineTenantsViewController.h"
#import "StatisticsViewController.h"
#import "XMHRefreshGifHeader.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)LUserInfoView *userInfoView;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

#define kMargin 15
static NSString * homeCell = @"homeCell";
@implementation MineViewController
{
    MineTopModel * _topModel;
    NSArray * _dataSource;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataSource];
    [self initSubViews];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mainRoot) name:AppDelegate_LoginSuccess object:nil];
    [self getTopData];
}
- (void)mainRoot
{
    [self getTopData];
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [self getTopData];
//}
//初始化数据源
- (void)initDataSource
{
    _dataSource = [[NSMutableArray alloc] init];
    _dataSource = @[[MineCellModel createModelWithTitle:@"意见反馈" icon:@"wode_yijianfankui"],[MineCellModel createModelWithTitle:@"邀请入驻" icon:@"yaoqingruzhu"],[MineCellModel createModelWithTitle:@"我的营销二维码" icon:@"wode_wodeyingxiaoerweima"],[MineCellModel createModelWithTitle:@"设置" icon:@"wode_shezhi"]];
}
- (void)initSubViews
{   //设置title
    [self.navView setNavViewTitle:@"我的"];
    //添加tableView
    [self.view addSubview:self.tbView];
    
    self.view.backgroundColor = Color_NormalBG;
}
- (UITableView *)tbView
{
//    WeakSelf
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(kMargin, Heigh_Nav, SCREEN_WIDTH - 2 * kMargin, Heigh_View) style:UITableViewStylePlain];
        _tbView.backgroundColor = [UIColor clearColor];
        _tbView.tableHeaderView = self.userInfoView;
        _tbView.tableFooterView = [UIView new];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tbView.separatorColor = Color_NormalBG;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf getTopData];
//        }];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self getTopData];
            });
        }];
    }
    return _gifHeader;
}
- (LUserInfoView *)userInfoView
{
    WeakSelf
    if (!_userInfoView) {
        _userInfoView = [LUserInfoView loadUserInfoView];
        _userInfoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 156);
        _userInfoView.UserInfoViewBlock = ^{
            MineInformationController * next = [[MineInformationController alloc] init];
            [weakSelf.navigationController pushViewController:next animated:NO];
        };
    }
    return _userInfoView;
}
//获取顶部 用户信息数据
- (void)getTopData
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * framId = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    [MineRequest requestTopDataFramId:framId uid:accountId joinCode:joinCode resultBlock:^(MineTopModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_userInfoView updateUserInfoViewModel:model];
            [_tbView.mj_header endRefreshing];
        }
    }];
}
#pragma mark <UITableView>
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HomeCell * cell = nil;
    if (!cell) {
        cell = loadNibName(@"HomeCell");
    }
    [cell updateHomeCellModel:_dataSource[indexPath.row] index:indexPath.row count:_dataSource.count];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCellModel * model = _dataSource[indexPath.row];
    if ([model.title isEqualToString:@"意见反馈"]) {
        SuggestViewController * next = [[SuggestViewController alloc] init];
        [self.navigationController pushViewController:next animated:NO];
    }
    if ([model.title isEqualToString:@"邀请入驻"]) {
        MineTenantsViewController *tenantsVC=[[MineTenantsViewController alloc]init];
        [self.navigationController pushViewController:tenantsVC animated:NO];
    }
    if ([model.title isEqualToString:@"我的营销二维码"]) {
        StatisticsViewController *statisticsVC = [[StatisticsViewController alloc] init];
         [self.navigationController pushViewController:statisticsVC animated:NO];
    }
    if ([model.title isEqualToString:@"设置"]) {
        SettingViewController * next = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:next animated:NO];
    }
}
@end
