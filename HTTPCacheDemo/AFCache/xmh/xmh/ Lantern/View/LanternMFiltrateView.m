//
//  LanternMFiltrateView.m
//  xmh
//
//  Created by ald_ios on 2019/2/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMFiltrateView.h"
#import "LanternMProCell.h"
#import "LanternMProHeaderView.h"
@interface LanternMFiltrateView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, assign)NSInteger selectSection;
@property (nonatomic, assign)NSInteger selectIndex;
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (nonatomic, strong)NSArray * keySource;
@property (nonatomic, strong)NSMutableDictionary * selectParam;
@end
@implementation LanternMFiltrateView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _btnLeft.layer.cornerRadius = _btnRight.layer.cornerRadius = 3;
    _btnLeft.layer.masksToBounds = _btnRight.layer.masksToBounds = YES;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 20 - 15 *3) / 4, 30);
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.minimumLineSpacing = 10;
    _myCollectionView.dataSource = self;
    _myCollectionView.delegate = self;
    _myCollectionView.scrollEnabled = YES;
    _myCollectionView.bounces = NO;
    _myCollectionView.collectionViewLayout = layout;
    _myCollectionView.showsVerticalScrollIndicator = NO;
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    [_myCollectionView registerNib:[UINib nibWithNibName:@"LanternMProCell" bundle:nil] forCellWithReuseIdentifier:@"LanternMProCell"];
    [_myCollectionView registerNib:[UINib nibWithNibName:@"LanternMProHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_bg addGestureRecognizer:tap];
    _keySource = @[@"xiaoshou",@"chengjiao",@"shizuo",@"pujilv",@"fugoulv"];
}

- (void)tapDown:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}
- (IBAction)reset:(UIButton *)sender
{
    for (int i = 0; i< _dataSource.count; i++) {
        NSArray * tempArr = _dataSource[i][@"list"];
        for (int j = 0; j< tempArr.count; j++) {
            NSMutableDictionary * tempDic = tempArr[j];
            [tempDic setValue:@(NO) forKey:@"select"];
        }
    }
    [_myCollectionView reloadData];
}
- (IBAction)search:(UIButton *)sender
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < _keySource.count; i ++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        NSMutableArray * customArr = [[NSMutableArray alloc] init];
        NSMutableArray * sysArr = [[NSMutableArray alloc] init];
        NSArray * tempArr = _dataSource[i][@"list"];
        for (int j = 0; j< tempArr.count; j++) {
            NSMutableDictionary * tempDic = tempArr[j];
            if ([tempDic[@"select"] boolValue]) {
                [sysArr addObject:@(j + 1)];
                if ([tempDic.allKeys containsObject:@"custom"]) {
                    [customArr addObject:tempDic[@"name"]];
                }
            }
        }
        [dict setValue:customArr forKey:@"custom"];
        [dict setValue:sysArr forKey:@"sys"];
        [param setValue:dict forKey:_keySource[i]];
    }
    if (_LanternMFiltrateViewSearchBlock) {
        _LanternMFiltrateViewSearchBlock(param.jsonData);
    }
    [self removeFromSuperview];
}
#pragma mark ------UICollectionViewDelegate------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        LanternMProHeaderView *headerView = (LanternMProHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.LanternMProHeaderViewClickBlock = ^(NSMutableDictionary * _Nonnull param) {
            if ([_dataSource containsObject:param]) {
                [_dataSource replaceObjectAtIndex:[_dataSource indexOfObject:param] withObject:param];
            }
            for (int i = 0; i < _dataSource.count; i++) {
                NSInteger index = [_dataSource indexOfObject:param];
                if (i != index) {
                    _dataSource[i][@"selected"] = @"0";
                }
            }
            [_myCollectionView reloadData];
        };
        
        [headerView updateViewParam:_dataSource[indexPath.section]];
        reusableView = headerView;
    }
    
    return reusableView;
}
#pragma mark - UICollectionViewDelegateFlowLayout
// 设置区头尺寸高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(SCREEN_WIDTH - 20, 50);
    return size;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LanternMProCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LanternMProCell" forIndexPath:indexPath];
    NSMutableArray * tempArr = _dataSource[indexPath.section][@"list"];
    if (indexPath.row == tempArr.count - 1) {
        [cell updateCellParam:_dataSource[indexPath.section][@"list"][indexPath.row] islast:YES];
    }else{
        [cell updateCellParam:_dataSource[indexPath.section][@"list"][indexPath.row] islast:NO];
    }
    cell.LanternMProCellBlock = ^(NSMutableDictionary * _Nonnull param) {
        [tempArr replaceObjectAtIndex:indexPath.row withObject:param];
    };
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_dataSource[section][@"selected"] boolValue]) {
        NSArray * tempArr = _dataSource[section][@"list"];
        return tempArr.count;
    }else{
        return 0;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i< _dataSource.count; i++) {
        NSArray * tempArr = _dataSource[i][@"list"];
        for (int j = 0; j< tempArr.count; j++) {
            NSMutableDictionary * tempDic = tempArr[j];
            if ([tempDic[@"select"] boolValue]) {
                _selectParam = tempDic;
            }
        }
    }
    NSMutableDictionary * currentDic = _dataSource[indexPath.section][@"list"][indexPath.row];
    if ([currentDic isEqual:_selectParam]) {
        if ([currentDic[@"select"] boolValue]) {
            currentDic[@"select"] = @(NO);
        }else{
            currentDic[@"select"] = @(YES);
        }
    }else{
        _selectParam[@"select"] = @(NO);
        currentDic[@"select"] = @(YES);
        _selectParam = currentDic;
    }
    [_myCollectionView performBatchUpdates:^{
        [_myCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    } completion:nil];
}
@end
