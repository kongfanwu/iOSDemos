//
//  XMHSelectDateView.h
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 销售选择时间 top view

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHSelectDateView : UIView

@property (nonatomic, copy) void (^selectDateBlock)(XMHSelectDateView *selectDateView);
/** <#type#> */
@property (nonatomic, copy) void (^dateBlock)(XMHSelectDateView *selectDateView, NSString *startDate, NSString *endDate);
/** 选中的button */
@property (nonatomic, strong) UIButton *selectButton;
@end

NS_ASSUME_NONNULL_END
