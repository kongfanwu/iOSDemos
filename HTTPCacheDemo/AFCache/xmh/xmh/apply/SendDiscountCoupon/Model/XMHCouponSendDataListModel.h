//
//  XMHCouponSendDataListModel.h
//  xmh
//
//  Created by ald_ios on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHCouponSendDataModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponSendDataListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHCouponSendDataModel *> *list;
@end
@interface XMHCouponSendDataModel : NSObject
/** 顾客姓名 */
@property (nonatomic, copy)NSString *user_name;
/** 订单号 */
@property (nonatomic, copy)NSString *ordernum;
/** 核销门店 */
@property (nonatomic, copy)NSString *store_name;
/** 使用时间 */
@property (nonatomic, copy)NSString *time;
/** 核销美容师 */
@property (nonatomic, copy)NSString *jis_name;
/** 订单金额 */
@property (nonatomic, copy)NSString *price;
@end
NS_ASSUME_NONNULL_END
