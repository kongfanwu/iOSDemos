//
//  RefundDetailCell2.h
//  xmh
//
//  Created by ald_ios on 2018/11/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RefundPerformanceModel;
@interface RefundDetailCell2 : UITableViewCell
/** 输入框回调 */
@property (nonatomic, copy)void (^RefundDetailCell2InputBlock)(RefundPerformanceModel *refundPerformanceModel);
/** 加号按钮点击回调 */
@property (nonatomic, copy)void (^RefundDetailCell2AddBlock)(RefundPerformanceModel *refundPerformanceModel);
/** 减号按钮点击回调 */
@property (nonatomic, copy)void (^RefundDetailCell2MinusBlock)(RefundPerformanceModel *refundPerformanceModel);
 /** 右箭头点击回调 */
@property (nonatomic, copy)void (^RefundDetailCell2SelectBlock)(RefundPerformanceModel *refundPerformanceModel);
- (void)updateRefundDetailCell2Model:(RefundPerformanceModel *)model;
@end
