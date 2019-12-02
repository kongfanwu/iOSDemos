//
//  ABSegmentTitleView.h
//  AddressBookListDemo
//
//  Created by ducaiyan on 22/5/18.
//  Copyright © 2018年 ducaiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ABSegmentTitleView;

@protocol ABSegmentTitleViewDelegate <NSObject>

@optional

/**
 切换标题

 @param titleView ABSegmentTitleView
 @param startIndex 切换前标题索引
 @param endIndex 切换后标题索引
 */
- (void)ABSegmentTitleView:(ABSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

@end

@interface ABSegmentTitleView : UIView

@property (nonatomic, weak) id<ABSegmentTitleViewDelegate>delegate;

/**
 标题文字间距，默认0
 */
@property (nonatomic, assign) CGFloat itemMargin;

/**
 当前选中标题索引，默认0
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 标题字体大小，默认14
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 标题正常颜色，默认black
 */
@property (nonatomic, strong) UIColor *titleNormalColor;

/**
 标题选中颜色，默认red
 */
@property (nonatomic, strong) UIColor *titleSelectColor;

/**
 指示器颜色，默认与titleSelectColor一样
 */
@property (nonatomic, strong) UIColor *indicatorColor;

/**
 标题数组
 */
@property (nonatomic, strong) NSArray *titlesArr;

/**
 数量数组
 */
@property (nonatomic, strong) NSArray *bagesArr;
/**
 对象方法创建FSSegmentTitleView
 
 @param frame frame
 @param titlesArr 标题数组
 @param delegate delegate
 @return ABSegmentTitleView
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArr delegate:(id<ABSegmentTitleViewDelegate>)delegate;

@end
