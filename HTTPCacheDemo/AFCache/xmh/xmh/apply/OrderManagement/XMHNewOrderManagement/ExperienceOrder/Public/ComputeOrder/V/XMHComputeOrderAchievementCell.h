//
//  XMHComputeOrderAchievementCell.h
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHComputeOrderAchievementCell : UITableViewCell
/** 归属回调 tag 1 业绩 2 门店 3 店长*/
@property (nonatomic, copy) void (^shuiShuBlock)(NSInteger tag);
/** 创建订单类型 默认 XMHCreateOrderTypeExperience */
@property (nonatomic) XMHCreateOrderType createOrderType;
@end

NS_ASSUME_NONNULL_END
