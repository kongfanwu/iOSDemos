//
//  LanternXSPlanVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/27.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternXSPlanVC.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "LanternPlanVC.h"
@interface LanternXSPlanVC ()
<
WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler
>
@property (nonatomic, strong)WKWebView * detailWebView;
@end

@implementation LanternXSPlanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.detailWebView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[_detailWebView configuration].userContentController removeScriptMessageHandlerForName:@"LanternGoBack"];
    [[_detailWebView configuration].userContentController removeScriptMessageHandlerForName:@"LanternEdit"];
}

-(WKWebView *)detailWebView
{
    if (!_detailWebView) {
        _detailWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _detailWebView.UIDelegate = self;
        _detailWebView.navigationDelegate = self;
//        _detailWebView.scrollView.scrollEnabled = NO;
        [[_detailWebView configuration].userContentController addScriptMessageHandler:self name:@"LanternGoBack"];
        [[_detailWebView configuration].userContentController addScriptMessageHandler:self name:@"LanternEdit"];
        if (@available(iOS 11.0, *)) {
            _detailWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        [_detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@intelligence/consumption.html",SERVER_H5]]]];
    }
    return _detailWebView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_detailWebView reload];
}
#pragma mark ------WKWebView------
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * token = infomodel.data.token;
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    NSString * date = @"";
    if (_date.length > 0) {
        date = _date;
    }else{
        date = [NSString stringWithFormat:@"%@-%@",_year,_lanternHistoryPlanModel.month];
    }
    NSString * jsStr = [NSString stringWithFormat:@"LanternCallIos('%@','%@','%@','%@','%@')",token,joinCode,@"1",infomodel.data.account,date];
    [XMHWebSignTools loadWebViewJs:webView];
    [_detailWebView evaluateJavaScript:jsStr completionHandler:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................页面加载失败时调用");
}
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"LanternGoBack"]) {
        if (_comeFrom == DetailComeFromeMakePlan) {
             [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
        }else if (_comeFrom == DetailComeFromeHistory){
            [self.navigationController popViewControllerAnimated:NO];
        }
    }else if ([message.name isEqualToString:@"LanternEdit"]) {
        NSString *editID = (NSString *)message.body;
        if (_comeFrom == DetailComeFromeMakePlan) {
            if (_LanternXSPlanVCBlock) {
                _LanternXSPlanVCBlock(editID,@"1");
            }
            [self.navigationController popViewControllerAnimated:NO];
        }else if (_comeFrom == DetailComeFromeHistory){
            LanternPlanVC * lanternPlanVC = [[LanternPlanVC alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:lanternPlanVC];
            nav.navigationBar.hidden = YES;
            lanternPlanVC.type = @"1";
            lanternPlanVC.date = [NSString stringWithFormat:@"%@-%@",_year,_lanternHistoryPlanModel.month];
            lanternPlanVC.isSave = @"1";
            lanternPlanVC.editID = (NSString *)message.body;
            lanternPlanVC.comeFrom = ComeFromeDetail;
            [self.navigationController pushViewController:lanternPlanVC animated:NO];
        }
    }
}
@end
