//
//  XMHServiceOrderCell.h
//  xmh
//
//  Created by KFW on 2019/3/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHNumberView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceOrderCell : UITableViewCell
/** 改变数量回调 */
@property (nonatomic, copy) void (^didChangeBlock)(XMHNumberView *numberView);

/** 点击购物车回调 */
@property (nonatomic, copy) void (^didAddToShopCartBlock)();
@end

NS_ASSUME_NONNULL_END
