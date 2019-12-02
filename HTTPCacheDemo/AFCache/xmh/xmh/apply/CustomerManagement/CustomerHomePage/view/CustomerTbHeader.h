//
//  CustomerTbHeader.h
//  xmh
//
//  Created by ald_ios on 2018/10/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//  无标题4个数据 高度 160   8个数据 260
//  有标题4个数据 高度 200   8个数据 200

#import <UIKit/UIKit.h>

@interface CustomerTbHeader : UIView
/** 标题切换Block */
@property (nonatomic, copy) void (^CustomerTbHeaderTitleBlock)(NSInteger index);

/** 八筒数据点击 */
@property (nonatomic, copy) void (^CustomerTbHeaderContentBlock)(NSInteger index,NSString *name);

/** 更多按钮点击 */
@property (nonatomic, copy) void (^CustomerTbHeaderMoreBlock)(BOOL isSelect);

/**
 *更新头部数据
 *@param modelArr model数组
 */
- (void)updateCustomerTbHeaderModel:(NSArray *)modelArr;

/**
 *更新头部标题
 *@param titleArr 标题数组
 */
- (void)updateCustomerTbHeaderTitle:(NSArray *)titleArr;

/**
 *取消选中状态

 @param canSelect 是否可选
 */
- (void)updateCustomerSelectStateCanSelect:(BOOL)canSelect ;

/**
 *判断哪个模块Customer点击效果形式

 @param module 模块缩写
 */
- (void)updateCustomerModule:(NSString *)module;
/** 切换是否展开状态 */
- (void)updateCustomerTbHeaderStates;

@end

