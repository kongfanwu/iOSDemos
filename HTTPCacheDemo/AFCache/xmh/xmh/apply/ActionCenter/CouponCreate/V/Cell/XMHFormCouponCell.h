//
//  XMHFormCouponCell.h
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormBaseCell.h"
@class XMHItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormCouponCell : XMHFormBaseCell
/** <#type#> */
@property (nonatomic, copy) void (^didSelectBlock)(XMHFormCouponCell *cell, XMHItemModel *itemMdoel);
@end

NS_ASSUME_NONNULL_END
