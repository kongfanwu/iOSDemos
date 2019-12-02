//
//  LSmartDetailController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LSmartDetailController.h"
#import "LSmartDeatilHeaderView.h"
#import "LSmartJiShiCell.h"
#import "LSmartDeatilSectionHeaderView.h"
#import "LFreezeSubmitView.h"
#import "ZFRequest.h"
#import "LSmartDeatilSectionHeaderView.h"
@interface LSmartDetailController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LSmartDetailController
{
    UITableView * _tb;
    LFreezeSubmitView * _submit;
    LAllocationDetaiModel * _detailModel;
    LSmartDeatilHeaderView * _headerView;
    LSmartDeatilSectionHeaderView * _sectionHeader;
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self initSubViews];
}
-(void)setModel:(LTempModel *)model
{
    WeakSelf
    _model = model;
    [ZFRequest requestAllocationDetailUserId:model.userid jis:model.jis joincode:model.joincode resultBlock:^(LAllocationDetaiModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _detailModel = model;
            [weakSelf updateUI];
        }else{
            
        }
    }];
}
- (void)updateUI
{
    _headerView.model = _detailModel;
    _headerView.listModel =  [LAllocationListModel AllocationListModelAccountid:_detailModel.first.account_id jis:_detailModel.first.jis jis_cql:_detailModel.first.jis_cql jis_hkdj:_detailModel.first.jis_hkdj jis_xsyj:_detailModel.first.jis_xsyj jis_xhxm:_detailModel.first.jis_xhxm jis_ddpc:_detailModel.first.jis_ddpc jis_img:_detailModel.first.jis_img jis_name:_detailModel.first.jis_name jis_max:_detailModel.first.jis_max jis_min:_detailModel.first.jis_min];;
    [_tb reloadData];
}
- (void)initSubViews
{
    [self creatNav];
    [self createTableView];
    [self createSubmitView];
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"分配详情" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)createSubmitView
{
    LFreezeSubmitView * submit = [[[NSBundle mainBundle]loadNibNamed:@"LFreezeSubmitView" owner:nil options:nil]lastObject];
    submit.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
    _submit = submit;
    [submit.submit setTitle:@"确认" forState:UIControlStateNormal];
    [submit.submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
}
- (void)submit
{
    WeakSelf
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSMutableDictionary *ujDic = [NSMutableDictionary dictionary];
    ujDic[@"user_id"] = [NSString stringWithFormat:@"%ld",_headerView.model.first.user_id];
    ujDic[@"jis"] = _headerView.listModel.jis;
    params[@"data"]  = [NSArray arrayWithObjects:ujDic, nil].jsonData;
    [ZFRequest requestYiJianFenPeiParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [XMHProgressHUD showOnlyText:@"分配成功"];
            [weakSelf performSelector:@selector(back) withObject:nil afterDelay:2];
        }
    }];
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, Heigh_View_normal - 70)];
    LSmartDeatilHeaderView * headerView =  [[[NSBundle mainBundle]loadNibNamed:@"LSmartDeatilHeaderView" owner:nil options:nil]lastObject];
    _headerView = headerView;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 205);
    _tb.tableHeaderView = headerView;
    _tb.dataSource = self;
    _tb.delegate = self;
    [self.view addSubview:_tb];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _detailModel.jis_list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"cellName";
    LSmartJiShiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LSmartJiShiCell" owner:nil options:nil]lastObject];
    }
    cell.LSmartJiShiCellBlock = ^(LAllocationListModel *model) {
        NSInteger index = [_detailModel.jis_list indexOfObject:model];
        [_detailModel.jis_list replaceObjectAtIndex:index withObject:_headerView.listModel];

        [_tb reloadData];
         _headerView.listModel = model;
    };
    cell.model = _detailModel.jis_list[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!_sectionHeader) {
       _sectionHeader =  [[[NSBundle mainBundle]loadNibNamed:@"LSmartDeatilSectionHeaderView" owner:nil options:nil]lastObject];
    }
    _sectionHeader.lb.text = [NSString stringWithFormat:@"匹配技师(%ld)",_detailModel.count];
    return _sectionHeader;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

@end
