//
//  LanternRecommendVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternRecommendVC.h"
#import "LanternRecommendCell.h"
#import "LanternRecommendSwtichView.h"
#import "CheckPlanVC.h"
#import "LanternRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "LanternRecommendFootView.h"
#import "LanternPlanVC.h"
#import "DateTools.h"
#import "LanternCustomerDetailVC.h"
#import "XMHRefreshGifHeader.h"
@interface LanternRecommendVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)LanternRecommendSwtichView * recommonSwitchView;
@property (nonatomic, strong)LanternRecommendFootView * lanternRecommendFootView;
@property (nonatomic, strong)LanternRecommedListModel * lanternRecommedListModel;
@property (nonatomic, strong)NSString * currentMonth;
@property (nonatomic, strong)NSString * nextMonth;
@property (nonatomic, strong)NSString * date;
@property (nonatomic, strong)NSString * footerType;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
/** <##> */
@property (nonatomic) NSInteger tag;
@end

@implementation LanternRecommendVC
{
    /** 加载更多 */
    BOOL _isMore;
    NSInteger _page;
    /** switch选择 */
//    NSInteger _tag;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [[NSMutableArray alloc] init];
    _isMore = NO;
    _page = 0;
    _currentMonth = [DateTools getCurrentMonth];
    _nextMonth = [DateTools getNextMonth];
    _date = _nextMonth;
    _footerType = @"1";
    [self initSubViews];
    [self requestRecommendData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestRecommendData];
}
- (void)initSubViews
{
    WeakSelf
    [self.navView setNavViewTitle:@"智能推荐" backBtnShow:YES rightBtnTitle:@"查看历史计划"];
    self.navView.backgroundColor = kBtn_Commen_Color;
    self.navView.NavViewRightBlock = ^{
        CheckPlanVC  * checkPlanVC = [[CheckPlanVC alloc] init];
        [weakSelf.navigationController pushViewController:checkPlanVC animated:NO];
    };
    [self.view addSubview:self.recommonSwitchView];
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.lanternRecommendFootView];
    
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _recommonSwitchView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _recommonSwitchView.bottom - 70 - kSafeAreaBottom) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        __weak typeof(self) _self = self;
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestMoreData];
        }];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
           [self refreshTbData];
            
        }];
    }
    return _gifHeader;
}
- (LanternRecommendSwtichView *)recommonSwitchView
{
    WeakSelf
    if (!_recommonSwitchView) {
        _recommonSwitchView = loadNibName(@"LanternRecommendSwtichView");
        _recommonSwitchView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 44);
        _recommonSwitchView.LanternRecommendSwtichViewBlock = ^(NSUInteger tag) {
            weakSelf.tag = tag;
            if (tag == 101) {/** 本月 */
                [weakSelf.lanternRecommendFootView updateLanternRecommendFootViewLeftEnable:weakSelf.lanternRecommedListModel.thisConsume rightEnable:weakSelf.lanternRecommedListModel.thisExpend];
                [weakSelf.lanternRecommendFootView updateLanternRecommendFootViewMonth:weakSelf.currentMonth];
                weakSelf.date = weakSelf.currentMonth;

            }
            if (tag == 100) {/** 下月 */
                [weakSelf.lanternRecommendFootView updateLanternRecommendFootViewLeftEnable:weakSelf.lanternRecommedListModel.nextConsume rightEnable:weakSelf.lanternRecommedListModel.nextExpend];
                weakSelf.date = weakSelf.nextMonth;
                [weakSelf.lanternRecommendFootView updateLanternRecommendFootViewMonth:weakSelf.nextMonth];
            }
            
        };
    }
    return _recommonSwitchView;
}
- (LanternRecommendFootView *)lanternRecommendFootView
{
    WeakSelf
    if (!_lanternRecommendFootView) {
        _lanternRecommendFootView = loadNibName(@"LanternRecommendFootView");
        _lanternRecommendFootView.frame = CGRectMake(0, SCREEN_HEIGHT - 70 - kSafeAreaBottom, SCREEN_WIDTH, 70);
        _lanternRecommendFootView.LanternRecommendFootViewBlock = ^(NSString *type) {
            LanternPlanVC * lanternPlanVC = [[LanternPlanVC alloc] init];
            lanternPlanVC.type = type;
            lanternPlanVC.date = weakSelf.date;
            lanternPlanVC.comeFrom = ComeFromeHome;
            [weakSelf.navigationController pushViewController:lanternPlanVC animated:NO];
            weakSelf.footerType = type;
        };
        [_lanternRecommendFootView updateLanternRecommendFootViewMonth:weakSelf.nextMonth];
    }
    return _lanternRecommendFootView;
}
- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestRecommendData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 0;
    [self requestRecommendData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kLanternRecommendCell = @"kLanternRecommendCell";
    LanternRecommendCell * lanternRecommendCell = [tableView dequeueReusableCellWithIdentifier:kLanternRecommendCell];
    if (!lanternRecommendCell) {
        lanternRecommendCell = loadNibName(@"LanternRecommendCell");
    }
    [lanternRecommendCell updateLanternRecommendCellModel:_dataSource[indexPath.row]];
    return lanternRecommendCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LanternCustomerDetailVC * lanternCustomerDetailVC = [[LanternCustomerDetailVC alloc] init];
    lanternCustomerDetailVC.lanternRecommedModel = _dataSource[indexPath.row];
    [self.navigationController pushViewController:lanternCustomerDetailVC animated:NO];
}
#pragma mark ------网络请求------
- (void)requestRecommendData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:page?page:@"" forKey:@"page"];
    [LanternRequest requestRecommendData:param resultBlock:^(LanternRecommedListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            _lanternRecommedListModel = model;
            if(_footerType.integerValue == 1){
                [_lanternRecommendFootView updateLanternRecommendFootViewLeftEnable:_lanternRecommedListModel.nextConsume rightEnable:_lanternRecommedListModel.nextExpend];
            }else if (_footerType.integerValue == 2){
                [_lanternRecommendFootView updateLanternRecommendFootViewLeftEnable:_lanternRecommedListModel.thisConsume rightEnable:_lanternRecommedListModel.thisExpend];
            }
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.list];
            if (model.list.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            [_tbView reloadData];
        }else{}
    }];
}
@end
