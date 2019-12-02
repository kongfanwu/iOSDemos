//
//  RefundCustomer.m
//  xmh
//
//  Created by ald_ios on 2018/11/6.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundCustomer.h"
#import "RefundCustomerView.h"
#import "NSString+Check.h"
#import "ApproveRequest.h"
#import "ShareWorkInstance.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "RefundVC.h"
@interface RefundCustomer ()
@property (nonatomic, strong)RefundCustomerView *refundCustomerView;
@property (nonatomic, strong)UIButton *submitBtn;
/** 手机号 */
@property (nonatomic, copy) NSString * phone;
/** 验证码 */
@property (nonatomic, copy) NSString * code;
@end

@implementation RefundCustomer
{
    
    /** 账号 */
    NSString * _account;
    /** 登录人层级id */
    NSString * _framId;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    /** 初始设置 */
    self.view.backgroundColor = kBackgroundColor;
    [self loadinitData];
    
    
    /** nav */
    [self.navView setNavViewTitle:@"退款审批" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    [self.view addSubview:self.refundCustomerView];
    [self.view addSubview:self.submitBtn];
    
    
    
}
- (void)loadinitData
{
    _framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _account = infomodel.data.account;
}
- (RefundCustomerView *)refundCustomerView
{
    WeakSelf
    if (!_refundCustomerView) {
        _phone = nil;
        _code = nil;
        _refundCustomerView = loadNibName(@"RefundCustomerView");
        _refundCustomerView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 158);
        _refundCustomerView.RefundCustomerViewStateBlock = ^(NSString * text){
            if (text.length > 0) {
                weakSelf.submitBtn.backgroundColor = kBtn_Commen_Color;
            }else{
                weakSelf.submitBtn.backgroundColor = [ColorTools colorWithHexString:@"#CCCCCC"];
            }
        };
        _refundCustomerView.RefundCustomerViewCodeBlock = ^(NSString *code) {
            if (!code || code.length <= 0) {
                [XMHProgressHUD showOnlyText:@"请输入验证码"];
            }else{
                weakSelf.code = code;
            }
        };
        _refundCustomerView.RefundCustomerViewPhoneBlock = ^(NSString *phone) {
            if (!phone || phone.length <= 0) {
                [XMHProgressHUD showOnlyText:@"请输入手机号"];
            }else{
                weakSelf.phone = phone;
            }
        };
        //获取验证码 --tangyf
        _refundCustomerView.RefundCustomerViewGetCodeBlock = ^() {
           [weakSelf requestCode];
        };
        
        __weak typeof(self) _self = self;
        [_refundCustomerView setPhoneChangeBlock:^(NSString *text) {
            __strong typeof(_self) self = _self;
            self.phone = text;
        }];
        
        [_refundCustomerView setCodeChangeBlock:^(NSString *text) {
            __strong typeof(_self) self = _self;
            self.code = text;
        }];
    }
    return _refundCustomerView;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.backgroundColor = [ColorTools colorWithHexString:@"#CCCCCC"];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = FONT_SIZE(17);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.frame = CGRectMake(15, _refundCustomerView.bottom + 50, SCREEN_WIDTH - 30, 44);
        _submitBtn.layer.cornerRadius = 3;
        [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
- (void)submit
{
    /** 输入框取消第一响应者 */
    [_refundCustomerView updateRefundCustomerViewResignFirstResponder];

    if (!_phone||_phone.length<=0||![_phone isMobileNumber]) {
        [XMHProgressHUD showOnlyText:@"请输入正确的手机号"];
        return;
    }
    if (!_code ||_code.length<=0) {
        [XMHProgressHUD showOnlyText:@"请输入验证码"];
        return;
    }
    [self requestCommit];
/** 测试跳过 */
//    RefundVC * refundVC = [[RefundVC alloc] init];
//    refundVC.mobile = @"16666666656";
//    [self.navigationController pushViewController:refundVC animated:NO];
    
}
#pragma mark ------网络请求------
/** 获取验证码 */
- (void)requestCode
{
    if (!_phone || _phone.length <= 0) {
        [XMHProgressHUD showOnlyText:@"请输入手机号"];
        return;
    }
    
    [ApproveRequest requestSendCodeJoinCode:nil phone:_phone phType:@"2" account:_account framId:_framId resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            /** 发送成功开始跑秒 */
            [_refundCustomerView updateRefundCustomerViewCodeBtnState];
        }else{
            
        }
    }];
}
/** 提交请求验证手机号 和 验证码 */
- (void)requestCommit
{
    if (!_phone || _phone.length <= 0) {

        [XMHProgressHUD showOnlyText:@"请输入手机号"];

        return;
    }
    
    if (!_code || _code.length <= 0) {
        [XMHProgressHUD showOnlyText:@"请输入验证码"];

        return;
    }
    
    [ApproveRequest requestCheckCodeJoinCode:nil phone:_phone phcode:_code resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            RefundVC * refundVC = [[RefundVC alloc] init];
            refundVC.mobile = _phone;
//            refundVC.mobile = @"18674100147";
            [self.navigationController pushViewController:refundVC animated:NO];
        }else{
            
        }
    }];
}
@end
