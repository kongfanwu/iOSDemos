//
//  XMHACDataTopView.h
//  xmh
//
//  Created by ald_ios on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHCouponSendDataHeaderModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHACDataTopView : UIView
- (void)updateViewModel:(XMHCouponSendDataHeaderModel *)model;
@end

NS_ASSUME_NONNULL_END
