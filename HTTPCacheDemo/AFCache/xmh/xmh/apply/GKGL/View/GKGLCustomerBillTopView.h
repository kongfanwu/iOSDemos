//
//  GKGLCustomerBillTopView.h
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKGLCustomerBillTopView : UIView
@property (nonatomic, copy)void (^GKGLCustomerBillTopViewAddBillBlock)();
@property (nonatomic, copy)void (^GKGLCustomerBillTopViewCustomerOrderBlock)();
@end

NS_ASSUME_NONNULL_END
