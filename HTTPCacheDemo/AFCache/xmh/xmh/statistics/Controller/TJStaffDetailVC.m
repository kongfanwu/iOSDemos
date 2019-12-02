//
//  TJStaffDetailVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/6.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJStaffDetailVC.h"
#import "TJStaffInfoView.h"
#import "TJSectionTbHeader.h"
#import "TJStaffCell.h"
#import "TJRequest.h"
#import <WebKit/WebKit.h>
#import "ShareWorkInstance.h"
#import "TJStaffDetailModel.h"
@interface TJStaffDetailVC ()<UITableViewDelegate,UITableViewDataSource, WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)UIView *tbHeaderView;
@property (nonatomic, strong)TJStaffInfoView *staffInfoView;
@property (nonatomic, strong)TJSectionTbHeader *section1;
@property (nonatomic, strong)TJSectionTbHeader *section2;
@property (nonatomic, strong)WKWebView * webView;
@end

@implementation TJStaffDetailVC
{
    TJStaffDetailModel *_staffDetailModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    [self requestData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"员工详情" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.tbView];
    
}
- (UIView *)tbHeaderView
{
    if (!_tbHeaderView) {
        _tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 480)];
        _tbHeaderView.backgroundColor = kColorE;
        [_tbHeaderView addSubview:self.staffInfoView];
        [_tbHeaderView addSubview:self.section1];
        [_tbHeaderView addSubview:self.webView];
        [_tbHeaderView addSubview:self.section2];
        
    }
    return _tbHeaderView;
}
- (TJStaffInfoView *)staffInfoView
{
    if (!_staffInfoView) {
        _staffInfoView = loadNibName(@"TJStaffInfoView");
        _staffInfoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    }
    return _staffInfoView;
}
- (TJSectionTbHeader *)section1
{
    if (!_section1) {
        _section1 = loadNibName(@"TJSectionTbHeader");
        _section1.frame = CGRectMake(0, _staffInfoView.bottom + 10, SCREEN_WIDTH, 48);
        [_section1 updateTJSectionTbHeaderTitle:@"综合能力"];
    }
    return _section1;
}
- (TJSectionTbHeader *)section2
{
    if (!_section2) {
        _section2 = loadNibName(@"TJSectionTbHeader");
         _section2.frame = CGRectMake(0, _webView.bottom + 10, SCREEN_WIDTH, 48);
         [_section2 updateTJSectionTbHeaderTitle:@"排名详情"];
    }
    return _section2;
}
-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _section1.bottom, SCREEN_WIDTH, 270)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = NO;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@statistics/staff.html",SERVER_H5]]]];
    }
    return _webView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableHeaderView = self.tbHeaderView;
        _tbView.backgroundColor = kColorE;
    }
    return _tbView;
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
    NSString * jsStr = [NSString stringWithFormat:@"staffCallIOS('%@','%@','%@','%@')",_staffDetailModel.jishuli,_staffDetailModel.guanlili,_staffDetailModel.xiaoshouli,_staffDetailModel.fuwuli];
    [XMHWebSignTools loadWebViewJs:webView];
    [_webView evaluateJavaScript:jsStr completionHandler:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"...................页面加载失败时调用");
}

#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kTJStaffCell = @"kTJStaffCell";
    TJStaffCell * taffCell = [tableView dequeueReusableCellWithIdentifier:kTJStaffCell];
    if (!taffCell) {
        taffCell = loadNibName(@"TJStaffCell");
    }
    [taffCell updateTJStaffCellModel:_customerModel index:indexPath.row];
    return taffCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}
#pragma mark ------网络请求------
- (void)requestData
{
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [param setValue:_startTime?_startTime:@"" forKey:@"start_time"];
    [param setValue:_endTime?_endTime:@"" forKey:@"end_time"];
    [param setValue:_customerModel.account?_customerModel.account:@"" forKey:@"account"];
    [TJRequest requestTJStaffDataParam:param resultBlock:^(TJStaffDetailModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _staffDetailModel = model;
            model.store_name = _customerModel.store_name;
            _customerModel.rank1 = model.xiaoshouye_s;
            _customerModel.rank2 = model.xiaohao_s;
            _customerModel.rank3 = model.keci_s;
            _customerModel.rank4 = model.chengjiao_s;
            _customerModel.rank5 = model.xiaohaoxiangmu_s;
            [_staffInfoView updateTJStaffInfoViewModel:model];
            [_tbView reloadData];
        }else{}
    }];
}
@end
