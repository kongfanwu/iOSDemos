//
//  XMHMonthAndWeekBgView.m
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/3.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "XMHMonthAndWeekBgView.h"
#import "XMHMonthAndWeekCollectionView.h"
#import "XMHMonthAndWeekView.h"

// 日期导航高
CGFloat kDateBarHeight = 50.f;

@interface XMHMonthAndWeekBgView()
@property (nonatomic, strong) XMHMonthAndWeekCollectionView *collectionView;
@property (nonatomic, strong) XMHDateNavBarView *dateNavBarView;
/** XMHMonthAndWeekView */
@property (nonatomic, strong) XMHMonthAndWeekView *monthAndWeekView;
/** 选中的日期，日期无序 */
@property (nonatomic, strong) NSArray <XMHMonthAndWeekModel *> *selectModelArray;
@end

@implementation XMHMonthAndWeekBgView

- (void)dealloc
{
    [_monthAndWeekView removeObserver:self forKeyPath:@"isFold"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dateNavBarView = [[XMHDateNavBarView alloc] initWithFrame:CGRectMake(0, 0, self.width, kDateBarHeight)];
        [self addSubview:_dateNavBarView];
        
        self.monthAndWeekView = [[XMHMonthAndWeekView alloc] initWithFrame:CGRectMake(0, kDateBarHeight, self.width, self.height - kDateBarHeight)];
        _monthAndWeekView.type = _type;
        [self addSubview:_monthAndWeekView];
        
        self.collectionView = _monthAndWeekView.collectionView;
        
        __weak typeof(self) _self = self;
        [self.collectionView setDidSelectItemAtIndexPathBlock:^(XMHMonthAndWeekModel * _Nonnull model) {
            __strong typeof(_self) self = _self;
            if (self.didSelectItemAtIndexPathBlock) self.didSelectItemAtIndexPathBlock(model);
        }];

        [_monthAndWeekView setFrameDidChangeBlock:^{
            __strong typeof(_self) self = _self;
            self.height = kDateBarHeight + self.monthAndWeekView.height;
          
            self.monthAndWeekView.frame = CGRectMake(0, kDateBarHeight, self.width, self.height - kDateBarHeight);
            
            if (self.frameDidChangeBlock) self.frameDidChangeBlock();
        }];
        
        [_monthAndWeekView addObserver:self forKeyPath:@"isFold" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)setType:(XMHMonthAndWeekCollectionViewType)type {
    _type = type;
    _monthAndWeekView.type = _type;
}

- (void)setIsFold:(BOOL)isFold {
    _isFold = isFold;
    _monthAndWeekView.isFold = _isFold;
}

- (NSArray<XMHMonthAndWeekModel *> *)selectModelArray {
    _selectModelArray = _monthAndWeekView.collectionView.selectModelArray;
    return _selectModelArray;
}

- (void)handleScopeGesture:(UIPanGestureRecognizer *)sender {
    [_monthAndWeekView handleScopeGesture:sender];
}

/**
 设置默认得展开、收起 isFold YES 收起 NO 展开
 */
- (void)configDefaultIsFold:(BOOL)isFold {
    [_monthAndWeekView configDefaultIsFold:YES];
}

/**
 设置默认选中日期位置frame. 并显示到当前位置
 */
- (void)setDefaultSelectCellOffset {
    [_monthAndWeekView setDefaultSelectCellOffset];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == _monthAndWeekView && [keyPath isEqualToString:@"isFold"]) {
        BOOL newValue = [change[NSKeyValueChangeNewKey] boolValue];
        _isFold = newValue;
    }
}

@end
