//
//  BeautyManagerHomeVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyManagerHomeVC.h"
#import "BookManagerHomeCell.h"
#import "MineCellModel.h"
#import "RolesTools.h"
#import "BeautyCustomersVC.h"
#import "BeautyCFBillVC.h"
#import "BeautyCFBiaoVC.h"
#import "BeautyCFAnalyzeVC.h"
@interface BeautyManagerHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSArray * dataSource;
@end

@implementation BeautyManagerHomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    NSArray * jisLimit = @[@"8",@"9",@"10"];
    /** 美容师包含定制处方 和 处方订单 功能 */
    if ([jisLimit containsObject:mainrole]) {
         _dataSource = @[[MineCellModel createModelWithTitle:@"定制处方" icon:@"dingzhichufang"],[MineCellModel createModelWithTitle:@"处方订单" icon:@"chufangdingdan"],[MineCellModel createModelWithTitle:@"处方分析" icon:@"chufangfenxi"]];
    }
    /** 店长  包含 定制处方 处方订单  处方分析*/
    NSArray * allLimit = @[@"4",@"5",@"6"];
    if ([allLimit containsObject:mainrole]) {
         _dataSource = @[[MineCellModel createModelWithTitle:@"定制处方" icon:@"dingzhichufang"],[MineCellModel createModelWithTitle:@"处方订单" icon:@"chufangdingdan"],[MineCellModel createModelWithTitle:@"处方分析" icon:@"chufangfenxi"]];
    }
    
    /** 前台  店经理  管理层 包含 定制处方 处方订单  处方分析*/
    NSArray * oneLimit = @[@"1",@"3",@"7"];
    if ([oneLimit containsObject:mainrole]) {
        _dataSource = @[[MineCellModel createModelWithTitle:@"处方分析" icon:@"chufangfenxi"]];
    }
    [self initSubViews];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"美丽定制" backBtnShow:YES];
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
    if ([model.title isEqualToString:@"定制处方"]){
        BeautyCustomersVC *vc = [[BeautyCustomersVC alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
//        BeautyCFBiaoVC * next = [[BeautyCFBiaoVC alloc] init];
//        [self.navigationController pushViewController:next animated:NO];
    }else if ([model.title isEqualToString:@"处方订单"]){
        BeautyCFBillVC * next = [[BeautyCFBillVC alloc] init];
        [self.navigationController pushViewController:next animated:NO];
    }else if ([model.title isEqualToString:@"处方分析"]){
        BeautyCFAnalyzeVC * next = [[BeautyCFAnalyzeVC alloc] init];
        if ([RolesTools getUserMainRole] == 1 ||[RolesTools getUserMainRole] == 3) {
            next.pageType = BeautyPageTypeGL;
        }
        if ([RolesTools getUserMainRole] == 4 ||[RolesTools getUserMainRole] == 5 ||[RolesTools getUserMainRole] == 6 ||[RolesTools getUserMainRole] == 7) {
            next.pageType = BeautyPageTypeDZ;
        }
        if([RolesTools getUserMainRole] == 3 ||[RolesTools getUserMainRole] == 7){
            next.pageType = BeautyPageTypeDJLandQT;
        }
        next.mainRole = [RolesTools getUserMainRole];
        [self.navigationController pushViewController:next animated:NO];
    }
}
@end
