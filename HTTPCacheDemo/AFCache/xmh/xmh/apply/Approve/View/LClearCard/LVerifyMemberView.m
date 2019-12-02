//
//  LVerifyMemberView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LVerifyMemberView.h"
#import "NSString+Check.h"

@interface LVerifyMemberView() <UITextFieldDelegate>

@end

@implementation LVerifyMemberView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    _tfCode.delegate = self;
//    _tfPhoneNum.delegate = self;
//    _btnSendCode.layer.cornerRadius = 3;
//    _btnSendCode.layer.borderWidth = 0.5;
//    _btnSendCode.layer.borderColor = kBtn_Commen_Color.CGColor;
//
//    _btnVerifyCode.layer.cornerRadius = 3;
//    _btnVerifyCode.layer.borderWidth = 0.5;
//    _btnVerifyCode.layer.borderColor = kBtn_Commen_Color.CGColor;
    
    _btnSendCode.selected = NO;
    _btnSendCode.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotificationClick:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFieldTextDidChangeNotificationClick:(NSNotification *)not {
    UITextField *textField = not.object;
    if (textField == _tfPhoneNum) {
        if ([textField.text isMobileNumber]) {
            _btnSendCode.selected = YES;
            _btnSendCode.enabled = YES;
        } else {
            _btnSendCode.selected = NO;
            _btnSendCode.enabled = NO;
        }
    } else if (textField == _tfCode) {
        if (self.inputCodeBlock) self.inputCodeBlock(textField.text.length);
    }
}


@end
