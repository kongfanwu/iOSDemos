//
//  StatisticsViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "StatisticsViewController.h"
#import "StatisticsAndApplyCell.h"
#import "SmarketViewController.h"
#import "MineCellModel.h"
#import "ApplySectionFooter.h"
#import "ApplySectionHeader.h"
#import "ULBCollectionViewFlowLayout.h"
#import "XMHMarketVC.h"
static NSString * const reuseIdentifier = @"StatisticsAndApplyCell";
static NSString * const kHeaderView = @"kHeaderView";
static NSString * const kFooterView = @"kFooterView";
@interface StatisticsViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
ULBCollectionViewDelegateFlowLayout
>
@property (nonatomic,strong)UICollectionView * collectionView;
@end
@implementation StatisticsViewController
{
    NSArray * _dataSource;
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
    [self.navView setNavViewTitle:@"营销" backBtnShow:YES];
    [self.view addSubview:self.collectionView];
}
- (void)initBaseData
{
    _dataSource = @[[MineCellModel createModelWithTitle:@"扫码领礼" icon:@"yingxiao_saomalingli"],[MineCellModel createModelWithTitle:@"项目引流" icon:@"yingxiao_xiangmuyinliu"],[MineCellModel createModelWithTitle:@"老客裂变" icon:@"yingxiao_laokeliebian"],[MineCellModel createModelWithTitle:@"权益包" icon:@"gkgl_quanyibao"],[MineCellModel createModelWithTitle:@"VIP活动" icon:@"gkgl_viphuodong"]];
    _sectionTitleArr = @[@"营销"];
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
    return _dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StatisticsAndApplyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell updateStatisticsAndApplyCellModel:_dataSource[indexPath.row]withCount:nil];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    SmarketViewController * next = [[SmarketViewController alloc] init];
//
//    next.title = [_dataSource[indexPath.row] title];
    
/** 新版营销二维码分享不上线20190524 */
    
    NSString * title = [_dataSource[indexPath.row] title];
    XMHMarketVCType vcType;
    if ([title isEqualToString:@"扫码领礼"]) {
        vcType = XMHMarketVCTypeSMLL;
    }else if ([title isEqualToString:@"项目引流"]){
        vcType = XMHMarketVCTypeXMYL;
    }else if ([title isEqualToString:@"老客裂变"]){
        vcType = XMHMarketVCTypeLKLB;
    }else if ([title isEqualToString:@"权益包"]){
        vcType = XMHMarketVCTypeQYB;
    }else {
        vcType = XMHMarketVCTypeVIP;
    }
    XMHMarketVC * next = [[XMHMarketVC alloc] init];
    next.marketVCType = vcType;
    next.navtitle = [_dataSource[indexPath.row] title];
    
    [self.navigationController pushViewController:next animated:NO];
}
#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(80*WIDTH_SALE_BASE, 100*I6_HEIGHT_SALE);
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(20 *I6_HEIGHT_SALE, 30*WIDTH_SALE_BASE, 0, 30*WIDTH_SALE_BASE);
//}
@end
