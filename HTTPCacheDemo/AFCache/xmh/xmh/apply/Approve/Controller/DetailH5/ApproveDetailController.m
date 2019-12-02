//
//  ApproveDetailController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ApproveDetailController.h"
#import <WebKit/WebKit.h>
#import "LApproveQKModel.h"
#import "MzzCustomerDetailsController.h"
#import "SASaleListModel.h"
#import <YYModel/YYModel.h>
#import "ApproveNativeViewController.h"
#import "ApproveController.h"
#import "OrderManagementViewController.h"
@interface ApproveDetailController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end

@implementation ApproveDetailController
{
    WKWebView * _webView;
    NSArray * _bodyMsgArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    _bodyMsgArr = [[NSArray alloc] init];
  
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[_webView configuration].userContentController  removeScriptMessageHandlerForName:@"approveGoBack"];
    [[_webView configuration].userContentController  removeScriptMessageHandlerForName:@"gotoQK"];
    [[_webView configuration].userContentController  removeScriptMessageHandlerForName:@"setIosData"];
}
- (void)back
{
    if (_webView.isLoading) {
        [_webView stopLoading];
    }
    if ([_detailModel.navTitle isEqualToString:@"完善信息"]) {
        if ([_webView canGoBack]) {
            [_webView goBack];
        }else{
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[OrderManagementViewController class]]) {
                    [self.navigationController popToViewController:temp animated:NO];
                    return;
                }
//                if ([temp isKindOfClass:[ApproveController class]]) {
//                    [self.navigationController popToViewController:temp animated:NO];
//                }
                [self.navigationController popViewControllerAnimated:NO];
                return;
            }
            [self.navigationController popViewControllerAnimated:NO];
        }
    }else{
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[OrderManagementViewController class]]) {
                [self.navigationController popToViewController:temp animated:NO];
                return;
            }
//            if ([temp isKindOfClass:[ApproveController class]]) {
//                [self.navigationController popToViewController:temp animated:NO];
//                return;
//            }
            [self.navigationController popViewControllerAnimated:NO];
            return;
        }
        [self.navigationController popViewControllerAnimated:NO];
    }
}
- (void)createWebView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    //    _webView.scrollView.scrollEnabled = NO;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_detailModel.urlstr]]];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"approveGoBack"];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"gotoQK"];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"setIosData"];
    [self.view addSubview:_webView];
    
    
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    
        //// Date from
    
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    
        //// Execute
    
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
    
            // Done
    
        }];
    
}
- (void)setDetailModel:(ApproveDetailModel *)detailModel
{
    _detailModel = detailModel;
//    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:detailModel.navTitle withleftImageStr:@"back" withRightStr:nil];
//    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nav];
    [self.navView setNavViewTitle:detailModel.navTitle backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self createWebView];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"approveGoBack"]) {
        NSNumber * num = (NSNumber *)message.body;
        if (num.intValue == 0) { //返回
             [self back];//H5界面必须有参数，参数为空的话方法不调用
        }else if (num.intValue == 2){//确认拒绝
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[OrderManagementViewController class]]) {
                    [self.navigationController popToViewController:temp animated:NO];
                    return;
                }
                if ([temp isKindOfClass:[ApproveController class]]) {
                    [self.navigationController popToViewController:temp animated:NO];
                }
                
            }
//            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
        }else if (num.intValue == 3){//确认通过
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[OrderManagementViewController class]]) {
                    [self.navigationController popToViewController:temp animated:NO];
                    return;
                }
                if ([temp isKindOfClass:[ApproveController class]]) {
                    [self.navigationController popToViewController:temp animated:NO];
                }
               
            }
        }
    }else if ([message.name isEqualToString:@"gotoQK"]){

        NSString * strBody = (NSString *)message.body;
        if (strBody.length > 0) {
            _bodyMsgArr = [strBody componentsSeparatedByString:@","];
        }
        if (_bodyMsgArr.count == 3) {
            LApproveQKModel * model = [LApproveQKModel createModelWithUserId:_bodyMsgArr[0] joinCode:_bodyMsgArr[1] storeCode:_bodyMsgArr[2]];
             MzzCustomerDetailsController *detail = [UIStoryboard storyboardWithName:@"MzzCustomerDetails" bundle:nil].instantiateInitialViewController;
            detail.user_id = model.userId;
            detail.store_code = model.storeCode;
            [self.navigationController pushViewController:detail animated:NO];
        }
       
    }else if ([message.name isEqualToString:@"setIosData"]){
        NSDictionary *data = (NSDictionary *)message.body;
        ApproveNativeViewController *nativeVc = [[ApproveNativeViewController alloc]init];
//        nativeVc.BackBlock = ^{
//            [_webView reload];
//        };
        nativeVc.data = data;
        if (!_store_code) {
            _store_code = data[@"store_code"];
        }
        nativeVc.store_code = _store_code;
        [self.navigationController pushViewController:nativeVc animated:YES];
    }
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD showGifImage];
    MzzLog(@"...................页面开始加载时调用11");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................当内容开始返回时调用11");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载完成之后调用11");
    NSString * jsStr = [NSString stringWithFormat:@"smartAllocation('%@','%@','%@','%@','%@','%@','%@','%@')",_detailModel.token,_detailModel.join_code,_detailModel.code,_detailModel.accountId,_detailModel.from,_detailModel.ordernum,[NSString stringWithFormat:@"%d",_detailModel.fromList],_detailModel.accountId];
    
//    String string = FrameUtlis.getToken() + "," + FrameUtlis.getJoinCode() + "," + item.getCode() + "," +
//    FrameUtlis.getUserID() + "," + 1 + "," + "" + "," + 3 + "," + FrameUtlis.getUserID();
    
//    NSString * jsStr = [NSString stringWithFormat:@"smartAllocation('%@','%@','%@','%@','%@','%@','%@','%@')",_detailModel.token,_detailModel.join_code,_detailModel.code,_detailModel.accountId,@"1",@"",@"3", _detailModel.accountId];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
    //
    [XMHProgressHUD dismiss];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载失败时调用11");
}
//wk被terminate时调用
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    
//    if (navigationAction.navigationType==WKNavigationTypeBackForward) {                  //判断是返回类型
//        if (webView.backForwardList.backList.count>0) {                                  //得到栈里面的list
//            WKBackForwardListItem * item = webView.backForwardList.currentItem;          //得到现在加载的list
//            for (WKBackForwardListItem * backItem in webView.backForwardList.backList) { //循环遍历，得到你想退出到
//                //添加判断条件
////                [webView goToBackForwardListItem:[webView.backForwardList.backItem]];
//            }
//        }
//    }
//    
//    //允许跳转
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_webView reload];
}
@end
