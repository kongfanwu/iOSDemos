//
//  MzzTDViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/1.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTDViewController.h"
#import "MzzTDJoinListController.h"
#import "MzzTRViewController.h"
#import "MzzSelectButtom.h"
#import "LNavView.h"

@interface MzzTDViewController ()
@property (nonatomic ,strong)UIButton *currentBtn;
@property (nonatomic, strong)LNavView * navView;
/** <##> */
@property (nonatomic, strong) UIButton *leftBtn, *rightBtn;
@end

@implementation MzzTDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorF5F5F5;
    
    [self.view addSubview:self.navView];
    [self.navView setNavViewTitle:@"会员调店审批" backBtnShow:YES];
    
    [self creatView];
}

- (LNavView *)navView
{
    WeakSelf
    if (!_navView) {
        _navView = loadNibName(@"LNavView");
        _navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, KNaviBarHeight);
//        _navView.backgroundColor = [UIColor clearColor];
        _navView.backgroundColor = kBtn_Commen_Color;
        _navView.NavViewBackBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navView;
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"会员调店审批" withleftImageStr:@"back" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)creatView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, self.view.width, 200)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
//    MzzSelectButtom *tiaochu = [MzzSelectButtom buttonWithType:UIButtonTypeCustom];
//    tiaochu.tag = 0;
//    [tiaochu setTitle:@"调出门店" forState:UIControlStateNormal];
//    [tiaochu setImage:[UIImage imageNamed:@"syspyyzhifuxuanzeweixuan"] forState:UIControlStateNormal];
//    [tiaochu setTitle:@"调出门店" forState:UIControlStateSelected];
//    [tiaochu setImage:[UIImage imageNamed:@"syspyyzhifuxuanze"] forState:UIControlStateSelected];
//    [tiaochu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [tiaochu.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    tiaochu.frame = CGRectMake(backView.width/2 - 20 - 90, 70, 90, 20);
//    [tiaochu addTarget:self action:@selector(tiaochuOnclick:) forControlEvents:UIControlEventTouchUpInside];
//    _currentBtn = tiaochu;
//    [_currentBtn setSelected:YES];
//    [backView addSubview:tiaochu];
//
//    MzzSelectButtom *tiaoru = [MzzSelectButtom buttonWithType:UIButtonTypeCustom];
//    tiaoru.tag = 1;
//    [tiaoru setTitle:@"调入门店" forState:UIControlStateNormal];
//    [tiaoru setImage:[UIImage imageNamed:@"syspyyzhifuxuanzeweixuan"] forState:UIControlStateNormal];
//    [tiaoru setTitle:@"调入门店" forState:UIControlStateSelected];
//    [tiaoru setImage:[UIImage imageNamed:@"syspyyzhifuxuanze"] forState:UIControlStateSelected];
//    [tiaoru setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [tiaoru.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    tiaoru.frame = CGRectMake(backView.width/2 +20, 70, 90, 20);
//    [tiaoru addTarget:self action:@selector(tiaoruOnclick:) forControlEvents:UIControlEventTouchUpInside];
//    [backView addSubview:tiaoru];

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn = leftBtn;
    [leftBtn setImage:UIImageName(@"stspyy_tiaochumendian") forState:UIControlStateNormal];
    [leftBtn setImage:UIImageName(@"stspyy_tiaochumendian") forState:UIControlStateHighlighted];
    [leftBtn setTitle:@"调出门店" forState:UIControlStateNormal];
    [leftBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [leftBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    leftBtn.titleLabel.font = FONT_SIZE(13);
    [leftBtn setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    
    UIImage *selImage = [UIImage imageWithColor:[ColorTools colorWithHexString:@"#FFF0F8"] size:CGSizeMake(10, 10)];
    [leftBtn setBackgroundImage:selImage forState:UIControlStateSelected];
    [leftBtn setBackgroundImage:selImage forState:UIControlStateHighlighted];
    leftBtn.layer.cornerRadius = 5;
    leftBtn.layer.masksToBounds = YES;
    [leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 140));
        make.centerY.equalTo(backView);
        make.centerX.equalTo(backView).multipliedBy(0.5);
    }];
    leftBtn.tag = 0;
    leftBtn.selected = YES;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn = rightBtn;
    [rightBtn setImage:UIImageName(@"stspyy_tiaorumendian") forState:UIControlStateNormal];
    [rightBtn setImage:UIImageName(@"stspyy_tiaorumendian") forState:UIControlStateHighlighted];
    [rightBtn setTitle:@"调入门店" forState:UIControlStateNormal];
    [rightBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [rightBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    rightBtn.titleLabel.font = FONT_SIZE(13);
    [rightBtn setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    
//    UIImage *selImage = [UIImage imageWithColor:[ColorTools colorWithHexString:@"#FFF0F8"] size:CGSizeMake(10, 10)];
    [rightBtn setBackgroundImage:selImage forState:UIControlStateSelected];
    [rightBtn setBackgroundImage:selImage forState:UIControlStateHighlighted];
    
    rightBtn.layer.cornerRadius = 5;
    rightBtn.layer.masksToBounds = YES;
    [rightBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 140));
        make.centerY.equalTo(backView);
        make.centerX.equalTo(backView).multipliedBy(1.5);
    }];
    rightBtn.tag = 1;
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 3;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageWithColor:kBtn_Commen_Color size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset(50);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self centerAlignImageAndTextForButton:_leftBtn];
    [self centerAlignImageAndTextForButton:_rightBtn];
}

- (void)centerAlignImageAndTextForButton:(UIButton*)button
{
    CGFloat spacing = 5;
    CGSize imageSize = button.imageView.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(imageSize.height + spacing), 0);
    CGSize titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0, 0, -titleSize.width);
}

- (void)click:(UIButton *)sender {
    if (sender == _leftBtn) {
        _leftBtn.selected = YES;
        _rightBtn.selected = NO;
    } else {
        _leftBtn.selected = NO;
        _rightBtn.selected = YES;
    }
    
    _currentBtn = sender;
}

- (void)tiaochuOnclick:(UIButton *)tiaochu{
    if (tiaochu.selected) {
        return;
    }
    [tiaochu setSelected:YES];
    [_currentBtn setSelected:NO];
    _currentBtn = tiaochu;
}

- (void)tiaoruOnclick:(UIButton *)tiaoru{
    if (tiaoru.selected) {
        return;
    }
    [tiaoru setSelected:YES];
    [_currentBtn setSelected:NO];
    _currentBtn = tiaoru;
}
- (void)sure{
    if (_currentBtn.tag ==0) {
        //调出
        MzzTDJoinListController *joinVc = [[MzzTDJoinListController alloc] init];
        [self.navigationController pushViewController:joinVc animated:NO];
    }else{
        //调入
        MzzTRViewController *next = [[MzzTRViewController alloc] init];
        [self.navigationController pushViewController:next animated:NO];
    }
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
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
