//
//  RefundBottomView.h
//  xmh
//
//  Created by ald_ios on 2018/11/9.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundBottomView : UIView
/** 下一步回调 */
@property (nonatomic, copy) void (^RefundBottomViewNextBlock)();
/** 购物车回调 */
@property (nonatomic, copy) void (^RefundBottomViewGWCBlock)();
- (void)updateRefundBottomViewNum:(NSString *)num;
@end
