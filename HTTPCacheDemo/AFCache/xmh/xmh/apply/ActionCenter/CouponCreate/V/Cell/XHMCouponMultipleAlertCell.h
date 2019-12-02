//
//  XHMCouponMultipleAlertCell.h
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XHMCouponMultipleAlertCell : UICollectionViewCell
/** default YES */
@property (nonatomic) BOOL edit;
- (void)configureWithModel:(XMHItemModel *)model;

@end

NS_ASSUME_NONNULL_END
