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
@property (nonatomic, strong) NSArray <XMHMonthAndWeekModel *> *dataArray;
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

- (NSArray<XMHMonthAndWeekModel *> *)dataArray {
    _dataArray = _monthAndWeekView.collectionView.dataArray;
    return _dataArray;
}

- (void)handleScopeGesture:(UIPanGestureRecognizer *)sender {
    [_monthAndWeekView handleScopeGesture:sender];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == _monthAndWeekView && [keyPath isEqualToString:@"isFold"]) {
        BOOL newValue = [change[NSKeyValueChangeNewKey] boolValue];
        _isFold = newValue;
    }
}

@end
