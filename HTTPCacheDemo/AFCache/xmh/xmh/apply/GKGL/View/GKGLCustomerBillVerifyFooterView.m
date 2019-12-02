//
//  GKGLCustomerBillVerifyFooterView.m
//  xmh
//
//  Created by ald_ios on 2019/1/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerBillVerifyFooterView.h"
#import "GKGLCustomerBillVerifyCollectionViewCell.h"
#import "GKGLBillListModel.h"
#import <YYWebImage/YYWebImage.h>
@interface GKGLCustomerBillVerifyFooterView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewTitle;
@property (nonatomic,strong)UICollectionView *myCollectionView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@end
@implementation GKGLCustomerBillVerifyFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _dataSource = [[NSMutableArray alloc] init];
    /** 新版添加 */
    [self addSubview:self.myCollectionView];
}

- (UICollectionView *)myCollectionView {
    if (_myCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(70, 95);
//        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 , _viewTitle.bottom, SCREEN_WIDTH, self.height - _viewTitle.bottom) collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor clearColor];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 0);
        [_myCollectionView registerNib:[UINib nibWithNibName:@"GKGLCustomerBillVerifyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GKGLCustomerBillVerifyCollectionViewCell"];
        _myCollectionView.showsHorizontalScrollIndicator = NO;
        _myCollectionView.pagingEnabled = NO;
    }
    return _myCollectionView;
}
#pragma mark ------UICollectionViewDelegate------
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * param = _dataSource[indexPath.row];
    if ([param[@"selected"] integerValue] == 0) {
        [param setValue:@"1" forKey:@"selected"];
    }else{
        [param setValue:@"0" forKey:@"selected"];
    }
    if (_GKGLCustomerBillVerifyFooterViewBlock) {
        _GKGLCustomerBillVerifyFooterViewBlock(_dataSource);
    }
    [_myCollectionView reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GKGLCustomerBillVerifyCollectionViewCell * billCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GKGLCustomerBillVerifyCollectionViewCell" forIndexPath:indexPath];
    [billCollectionCell updateCellParam:_dataSource[indexPath.row]];
    return billCollectionCell;
}
- (void)updateGKGLCustomerBillVerifyFooterViewParam:(NSDictionary *)param
{
    [_dataSource removeAllObjects];
    [_dataSource addObjectsFromArray:param[@"approvalPerson"]];
    for (int i = 0; i < _dataSource.count; i++) {
        NSMutableDictionary * dict = _dataSource[i];
        [dict setValue:@"0" forKey:@"selected"];
    }
    [_myCollectionView reloadData];
}
@end
