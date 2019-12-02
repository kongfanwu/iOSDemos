//
//  XMHEmployeeReportDetailVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHEmployeeReportDetailVC.h"
#import "TJStaffInfoView.h"
#import "TJSectionTbHeader.h"
#import "TJRequest.h"
#import <WebKit/WebKit.h>
#import "ShareWorkInstance.h"
#import "TJStaffDetailModel.h"
#import "TJStaffCell.h"
#import "XMHTJStaffView.h"
#import "XMHRankDetailVC.h"
#import "XMHMonthAndWeekModel.h"
@interface XMHEmployeeReportDetailVC ()<UITableViewDelegate,UITableViewDataSource, WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)UIView *tbHeaderView;
@property (nonatomic, strong)TJStaffInfoView *staffInfoView;
@property (nonatomic, strong)UIView *subHeaderView;
@property (nonatomic, strong)TJSectionTbHeader *section1;
@property (nonatomic, strong)TJSectionTbHeader *section2;
@property (nonatomic, strong)WKWebView * webView;
@property (nonatomic, strong)UIView * bottomView;
@property (nonatomic, strong)UIView *sectionView;
@property (nonatomic, strong)NSMutableArray *staffViewArr;
/** 时间类型 day week month */
@property (nonatomic, copy) NSString *timeType;
/** 时间段 */
@property (nonatomic, strong) NSArray *dateArr;

@property (nonatomic, strong)TJStaffDetailModel *staffDetailModel;
/** 请求参数 */
@property (nonatomic, strong)NSMutableDictionary * param;
@end

@implementation XMHEmployeeReportDetailVC
{
    TJStaffDetailModel *_staffDetailModel;
}
- (instancetype)initWithDateArr:(NSArray *)dateArr timeType:(NSString *)timeType
{
    if (self = [super init]) {
        _dateArr = dateArr;
        _timeType = timeType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _staffViewArr = [NSMutableArray array];
    [self initSubViews];
    [self requestData];
}

- (void)initSubViews
{
    [self.navView setNavViewTitle:@"员工详情" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.bottomView];
    
}
- (UIView *)tbHeaderView
{
    if (!_tbHeaderView) {
        _tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 742)];
        _tbHeaderView.backgroundColor = kColorE;
        [_tbHeaderView addSubview:self.staffInfoView];
        [_tbHeaderView addSubview:self.subHeaderView];
        [_tbHeaderView addSubview:self.sectionView];
        
    }
    return _tbHeaderView;
}
//  顾客信息
- (TJStaffInfoView *)staffInfoView
{
    if (!_staffInfoView) {
        _staffInfoView = loadNibName(@"TJStaffInfoView");
        _staffInfoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 113);
    }
    return _staffInfoView;
}
- (UIView *)subHeaderView
{
    if (!_subHeaderView) {
        _subHeaderView = [[UIView alloc] initWithFrame:CGRectMake(10, self.staffInfoView.bottom + 10, SCREEN_WIDTH - 20, 274)];
        _subHeaderView.backgroundColor = UIColor.whiteColor;
        [_subHeaderView addSubview:self.section1];
        [_subHeaderView addSubview:self.webView];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_subHeaderView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _subHeaderView.bounds;
        maskLayer.path = maskPath.CGPath;
        _subHeaderView.layer.mask = maskLayer;

    }
    return _subHeaderView;
}
- (TJSectionTbHeader *)section1
{
    if (!_section1) {
        _section1 = loadNibName(@"TJSectionTbHeader");
        _section1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 47);
        [_section1 updateTJSectionTbHeaderTitle:@"综合能力"];
    }
    return _section1;
}
- (TJSectionTbHeader *)section2
{
    if (!_section2) {
        _section2 = loadNibName(@"TJSectionTbHeader");
        _section2.frame = CGRectMake(0, 0, SCREEN_WIDTH -  20, 48);
        [_section2 updateTJSectionTbHeaderTitle:@"排名详情"];
    }
    return _section2;
}
-(UIView *)sectionView
{
    if (!_sectionView) {
        _sectionView = UIView.new;
        _sectionView.frame = CGRectMake(10, self.subHeaderView.bottom + 10, SCREEN_WIDTH -  20, 335);
        _sectionView.backgroundColor = UIColor.whiteColor;
        [_sectionView addSubview:self.section2];
        for (int i = 0; i< 5; i++) {
            XMHTJStaffView *view =  [[[NSBundle mainBundle] loadNibNamed:@"XMHTJStaffView" owner:nil options:nil] firstObject];
            view.frame = CGRectMake(0, self.section2.bottom + i * 57.6, _sectionView.width, 57.6);
            [_sectionView addSubview:view];
            [_staffViewArr safeAddObject:view];
        }
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_sectionView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _sectionView.bounds;
        maskLayer.path = maskPath.CGPath;
        _sectionView.layer.mask = maskLayer;
    }
    return _sectionView;
}
-(WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _section1.bottom, SCREEN_WIDTH, 227)];
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
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 69 - kSafeAreaBottom) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableHeaderView = self.tbHeaderView;
        _tbView.backgroundColor =  kColorE;
        _tbView.tableFooterView = UIView.new;
    }
    return _tbView;
}
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.tbView.bottom , SCREEN_WIDTH, 69)];
        _bottomView.backgroundColor = UIColor.whiteColor;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 5;
         btn.frame = CGRectMake(15, 13, SCREEN_WIDTH - 30, 44);
        [btn setTitle:@"排名详情" forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(17);
        btn.backgroundColor = kLabelText_Commen_Color_ea007e;
        __weak typeof(self) _self = self;
        [btn bk_addEventHandler:^(id sender) {
            __strong typeof(_self) self = _self;
            XMHRankDetailVC *vc = XMHRankDetailVC.new;
            vc.param = self.param;
            [self.navigationController pushViewController:vc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
    
    }
    return _bottomView;
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
    return  UITableViewCell.new;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark ------网络请求------

- (void)requestData
{
    WeakSelf
    [XMHProgressHUD showGifImage];

    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    _param = [[NSMutableDictionary alloc] init];
    [_param setValue:framId?framId:@"" forKey:@"fram_id"];
    [_param setValue:_dateArr.jsonData forKey:@"date"];
    [_param setValue:_timeType?_timeType:@"" forKey:@"type"];
    [_param setValue:_customerModel.account?_customerModel.account:@"" forKey:@"account"];
    
    [YQNetworking postWithUrl:[XMHHostUrlManager urlWithModuleType:XMHModuleTypeReport subUrl:kREPORT_EMPLOYEES_JIS_INFO] refreshRequest:YES cache:YES params:_param progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        if (isSuccess) {
            TJStaffDetailModel  * model = [TJStaffDetailModel yy_modelWithDictionary:obj.data];
            weakSelf.staffDetailModel = model;
            weakSelf.customerModel.rank1 = model.xiaoshouye_s;
            weakSelf.customerModel.rank2 = model.xiaohao_s;
            weakSelf.customerModel.rank3 = model.keci_s;
            weakSelf.customerModel.rank4 = model.chengjiao_s;
            weakSelf.customerModel.rank5 = model.xiaohaoxiangmu_s;
            [weakSelf.staffInfoView updateTJStaffInfoViewModel:model];
            [weakSelf.staffViewArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XMHTJStaffView *view = obj;
                [view updateTJStaffCellModel:weakSelf.customerModel index:idx];
            }];
            [weakSelf.tbView reloadData];
        }else{}
    }];
}
@end
