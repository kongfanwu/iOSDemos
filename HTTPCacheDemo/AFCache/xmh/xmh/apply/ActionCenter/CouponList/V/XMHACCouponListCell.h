//
//  XMHACCouponListCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHCouponListStateItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHACCouponListCell : UITableViewCell

@property (nonatomic, copy) void (^didSelectClickBlock)(XMHACCouponListCell *cell, XMHCouponListStateItemModel *couponListStateItemModel);

// 更新布局
- (void)updataMarkLine;

- (void)resetMarkLine;
@end

NS_ASSUME_NONNULL_END
