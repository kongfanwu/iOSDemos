//
//  XMHActionCenterDataVC.m
//  xmh
//
//  Created by ald_ios on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHActionCenterDataVC.h"
#import "XMHACDataTopView.h"
#import "JasonSearchView.h"
#import "XMHACSendDataStatisticsCell.h"
#import "XMHActionCenterRequest.h"
#import "XMHCouponSendDataListModel.h"
#import "XMHCouponSendDataHeaderModel.h"
@interface XMHActionCenterDataVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)XMHACDataTopView * dataTopView;
@property (nonatomic, strong) UIView *counponBgView;
/** 优惠券按钮数组 */
@property (nonatomic, strong) NSMutableArray *couponArr;
/** 下划线 */
@property (nonatomic, strong) UIView *indicatorView;
/** 选中优惠券按钮 */
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIView * searchView;
@property (nonatomic, strong)XMHBaseTableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, copy)NSString * type;
@property (nonatomic, copy)NSString * search;

@end

@implementation XMHActionCenterDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    [self createSubViews];
    [self requestListData];
    [self requestHeaderData];
}
- (void)createSubViews
{
    [self.navView setNavViewTitle:@"数据统计" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.dataTopView];
    [self createSelectView];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.tbView];
}
- (XMHACDataTopView *)dataTopView
{
    if (!_dataTopView) {
        _dataTopView = loadNibName(@"XMHACDataTopView");
        _dataTopView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 100);
    }
    return _dataTopView;
}
- (void)createSelectView
{
    UIView *counponBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _dataTopView.bottom + 10, SCREEN_WIDTH, 44)];
    counponBgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:counponBgView];
    
    self.couponArr = [NSMutableArray array];
    CGFloat btnW = SCREEN_WIDTH / 3;
    CGFloat btnH = 41;
    NSArray *titles = @[@"现金券",@"折扣券",@"礼品券"];
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(counponBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 100;
        [counponBgView addSubview:btn];
        [self.couponArr safeAddObject:btn];
        if (i == 0) {
            [btn setTitleColor:[ColorTools colorWithHexString:@"#EA007A"] forState:UIControlStateNormal];
            self.selectBtn = btn;
        }
    }
    
    _indicatorView = [[UIView alloc]init];
    _indicatorView.backgroundColor = [ColorTools colorWithHexString:@"#EA007A"];
    _indicatorView.layer.cornerRadius = 3 * 0.5;
    _indicatorView.bounds = CGRectMake(0, 0, 25 , 3);
    _indicatorView.center = CGPointMake(self.selectBtn.center.x, 43);
    [counponBgView addSubview:_indicatorView];
    self.counponBgView = counponBgView;
}
- (UIView *)searchView
{
    WeakSelf
    if (!_searchView) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, self.counponBgView.bottom + 0.6, SCREEN_WIDTH, 63)];
        JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, (_searchView.height - 34)/2, SCREEN_WIDTH - 15 - 55, 34) withPlaceholder:@"请输入顾客名称或手机号"];
        search.line1.hidden = YES;
        search.searchBar.frame = search.bounds;
        [_searchView addSubview:search];
        search.searchBar.layer.cornerRadius = 3;
        search.searchBar.layer.masksToBounds = YES;
        
        __weak JasonSearchView * weakSearchView = search;
        search.searchBar.btnRightBlock = ^{
            weakSelf.search = weakSearchView.searchBar.text;
            [weakSelf requestListData];
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
        _tbView = [[XMHBaseTableView alloc] initWithFrame:CGRectMake(0, _searchView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _searchView.bottom) style:UITableViewStylePlain];
        _tbView.emptyEnable = YES;
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
    }
    return _tbView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kXMHACSendDataStatisticsCell = @"kXMHACSendDataStatisticsCell";
    XMHACSendDataStatisticsCell * cell = [tableView dequeueReusableCellWithIdentifier:kXMHACSendDataStatisticsCell];
    if (!cell) {
        cell = loadNibName(@"XMHACSendDataStatisticsCell");
    }
    [cell updateCellModel:_dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
- (void)counponBtnClick:(UIButton *)sender
{
    
    for (UIButton *btn in self.couponArr ) {
        if (sender.tag == btn.tag) {
            [btn setTitleColor:[ColorTools colorWithHexString:@"#EA007A"] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        }
    }
    _type = [NSString stringWithFormat:@"%ld",sender.tag - 100 + 3];
    self.selectBtn = sender;
    [UIView animateWithDuration:(0.05) animations:^{
        _indicatorView.center = CGPointMake(self.selectBtn.center.x, 43);
    }];
    [self requestListData];
}
#pragma mark ---网络请求
/** 列表数据 */
- (void)requestListData
{
    NSString * search = _search?_search:@"";
    NSString * type = _type?_type:@"3";
    NSString * activityid = _activityid?_activityid:@"";
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:activityid forKey:@"id"];
    [param setValue:search forKey:@"search"];
    [param setValue:type forKey:@"type"];
    [XMHActionCenterRequest requestCommonUrl:kCOUPON_SEND_USELIST_URL Param:param resultBlock:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            XMHCouponSendDataListModel *model = [XMHCouponSendDataListModel yy_modelWithDictionary:resultDic];
            _dataSource = [[NSMutableArray alloc] initWithArray:model.list];
            [_tbView reloadData];
        }
    }];
    
}
/** 获取统计头部数据 */
- (void)requestHeaderData
{
    NSString * activityid = _activityid?_activityid:@"";
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:activityid forKey:@"id"];
    [XMHActionCenterRequest requestCommonUrl:kCOUPON_SEND_USECOUNT_URL Param:param resultBlock:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            XMHCouponSendDataHeaderModel *model = [XMHCouponSendDataHeaderModel yy_modelWithDictionary:resultDic];
            [_dataTopView updateViewModel:model];
        }
    }];
}
@end
