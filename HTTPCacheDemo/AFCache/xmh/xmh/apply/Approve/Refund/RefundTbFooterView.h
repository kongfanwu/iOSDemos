//
//  RefundTbFooterView.h
//  xmh
//
//  Created by ald_ios on 2018/11/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RefundInfoModel,ApprovalInfo;
@interface RefundTbFooterView : UIView
@property (nonatomic, copy)void (^RefundTbFooterViewInputBlock)(NSString * input);
@property (nonatomic, copy)void (^RefundTbFooterViewApprovalTapBlock)();
- (void)updateRefundTbFooterViewModel:(RefundInfoModel *)model;
- (void)updateRefundTbFooterViewApprovalInfoModel:(ApprovalInfo *)model;
@end
