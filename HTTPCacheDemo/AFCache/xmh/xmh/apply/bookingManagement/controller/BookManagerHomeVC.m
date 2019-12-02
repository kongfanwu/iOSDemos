//
//  BookManagerHomeVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookManagerHomeVC.h"
#import "BookManagerHomeCell.h"
#import "MineCellModel.h"
#import "RolesTools.h"
#import "BookFastVC.h"
#import "BookBillHomeVC.h"
#import "BookAnalyzeVC.h"
#import "BookChartHomeVC.h"
@interface BookManagerHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSArray * dataSource;
@end

@implementation BookManagerHomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;
    /** 一键预约 预约订单 预约分析 */
    NSArray * allRoles = @[@"4",@"5",@"6",@"8",@"9",@"10"]; /** 技术店长、销售店长、售前店长、售后美容师、售前美容师、售中美容师 */
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    if ([allRoles containsObject:mainrole]) {
        _dataSource = @[[MineCellModel createModelWithTitle:@"一键预约" icon:@"yygl_yijianyuyue"],[MineCellModel createModelWithTitle:@"预约订单" icon:@"yygl_yuyuedingdan"],[MineCellModel createModelWithTitle:@"预约分析" icon:@"yygl_yuyuefenxi"]];
    }
    /** 预约分析 预约表  */
    NSArray * subRoles = @[@"7",@"1",@"2",@"3"];/** 前台、管理层 财务人员 店经理 */
    if ([subRoles containsObject:mainrole]) {
       _dataSource = @[[MineCellModel createModelWithTitle:@"预约分析" icon:@"yygl_yuyuefenxi"],[MineCellModel createModelWithTitle:@"预约表" icon:@"yygl_yuyuebiao"]];
    }
    [self initSubViews];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"预约管理" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.tbView];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorF5F5F5;
    }
    return _tbView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kBookManagerHomeCell = @"kBookManagerHomeCell";
    BookManagerHomeCell * cell = [tableView dequeueReusableCellWithIdentifier:kBookManagerHomeCell];
    if (!cell) {
        cell = loadNibName(@"BookManagerHomeCell");
    }
    [cell updatecellModel:_dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 146.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCellModel * model = _dataSource[indexPath.row];
    if ([model.title isEqualToString:@"一键预约"]) {
        BookFastVC * fastVC = [[BookFastVC alloc] init];
        [self.navigationController pushViewController:fastVC animated:NO];
    }else if ([model.title isEqualToString:@"预约订单"]){
        BookBillHomeVC * billHomeVC = [[BookBillHomeVC alloc] init];
        [self.navigationController pushViewController:billHomeVC animated:NO];
    }else if ([model.title isEqualToString:@"预约分析"]){
        BookAnalyzeVC * analyzeVC = [[BookAnalyzeVC alloc] init];
        BookAnalyzePageType  pageType;
        if ([RolesTools getUserMainRole] == 1) {
            pageType = BookAnalyzePageTypeManagement;
        }else if([RolesTools getUserMainRole] == 3){
            pageType = BookAnalyzePageTypeDJL;
        }else if ([RolesTools getUserMainRole] == 4 || [RolesTools getUserMainRole] == 5||[RolesTools getUserMainRole] == 6 || [RolesTools getUserMainRole] == 7){
            pageType = BookAnalyzePageTypeDZ;
        }else {
            pageType = BookAnalyzePageTypeStaff;
        }
        analyzeVC.pageType = pageType;
        [self.navigationController pushViewController:analyzeVC animated:NO];
    }else if ([model.title isEqualToString:@"预约表"]){
        BookChartHomeVC * chartVC = [[BookChartHomeVC alloc] init];
        [self.navigationController pushViewController:chartVC animated:NO];
    }else{}
}
@end
