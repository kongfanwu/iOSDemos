//
//  XMHMonthAndWeekBgView.h
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/3.
//  Copyright © 2019 kfw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHMonthAndWeekView.h"
#import "XMHDateNavBarView.h"

// 日期导航高
extern CGFloat kDateBarHeight;

NS_ASSUME_NONNULL_BEGIN

@interface XMHMonthAndWeekBgView : UIView
/** <##> */
@property (nonatomic, strong, readonly) XMHMonthAndWeekCollectionView *collectionView;
/** <##> */
@property (nonatomic, strong, readonly) XMHDateNavBarView *dateNavBarView;
- (void)handleScopeGesture:(UIPanGestureRecognizer *)sender;
/** 默认 YES:展开状态 NO：收起状态  */
@property (nonatomic) BOOL isFold;
/** <#type#> */
@property (nonatomic, copy) void (^frameDidChangeBlock)(void);

/** default XMHMonthAndWeekCollectionViewTypeWeek */
@property (nonatomic) XMHMonthAndWeekCollectionViewType type;

/** 选中的日期，日期无序 */
@property (nonatomic, strong, readonly) NSArray <XMHMonthAndWeekModel *> *dataArray;
@end

NS_ASSUME_NONNULL_END
