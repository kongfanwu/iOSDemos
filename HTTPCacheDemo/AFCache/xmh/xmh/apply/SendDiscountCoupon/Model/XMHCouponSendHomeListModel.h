//
//  XMHCouponSendHomeListModel.h
//  xmh
//
//  Created by ald_ios on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XMHCouponSendHomeModel;
@interface XMHCouponSendHomeListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHCouponSendHomeModel *> *list;
@end
@interface XMHCouponSendHomeModel : NSObject
/** 活动id */
@property (nonatomic, copy)NSString *activityid;
/** 商家编码 */
@property (nonatomic, copy)NSString *join_code;
/** 添加时间 */
@property (nonatomic, copy)NSString *insert_time;
/** 发放人数 */
@property (nonatomic, copy)NSString *xf_user;
/** 发放张数 */
@property (nonatomic, copy)NSString *xf_ticket;
/** 发起人 */
@property (nonatomic, copy)NSString *inper;
/** 使用人数 */
@property (nonatomic, copy)NSString *use_user;
/** 使用张数 */
@property (nonatomic, copy)NSString *use_ticket;
/** 活动总收款 */
@property (nonatomic, copy)NSString *use_price;
@end
NS_ASSUME_NONNULL_END
