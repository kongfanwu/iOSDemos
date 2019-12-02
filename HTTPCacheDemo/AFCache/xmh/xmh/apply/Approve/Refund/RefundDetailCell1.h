//
//  RefundDetailCell1.h
//  xmh
//
//  Created by ald_ios on 2018/11/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RefundModel;
@interface RefundDetailCell1 : UITableViewCell
@property (nonatomic, copy)void (^RefundDetailCell1Block)(RefundModel *model);
- (void)updateRefundDetailCell1Model:(RefundModel *)model;
@end
