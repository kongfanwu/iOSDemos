//
//  MzzTRViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/7.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTRViewController.h"
#import "LVerifyMemberView.h"
#import "ApproveRequest.h"
#import "NSString+Check.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "MzzTDDetailInfoController.h"
#import "SPRequest.h"
@interface MzzTRViewController ()
{
     LVerifyMemberView * _verifyView;
    NSString * _phoneNum;
    NSString * _fram_id;
    NSString * _account;
    NSString * _joinCode;
    NSString * _code;
    NSString * _accountId;
}
/** <##> */
@property (nonatomic, strong) UIButton *sureBtn;
@end

@implementation MzzTRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    // Do any additional setup after loading the view.
//    [self createNav];
    self.view.backgroundColor = kBackgroundColor;
    
    [self.navView setNavViewTitle:@"会员调店审批" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self createVerifyMemberView];
    [self loadinitData];
    
}
- (void)createNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"选择审批人" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)loadinitData
{
    NSString * fram_id = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    _fram_id = fram_id;
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = infomodel.data.account;
    _account = account;
    _accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    _joinCode = [ShareWorkInstance shareInstance].join_code;
}
- (void)createVerifyMemberView
{
    LVerifyMemberView * verifyView = [[[NSBundle mainBundle]loadNibNamed:@"LVerifyMemberView" owner:nil options:nil]lastObject];
    _verifyView = verifyView;
    [verifyView.titleLbl setText:@"验证要调店的会员"];
    verifyView.titleLbl.textColor = kColor3;
    verifyView.titleLbl.font = FONT_SIZE(16);
//    _verifyView.btnVerifyCode.enabled = NO;
    [verifyView.btnSendCode addTarget:self action:@selector(sendCodeClick) forControlEvents:UIControlEventTouchUpInside];
//    [verifyView.btnVerifyCode addTarget:self action:@selector(verifyCodeClick) forControlEvents:UIControlEventTouchUpInside];
    verifyView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 158);
    [self.view addSubview:verifyView];
    __weak typeof(self) _self = self;
    [verifyView setInputCodeBlock:^(BOOL isInput) {
        __strong typeof(_self) self = _self;
        self.sureBtn.enabled = isInput;
        self.sureBtn.selected = isInput;
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn = sureBtn;
    sureBtn.layer.cornerRadius = 3;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    [sureBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageWithColor:kColorC size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageWithColor:kBtn_Commen_Color size:CGSizeMake(10, 10)] forState:UIControlStateSelected];
    [sureBtn addTarget:self action:@selector(verifyCodeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verifyView.mas_bottom).offset(50);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(44);
    }];
    sureBtn.enabled = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sendCodeClick
{
    _phoneNum = _verifyView.tfPhoneNum.text;
    [_verifyView.tfPhoneNum resignFirstResponder];
    if (![_phoneNum isMobileNumber]) {
        MzzHud * hub = [[MzzHud alloc]initWithTitle:@"注意" message:@"请输入正确的手机号" centerButtonTitle:@"确定" click:^(NSInteger index) {
            
        }];
        [hub show];
    }else{
        [ApproveRequest requestSendCodeJoinCode:_joinCode phone:_phoneNum phType:@"1" account:_account framId:_fram_id resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
//                _verifyView.btnVerifyCode.enabled = YES;
            }
        }];
    }
}
- (void)verifyCodeClick
{
    [self.view endEditing:YES];
    
    if (![_verifyView.tfPhoneNum.text isMobileNumber]) {
        [MzzHud toastWithTitle:@"提示" message:@"请输入正确手机号"];
        return;
    }
    
    _code = _verifyView.tfCode.text;
    if (!_code || [_code isEqualToString:@""]) {
        [MzzHud toastWithTitle:@"提示" message:@"请输入验证码"];
        return;
    }
  
    [ApproveRequest requestCheckCodeJoinCode:_joinCode phone:_verifyView.tfPhoneNum.text phcode:_code resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self pushNextVc];
        }else{
            [MzzHud toastWithTitle:@"提示" message:@"验证码有误，请重新输入"];
        }
    }];
}

- (void)pushNextVc {
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = infomodel.data.account;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    params[@"mobile"] = _verifyView.tfPhoneNum.text;
    params[@"chType"] =  @"2";
    params[@"account"] =  account;
  
    [SPRequest requestChangeStoreParams:params resultBlock:^(SPChangeStoreModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess && model) {
            //跳转调店详细页
            MzzTDDetailInfoController *detailVc = [[MzzTDDetailInfoController alloc] init];
            [detailVc setupData:model];
            [self.navigationController pushViewController:detailVc animated:NO];
        }else{
            [MzzHud toastWithTitle:@"提示" message:@"请稍后再试"];
        }
    }];

    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
