//
//  CustomerActiveDetailVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/10.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerActiveDetailVC.h"
#import "CustomerReportCell.h"
#import "TJStaffInfoView.h"
#import "TJRequest.h"
#import "TJCustomerActiveDetailModel.h"
@interface CustomerActiveDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)TJStaffInfoView *staffInfoView;
@property (nonatomic, strong)UIView *tbHeaderView;
@end

@implementation CustomerActiveDetailVC
{
    TJCustomerActiveDetailModel * _customerActiveDetailModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    [self requestData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"顾客详情" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.tbView];
    
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
- (TJStaffInfoView *)staffInfoView
{
    if (!_staffInfoView) {
        _staffInfoView = loadNibName(@"TJStaffInfoView");
        _staffInfoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    }
    return _staffInfoView;
}
- (UIView *)tbHeaderView
{
    if (!_tbHeaderView) {
        _tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        _tbHeaderView.backgroundColor = kColorE;
        [_tbHeaderView addSubview:self.staffInfoView];
    }
    return _tbHeaderView;
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kCustomerReportCell = @"kCustomerReportCell";
    CustomerReportCell * customerReportCell = [tableView dequeueReusableCellWithIdentifier:kCustomerReportCell];
    if (!customerReportCell) {
        customerReportCell = loadNibName(@"CustomerReportCell");
    }
    [customerReportCell updateCustomerReportCellCustomerActiveDetailModel:_customerActiveDetailModel row:indexPath.row];
    return customerReportCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 3 ? 110.0f:90.0f;
}
- (void)requestData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_startTime?_startTime:@"" forKey:@"start_time"];
    [param setValue:_endTime?_endTime:@"" forKey:@"end_time"];
    [param setValue:_customerActiveModel.user_id?_customerActiveModel.user_id:@"" forKey:@"user_id"];
    [TJRequest requestTJCustomerActiveDetailDataParam:param resultBlock:^(TJCustomerActiveDetailModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _customerActiveDetailModel = model;
//            _customerActiveDetailModel.xiaohaoxiangmushu = _customerActiveModel.xiangmushu;
//            _customerActiveDetailModel.xiaofeijine = _customerActiveModel.xiaofeijine;
//            _customerActiveDetailModel.xiaofeicishu = _customerActiveModel.xiaofeicishu;
//            _customerActiveDetailModel.haokadanjia = _customerActiveModel.haokadanjia;
//            _customerActiveDetailModel.daodiancishu = _customerActiveModel.daodiancishu;
//            _customerActiveDetailModel.xiaohaojine = _customerActiveModel.xiaohaojine;
            _customerActiveDetailModel.name = _customerActiveModel.name;
            _customerActiveDetailModel.store_name = _customerActiveModel.store_name;
            [_staffInfoView updateTJStaffInfoViewCustomerActiveDetailModel:_customerActiveDetailModel];
            [_tbView reloadData];
        }else{}
    }];
}
@end
