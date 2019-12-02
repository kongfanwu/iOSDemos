//
//  LVerifyMemberView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 233

#import <UIKit/UIKit.h>

@interface LVerifyMemberView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
@property (weak, nonatomic) IBOutlet UIButton *btnSendCode;
@property (weak, nonatomic) IBOutlet UIButton *btnVerifyCode;

/** <#type#> */
@property (nonatomic, copy) void (^inputCodeBlock)(BOOL isInput);

@end
