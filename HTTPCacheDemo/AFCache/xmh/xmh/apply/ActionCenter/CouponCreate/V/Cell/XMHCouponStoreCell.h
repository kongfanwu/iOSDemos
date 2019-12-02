//
//  XMHCouponStoreCell.h
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHServiceGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponStoreCell : UITableViewCell
/** default YES */
@property (nonatomic) BOOL edit;
/** <##> */
@property (nonatomic, strong) UIButton *titleButton;
- (void)configureWithModel2:(XMHServiceGoodsModel *)model;

@end

NS_ASSUME_NONNULL_END
