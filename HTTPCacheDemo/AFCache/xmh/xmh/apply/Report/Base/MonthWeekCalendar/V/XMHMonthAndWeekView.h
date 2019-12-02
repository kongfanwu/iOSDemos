//
//  XMHMonthAndWeekView.h
//  FSCalendarExample
//
//  Created by kfw on 2019/7/1.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHMonthAndWeekCollectionView.h"




NS_ASSUME_NONNULL_BEGIN

@interface XMHMonthAndWeekView : UIView
/** <##> */
@property (nonatomic, strong) XMHMonthAndWeekCollectionView *collectionView;

- (void)handleScopeGesture:(UIPanGestureRecognizer *)sender;
/** 默认 YES:展开状态 NO：收起状态  */
@property (nonatomic) BOOL isFold;
/** <#type#> */
@property (nonatomic, copy) void (^frameDidChangeBlock)(void);

/** default XMHMonthAndWeekCollectionViewTypeWeek */
@property (nonatomic) XMHMonthAndWeekCollectionViewType type;
/**
 设置默认得展开、收起 isFold YES 收起 NO 展开
 */
- (void)configDefaultIsFold:(BOOL)isFold;

/**
 设置默认选中日期位置frame. 并显示到当前位置
 */
- (void)setDefaultSelectCellOffset;
@end

NS_ASSUME_NONNULL_END
