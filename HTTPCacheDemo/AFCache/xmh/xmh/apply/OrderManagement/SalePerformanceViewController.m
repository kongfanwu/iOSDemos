//
//  SalePerformanceViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SalePerformanceViewController.h"
#import "DateHeaderView.h"
#import "DatePickerView.h"
#import "JasonSearchView.h"
#import "SalePerformanceChoiceView.h"
#import "tempModel.h"
#import "OrderServiceCell.h"
#import "LOrderYejiListModel.h"
#import "SaleListRequest.h"
#import "LOrderDetailCell.h"
#import "LDatePickView.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "MzzJiSuanViewController.h"
#import "FWDDetailViewController.h"
#import "SalePerforManceHuikuanView.h"
#import "XMHCredentialSalesCell.h"
#import "XMHCredentiaSalesOrderMdoel.h"
@interface SalePerformanceViewController (){
//    DateHeaderView * _dateHeaderView;
//    DatePickerView * _dp;
    NSString *cstartTime;
    NSString *cendTime;
    JasonSearchView    *_searchView;
    
    SalePerformanceChoiceView   *_choiceView;
    SalePerforManceHuikuanView  *_huikuanView;
    __weak IBOutlet UITableView *tbView;
    
    __weak IBOutlet NSLayoutConstraint *tbTopConstraint;
    NSMutableArray *_arrSource;
    LOrderYejiListModel * _yejiListModel;
    NSString * _start;
    NSString * _end;
    NSString * _orderType;
    NSString * _q;
    NSString * _isFq;
    NSString * _page;
    LDatePickView * _datePickView;
}
@property (nonatomic, strong)NSArray * dateSource;
@end

@implementation SalePerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
   
    [self creatNav];
    [self initSubViews];
    _arrSource = [[NSMutableArray alloc]init];
    _fromStr = @"回款";
}
- (void)loadData
{
   
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    NSString * framID = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    [param setValue:account?account:@"" forKey:@"inId"];
    [param setValue:framID?framID:@"" forKey:@"fram_id"];
    [param setValue:_startTime?_startTime:@"" forKey:@"startTime"];
    [param setValue:_endTime?_endTime:@"" forKey:@"endTime"];
    [param setValue:_page?_page:@"1" forKey:@"page"];
    [param setValue:@"1" forKey:@"is_fq"];
    [param setValue:_q?_q:@"" forKey:@"q"];

    
    [SaleListRequest requestSaleYeJiListParam:param resultBlock:^(LOrderYejiListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            
            _yejiListModel = model;
            _choiceView.yejiListModel = model;
            _huikuanView.yejiListModel = model;
            NSDictionary * jsonDic = (NSDictionary *)model.yy_modelToJSONObject;
            _dateSource = [NSArray yy_modelArrayWithClass:[XMHCredentiaSalesOrderMdoel class] json:jsonDic[@"list"]];
            [tbView reloadData];
        }
    }];
}

- (void)creatNav{
//    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"销售业绩" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
//    nav.lineImageView.hidden = YES;
//    nav.backgroundColor = kBtn_Commen_Color;
//    nav.lbTitle.textColor = [UIColor whiteColor];
//    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nav];
    
    [self.navView setNavViewTitle:@"分期回款营收" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    
    
}
- (void)initSubViews{
    WeakSelf
    UIView *backGround =[[UIView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 54+100+15)];
    backGround.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGround];
//    _datePickView = [[LDatePickView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 44) dateBlock:^(NSString *start, NSString *end) {
//        _startTime = start;
//        _endTime = end;
//        if ([self.fromStr isEqualToString:@"回款"]) {
//            _isFq = @"1";
//        }
//        [weakSelf loadData];
//
//    }];
    _datePickView = [[LDatePickView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 44) startTime:self.startTime endTime:self.endTime dateBlock:^(NSString *start, NSString *end) {
        _startTime = start;
        _endTime = end;
        if ([self.fromStr isEqualToString:@"回款"]) {
            _isFq = @"1";
        }
        [weakSelf loadData];
    }];
    _datePickView.backgroundColor = RGBColorWithAlpha(255, 255, 255, 0.96);
    _datePickView.layer.shadowColor= RGBColorWithAlpha(51, 51, 51, 0.14).CGColor;
    _datePickView.layer.shadowOpacity = 1;
    _datePickView.layer.shadowRadius = 30;
    _datePickView.layer.cornerRadius = 10;
    [backGround addSubview:_datePickView];
    
    //销售营收/分期回款营收/销售服务营收 头部
    _choiceView = [[[NSBundle mainBundle] loadNibNamed:@"SalePerformanceChoiceView" owner:nil options:nil] firstObject];
    _choiceView.frame = CGRectMake(0, _datePickView.bottom+10, SCREEN_WIDTH, 100);
    _choiceView.SalePerformanceChoiceViewBlock = ^(NSString *index) {
        _isFq = index;
        [weakSelf loadData];
    };
    
    _huikuanView = [[[NSBundle mainBundle]loadNibNamed:@"SalePerforManceHuikuanView" owner:nil options:nil]firstObject];
    _huikuanView.frame =CGRectMake(0, _datePickView.bottom+10, SCREEN_WIDTH, 72);
    if ([self.fromStr isEqualToString:@"回款"]) {
        _isFq = @"1";
        backGround.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 54+72+10);
        [backGround addSubview:_huikuanView];
        [weakSelf loadData];
    }else{
        [backGround addSubview:_choiceView];
    }
    if (!_searchView) {
        _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, backGround.bottom+10, SCREEN_WIDTH, 45)withPlaceholder:@"姓名/手机号"];
        _searchView.searchBar.layer.cornerRadius = 3;
        _searchView.searchBar.layer.masksToBounds = YES;
        [self.view addSubview:_searchView];
    }
    __block JasonSearchView    *tempsearchView = _searchView;
    _searchView.searchBar.btnRightBlock = ^{
        _q = tempsearchView.searchBar.text;
        [weakSelf loadData];
    };
    [_searchView updateHaoKaFrame];
    _searchView.searchBar.btnleftBlock = ^{
        _q = @"";
        [weakSelf loadData];
    };
    tbTopConstraint.constant = _searchView.bottom;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHCredentialSalesCell *cell = [XMHCredentialSalesCell createCellWithTable:tableView];
    [cell configureWithModel:_dateSource[indexPath.row]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dateSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    LOrderYejiModel *model = _yejiListModel.list[indexPath.row];
//    if (_isFq.integerValue ==2) {
//        FWDDetailViewController * next = [[FWDDetailViewController alloc] init];
//        [self.navigationController pushViewController:next animated:NO];
//        next.comeFrom = @"DDGL";
//        next.ordernum = model.ordernum;
//    }else{
//        MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
//        [vc setOrderNum:model.ordernum andYemianStyle:YemianXiangQing andType:model.type andUid:[NSString stringWithFormat:@"%ld",model.user_id]withName:@""];
//        [self.navigationController pushViewController:vc animated:NO];
//    }
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
