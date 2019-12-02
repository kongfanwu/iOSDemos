//
//  LanternManagerHomeVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternManagerHomeVC.h"
#import "MineCellModel.h"
#import "ApplySectionFooter.h"
#import "ApplySectionHeader.h"
#import "ULBCollectionViewFlowLayout.h"
#import "StatisticsAndApplyCell.h"
#import "LanternSmartSearchVC.h"
#import "LolSmartAllocationController.h"
#import "RolesTools.h"
#import "LanternMYuanGongVC.h"
#import "LanternMGuKeVC.h"
#import "LanternMProVC.h"
#import "LanternMHistoryVC.h"
#import "LanternHomeCell.h"
#import "LanternRecommendVC.h"
#import "XMHSmartHelperHomeVC.h"
static NSString * const reuseIdentifier = @"StatisticsAndApplyCell";
static NSString * const kHeaderView = @"kHeaderView";
static NSString * const kFooterView = @"kFooterView";
@interface LanternManagerHomeVC ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
ULBCollectionViewDelegateFlowLayout,
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)NSArray * dataSource;
@property (nonatomic, strong)NSArray * collectionSource;
@end

@implementation LanternManagerHomeVC
{
//    NSArray * _dataSource;
    NSArray * _sectionTitleArr;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaseData];
    [self initSubViews];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"AI灯神"];
    
    
    _dataSource = @[[MineCellModel createModelWithTitle:@"智能助手" icon:@"zhinengzhushou"],[MineCellModel createModelWithTitle:@"智能推荐" icon:@"ai_shendeng_zhinengtuijian"]];
//    [self.navView setNavViewTitle:@"AI灯神"];
    self.navView.backgroundColor = kColorTheme;
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tbView];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([RolesTools getUserMainRole] == 1 ||[RolesTools getUserMainRole] == 3||[RolesTools getUserMainRole] == 4||[RolesTools getUserMainRole] == 5||[RolesTools getUserMainRole] == 6||[RolesTools getUserMainRole] == 7) {
        self.collectionView.hidden = NO;
        self.tbView.hidden = YES;
    }else{
        self.collectionView.hidden = YES;
        self.tbView.hidden = NO;
    }
}
- (void)initBaseData
{
    _collectionSource = @[[MineCellModel createModelWithTitle:@"智能检索" icon:@"aidengshen_zhinengjiansuo"],[MineCellModel createModelWithTitle:@"智能分配" icon:@"yingyong_zhinengfenpei"],[MineCellModel createModelWithTitle:@"智能监测" icon:@"aidengshen_zhinengjiance"],[MineCellModel createModelWithTitle:@"智能追踪" icon:@"aidengshen_zhinengzhuizong"]];
//     _dataSource = @[[MineCellModel createModelWithTitle:@"智能检索" icon:@"yingxiao_saomalingli"],[MineCellModel createModelWithTitle:@"智能监测" icon:@"yingxiao_xiangmuyinliu"],[MineCellModel createModelWithTitle:@"智能追踪" icon:@"yingxiao_laokeliebian"]];
    _sectionTitleArr = @[@"AI灯神"];
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        ULBCollectionViewFlowLayout *layout = [[ULBCollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGSize size = [UIScreen mainScreen].bounds.size;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 20)/3 - 10, (SCREEN_WIDTH - 20)/3);
        //        layout.minimumInteritemSpacing = 10;
        //        layout.minimumLineSpacing = 10;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
        layout.headerReferenceSize = CGSizeMake(size.width, 56);
        layout.footerReferenceSize = CGSizeMake(size.width, 20);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, Heigh_Nav,SCREEN_WIDTH - 20,Heigh_View) collectionViewLayout:layout];
        [_collectionView registerClass:[StatisticsAndApplyCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerClass:[ApplySectionHeader class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderView];
        [_collectionView registerClass:[ApplySectionFooter class]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterView];
        _collectionView.delegate =self;
        _collectionView.dataSource =self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        ApplySectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderView forIndexPath:indexPath];
        [header updateApplySectionHeaderTitle:_sectionTitleArr[indexPath.section]];
        reusableView = header;
    }else if (kind == UICollectionElementKindSectionFooter){
        ApplySectionFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterView forIndexPath:indexPath];
        reusableView = footer;
    }
    return reusableView;
}
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section
{
    return [UIColor whiteColor];
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectionSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StatisticsAndApplyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell updateStatisticsAndApplyCellModel:_collectionSource[indexPath.row]withCount:nil];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MineCellModel * model = _collectionSource[indexPath.row];
    if ([model.title isEqualToString:@"智能检索"]) {
        LanternSmartSearchVC * lanternSmartSearchVC = [[LanternSmartSearchVC alloc] initWithControllersClass:@[[LanternMYuanGongVC class],[LanternMGuKeVC class],[LanternMProVC class],[LanternMHistoryVC class]]];
        [self.navigationController pushViewController:lanternSmartSearchVC animated:NO];
    }
    if ([model.title isEqualToString:@"智能监测"]) {
        [SVProgressHUD showInfoWithStatus:@"正在开发建设中，敬请期待"];
    }
    if ([model.title isEqualToString:@"智能分配"]) {
        if ([RolesTools applyPushToApproveVC]) {
            LolSmartAllocationController * nextVC = [[LolSmartAllocationController alloc] init];
            [self.navigationController pushViewController:nextVC animated:NO];
        }else{
            [[[MzzHud alloc]initWithTitle:@"提示" message:@"您没有权限操作，若有疑问请联系管理员" centerButtonTitle:@"我知道了" click:nil] show];
        }
    }
    if ([model.title isEqualToString:@"智能追踪"]) {
        [SVProgressHUD showInfoWithStatus:@"正在开发建设中，敬请期待"];
    }
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorF5F5F5;
    }
    return _tbView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kLanternHomeCell = @"kLanternHomeCell";
    LanternHomeCell * lanternHomeCell = [tableView dequeueReusableCellWithIdentifier:kLanternHomeCell];
    if (!lanternHomeCell) {
        lanternHomeCell = loadNibName(@"LanternHomeCell");
        
    }
    [lanternHomeCell updateLanternHomeCellModel:_dataSource[indexPath.row]];
    return lanternHomeCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 141;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCellModel * model = _dataSource[indexPath.row];
    if ([model.title isEqualToString:@"智能助手"]) {
        XMHSmartHelperHomeVC * nextVC = [[XMHSmartHelperHomeVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:NO];
    }
    if ([model.title isEqualToString:@"智能推荐"]) {
        LanternRecommendVC * lanternRecommendVC = [[LanternRecommendVC alloc] init];
        [self.navigationController pushViewController:lanternRecommendVC animated:NO];
    }
}
@end
