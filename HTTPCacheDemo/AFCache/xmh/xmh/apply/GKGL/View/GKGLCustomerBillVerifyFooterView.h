//
//  GKGLCustomerBillVerifyFooterView.h
//  xmh
//
//  Created by ald_ios on 2019/1/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKGLCustomerBillVerifyFooterView : UIView
@property (nonatomic, copy)void (^GKGLCustomerBillVerifyFooterViewBlock)(NSMutableArray *param);
- (void)updateGKGLCustomerBillVerifyFooterViewParam:(NSDictionary *)param;
@end

NS_ASSUME_NONNULL_END
