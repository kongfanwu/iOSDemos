//
//  LSelectApprovalController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LSelectApprovalController.h"
#import "LFreezeHeaderView.h"
#import "LFreezeCell6.h"
#import "LFreezeSubmitView.h"
@interface LSelectApprovalController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation LSelectApprovalController
{
    UITableView * _tb;
    LApprocePersonModel * _selectModel;
    LFreezeSubmitView * _submit;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /** nav */
    [self.navView setNavViewTitle:@"选择审批人" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self initSubViews];
}
- (void)initSubViews
{
    [self createNav];
    [self createtabelView];
    [self createSubmitView];
}
- (void)createSubmitView
{
    LFreezeSubmitView * submit = [[[NSBundle mainBundle]loadNibNamed:@"LFreezeSubmitView" owner:nil options:nil]lastObject];
    submit.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
    _submit = submit;
    [submit.submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
}
- (void)submit
{
    if (_LSelectApprovalControllerBlock) {
        _LSelectApprovalControllerBlock(_selectModel);
    }
    [self back];
}
- (void)setApprocePersonList:(NSArray<LApprocePersonModel *> *)approcePersonList
{
    _approcePersonList = approcePersonList;
    for (LApprocePersonModel * model in approcePersonList) {
        model.isSelect = NO;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
       [_tb reloadData];
    });
}
- (void)createNav
{
//    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"选择审批人" withleftImageStr:@"back" withRightStr:nil];
//    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nav];
}
- (void)createtabelView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, Heigh_View_normal - 70) style:UITableViewStylePlain];
    [self.view addSubview:_tb];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    LFreezeHeaderView * header = [[[NSBundle mainBundle]loadNibNamed:@"LFreezeHeaderView" owner:nil options:nil]lastObject];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    _tb.tableHeaderView = header;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LFreezeCell6 * cell = [[[NSBundle mainBundle]loadNibNamed:@"LFreezeCell6" owner:nil options:nil]lastObject];
    cell.model = _approcePersonList[indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _approcePersonList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectModel.isSelect = NO;
    LApprocePersonModel * model = _approcePersonList[indexPath.row];
    model.isSelect = YES;
    _selectModel = model;
    [_tb reloadData];
}
@end
