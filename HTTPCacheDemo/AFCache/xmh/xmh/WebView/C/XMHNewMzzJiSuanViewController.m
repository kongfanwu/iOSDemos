//
//  XMHNewMzzJiSuanViewController.m
//  xmh
//
//  Created by KFW on 2019/4/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHNewMzzJiSuanViewController.h"


#import <WebKit/WebKit.h>
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "OrderManagementViewController.h"
#import "OrderSaleViewController.h"
#import "XMHNormalOrderManagementVC.h"
#import "XMHSalesOrderVC.h"
#import "XMHCredentiaManageBossVC.h"
#import "XMHCredentiaManageVenditionVC.h"
@interface XMHNewMzzJiSuanViewController ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>
@property (nonatomic , strong) WKWebView *web;
@property (nonatomic ,copy) NSString *price;
@property (nonatomic ,copy) NSString *user_id;
@property (nonatomic ,copy) NSString *orderNum;
@property (nonatomic ,copy) NSString *customerName;
@property (nonatomic ,copy) NSString *zt;
@property (nonatomic ,copy) NSString *uid;
@property (nonatomic ,assign) NSUInteger type;
@property (nonatomic ,strong)UIView *backGroundTopView;
@property (nonatomic ,strong)NSDictionary *orderDic;
@property (nonatomic ,copy) NSString *name;//操作类型:如结算..
@end


@implementation XMHNewMzzJiSuanViewController
{
    customNav *nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self creatNav];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[_web configuration].userContentController  removeScriptMessageHandlerForName:@"SaleServiecDetailCallback"];
    [[_web configuration].userContentController  removeScriptMessageHandlerForName:@"goindex"];
    [[_web configuration].userContentController  removeScriptMessageHandlerForName:@"godetails"];
    [[_web configuration].userContentController  removeScriptMessageHandlerForName:@"goBackList"];
    [[_web configuration].userContentController  removeScriptMessageHandlerForName:@"openSaleOrder"];
    [[_web configuration].userContentController  removeScriptMessageHandlerForName:@"ReverseClick"];
    [[_web configuration].userContentController  removeScriptMessageHandlerForName:@"gobackOrderManagementVC"];
}

-(UIView *)backGroundTopView
{
    if (!_backGroundTopView) {
        _backGroundTopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _backGroundTopView.backgroundColor = kBtn_Commen_Color;
    }
    return _backGroundTopView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatNav{
    nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"详情页" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lineImageView.hidden = YES;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    _backGroundTopView = [[UIView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 30)];
    _backGroundTopView.backgroundColor =kBtn_Commen_Color;
    [self.view addSubview:_backGroundTopView];
    
}

-(void)pop{
    if (_popToOrderMainPageVC) {
        _popToOrderMainPageVC();
        return;
    }
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)setOrderNum:(NSString *)orderNum andYemianStyle:(YemianStyle )yemianStyle andType:(NSUInteger)type andUid:(NSString *)uid withName:(NSString *)name{
    
    [self creatNet];
    _orderNum = orderNum;
    _yemianStyle = yemianStyle;
    _uid = uid;
    _type = type;
    _name = name;
    //tangyf begin 2018-11-29
    if(_yemianStyle == YemianZhongZhi)
    {
        [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sales/stopNew.html",SERVER_H5]]]];
        return;
    }
    //tangyf end
    if (type ==1) {
        //sales/detailsNew.html 替换原来的sales/details.html
        [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sales/detailsNew.html",SERVER_H5]]]];
    }else if (type ==2){
        [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sales/details_zhihuanNew.html",SERVER_H5]]]];
    }else if (type ==3){
        [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sales/gexingInfor.html",SERVER_H5]]]];
    }else{
        [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sales/detailsNew.html",SERVER_H5]]]];
    }
}
//逆向开单分期
-(void)setOrderDic:(NSDictionary *)dic withType:(NSUInteger )type andYemianStyle:(YemianStyle )yemianStyle wiTitle:(NSString *)title{
    
    [self creatNet];
    nav.lbTitle.text = title;
    self.orderDic = dic;
    _yemianStyle = yemianStyle;
    _type = type;
    [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@reverse/pay.html",SERVER_H5]]]];
}
//逆向开单详情页
-(void)setOrderDetailNum:(NSString *)orderNum andYemianStyle:(YemianStyle )yemianStyle
{
    [self creatNet];
    _yemianStyle = yemianStyle;
    _orderNum = orderNum;
    [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sales/detailsNew.html",SERVER_H5]]]];
}
- (void)setFWDOrderNum:(NSString *)orderNum
{
    _orderNum = orderNum;
    [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@serv/detailsNew.html",SERVER_H5]]]];
}
- (void)setOrderNum:(NSString *)orderNum  andZt:(NSString *)zt{
    [self creatNet];
    _orderNum = orderNum;
    _zt = zt;
//    [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@serv/details.html",SERVER_H5]]]];
    [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@serv/detailsNew.html",SERVER_H5]]]];
    
}
-(void)creatNet{
    if (!_web) {
        _web = [[WKWebView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav )];
        _web.navigationDelegate = self;
        _web.UIDelegate = self;
        _web.backgroundColor = [UIColor clearColor];
        _web.layer.cornerRadius = 6;
        _web.layer.masksToBounds = YES;
        [[_web configuration].userContentController addScriptMessageHandler:self name:@"SaleServiecDetailCallback"];
        [[_web configuration].userContentController addScriptMessageHandler:self name:@"goindex"];
        [[_web configuration].userContentController addScriptMessageHandler:self name:@"godetails"];
        [[_web configuration].userContentController addScriptMessageHandler:self name:@"goBackList"];
        [[_web configuration].userContentController addScriptMessageHandler:self name:@"openSaleOrder"];
        [[_web configuration].userContentController addScriptMessageHandler:self name:@"ReverseClick"];
        [[_web configuration].userContentController addScriptMessageHandler:self name:@"gobackOrderManagementVC"];
       
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
        }];
        //        [self.view addSubview:_backGroundTopView];
        [self.view addSubview:_web];
        //        [self.view bringSubviewToFront:_web];
    }
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [XMHProgressHUD showGifImage];
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [XMHProgressHUD dismiss];
    
    if (_zt) {
        //服务单
        LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
        NSString *js =[NSString stringWithFormat:@"jisuan('%@','%@','%@','%@')",model.data.token,_orderNum,[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.function_id],_zt];
        [XMHWebSignTools loadWebViewJs:webView];
        [_web evaluateJavaScript:js completionHandler:nil];
    }else{
        //销售单
        LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
        switch (_yemianStyle) {
            case YemianXiangQing:
            {
                NSString *js =[NSString stringWithFormat:@"jisuan('%@','%@','%@','%@')",_orderNum,model.data.token,@"1",[ShareWorkInstance shareInstance].join_code];
                [XMHWebSignTools loadWebViewJs:webView];
                [_web evaluateJavaScript:js completionHandler:nil];
            }
                break;
            case YemianJieSuan:
            {
                NSString *js =[NSString stringWithFormat:@"jisuan('%@','%@','%@','%@')",_orderNum,model.data.token,@"2",[ShareWorkInstance shareInstance].join_code];
                [XMHWebSignTools loadWebViewJs:webView];
                [_web evaluateJavaScript:js completionHandler:nil];
                NSString *js1 =[NSString stringWithFormat:@"jiesuan('%@','%@','%@','%@','%@')",_uid,model.data.token,_orderNum,[ShareWorkInstance shareInstance].join_code,[NSString stringWithFormat:@"%ld",_type]];
                [XMHWebSignTools loadWebViewJs:webView];
                [_web evaluateJavaScript:js1 completionHandler:nil];
               
            }
                break;
            case YemianHuanKuan:
            {
                NSString *js =[NSString stringWithFormat:@"jisuan('%@','%@','%@','%@')",_orderNum,model.data.token,@"3",[ShareWorkInstance shareInstance].join_code];
                [XMHWebSignTools loadWebViewJs:webView];
                [_web evaluateJavaScript:js completionHandler:nil];
            }
                break;
            case YemianZhongZhi:
            {
                /** 参数1 表示立即还款自动点击 */
                NSString *js =[NSString stringWithFormat:@"jisuan('%@','%@','%@','%@','1')",_orderNum,model.data.token,@"4",[ShareWorkInstance shareInstance].join_code];
                [XMHWebSignTools loadWebViewJs:webView];
                [_web evaluateJavaScript:js completionHandler:nil];
            }
                break;
            case YemianBuQian:
            {
                NSString *js =[NSString stringWithFormat:@"jisuan('%@','%@','%@','%@')",_orderNum,model.data.token,@"5",[ShareWorkInstance shareInstance].join_code];
                [XMHWebSignTools loadWebViewJs:webView];
                [_web evaluateJavaScript:js completionHandler:nil];
                NSString *js1 =[NSString stringWithFormat:@"jiesuan('%@','%@','%@','%@','%@')",_uid,model.data.token,_orderNum,[ShareWorkInstance shareInstance].join_code,[NSString stringWithFormat:@"%ld",_type]];
                [XMHWebSignTools loadWebViewJs:webView];
                [_web evaluateJavaScript:js1 completionHandler:nil];
            }
                break;
            case YemianFenQi:
            {
                /** 快速开单分期 */
                NSString *js =[NSString stringWithFormat:@"jisuan('%@')",_orderDic.jsonData];
                [XMHWebSignTools loadWebViewJs:webView];
                [_web evaluateJavaScript:js completionHandler:nil];
            }
                break;
            case YemianFenQiXiangQing:
            {
                /** 快速开单分期 */
                NSString *js =[NSString stringWithFormat:@"jisuan('%@','%@')",_orderNum,model.data.token];
                [XMHWebSignTools loadWebViewJs:webView];
                [_web evaluateJavaScript:js completionHandler:nil];
            }
                break;
        }
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //h5提交失败、取消按钮回调
    if ([message.name isEqualToString:@"SaleServiecDetailCallback"]) {
        if ([message.body isKindOfClass:[NSString class]]) {
//            NSString *str = (NSString *)message.body;
//            [[[MzzHud alloc] initWithTitle:@"提示" message:str centerButtonTitle:@"知道了" click:^(NSInteger index) {
//                for (UIViewController *temp in self.navigationController.viewControllers) {
//                    if ([temp isKindOfClass:[XMHNormalOrderManagementVC class]]) {
//                        [self.navigationController popToViewController:temp animated:NO];
//                    }else if ([temp isKindOfClass:[XMHCredentiaManageBossVC class]]){
//                        [self.navigationController popToViewController:temp animated:NO];
//                    }
//                }
//                
//            }]show];
        }
    }
    if ([message.name isEqualToString:@"openSaleOrder"]) {
        // 开销售单
    }
    if ([message.name isEqualToString:@"gobackOrderManagementVC"]) {
        //返回订单首页
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[XMHNormalOrderManagementVC class]]) {
                [self.navigationController popToViewController:temp animated:NO];
            }else if ([temp isKindOfClass:[XMHCredentiaManageBossVC class]]){
                [self.navigationController popToViewController:temp animated:NO];
            }
        }
    }
    //返回上一页 ,补齐项目后返回首页
    if ([message.name isEqualToString:@"goindex"]) {
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[XMHNormalOrderManagementVC class]] && _entrance == 0) {
                [self.navigationController popToViewController:temp animated:NO];
            }else if ([temp isKindOfClass:[XMHCredentiaManageVenditionVC class]]){
                [self.navigationController popToViewController:temp animated:NO];
            }
        }
    }
    if ([message.name isEqualToString:@"goBackList"]) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    //跳转详情页
    if ([message.name isEqualToString:@"godetails"]) {
        if (_zt) {
            _zt = @"1";
            [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@serv/detailsNew.html",SERVER_H5]]]];
        }else{
            _yemianStyle = YemianXiangQing;
            if (_type ==1) {
                [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sales/detailsNew.html",SERVER_H5]]]];
            }else if (_type ==2){
                [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sales/details_zhihuanNew.html",SERVER_H5]]]];
            }else if (_type ==3){
                [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sales/gexingInfor.html",SERVER_H5]]]];
            }else if (_type == 6){
                _yemianStyle = YemianFenQiXiangQing;
                _orderNum = message.body;
                [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@reverse/details.html",SERVER_H5]]]];
            }else{
                [_web loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sales/detailsNew.html",SERVER_H5]]]];
            }
        }
    }
    //补齐项目,查看详情后再次点击补齐项目的入口.需要H5和产品沟通是否还需要跳转再次补齐一次项目
    if ([message.name isEqualToString:@"ReverseClick"]) {
        
        XMHSalesOrderVC *vc = [[XMHSalesOrderVC alloc]init];
        vc.selectModel = _customer;//传入顾客
        vc.yingfuPrice = [self.orderDic safeObjectForKey:@"shifujine"];;
        vc.storeCode = [self.orderDic safeObjectForKey:@"store_code"];
        vc.ordernum = [self.orderDic safeObjectForKey:@"ordernum"];
        [self.navigationController pushViewController:vc animated:NO];
        
    }
}

@end
