//
//  XMHActionCenterVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHActionCenterVC.h"
#import "BookManagerHomeCell.h"
#import "MineCellModel.h"
#import "XMHCouponListVC.h"
#import "XMHActionCenterSendVC.h"

@interface XMHActionCenterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)NSArray * dataSource;
@end

@implementation XMHActionCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView setNavViewTitle:@"优惠券" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self createSubViews];
}

- (void)createSubViews{
    _dataSource = @[[MineCellModel createModelWithTitle:@"创建" icon:@"huodongzhongxin_chuangjian"],[MineCellModel createModelWithTitle:@"发放" icon:@"huodongzhongxin_fafang"]];
    
    [self.view addSubview:self.tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"BookManagerHomeCell" bundle:nil] forCellReuseIdentifier:@"BookManagerHomeCell"];
    
}
#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 146;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MineCellModel * model = _dataSource[indexPath.row];
    if ([model.title isEqualToString:@"创建"]) {
        XMHCouponListVC *vc = [[XMHCouponListVC alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
    }else if ([model.title isEqualToString:@"发放"]){
        XMHActionCenterSendVC * next = [[XMHActionCenterSendVC alloc] init];
        [self.navigationController pushViewController:next animated:NO];
    }
    
}
#pragma mark -- UITableViewDataSource

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kColorF5F5F5;
        _tableView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, self.view.frame.size.height);
       
    }
    return _tableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
