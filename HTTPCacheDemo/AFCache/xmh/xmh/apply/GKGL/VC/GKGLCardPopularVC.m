//
//  GKGLCardPopularVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCardPopularVC.h"
#import "LanternPlanCollectionCell.h"
#import "GKGLCardPopularHeaderView.h"
#import "GKGLCardPopularFooterView.h"
#import "GKGLCardPopularDetailVC.h"
#import "MzzCustomerRequest.h"
@interface GKGLCardPopularVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *myCollectionView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@end

@implementation GKGLCardPopularVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorE;
    [self.navView setNavViewTitle:@"卡项普及" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.myCollectionView];
    _dataSource = [[NSMutableArray alloc] init];
    [self requestCardData];
}
- (UICollectionView *)myCollectionView {
    if (_myCollectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemW = (SCREEN_WIDTH - 40) / 2;
        CGFloat itemH = 30;
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 5, 15);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_myCollectionView registerNib:[UINib nibWithNibName:@"LanternPlanCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LanternPlanCollectionCell"];
        [_myCollectionView registerNib:[UINib nibWithNibName:@"GKGLCardPopularHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [_myCollectionView registerNib:[UINib nibWithNibName:@"GKGLCardPopularFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    }
    return _myCollectionView;
}
#pragma mark ------UICollectionViewDelegate------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    WeakSelf
    if (kind == UICollectionElementKindSectionHeader) {
        GKGLCardPopularHeaderView *headerView = (GKGLCardPopularHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [headerView updateGKGLCardPopularHeaderViewTitleIndex:indexPath.section];
        headerView.GKGLCardPopularHeaderViewTapBlock = ^(NSInteger index){
            GKGLCardPopularDetailVC * cardPopularDetailVC = [[GKGLCardPopularDetailVC alloc] init];
            cardPopularDetailVC.dataSource = _dataSource[index];
            [weakSelf.navigationController pushViewController:cardPopularDetailVC animated:NO];
        };
//        [headerView updateLanternPlanSetionHeardViewModel:_dataSource[indexPath.section]];
        reusableView = headerView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        GKGLCardPopularFooterView *footer = (GKGLCardPopularFooterView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footer.backgroundColor = kColorE;
        //        [headerView updateLanternPlanSetionHeardViewModel:_dataSource[indexPath.section]];
        reusableView = footer;
    }
    return reusableView;
}
// 设置区头尺寸高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(SCREEN_WIDTH - 30, 50);
    return size;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(SCREEN_WIDTH - 30, 20);
    return size;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    return 3;
    return _dataSource.count;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_dataSource[section] count] >6) {
        return 6;
    }else{
       return [_dataSource[section] count];
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LanternPlanCollectionCell * lanternPlanCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LanternPlanCollectionCell" forIndexPath:indexPath];
    [lanternPlanCollectionCell updateCellParam:_dataSource[indexPath.section][indexPath.row]];
    return lanternPlanCollectionCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
}
#pragma mark ------网络请求------
- (void)requestCardData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_userid?_userid:@"" forKey:@"user_id"];
    NSMutableArray * cardArr = [[NSMutableArray alloc] init];
    [MzzCustomerRequest requestGKGLCustomerCommonUrl:kGKGL_CARDPOPULAR_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            for (int i = 0; i < resultDic.allKeys.count; i++) {
                NSString * key = resultDic.allKeys[i];
                if (!([key isEqualToString:@"goods"])&&!([key isEqualToString:@"pro"])) {
                    [cardArr addObjectsFromArray:resultDic[key]];
                }
            }
            [_dataSource addObject:cardArr];
            [_dataSource addObject:resultDic[@"pro"]];
            [_dataSource addObject:resultDic[@"goods"]];
            [_myCollectionView reloadData];
        }else{}
    }];
}
@end
