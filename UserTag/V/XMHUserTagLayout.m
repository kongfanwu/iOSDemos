//
//  XMHUserTagLayout.m
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUserTagLayout.h"

@interface XMHUserTagLayout() <UICollectionViewDelegateFlowLayout>
@property (assign, nonatomic) CGFloat currentY;   //当前Y值
@property (assign, nonatomic) CGFloat currentX;   //当前X值
@property (strong, nonatomic) NSMutableArray * attrubutesArray;   //所有元素的布局信息

@property (strong, nonatomic) NSMutableDictionary *cellLayoutInfo;//保存cell的布局
@property (strong, nonatomic) NSMutableDictionary *headLayoutInfo;//保存头视图的布局
@property (strong, nonatomic) NSMutableDictionary *footLayoutInfo;//保存尾视图的布局

@end

@implementation XMHUserTagLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        _headerViewHeight = 0;
        _footViewHeight = 0;
        self.cellLayoutInfo = [NSMutableDictionary dictionary];
        self.headLayoutInfo = [NSMutableDictionary dictionary];
        self.footLayoutInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

//CollectionView会在初次布局时首先调用该方法
//CollectionView会在布局失效后、重新查询布局之前调用此方法
//子类中必须重写该方法并调用超类的方法
-(void)prepareLayout {
    [super prepareLayout];

    //重新布局需要清空
    [self.cellLayoutInfo removeAllObjects];
    [self.headLayoutInfo removeAllObjects];
    [self.footLayoutInfo removeAllObjects];
    
    //初始化首个item位置
    _currentY = 0;
    _currentX = _sectionInsets.left;
    _attrubutesArray = [NSMutableArray array];

    //获取宽度
    CGFloat contentWidth = self.collectionView.frame.size.width - _sectionInsets.left - _sectionInsets.right;
    //取有多少个section
    NSInteger sectionsCount = [self.collectionView numberOfSections];
    id <UICollectionViewDelegateFlowLayout> delegate = (id <UICollectionViewDelegateFlowLayout>) self.collectionView.dataSource;
    
    for (NSInteger section = 0; section < sectionsCount; section++) {
        _currentY += _sectionInsets.top;
        //存储headerView属性
        NSIndexPath *supplementaryViewIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        
        // 1 Header
        CGSize headerSize = CGSizeMake(-1, -1);
        if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
            headerSize = [delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
        }
        
        CGFloat headedrHeight = CGSizeEqualToSize(headerSize, CGSizeMake(-1, -1)) ? _headerViewHeight : headerSize.height;
        //头视图的高度不为0并且根据代理方法能取到对应的头视图的时候，添加对应头视图的布局对象
        if (headedrHeight > 0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) {
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:supplementaryViewIndexPath];
            //设置frame
            attribute.frame = CGRectMake(0, _currentY, self.collectionView.frame.size.width, headedrHeight);
            //保存布局对象
            self.headLayoutInfo[supplementaryViewIndexPath] = attribute;
            //设置下个布局对象的开始Y值
            _currentY = _currentY + headedrHeight + _lineSpace;
        } else {
            _currentY = _currentY + _lineSpace;
        }
        
        // 2 Cells
        NSInteger lineCount = 0; // 记录当前行有几个cell
        CGFloat cellX = _currentX;
        CGFloat cellY = _currentY;
        //计算cell的布局
        //取出section有多少个row
        NSInteger rowsCount = [self.collectionView numberOfItemsInSection:section];
        //分别计算设置每个cell的布局对象
        for (NSInteger row = 0; row < rowsCount; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            //保留cell的布局对象
            self.cellLayoutInfo[indexPath] = attribute;
            //计算item宽
            CGFloat itemW = 0;
            if (_widthComputeBlock) {
                itemW = self.widthComputeBlock(indexPath, _itemHeight);
                //约束宽度最大值
                if (itemW > contentWidth) {
                    itemW = contentWidth;
                }
            } else {
                NSAssert(YES, @"请实现计算宽度的block方法");
            }
            
            //计算item的frame
            CGRect frame;
            frame.size = CGSizeMake(itemW, _itemHeight);
         
//            if ((indexPath.item % 3 == 0 && indexPath.item != 0) || (cellX + itemW) > contentWidth) {
//                cellX = _currentX;
//                cellY += (_itemHeight + _lineSpace);
//            }

            // cell换行条件， 1 一行超过3个cell  2 cell right 超过当前总宽
            if (lineCount == 3 || (cellX + itemW) > contentWidth) {
                lineCount = 0;
                
                cellX = _currentX;
                cellY += (_itemHeight + _lineSpace);
            }
            
            lineCount++;
            
            //设置坐标
            frame.origin = CGPointMake(cellX, cellY);
            attribute.frame = frame;
            
            //偏移当前坐标
            cellX += frame.size.width + _itemSpace;
        }
        
        if (rowsCount > 0) {
            _currentY = cellY + (_itemHeight + _lineSpace);
        }
        
        // 3 Footer
        CGSize footerSize = CGSizeMake(-1, -1);
        if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
            footerSize = [delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:section];
        }
        
        CGFloat footerHeight = CGSizeEqualToSize(footerSize, CGSizeMake(-1, -1)) ? _footViewHeight : footerSize.height;
        //头视图的高度不为0并且根据代理方法能取到对应的头视图的时候，添加对应头视图的布局对象
        if (footerHeight > 0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) {
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:supplementaryViewIndexPath];
            //设置frame
            attribute.frame = CGRectMake(0, _currentY, self.collectionView.frame.size.width, footerHeight);
            //保存布局对象
            self.footLayoutInfo[supplementaryViewIndexPath] = attribute;
            //设置下个布局对象的开始Y值
            _currentY = _currentY + footerHeight + _sectionInsets.bottom;
        } else {
            _currentY = _currentY + _sectionInsets.bottom;
        }
        
    }
}

//子类必须重写此方法。
//并使用它来返回CollectionView视图内容的宽高，
//这个值代表的是所有的内容的宽高，并不是当前可见的部分。
//CollectionView将会使用该值配置内容的大小来促进滚动。
- (CGSize)collectionViewContentSize {
    CGFloat maxY = _currentY;// + _itemHeight + _sectionInsets.bottom;
    return CGSizeMake(self.collectionView.frame.size.width, MAX(maxY, self.collectionView.frame.size.height));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray array];
    
    //添加当前屏幕可见的cell的布局
    [self.cellLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
    //添加当前屏幕可见的头视图的布局
    [self.headLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
    //添加当前屏幕可见的尾部的布局
    [self.footLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
    return allAttributes;
}

//插入cell的时候系统会调用改方法
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = self.cellLayoutInfo[indexPath];
    return attribute;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = nil;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        attribute = self.headLayoutInfo[indexPath];
    }else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]){
        attribute = self.footLayoutInfo[indexPath];
    }
    return attribute;
}

@end
