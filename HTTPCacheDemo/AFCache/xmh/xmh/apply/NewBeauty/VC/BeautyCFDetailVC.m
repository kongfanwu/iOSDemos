//
//  BeautyCFDetailVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFDetailVC.h"
#import <WebKit/WebKit.h>
#import "BeautyCFDetailUserInfoView.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "BeautyCFReportVC.h"
#import "BeautyRequest.h"
#import "BeautyCustomersVC.h"
#import "BeautyCFReportWriteVC.h"
#import "BeautyCFResultVC.h"
@interface BeautyCFDetailVC ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong)BeautyCFDetailUserInfoView *userInfoView;
@property (nonatomic, strong)WKWebView * webView;

@end

@implementation BeautyCFDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;
    [self initSubViews];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"chufangcallback"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"ChufangDetailChuFangZhiXingBiaocallback"];
}

- (void)initSubViews
{
    WeakSelf
    if (_from == 0 ||_from == 2) {
         [self.navView setNavViewTitle:@"处方详情" backBtnShow:YES];
    }else{
        [self.navView setNavViewTitle:@"处方详情" backBtnShow:YES rightBtnTitle:@"处方报告"];
    }
    
    if ([self.param[@"zt"] integerValue] == 2 || [self.param[@"zt"] integerValue] == 3) {
        [self.navView setNavViewTitle:@"处方详情" backBtnShow:YES rightBtnTitle:@"处方报告"];
    }
    if ([self.param[@"come"] integerValue]== 1) {
        if ([self.param[@"presentation"] isEqual:[NSNull null]] || [self.param[@"proposal"] isEqual:[NSNull null]] || !self.param[@"presentation"] || !self.param[@"proposal"]){
            [self.navView setNavViewTitle:@"处方详情" backBtnShow:YES];
        }
    }
    __weak typeof(self) _self = self;
    self.navView.NavViewRightBlock = ^{
        __strong typeof(_self) self = _self;
        /** 判断是否填写了处方执行报告 和 处方执行建议 */
        
        if ([self.param[@"presentation"] isEqual:[NSNull null]] || [self.param[@"proposal"] isEqual:[NSNull null]] || !self.param[@"presentation"] || !self.param[@"proposal"] || [self.param[@"presentation"] isEqualToString:@"null"]||[self.param[@"proposal"] isEqualToString:@"null"]) {
            /** 跳转填写处方报告界面 */
            BeautyCFReportWriteVC * next = [[BeautyCFReportWriteVC alloc] init];
            next.param = weakSelf.param;
            [weakSelf.navigationController pushViewController:next animated:NO];
        }else{
            /** 跳转处方报告*/
            BeautyCFReportVC * next = [[BeautyCFReportVC alloc] init];
            next.param = weakSelf.param;
            [weakSelf.navigationController pushViewController:next animated:NO];
        }
    };
    self.navView.NavViewBackBlock = ^{
        if (weakSelf.msgBlock) {
            weakSelf.msgBlock();
            return ;
        }
        if (weakSelf.makeCFBlock) {
            weakSelf.makeCFBlock();
            return ;
        }
        if (weakSelf.beautyZCFBlock) {
            weakSelf.beautyZCFBlock();
            return ;
        }
        if (weakSelf.gkglBlock) {
            weakSelf.gkglBlock();
            return;
        }
        if (weakSelf.gkglBillDetaiCFBlock) {
            weakSelf.gkglBillDetaiCFBlock();
            return;
        }
        [weakSelf.navigationController popToRootViewControllerAnimated:NO];
        
    };
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.userInfoView];
    [self.view addSubview:self.webView];
    [_userInfoView updateViewParam:_param];
    
}
- (BeautyCFDetailUserInfoView *)userInfoView
{
    WeakSelf
    if (!_userInfoView) {
        _userInfoView = loadNibName(@"BeautyCFDetailUserInfoView");
        _userInfoView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 100);
        _userInfoView.BeautyCFDetailUserInfoViewDelBlock = ^(NSMutableDictionary * _Nonnull param) {
            [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"您确定您要将此处方作废吗？此操作将不可恢复，请谨慎操作" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
                if (index == 1) {
                   [weakSelf requestDelCF];
                }
            }]show];
        };
        _userInfoView.BeautyCFDetailUserInfoViewContinueBlock = ^(NSMutableDictionary * _Nonnull param) {
            if (weakSelf.from == 2) {/** 直接退回到选择顾客界面 */
                [weakSelf.navigationController popToViewController:weakSelf.navigationController.viewControllers[1] animated:NO];
            }else{
                /** 跳转顾客界面继续开单 */
                BeautyCustomersVC * next = [[BeautyCustomersVC alloc] init];
                [weakSelf.navigationController pushViewController:next animated:NO];
            }
        };
        _userInfoView.BeautyCFDetailUserInfoViewEndBlock = ^(NSMutableDictionary * _Nonnull param) {
            [[[MzzHud alloc]initWithTitle:@"温馨提示" message:@"您确定您要将此处方作废吗？此操作将不可恢复，请谨慎操作" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
                if (index == 1) {
                    [weakSelf requestEndCFParam:weakSelf.param];
                }
            }]show];
        };
    }
    return _userInfoView;
}
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _userInfoView.bottom + 10, SCREEN_WIDTH, SCREEN_HEIGHT - _userInfoView.bottom - 10)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"chufangcallback"];
        [[_webView configuration].userContentController addScriptMessageHandler:self name:@"ChufangDetailChuFangZhiXingBiaocallback"];
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",SERVER_H5,kBEAUTY_CFDETAIL_URL];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    }
    return _webView;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString * callbackstr = message.body;
//    [XMHProgressHUD showOnlyText:callbackstr];
    /** 顾客基本信息 */
    if (![callbackstr hasPrefix:@"{"]) {
        NSArray * infoArr = [callbackstr componentsSeparatedByString:@","];
        NSMutableDictionary * userParam = [[NSMutableDictionary alloc] init];
        [userParam setValue:infoArr[0] forKey:@"zt"];
        [userParam setValue:infoArr[1] forKey:@"user_name"];
        [userParam setValue:infoArr[2] forKey:@"icon"];
        [userParam setValue:infoArr[3] forKey:@"num"];
        [userParam setValue:infoArr[4] forKey:@"num1"];
        [_param setValue:infoArr[0] forKey:@"zt"];
        [_param setValue:infoArr[1] forKey:@"user_name"];
        [_param setValue:infoArr[2] forKey:@"icon"];
        [_param setValue:infoArr[3] forKey:@"num"];
        [_param setValue:infoArr[4] forKey:@"num1"];
        [_param setValue:infoArr[5] forKey:@"presentation"];
        [_param setValue:infoArr[6] forKey:@"proposal"];
        [_userInfoView updateViewParam:userParam];
        if ([_param[@"come"] integerValue]== 2) {
            if ([infoArr[0]integerValue] == 2 || [infoArr[0]integerValue] == 3) {
                [self.navView setNavViewTitle:@"处方详情" backBtnShow:YES rightBtnTitle:@"处方报告"];
            }
        }
        if ([_param[@"come"] integerValue]== 1) {
            if ([_param[@"presentation"] isEqual:[NSNull null]] || [_param[@"proposal"] isEqual:[NSNull null]] || !_param[@"presentation"] || !_param[@"proposal"]||[_param[@"presentation"] isEqualToString:@"null"]||[_param[@"proposal"] isEqualToString:@"null"]){
                [self.navView setNavViewTitle:@"处方详情" backBtnShow:YES];
            }else{
                [self.navView setNavViewTitle:@"处方详情" backBtnShow:YES rightBtnTitle:@"处方报告"];
            }
        }
        
    }else{
        BeautyCFResultVC * next = [[BeautyCFResultVC alloc] init];
        next.param = _param;
        next.callStr = callbackstr;
        [self.navigationController pushViewController:next animated:NO];
    }
}
- (void)dealloc
{
//    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"chufangcallback"];
//    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"ChufangDetailChuFangZhiXingBiaocallback"];
}



- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [XMHProgressHUD showGifImage];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [XMHProgressHUD dismiss];
    
    
    if (_callBackMsg.length > 0) {
        NSString *js = [NSString stringWithFormat:@"ChufangDetailChuFangZhiXingBiaocallJs('%@')",_callBackMsg];
        [XMHWebSignTools loadWebViewJs:webView];
        [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            
        }];
    }else{
        LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
        NSString * token = model.data.token;
        [XMHWebSignTools loadWebViewJs:webView];
        NSString *js = [NSString stringWithFormat:@"ChufangDetailCallJs('%@','%@')",token,_param[@"ordernum"]];
        [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        }];
    }
    
}
#pragma mark -----网络请求----
///** 终止处方 */
//- (void)requestEndCF
//{
//    NSString * ordernum = _param[@"ordernum"];
//    NSString * storeCode = _param[@"store_code"];
//    [[BeautyRequest alloc] requestChuFangJieShuordernum:ordernum store_code:storeCode resultBlock:^(id obj, BOOL isSuccess, NSDictionary *errorDic) {
//        if (isSuccess) {
//
//        }
//    }];
//}
/** 删除处方 */
- (void)requestDelCF{
    NSString * ordernum = _param[@"ordernum"];
    NSString * storeCode = _param[@"store_code"];
    [[BeautyRequest alloc] requestChuFangDelordernum:ordernum store_code:storeCode resultBlock:^(id obj, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [self.navigationController popViewControllerAnimated:NO];
        }
    }];
}
/** 终止处方 */
- (void)requestEndCFParam:(NSMutableDictionary *)param;
{
    NSString * ordernum = param[@"ordernum"];
    NSString * storeCode = param[@"store_code"];
    [[BeautyRequest alloc] requestChuFangJieShuordernum:ordernum store_code:storeCode resultBlock:^(id obj, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            /** 跳转填写处方报告界面 */
            BeautyCFReportWriteVC * next = [[BeautyCFReportWriteVC alloc] init];
            next.param = param;
            next.from = 2;
            [self.navigationController pushViewController:next animated:NO];
        }else{
            [XMHProgressHUD showOnlyText:errorDic[@"error"]];
        }
    }];
}
@end
