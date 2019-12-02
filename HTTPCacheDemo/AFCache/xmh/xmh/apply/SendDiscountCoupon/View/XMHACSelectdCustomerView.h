//
//  XMHACSelectdCustomerView.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHACSelectdCustomerView : UIView
/** 已选顾客点击回调 */
@property (nonatomic, copy) void (^selectdCustomerViewBlock)(NSMutableArray * modelArr);
/** 添加顾客点击回调 */
@property (nonatomic, copy) void (^addCustomerViewBlock)();
- (void)updateView:(NSMutableArray *)modelArr;
@end

NS_ASSUME_NONNULL_END
