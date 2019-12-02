//
//  RefundCustomerInfoView.h
//  xmh
//
//  Created by ald_ios on 2018/11/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RefundInfoModel;
@interface RefundCustomerInfoView : UIView
@property (nonatomic, copy)void (^RefundCustomerInfoViewBlock)(BOOL isAll);
- (void)updateRefundCustomerInfoViewModel:(RefundInfoModel*)model;
- (void)updateRefundCustomerInfoViewSwitchState:(BOOL)off;
@end
