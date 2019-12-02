//
//  XMHCouponSendErrorListModel.h
//  xmh
//
//  Created by ald_ios on 2019/5/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XMHCouponSendErrorModel;
@interface XMHCouponSendErrorListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHCouponSendErrorModel *> *list;
@end
@interface XMHCouponSendErrorModel : NSObject
/** 优惠券id */
@property (nonatomic, copy)NSString *uid;
/** 优惠券名称 */
@property (nonatomic, copy)NSString *name;
/** 剩余库存 */
@property (nonatomic, copy)NSString *remain_num;
/** 最低补充 */
@property (nonatomic, copy)NSString *supply_num;
@end
NS_ASSUME_NONNULL_END
