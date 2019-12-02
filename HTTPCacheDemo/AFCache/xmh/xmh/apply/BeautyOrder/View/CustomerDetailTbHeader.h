//
//  CustomerDetailTbHeader.h
//  xmh
//
//  Created by ald_ios on 2018/11/1.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomerMessageModel;
@interface CustomerDetailTbHeader : UIView
- (void)updateCustomerDetailTbHeaderModel:(CustomerMessageModel *)model;
- (void)updateCustomerDetailTbHeaderParam:(NSMutableDictionary *)param;
@end
