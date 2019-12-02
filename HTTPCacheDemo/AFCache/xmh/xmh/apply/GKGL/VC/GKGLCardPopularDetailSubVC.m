//
//  GKGLCardPopularDetailSubVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCardPopularDetailSubVC.h"
#import "LanternPlanCollectionCell.h"
@interface GKGLCardPopularDetailSubVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *myCollectionView;
@end

@implementation GKGLCardPopularDetailSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorE;
    [self.view addSubview:self.myCollectionView];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.myCollectionView.frame = self.view.bounds;
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
        _myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _myCollectionView.top = 10;
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
        [_myCollectionView registerNib:[UINib nibWithNibName:@"LanternPlanCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LanternPlanCollectionCell"];
    }
    return _myCollectionView;
}
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    [_myCollectionView reloadData];
}
#pragma mark ------UICollectionViewDelegate------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LanternPlanCollectionCell * lanternPlanCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LanternPlanCollectionCell" forIndexPath:indexPath];
    [lanternPlanCollectionCell updateCellParam:_dataSource[indexPath.row] tag:_tag];
    return lanternPlanCollectionCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
