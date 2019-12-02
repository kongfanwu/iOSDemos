//
//  MineTenantsViewController.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/10/19.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MineTenantsViewController.h"
#import "MineRequest.h"
#import "BaseModel.h"
@interface MineTenantsViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backGroundToTopConstraint;
@property (weak, nonatomic) IBOutlet UILabel *lbCode;

@end

@implementation MineTenantsViewController
{
    BaseModel *_baseModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.toTopConstraint.constant = Heigh_Nav;
    self.backGroundToTopConstraint.constant = Heigh_Nav +51;
    [self requestInvitationCodeData];
    [self creatNav];
    UILongPressGestureRecognizer * press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(press:)];
    _lbCode.userInteractionEnabled = YES;
    [_lbCode addGestureRecognizer:press];
}
- (void)creatNav
{
    customNav * nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"邀请入驻" withleftTitleStr:nil withleftImageStr:@"stgkgl_fanhui" withRightBtnImag:nil withRightBtnTitle:nil];
    nav.lineImageView.hidden = YES;
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------网络请求------
- (void)requestInvitationCodeData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [MineRequest requestInvitationCodeParams:param resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _baseModel = model;
            _lbCode.text = model.data[@"code"];
        }
    }];
}
- (void)press:(UILongPressGestureRecognizer *)longPress
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = _lbCode.text;
}
@end
