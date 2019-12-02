//
//  GKGLMemberBenefitsDetailVC.m
//  xmh
//
//  Created by ald_ios on 2019/1/16.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLMemberBenefitsDetailVC.h"
#import <YYWebImage/YYWebImage.h>
#import <WebKit/WebKit.h>
@interface GKGLMemberBenefitsDetailVC ()
@property (nonatomic, strong)UIImageView * detailImgView;
@property (nonatomic, strong)WKWebView * webView;
@end

@implementation GKGLMemberBenefitsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorE;
    [self.navView setNavViewTitle:@"顾客订单" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_param[@"after_buy"]]]];
//    [self.view addSubview:self.detailImgView];
//    [_detailImgView yy_setImageWithURL:URLSTR(_param[@"after_buy"]) placeholder:kDefaultImage];
}
- (UIImageView *)detailImgView
{
    if (!_detailImgView) {
        _detailImgView = [[UIImageView alloc] init];
        _detailImgView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav);
        _detailImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _detailImgView;
}
-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
//        _webView.UIDelegate = self;
//        _webView.navigationDelegate = self;
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_H5,kGKGL_DATASTATISTICS_URL]]]];
    }
    return _webView;
}
@end
