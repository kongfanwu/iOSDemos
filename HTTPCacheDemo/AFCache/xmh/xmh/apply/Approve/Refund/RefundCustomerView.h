//
//  RefundCustomerView.h
//  xmh
//
//  Created by ald_ios on 2018/11/6.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundCustomerView : UIView
/** 获取手机号 */
@property (nonatomic, copy)void (^RefundCustomerViewPhoneBlock)(NSString *code);

@property (nonatomic, copy)void (^RefundCustomerViewCodeBlock)(NSString *code);
/** 回调验证码是否输入内容状态 */
@property (nonatomic, copy)void (^RefundCustomerViewStateBlock)(NSString *text);
/** 获取验证码 */
@property (nonatomic, copy)void (^RefundCustomerViewGetCodeBlock)();

/** <#type#> */
@property (nonatomic, copy) void (^phoneChangeBlock)(NSString *text);
@property (nonatomic, copy) void (^codeChangeBlock)(NSString *text);

/** 设置提示标题 */
- (void)updateRefundCustomerViewNotice:(NSString *)notice;
- (void)updateRefundCustomerViewResignFirstResponder;
/** 更新发送验证码按钮状态 */
- (void)updateRefundCustomerViewCodeBtnState;
//- (void)updateRefundCustomerViewResetCode;
@end
