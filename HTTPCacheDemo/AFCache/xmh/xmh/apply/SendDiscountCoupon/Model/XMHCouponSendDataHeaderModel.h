//
//  XMHCouponSendDataHeaderModel.h
//  xmh
//
//  Created by ald_ios on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponSendDataHeaderModel : NSObject
/** 保有顾客 */
@property (nonatomic, copy)NSString *bygk;
/** 休眠顾客 */
@property (nonatomic, copy)NSString *xmgk;
/** 流失顾客 */
@property (nonatomic, copy)NSString *lsgk;
/** 新增顾客 */
@property (nonatomic, copy)NSString *xzgk;
@end

NS_ASSUME_NONNULL_END
