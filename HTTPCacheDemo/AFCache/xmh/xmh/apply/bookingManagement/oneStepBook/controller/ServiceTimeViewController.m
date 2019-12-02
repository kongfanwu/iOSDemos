//
//  ServiceTimeViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ServiceTimeViewController.h"
#import "ServiceStateView.h"
#import "OneDateView.h"
#import <WebKit/WebKit.h>
#import "MzzHud.h"
#import "ShareBookInstance.h"
#import "LolJiShiTimeModel.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
@interface ServiceTimeViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end

@implementation ServiceTimeViewController
{
    customNav * _nav;
    ServiceStateView * _stateView;
    OneDateView * _date ;
    WKWebView * _webView;
    NSString * _dateStr;
    MzzHud * _hub;
    LolJiShiTimeModel * _model;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self initSubViews];
}
- (void)setCustomerModel:(CustomerMessageModel *)customerModel{
    _customerModel = customerModel;
}
- (void)initSubViews
{
    [self creatNav];
    [self createServiceStateView];
    [self createWebView];
    [self createDateView];
}
- (void)creatNav
{
    _nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"服务技师时间" withleftImageStr:@"back" withRightStr:nil];
    [_nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}
- (void)createServiceStateView
{
    _stateView = [[ServiceStateView alloc] initWithFrame:CGRectMake(0, Heigh_Nav + 1, SCREEN_WIDTH, 44)];
    _stateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_stateView];
}
- (void)createDateView
{
    _date = [[OneDateView alloc] initWithFrame:CGRectMake(0, Heigh_Nav + 1 + 44 +1, SCREEN_WIDTH, 44)];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter stringFromDate:date];
    __block NSString * endStr = [dateFormatter stringFromDate:date];
    _dateStr = endStr;
    __block WKWebView * weakWebView = _webView;
    _date.OneDateViewBlock = ^(NSString *dateStr,NSIndexPath * path) {
        NSRange range;
        if (path.row ==0){
            range = NSMakeRange(2, 5);
        }else{
            range = NSMakeRange(3, 5);
        }
        endStr = [endStr stringByReplacingCharactersInRange:NSMakeRange(4, 6) withString:[NSString stringWithFormat:@"-%@",[[dateStr substringWithRange:range] stringByReplacingOccurrencesOfString:@"/" withString:@"-"]]];
        _dateStr = endStr;
//#warning TODO: 加入菊花
        [weakWebView reload];
    };
    [self.view addSubview:_date];
}
- (void)createWebView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav + 1 + 44 +1 + 44, SCREEN_WIDTH, SCREEN_HEIGHT - _date.bottom)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@yuyue/tableIos.html",SERVER_H5]]]];
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"getMessage"];
    [self.view addSubview:_webView];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSMutableString * endTime = [[NSMutableString alloc] init];
    //code
    [_hub show];
    NSLog(@"name = %@, body = %@", message.name, message.body);
    LolJiShiTimeModel * model = [[LolJiShiTimeModel alloc] init];
    
    NSData * jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        NSLog(@"解析失败");
    }
    model.name = dic[@"name"];
//    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString * selectTime = dic[@"time"];
    NSArray * arrTime = [selectTime componentsSeparatedByString:@":"];
    NSString * hour = @"";
    if (arrTime.count >=1) {
        if ([arrTime[0] length] ==1) {
            hour = [NSString stringWithFormat:@"0%@",arrTime[0]];
        }else{
            hour = arrTime[0];
        }
    }
    [endTime appendString:hour];
    [endTime appendString:@":"];
    [endTime appendString:arrTime[1]];
    [endTime appendString:@":"];
    [endTime appendString:@"00"];
    model.time = [NSString stringWithFormat:@"%@ %@",[_dateStr substringWithRange:NSMakeRange(0, 10)],endTime];
    model.uid = dic[@"u_is"];
    _model = model;
    
    _hub = [[MzzHud alloc] initWithTitle:@"" message:@"您是否确认预约此时间进行服务" leftButtonTitle:@"放弃预约" rightButtonTitle:@"立即预约" click:^(NSInteger index) {
        if (index ==0) {  //放弃预约
            //            [_hub dismiss];
        }else if(index ==1){ // 立即预约
            if (_ServiceTimeViewControllerBlock) {
                _ServiceTimeViewControllerBlock(_model);
            }
            [self back];
            //            [ShareBookInstance shareInstance].jiShiTimeModel = _model;
        }
    }];
    
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面开始加载时调用");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................当内容开始返回时调用");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载完成之后调用");
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * token = model.data.token;
    NSString * jsStr = [NSString stringWithFormat:@"callIos('%@','%@','%@','%@','%@')",token,[NSString stringWithFormat:@"%ld",_customerModel.uid],_customerModel.join_code,_customerModel.store_code,_dateStr];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    MzzLog(@"...................页面加载失败时调用");
}
//wk被terminate时调用
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//移除
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"getMessage"];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
