//
//  MineModifyPhoneViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/16.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MineModifyPhoneViewController.h"
#import "MineInformationModel.h"
#import "MineRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "NSString+Check.h"
@interface MineModifyPhoneViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
@property (weak, nonatomic) IBOutlet UIButton *btnCode;

@end

@implementation MineModifyPhoneViewController
{
      MineInformationModel * _model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _lbPhone.text = [NSString stringWithFormat:@"您的手机号: %@",_model.phone];
    [self initSubViews];
}

- (void)initSubViews
{
    [self creatNav];
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"我的资料" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)codeClick:(id)sender {
    
    if (!(_tfPhone.text.length > 0)) {
//        [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionCenten title:@"手机号不能为空"];
//        [SVProgressHUD showSuccessWithStatus:@"手机号不能为空"];
        [XMHProgressHUD showOnlyText:@"手机号不能为空"];
        return;
    }
    if (![_tfPhone.text isMobileNumber]){
//        [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionCenten title:@"手机号格式不对"];
         [XMHProgressHUD showOnlyText:@"手机号格式不对"];
        return;
    }
    [MineRequest requestCodePhone:_tfPhone.text resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
//            [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionCenten title:@"短信发送成功"];
            [XMHProgressHUD showOnlyText:@"短信发送成功"];
        }
    }];
}
- (void)setInfoModel:(MineInformationModel *)model
{
    _model = model;
}
- (IBAction)sureClick:(id)sender {
    
    if (!(_tfPhone.text.length > 0)) {
//         [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionCenten title:@"手机号不能为空"];
        [XMHProgressHUD showOnlyText:@"手机号不能为空"];
        return;
    }
    if (!(_tfCode.text.length > 0)) {
//        [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionCenten title:@"验证码不能为空"];
        [XMHProgressHUD showOnlyText:@"验证码不能为空"];
        return;
    }
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    [MineRequest requestModifyPhone:_tfPhone.text code:_tfCode.text uid:accountId resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
//            [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionCenten title:@"短信发送成功"];
            [XMHProgressHUD showOnlyText:@"短信发送成功"];
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
        }
    }];
}
@end
