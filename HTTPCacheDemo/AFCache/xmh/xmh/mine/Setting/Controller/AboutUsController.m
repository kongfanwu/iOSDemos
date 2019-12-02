//
//  AboutUsController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "AboutUsController.h"
#import <WebKit/WebKit.h>
@interface AboutUsController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation AboutUsController
{
    WKWebView * _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navView setNavViewTitle:@"关于我们" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self initSubViews];
}
- (void)initSubViews
{
//    [self creatNav];
    [self createWebView];
}
- (void)createWebView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@about/about.html",SERVER_H5]]]];
    [self.view addSubview:_webView];
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"关于我们" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
//- (void)createTextView
//{
//    UITextView * tv = [[UITextView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
//    tv.font = FONT_SIZE(14);
//    tv.textColor = kLabelText_Commen_Color_3;
//    [self.view addSubview:tv];
//    tv.text = @"    享美会，意为“享受美的服务，分享美的体验”，由北京享美会网络科技有限公司研发并开创，是一个服务于美业，完全基于线下门店经营场景，贯穿客户从引流、转化、消耗到持续复购的整体业务流程，导入“引流、拓客、锁客、老客裂变”四大营销模式和建立“智能预约、电子订单、处方消耗规划、自动追踪服务、会员管理、员工管理、卡项项目整合、智能数据分析”八大管理机制，通过平台云端智能数据处理中心，实现门店运营数据自动生成、数字管控、实时互通，为用户提供营销管理解决方案的“智慧型·用户营销管理·云平台”。其宗旨为，“每一步，回归简单”，意在通过最为简单的方式，让美业老板随时随地掌控门店，从而解放美业老板、规范门店经营秩序、实现门店健康持续、开启美业运营新时代！\
//        \
//        \
//        \
//              在客户逐步迭代的今天，享美会，通过对线上运营及线下业务管理的完美融合，打造全新美容业态，利用互联网平台优势，通过技术的革新，固化标准程序和简化门店团队的工作流程，规范门店的运营秩序，解放美业老板，助力美容产业整体升级！";
//}
@end
