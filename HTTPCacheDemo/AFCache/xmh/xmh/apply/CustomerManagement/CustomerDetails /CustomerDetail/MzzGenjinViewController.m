//
//  MzzGenjinViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/4.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzGenjinViewController.h"
#import <WebKit/WebKit.h>
#import "LolUserInfoModel.h"
#import "UserManager.h"
@interface MzzGenjinViewController ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>
@property (nonatomic , strong) WKWebView *web;
@property (nonatomic ,copy) NSString *jis;
@property (nonatomic ,copy) NSString *uid;
@property (nonatomic ,copy) NSString *uanme;
@property (nonatomic ,assign) BOOL formWork;
@end

@implementation MzzGenjinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self creatNav];
    [self creatNet];
}
-(void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"跟进客户" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
-(void)creatNet{
    
    _web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20 )];
    _web.navigationDelegate = self;
    _web.UIDelegate = self;
    _web.backgroundColor = [UIColor whiteColor];
    [[_web configuration].userContentController addScriptMessageHandler:self name:@"genjinguke"];
    if (_formWork) {
        [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@gk/genjin/work.html",SERVER_H5]]]];
    }else{
        [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@gk/genjin/list.html",SERVER_H5]]]];
    }
    
    
    [self.view addSubview:_web];
    
    
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setJis:(NSString *)jis andUser_id:(NSString *)user_id andUname:(NSString *)uname{
    _jis = jis;
    _uid = user_id;
    _uanme = uname;
    
}
- (void)setJis:(NSString *)jis andUser_id:(NSString *)user_id andUname:(NSString *)uname andFromWork:(BOOL)fromWork{
    [self setJis:jis andUser_id:user_id andUname:uname];
    _formWork = fromWork;
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    
    NSString *js =[NSString stringWithFormat:@"genjincallJs('%@','%@','%@','%@','%@')",model.data.token,_jis,_uid,_uanme,model.data.account];
    [XMHWebSignTools loadWebViewJs:webView];
    [_web evaluateJavaScript:js completionHandler:nil];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"genjinguke"]) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}
@end
