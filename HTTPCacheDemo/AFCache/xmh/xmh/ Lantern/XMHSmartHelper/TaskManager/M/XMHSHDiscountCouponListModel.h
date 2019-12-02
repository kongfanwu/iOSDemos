//
//  XMHSHDiscountCouponListModel.h
//  xmh
//
//  Created by ald_ios on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHSHDiscountCouponModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSHDiscountCouponListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHSHDiscountCouponModel *> *list;
@end
@interface XMHSHDiscountCouponModel : NSObject
@property (nonatomic, copy)NSString *coupon_id;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *startTime;
@property (nonatomic, copy)NSString *endTime;
@property (nonatomic, copy)NSString *join_name;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, copy)NSString *discount;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *fulfill;
@property (nonatomic, copy)NSString *jh_zt;
@property (nonatomic, assign)BOOL selected;
- (NSString *)typeName;
@end
NS_ASSUME_NONNULL_END
