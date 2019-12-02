//
//  ChuFangReporterViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/18.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ChuFangReporterViewController.h"
#import <WebKit/WebKit.h>
#import "ChufangDetailTopView.h"
#import <WebKit/WebKit.h>
@interface ChuFangReporterViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>{
    WKWebView *_webView;
    ChufangDetailTopView *_topView;
}

@end

@implementation ChuFangReporterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNav];
    [self initSubviews];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"处方报告" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)initSubviews{
    _topView = [[[NSBundle mainBundle]loadNibNamed:@"ChufangDetailTopView" owner:nil options:nil] firstObject];
    _topView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 107);
    [self.view addSubview:_topView];
    _topView.btn1.hidden = YES;
    _topView.btn2.hidden = YES;
    if (_subinfo &&_info) {
        _name = _info.uname;
        _img  = _info.headimgurl;
        _num = [NSString stringWithFormat:@"%ld",_subinfo.num];
        _num1 = [NSString stringWithFormat:@"%ld",_subinfo.num1];
        _billNum = _subinfo.ordernum;
    }
    [_topView freshChufangDetailTopView:_name img:_img num:_num num1:_num1 zt:nil];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _topView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _topView.bottom)];
    [self.view addSubview:_webView];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    NSString *urlStr = [NSString stringWithFormat:@"%@beauty/report.html",SERVER_H5];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
//    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"chufangcallback"];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
//    NSLog(@"body=%@",message.body);
//    NSString * callbackstr = message.body;
//    NSArray *retuenarr = [callbackstr componentsSeparatedByString:@","];
//    NSString *name;
//    NSString *img;
//    NSString *num1;
//    NSString *num;
//    if (retuenarr.count>1) {
//        name = retuenarr[1];
//    }
//    if (retuenarr.count>2) {
//        img = retuenarr[2];
//    }
//    if (retuenarr.count>3) {
//        num = retuenarr[3];
//    }
//    if (retuenarr.count>4) {
//        num1 = retuenarr[4];
//    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //传token,项目编号
    NSString *js = [NSString stringWithFormat:@"ChufangDetailCallJs('%@','%@')",_token,_billNum];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
