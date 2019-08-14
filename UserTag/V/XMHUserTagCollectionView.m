//
//  XMHUserTagCollectionView.m
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUserTagCollectionView.h"
#import "XMHUserTagSectionModel.h"
#import "XMHUserTagModel.h"
#import "XMHUserTagCell.h"
#import "XMHUserTagCollectionHeaderView.h"

@interface XMHUserTagCollectionView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation XMHUserTagCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;

        [self registerClass:[XMHUserTagCell class] forCellWithReuseIdentifier:@"XMHUserTagCellIdentifier"];
        [self registerClass:[XMHUserTagCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader"];
        [self registerClass:[XMHUserTagCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    XMHUserTagSectionModel *sectionMdoel = _dataArray[section];
    return sectionMdoel.childs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMHUserTagSectionModel *sectionMdoel = _dataArray[indexPath.section];
    XMHUserTagModel *userTagModel = sectionMdoel.childs[indexPath.item];
    
    XMHUserTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMHUserTagCellIdentifier" forIndexPath:indexPath];
    [cell configModel:userTagModel];
    __weak typeof(self) _self = self;
    [cell setDeleteClickBlock:^(XMHUserTagModel * _Nonnull userTagModel) {
        __strong typeof(_self) self = _self;
        if ([self.aDelegate respondsToSelector:@selector(deleteCellIndexPath:)]) {
            [self.aDelegate deleteCellIndexPath:indexPath];
        }
    }];
    return cell;
}

#pragma mark - UICollectionViewDelegate

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    XMHUserTagSectionModel *sectionMdoel = _dataArray[indexPath.section];
//    XMHUserTagModel *userTagModel = sectionMdoel.childs[indexPath.item];
//    return userTagModel.cellSize;
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 15, 0, 15);
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 15;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}
//

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    XMHUserTagSectionModel *sectionMdoel = _dataArray[section];
    if (section == _dataArray.count - 1 && sectionMdoel.type == XMHUserTagSectionModelTypeAdd) {
        return CGSizeZero;
    }
    return CGSizeMake(collectionView.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    XMHUserTagSectionModel *sectionMdoel = _dataArray[section];
    
    if (section == _dataArray.count - 1 && sectionMdoel.type == XMHUserTagSectionModelTypeAdd) {
        return CGSizeMake(collectionView.width, 70);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    XMHUserTagSectionModel *sectionMdoel = _dataArray[indexPath.section];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XMHUserTagCollectionHeaderView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader" forIndexPath:indexPath];
        [collectionReusableView configModel:sectionMdoel];
//        collectionReusableView.backgroundColor = UIColor.redColor;
        return collectionReusableView;
    } else {
        XMHUserTagCollectionHeaderView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
//        collectionReusableView.backgroundColor = UIColor.blueColor;
        [collectionReusableView configModel:sectionMdoel];
        
        __weak typeof(self) _self = self;
        [collectionReusableView setTapClickBlock:^{
            __strong typeof(_self) self = _self;
            if ([self.aDelegate respondsToSelector:@selector(addTagType)]) {
                [self.aDelegate addTagType];
            }
        }];
        return collectionReusableView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMHUserTagSectionModel *sectionMdoel = _dataArray[indexPath.section];
    XMHUserTagModel *userTagModel = sectionMdoel.childs[indexPath.item];
    if (userTagModel.type == XMHUserTagModelTypeAdd) {
        if ([self.aDelegate respondsToSelector:@selector(addCellIndexPath:)]) {
            [self.aDelegate addCellIndexPath:indexPath];
        }
    } else {
        if ([self.aDelegate respondsToSelector:@selector(didSelectItemAtIndexPath:)]) {
            [self.aDelegate didSelectItemAtIndexPath:indexPath];
        }
    }
}

@end
