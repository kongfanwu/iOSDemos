//
//  GKGLDiscountCouponSubVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/16.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKGLDiscountCouponSubVC : UIViewController
@property (nonatomic, assign)NSInteger tag;
@property (nonatomic, copy)NSString * userid;
@property (nonatomic, copy)void (^GKGLDiscountCouponSubVCBlock)(NSString * count);
@end

NS_ASSUME_NONNULL_END
