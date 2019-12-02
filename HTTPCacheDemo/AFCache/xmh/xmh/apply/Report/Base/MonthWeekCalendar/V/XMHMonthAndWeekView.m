//
//  XMHMonthAndWeekView.m
//  FSCalendarExample
//
//  Created by kfw on 2019/7/1.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "XMHMonthAndWeekView.h"
#import "XMHCollectionWeekCell.h"
#import "XMHMonthAndWeekModel.h"

@interface XMHMonthAndWeekView()
/** self 高 */
@property (nonatomic) CGFloat originHeight;
/** cell 高 */
@property (nonatomic) CGFloat cellMinHeight;
/** cell 行间距 */
@property (nonatomic) CGFloat cellMinimumLineSpacing;
/** cell 间间距 */
@property (nonatomic) CGFloat cellMinimumInteritemSpacing;
/** collectionView 每行cell数量 */
@property (nonatomic) NSUInteger lineItemCount;
/** 开始滑动偏移量 */
@property(nonatomic) CGPoint beginContentOffset;
/** 获取可见屏幕最小Y */
@property (nonatomic) CGFloat beginVisibleY;
@end

@implementation XMHMonthAndWeekView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.isFold = YES;
        _type = XMHMonthAndWeekCollectionViewTypeWeek;
        self.originHeight = self.height;
        
        UICollectionViewScrollDirection direction = UICollectionViewScrollDirectionVertical;
        UICollectionViewFlowLayout *layout = [XMHMonthAndWeekCollectionView layoutFromScrollDirection:direction];
        self.collectionView = [[XMHMonthAndWeekCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.originHeight) collectionViewLayout:layout];
        _collectionView.isFold = _isFold;
        _collectionView.xmhScrollDirection = direction;
        [self addSubview:_collectionView];
        
        [self configIvars];
        
        [_collectionView reloadData];
    }
    return self;
}

- (void)configIvars {
    _cellMinHeight = [XMHMonthAndWeekCollectionView cellHeightType:_collectionView.type];
    _cellMinimumLineSpacing = [XMHMonthAndWeekCollectionView cellMinimumLineSpacingType:_collectionView.type fold:_isFold];
    _cellMinimumInteritemSpacing = [XMHMonthAndWeekCollectionView cellMinimumInteritemSpacingType:_collectionView.type fold:_isFold];
    _lineItemCount = [XMHMonthAndWeekCollectionView lineItemCountType:_collectionView.type];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)setType:(XMHMonthAndWeekCollectionViewType)type {
    _type = type;
    _collectionView.type = _type;
    [self configIvars];
}

- (void)setIsFold:(BOOL)isFold {
    _isFold = isFold;
    _collectionView.isFold = _isFold;
}

#pragma mark - Public

/**
 设置默认选中日期位置frame. 并显示到当前位置
 */
- (void)setDefaultSelectCellOffset {
    // 设置偏移量到默认日期位置
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        XMHMonthAndWeekModel *model = [_collectionView getOnlySelectModelDataArray];
        UICollectionViewCell *cell = _collectionView.visibleCells.firstObject;
        
        //        NSInteger cellCount = 0;
        //        if (model.currentNum > _lineItemCount) {
        //            cellCount = model.currentNum - _lineItemCount;
        //        } else {
        //            cellCount = model.currentNum;
        //        }
        //        CGFloat offsetX = ((cell.frame.size.width + _cellMinimumInteritemSpacing) * cellCount);
        //        [_collectionView setContentOffset:CGPointMake(offsetX, _collectionView.contentOffset.y)];
        
        // 计算默认日期cell frame
        CGFloat cellW = cell.frame.size.width + _cellMinimumInteritemSpacing;
        CGFloat cellH = cell.frame.size.height + _cellMinimumLineSpacing;
        
        NSInteger lineCount = floorf((model.currentNum - 1) / _lineItemCount);
        NSInteger lineUpCellCount = (model.currentNum % 4);
        if (lineUpCellCount == 0) {
            lineUpCellCount = _lineItemCount - 1;
        } else {
            lineUpCellCount -= 1;
        }
        
        CGFloat x = cellW * lineUpCellCount;
        CGFloat y = cellH * lineCount;
        _collectionView.lastFrame = CGRectMake(x, y, cell.frame.size.width, cell.frame.size.height);
        // 收起状态 设置偏移量
        if (!_isFold) {
            // 收起状态，便宜到默认日期位置
            [self foldStateSelectCellPositionAlign];
        }
    });
}

/**
 设置默认得展开、收起 isFold YES 收起 NO 展开
 */
- (void)configDefaultIsFold:(BOOL)isFold {
    self.isFold = isFold;
    
    // 重新获取布局属性
    [self configIvars];
    
    // 切换展开收起状态
    [self scopeTransitionDidEnd:nil];
    
    [self setDefaultSelectCellOffset];
}

- (void)handleScopeGesture:(UIPanGestureRecognizer *)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            [self scopeTransitionDidBegan:sender];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self scopeTransitionDidUpdate:sender];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:{
            [self scopeTransitionDidEnd:sender];
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - Private

- (void)scopeTransitionDidBegan:(UIPanGestureRecognizer *)sender {
    // 展开
    if (self.isFold) {
        // 获取可见屏幕最小Y
        CGFloat beginVisibleYVar = MAXFLOAT;
        for (int i = 0; i < self.collectionView.visibleCells.count; i++) {
            XMHCollectionWeekCell *cell = self.collectionView.visibleCells[i];
            CGFloat tmp = CGRectGetMinY(cell.frame);
            if (tmp < beginVisibleYVar) {
                beginVisibleYVar = tmp;
            }
        }
        self.beginVisibleY = beginVisibleYVar;
    }
    // 记录开始滑动时，之前的偏移量
    self.beginContentOffset = _collectionView.contentOffset;
//    self.beginVisibleY = CGRectGetMinY(((UIView *)self.collectionView.visibleCells.firstObject).frame);
    // 收起状态
    if (!self.isFold) {
        _collectionView.isFold = YES;// 提前通知布局方式
        // 展开布局
        _collectionView.xmhScrollDirection = UICollectionViewScrollDirectionVertical;
    }
}

- (void)scopeTransitionDidUpdate:(UIPanGestureRecognizer *)sender {
    CGFloat translation = ABS([sender translationInView:sender.view].y);
    // 收起
    if (self.isFold) {
        if (self.height > _cellMinHeight) {
            self.height = _originHeight  - translation;
            [self foldCollectionViewTranslation:translation];
        }
        // 最小区域限制
        if (self.height <= _cellMinHeight) {
            self.height = _cellMinHeight;
        }
    }
    // 展开
    else {
        if (self.height < _originHeight) {
            self.height = _cellMinHeight + translation;
            [self noFoldCollectionViewTranslation:translation];
        }
        // 最大区域限制
        if (self.height >= _originHeight) {
            self.height = _originHeight;
        }
    }
    
    if (self.frameDidChangeBlock) self.frameDidChangeBlock();
}

- (void)scopeTransitionDidEnd:(UIPanGestureRecognizer *)sender {
    // 展开状态
    if (self.isFold) {
        // 收起
        self.height = _cellMinHeight;
        [self foldCollectionViewTranslation:_originHeight - _cellMinHeight];
        self.isFold = NO;
        
        if (self.frameDidChangeBlock) self.frameDidChangeBlock();
        
        _collectionView.xmhScrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // 在collectionView 刷新完后设置偏移量
        [self performSelector:@selector(foldStateSelectCellPositionAlign) withObject:nil afterDelay:0.01];
    }
    // 收起状态
    else {
        // 展开
        self.height = _originHeight;
        [self noFoldCollectionViewTranslation:_originHeight - (_cellMinHeight)];
        self.isFold = YES;
    
        if (self.frameDidChangeBlock) self.frameDidChangeBlock();
        
        // 收拾begin时候，可能已经设置了 UICollectionViewScrollDirectionVertical
        if (_collectionView.xmhScrollDirection != _collectionView.xmhScrollDirection) {
            _collectionView.xmhScrollDirection = UICollectionViewScrollDirectionVertical;
        }
    }
}

/**
 收起，处理CollectionView 滑动效果
 */
- (void)foldCollectionViewTranslation:(CGFloat)translation {
//    CGFloat contentSizeHeith = _collectionView.contentSize.height;
    CGFloat upOffsetYGap = CGRectGetMinY(_collectionView.lastFrame);
//    CGFloat bottomOffsetYGap = CGRectGetMaxY(_collectionView.lastFrame);

    // 一屏够用
    // 滑动百分比 = 根据点击cell y / 手势滑动总高度
    CGFloat baiFenBi = upOffsetYGap / (_originHeight - _cellMinHeight);
    // _collectionView偏移量 = 手势偏移量 * 百分比
    CGFloat upOffsetY = baiFenBi * translation;
    
    // 如果开始滑动时存在偏移量
    if (_beginContentOffset.y > 0) {
        // 开始滑动时偏移量百分比 = 开始滑动时偏移量 / 手势滑动总高度
        CGFloat baiFenBi2 = _beginContentOffset.y / (_originHeight - _cellMinHeight);
        // _collectionView偏移量 - _collectionView开始滑动时偏移量。逐渐抵消掉开始滑动时存在偏移量
        upOffsetY = upOffsetY - (baiFenBi2 * translation);
    }
    
//    NSLog(@"translation:%f upOffsetY:%lf baiFenBi:%lf", translation, upOffsetY, baiFenBi);
    [_collectionView setContentOffset:CGPointMake(_collectionView.contentOffset.x, _beginContentOffset.y + upOffsetY) animated:NO];
}

/**
 展开，处理CollectionView 滑动效果
 */
- (void)noFoldCollectionViewTranslation:(CGFloat)translation {
//    CGFloat contentSizeHeith = _collectionView.contentSize.height;
    CGFloat upOffsetYGap = CGRectGetMinY(_collectionView.lastFrame);
//    CGFloat bottomOffsetYGap = CGRectGetMaxY(_collectionView.lastFrame);
    
    CGFloat jiPingHeight = upOffsetYGap - (upOffsetYGap - _beginVisibleY);
    // 目标位置在第几屏高
//    NSInteger jiPing = floor(upOffsetYGap / (_originHeight));
//    CGFloat jiPingHeight = jiPing * (_originHeight);
    
    // 计算需要滑动的距离 = upOffsetYGap - 目标位置在第几屏高（屏高是 _originHeight），之前的屏高。例如在第5屏，之前的屏高就是 （4 * _originHeight）
    CGFloat computeScrollGap = upOffsetYGap - jiPingHeight;
    CGFloat baiFenBi = computeScrollGap / (_originHeight - _cellMinHeight);
    // 180 - translation(10) * 0.72
    CGFloat upOffsetY = upOffsetYGap - (baiFenBi * translation);
//    NSLog(@"translation:%f upOffsetY:%lf baiFenBi:%lf", translation, upOffsetY, baiFenBi);

    // 开始滑动可能为负数
    if (upOffsetY >= upOffsetYGap) {
        return;
    }
    [_collectionView setContentOffset:CGPointMake(_collectionView.contentOffset.x, upOffsetY) animated:NO];
}

/**
 展开状态选中的按钮，对齐到收起状态相应的按钮位置
 */
- (void)foldStateSelectCellPositionAlign {
    // 收起后、collectionView 为 UICollectionViewScrollDirectionHorizontal 后。将展开状态选中的按钮 X 位置,映射到收起状态相同的 X 位置.
    // 选中按钮之前有几行
    NSInteger lineCount = _collectionView.lastFrame.origin.y / (_cellMinHeight + _cellMinimumLineSpacing);
    // 便宜X位置 = 每个按钮宽 * 每行有几个按钮 * 几行.  只需要计算选中按钮之前有几行的偏移量即可。
    CGFloat offsetX = ((_collectionView.lastFrame.size.width + _cellMinimumInteritemSpacing) * _lineItemCount) * lineCount;
//    if (_type == XMHMonthAndWeekCollectionViewTypeMonth && lineCount > 0) {
//        // 与item间间距，与边缘，不同。
//        offsetX -= _cellMinimumInteritemSpacing;
//    }
    NSLog(@"foldStateSelectCellPositionAlign:%lf", offsetX);
    [_collectionView setContentOffset:CGPointMake(offsetX, _collectionView.contentOffset.y)];
}

@end
