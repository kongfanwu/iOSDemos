//
//  XMHCouponSendCustomerListModel.h
//  xmh
//
//  Created by ald_ios on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHCouponSendCustomerModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponSendCustomerListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHCouponSendCustomerModel *> *list;
@end
@interface XMHCouponSendCustomerModel : NSObject
/** 顾客id */
@property (nonatomic, copy)NSString *user_id;
/** 顾客名称 */
@property (nonatomic, copy)NSString *name;
/** 门店名称 */
@property (nonatomic, copy)NSString *store_name;
/** 顾客等级 */
@property (nonatomic, copy)NSString *grade;
/** 顾客头像 */
@property (nonatomic, copy)NSString *pic;
/** 顾客手机号 */
@property (nonatomic, copy)NSString *mobile;
/** 顾客名称 */
@property (nonatomic, copy)NSString *user_name;
@end
NS_ASSUME_NONNULL_END
