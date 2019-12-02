//
//  RefundCustomerView.m
//  xmh
//
//  Created by ald_ios on 2018/11/6.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundCustomerView.h"
#import "NSString+Check.h"
@interface RefundCustomerView ()<UITextFieldDelegate>
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *lbNotice;
/** 手机号输入框 */
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
/** 验证码输入框 */
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
/** 获取验证码按钮 */
@property (weak, nonatomic) IBOutlet UIButton *btnVerify;

@end
@implementation RefundCustomerView
{
    BOOL _isTapCode;
    dispatch_source_t _ktimer;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _tfPhone.delegate = self;
    _tfCode.delegate = self;
    [_btnVerify addTarget:self action:@selector(verifyCode) forControlEvents:UIControlEventTouchUpInside];
    [_tfCode addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [_tfPhone addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    _tfPhone.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _tfPhone.leftViewMode = UITextFieldViewModeAlways;
    
    _tfCode.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _tfCode.leftViewMode = UITextFieldViewModeAlways;
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)updateRefundCustomerViewNotice:(NSString *)notice
{
    _lbNotice.text = notice;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:_tfPhone]&& _tfPhone.text && _tfPhone.text.length > 0) {
        //tangyf begin 2018-11-29
        if (_RefundCustomerViewPhoneBlock) {
            _RefundCustomerViewPhoneBlock(_tfPhone.text);
        }//tangyf end
         [_btnVerify setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    }
    if ([textField isEqual:_tfCode]&& _tfCode.text && _tfCode.text.length > 0) {
        if (_RefundCustomerViewCodeBlock) {
            _RefundCustomerViewCodeBlock(textField.text);
        }
    }
}
/** 验证码输入事件回调外界状态 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:_tfCode]) {
        if (_RefundCustomerViewStateBlock) {
            _RefundCustomerViewStateBlock(@"1");
        }
    }
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if ([textField isEqual:_tfCode]) {
//        if (_RefundCustomerViewStateBlock) {
//            _RefundCustomerViewStateBlock(textField.text);
//        }
//    }
//    return YES;
//}

-(void)textFieldTextChange:(UITextField *)textField{
//    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    if ([textField isEqual:_tfCode]) {
        if (_RefundCustomerViewStateBlock) {
            _RefundCustomerViewStateBlock(textField.text);
        }
    }
    if ([textField isEqual:_tfPhone]) {
        if (textField.text.length == 0) {
            [self updateRefundCustomerViewResetCode];
        }
    }
}
- (void)verifyCode
{
    if (!_tfPhone.text||_tfPhone.text.length<=0||![_tfPhone.text isMobileNumber]) {
        [XMHProgressHUD showOnlyText:@"请输入正确的手机号"];
        return;
    }else{
//        [self openCountdown];
    }
    if (_RefundCustomerViewGetCodeBlock) {
        _RefundCustomerViewGetCodeBlock();
    }
}
// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    _ktimer = _timer;
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [_btnVerify setTitle:@"重新发送" forState:UIControlStateNormal];
                [_btnVerify setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
                _btnVerify.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [_btnVerify setTitle:[NSString stringWithFormat:@"%.2d%@", seconds,@"秒后重发"] forState:UIControlStateNormal];
                [_btnVerify setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
                _btnVerify.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
- (void)updateRefundCustomerViewResignFirstResponder
{
    [_tfPhone resignFirstResponder];
    [_tfCode resignFirstResponder];
}
- (void)updateRefundCustomerViewCodeBtnState
{
    if(_ktimer){
        dispatch_source_cancel(_ktimer);
        _btnVerify.userInteractionEnabled = YES;
    }
    [self openCountdown];
}
- (void)updateRefundCustomerViewResetCode
{
    if(_ktimer){
       dispatch_source_cancel(_ktimer);
         _btnVerify.userInteractionEnabled = YES;
    }
    [_btnVerify setTitle:@"获取验证码" forState:UIControlStateNormal];
}

- (void)textFieldTextDidChangeNotification:(NSNotification *)not {
    UITextField *tf = not.object;
    if (tf == _tfPhone) {
        if (self.phoneChangeBlock) self.phoneChangeBlock(tf.text);
    } else if (tf == _tfCode) {
        if (self.codeChangeBlock) self.codeChangeBlock(tf.text);
    }
}

@end
