//
//  XMHNumberView.h
//  xmh
//
//  Created by KFW on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 数字切换View

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHNumberView : UIView
/** 最大值 默认 NSIntegerMax */
@property (nonatomic) NSInteger maxNumber;
/** 最小值 默认 1 */
@property (nonatomic) NSInteger minNumber;
/** 改变数量回调 */
@property (nonatomic, copy) void (^didChangeBlock)(XMHNumberView *numberView);
/** 改变数量-加按钮回调 */
@property (nonatomic, copy) void (^addChangeBlock)(XMHNumberView *numberView);
/** 改变数量-减按钮回调 */
@property (nonatomic, copy) void (^delectChangeBlock)(XMHNumberView *numberView);
/** 当前数值 */
@property (nonatomic) NSInteger currentNumber;
@end

NS_ASSUME_NONNULL_END
