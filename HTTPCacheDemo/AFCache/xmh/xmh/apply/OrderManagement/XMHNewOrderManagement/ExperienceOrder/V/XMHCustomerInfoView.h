//
//  XMHCustomerInfoView.h
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 顾客详情信息

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHCustomerInfoView : UIView

/** <#type#> */
@property (nonatomic, copy) void (^searchBlock)(XMHCustomerInfoView *customerInfoView);
/** <#type#> */
@property (nonatomic, copy) void (^deleteUserBlock)(XMHCustomerInfoView *customerInfoView);

/**
 配置用户信息
 
 @param userName 用户名+手机号
 */
- (void)configUserName:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END
