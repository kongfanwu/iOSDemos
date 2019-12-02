//
//  MineInfoChangePhoneController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/16.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MineInfoChangePhoneController.h"
#import "MineModifyPhoneViewController.h"
@interface MineInfoChangePhoneController ()

@end

@implementation MineInfoChangePhoneController
{
    MineInformationModel * _model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     _lbPhone.text = [NSString stringWithFormat:@"您的手机号:%@",_model.phone];
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
- (void)infoModel:(MineInformationModel *)model
{
    _model = model;
}
- (IBAction)sure:(UIButton *)sender {
    MineModifyPhoneViewController * next = [[MineModifyPhoneViewController alloc] init];
    [next setInfoModel:_model];
    [self.navigationController pushViewController:next animated:NO];
}
@end
