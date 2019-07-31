//
//  XMHMonthAndWeekCollectionView.m
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/1.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "XMHMonthAndWeekCollectionView.h"
#import "XMHCollectionWeekCell.h"
#import "XMHCollectionMonthCell.h"
#import "XMHMonthAndWeekModel.h"

@interface XMHMonthAndWeekCollectionView() <UICollectionViewDelegate, UICollectionViewDataSource>
/** 选中的model集合 */
@property (nonatomic, strong) NSMutableArray *selectModelArray;
@end

@implementation XMHMonthAndWeekCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        _type = XMHMonthAndWeekCollectionViewTypeWeek;
        _xmhScrollDirection = UICollectionViewScrollDirectionVertical;
        self.delegate = self;
        self.dataSource = self;

        [self registerClass:[XMHCollectionWeekCell class] forCellWithReuseIdentifier:@"XMHCollectionWeekCellIdentifier"];
        [self registerClass:[XMHCollectionMonthCell class] forCellWithReuseIdentifier:@"XMHCollectionMonthCellIdentifier"];
        
        self.lastFrame = CGRectZero;
        
    }
    return self;
}

- (void)setDataArray:(NSArray <XMHMonthAndWeekModel *> *)dataArray {
    _dataArray = dataArray;
    [self reloadData];
}

#pragma mark - Private

- (void)setXmhScrollDirection:(UICollectionViewScrollDirection)xmhScrollDirection {
    _xmhScrollDirection = xmhScrollDirection;
    self.collectionViewLayout = [self.class layoutFromScrollDirection:xmhScrollDirection];
    [self reloadData];
}

- (NSMutableArray *)selectModelArray {
    if (_selectModelArray) return _selectModelArray;
    _selectModelArray = NSMutableArray.new;
    return _selectModelArray;
}

#pragma mark - Public

/**
 返回cell 高

 @param type 类型
 @return cell 高
 */
+ (CGFloat)cellHeightType:(XMHMonthAndWeekCollectionViewType)type {
    return type == XMHMonthAndWeekCollectionViewTypeWeek ? 50 : 25;
}

/**
 返回cell 行间距
 */
+ (CGFloat)cellMinimumLineSpacingType:(XMHMonthAndWeekCollectionViewType)type fold:(BOOL)isFold {
    /* 注意
     UICollectionViewScrollDirectionVertical： inimumLine 为行间距，MinimumInteritem 为竖间距
     UICollectionViewScrollDirectionHorizontal: inimumLine 为竖间距 MinimumInteritem 为行间距
     */
    // 展开状态
    if (isFold) {
        // 行间距
        if (type == XMHMonthAndWeekCollectionViewTypeWeek) {
            return 10;
        } else {
            return 20;
        }
    } else {
        // 列间距
        if (type == XMHMonthAndWeekCollectionViewTypeWeek) {
            return 10;
        } else {
            return 50;
        }
    }
    return 0;
}

/**
 返回cell 间间距
 */
+ (CGFloat)cellMinimumInteritemSpacingType:(XMHMonthAndWeekCollectionViewType)type fold:(BOOL)isFold {
    // 展开状态
    if (isFold) {
        // 列间距
        if (type == XMHMonthAndWeekCollectionViewTypeWeek) {
            return 10;
        } else {
            return 50;
        }
    } else {
        // 行间距
        if (type == XMHMonthAndWeekCollectionViewTypeWeek) {
            return 10;
        } else {
            return 20;
        }
    }
    return 0;
}

/**
 每行cell 数量
 */
+ (NSUInteger)lineItemCountType:(XMHMonthAndWeekCollectionViewType)type {
    return 4;
}

+ (UIEdgeInsets)insetForSectionType:(XMHMonthAndWeekCollectionViewType)type {
    if (type == XMHMonthAndWeekCollectionViewTypeWeek) {
        return UIEdgeInsetsMake(0, 15, 0, 15);
    } else {
        return UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return UIEdgeInsetsZero;
}

/**
 通过滑动方向创建layout
 */
+ (UICollectionViewFlowLayout *)layoutFromScrollDirection:(UICollectionViewScrollDirection)xmhScrollDirection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = xmhScrollDirection;
    return layout;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMHMonthAndWeekModel *model = _dataArray[indexPath.item];
    if (_type == XMHMonthAndWeekCollectionViewTypeWeek) {
        XMHCollectionWeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMHCollectionWeekCellIdentifier" forIndexPath:indexPath];
        [cell configModel:model];
        return cell;
    } else {
        XMHCollectionMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XMHCollectionMonthCellIdentifier" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        [cell configModel:model];
        return cell;
    }
    return UICollectionViewCell.new;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat minimumInteritemSpacing = 0;
    if (_isFold) {
        minimumInteritemSpacing = [self.class cellMinimumInteritemSpacingType:_type fold:_isFold];
    } else {
        minimumInteritemSpacing = [self.class cellMinimumLineSpacingType:_type fold:_isFold];
    }
    
    NSInteger lineItemCount = [self.class lineItemCountType:_type];
    UIEdgeInsets sectionEdge = [self.class insetForSectionType:_type];
    if (_type == XMHMonthAndWeekCollectionViewTypeWeek) {
        CGFloat itemW = (collectionView.width - (minimumInteritemSpacing * (lineItemCount - 1)) - (sectionEdge.left + sectionEdge.right)) / lineItemCount;
        return CGSizeMake(itemW, [self.class cellHeightType:_type]);
    } else {
        CGFloat itemW = (collectionView.width - (minimumInteritemSpacing * (lineItemCount - 1)) - (sectionEdge.left + sectionEdge.right)) / lineItemCount;
        return CGSizeMake(itemW, [self.class cellHeightType:_type]); // 78.5 56.25
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return [self.class insetForSectionType:_type];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [self.class cellMinimumLineSpacingType:_type fold:_isFold];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat gap = [self.class cellMinimumInteritemSpacingType:_type fold:_isFold];
    return gap;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 展开方式记录选中按钮位置
    if (_xmhScrollDirection == UICollectionViewScrollDirectionVertical) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        self.lastFrame = cell.frame;
    }
    
    XMHMonthAndWeekModel *model = _dataArray[indexPath.item];
    model.select = !model.select;
    [collectionView reloadData];
    
    if ([self.selectModelArray containsObject:model]) {
        [self.selectModelArray removeObject:model];
    } else {
        if (model.select) [self.selectModelArray addObject:model];
    }
}



@end
