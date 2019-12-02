//
//  LMemberFreezeViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LMemberFreezeViewController.h"
#import "LFreezeQueryMemberView.h"
#import "NSString+Check.h"
#import "ApproveRequest.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "LFreezeCustomerModel.h"
#import "LFreezeCell1.h"
#import "LFreezeCell2.h"
#import "LFreezeCell3.h"
#import "LFreezeCell4.h"
#import "LFreezeCell5.h"
#import "LFreezeSubmitView.h"
#import "LSelectApprovalController.h"
#import "LNavView.h"
@interface LMemberFreezeViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@end

@implementation LMemberFreezeViewController
{
    LFreezeQueryMemberView * _queryView;
    LFreezeModel * _freezeModel;
    UITableView * _tb;
    LFreezeSubmitView * _submit;
    NSString * _fram_id;
    NSString * _account;
    NSString * _accountId;
    NSString * _joinCode;
    LSponsorApproceModel * _sponsorApproceModel;
    LApprocePersonModel * _personModel;
    LFreezeCell4 * _cell4;
    LFreezeCell3 * _cell3;
    BOOL _isHaveData;
    NSString * _cause;
    UILabel *_lbTips;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBackgroundColor;
    [self initSubViews];
    [self loadinitData];
}
- (void)loadinitData
{
    NSString * fram_id = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    _fram_id = fram_id;
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = infomodel.data.account;
    _account = account;
    _accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    _joinCode = [ShareWorkInstance shareInstance].join_code;
}
- (void)initSubViews
{
    [self createNav];
    [self searchView];
    [self createtabelView];
    [self createSubmitView];
}
- (void)createtabelView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, kNavContentHeight - 70) style:UITableViewStylePlain];
    [self.view addSubview:_tb];
    _tb.hidden = YES;
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.backgroundColor = kColorF5F5F5;
}
- (void)createSubmitView
{
    LFreezeSubmitView * submit = [[[NSBundle mainBundle]loadNibNamed:@"LFreezeSubmitView" owner:nil options:nil]lastObject];
    submit.frame = CGRectMake(0, SCREEN_HEIGHT - 70 - kSafeAreaBottom, SCREEN_WIDTH, 70);
    _submit = submit;
    [submit.submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    submit.hidden = YES;
    [self.view addSubview:submit];
}
- (void)submit
{
    WeakSelf
    NSString * approvalPersonId = [NSString stringWithFormat:@"%ld",_personModel.u_id];
    NSString * userId = [NSString stringWithFormat:@"%ld",_sponsorApproceModel.user_id];
    if ([approvalPersonId isEqualToString:@"0"]) {//判断审批人
        MzzHud * hub = [[MzzHud alloc]initWithTitle:@"注意" message:@"请选择审批人" centerButtonTitle:@"知道了" click:^(NSInteger index) {
            
        }];
        [hub show];
        return;
    }
    NSMutableString * duplicatePerson = [[NSMutableString alloc] init];
    for (int i = 0; i < _sponsorApproceModel.duplicatePerson.count; i++) {
        LDuplicatePersonModel * model = _sponsorApproceModel.duplicatePerson[i];
        [duplicatePerson appendString:[NSString stringWithFormat:@"%ld,",(long)model.u_id]];
    }
    if ((duplicatePerson.length > 0)) {
        [duplicatePerson replaceCharactersInRange:NSMakeRange(duplicatePerson.length -1, 1) withString:@""];
    }
    if (_sponsorApproceModel.user_serNum >0) {//判断服务剩余次数  如果大于0 不予提交
        [[[MzzHud alloc]initWithTitle:@"注意" message:@"服务次数不为0不能提交" centerButtonTitle:@"知道了" click:^(NSInteger index) {
            
        }]show];
        return;
    }
    if (_sponsorApproceModel.user_surplus >0) {//判断服务剩余次数  如果大于0 不予提交
        [[[MzzHud alloc]initWithTitle:@"注意" message:@"总余额不为0不能提交" centerButtonTitle:@"知道了" click:^(NSInteger index) {
            
        }]show];
        return;
    }
    if (_sponsorApproceModel.user_awardNum >0) {//判断服务剩余次数  如果大于0 不予提交
        [[[MzzHud alloc]initWithTitle:@"注意" message:@"剩余奖赠不为0不能提交" centerButtonTitle:@"知道了" click:^(NSInteger index) {
            
        }]show];
        return;
    }
    NSString * remainder = [NSString stringWithFormat:@"%ld",_sponsorApproceModel.user_surplus];
    [ApproveRequest requestApproveSubmitJoinCode:_joinCode code:_sponsorApproceModel.code approvalPerson:approvalPersonId duplicatePerson:duplicatePerson account:_account accountId:_accountId cause:_cause userId:userId remainder:remainder user_store_id:_sponsorApproceModel.user_store_id resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [XMHProgressHUD showOnlyText:@"提交成功"];
            [weakSelf performSelector:@selector(back) withObject:nil afterDelay:2];
        }
    }];
}
- (void)createNav
{
    WeakSelf
    LNavView * navView =  loadNibName(@"LNavView");
    navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav);
    [navView setNavViewTitle:@"会员冻结审批" backBtnShow:YES];
    navView.NavViewBackBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
    [self.view addSubview:navView];
}

- (void)searchView{
    LFreezeQueryMemberView * queryView = [[[NSBundle mainBundle]loadNibNamed:@"LFreezeQueryMemberView" owner:nil options:nil]lastObject];
    queryView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 203);
    _queryView = queryView;
    _queryView.tfQuery.delegate = self;
    [_queryView.btnQuery addTarget:self action:@selector(queryClick) forControlEvents:UIControlEventTouchUpInside];
    queryView.backgroundColor = kBackgroundColor;
    [self.view addSubview:queryView];
    
    _lbTips = [[UILabel alloc]init];
    _lbTips.frame = CGRectMake(63, (self.view.frame.size.height - 49) * 0.5, SCREEN_WIDTH - 2 * 63, 49);
    _lbTips.backgroundColor = [UIColor blackColor];
    _lbTips.font = [UIFont systemFontOfSize:15];
    _lbTips.textColor = UIColor.whiteColor;
    _lbTips.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_lbTips];
    _lbTips.hidden = YES;
    
}
- (void)queryClick
{
    if (_queryView.tfQuery.text.length == 0 ||!([_queryView.tfQuery.text isMobileNumber])) {
//        _queryView.lbTips.text = @"请先输入正确的手机号";
        _lbTips.text = @"请先输入正确的手机号";
        _lbTips.hidden = NO;
    }else{
        [self queryMember];
    }
    [_queryView.tfQuery resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    textField.text = @"18810760819";  //TODO: 正式之后注释掉
    if ([textField.text isMobileNumber]) {
        [self queryMember];
    }else{
//        _queryView.lbTips.text = @"请输入正确的手机号码";
        _queryView.hidden = NO;
        _lbTips.text = @"请先输入正确的手机号";
        _lbTips.hidden = NO;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    _lbTips.hidden = YES;
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _lbTips.hidden = YES;
    _cell3.lb1.text = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    _cause = textView.text;
}
- (void)queryMember
{
    [ApproveRequest requestQueryCustomerFramId:_fram_id account:_account keyword:_queryView.tfQuery.text resultBlock:^(LFreezeCustomerModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            if (model.list.count == 0) {
                _queryView.hidden = NO;
//                _queryView.lbTips.hidden = NO;
//                _queryView.lbTips.text = @"未查询到该顾客";
                _lbTips.text = @"未查询到该顾客";
                _lbTips.hidden = NO;
            }else{
                _freezeModel = [model.list firstObject];
                _queryView.hidden = YES;
                 _lbTips.hidden = YES;
                [self showView];
            }
        }
    }];
}
- (void)showView
{
    [ApproveRequest requestSponsorApproceJoinCode:_joinCode account:_account userId:[NSString stringWithFormat:@"%ld",_freezeModel.u_id] framId:_fram_id user_store_id:[NSString stringWithFormat:@"%@",_freezeModel.user_store_id] resultBlock:^(LSponsorApproceModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _sponsorApproceModel = model;
            [_tb reloadData];
            _tb.hidden = NO;
            _submit.hidden = NO;
        }else{
            
        }
    }];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark --------UITableViewDelegate--------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    if (indexPath.row == 0) {
        LFreezeCell1 * cell = [[[NSBundle mainBundle]loadNibNamed:@"LFreezeCell1" owner:nil options:nil]lastObject];
        cell.model = _sponsorApproceModel;
      
        return cell;
    }else if(indexPath.row ==1){
        LFreezeCell2 * cell = [[[NSBundle mainBundle]loadNibNamed:@"LFreezeCell2" owner:nil options:nil]lastObject];
        cell.model = _sponsorApproceModel;
        return cell;
    }else if (indexPath.row == 2){
        _cell3 = [[[NSBundle mainBundle]loadNibNamed:@"LFreezeCell3" owner:nil options:nil]lastObject];
        _cell3.tfReason.delegate = self;
        return _cell3;
    }else if(indexPath.row ==3){
        if (!_cell4) {
            _cell4 = [[LFreezeCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"freeze4"];
        }
        if (!_cell4.model) {
            if (_sponsorApproceModel.approvalPerson.count ==1) {
                _personModel = _sponsorApproceModel.approvalPerson[0];
            }
             _cell4.approcePersonList = _sponsorApproceModel.approvalPerson;
        }
        LSelectApprovalController * next = [[LSelectApprovalController alloc] init];
        next.LSelectApprovalControllerBlock = ^(LApprocePersonModel *model) {
            _cell4.model = model;
            _personModel = model;
            dispatch_async(dispatch_get_main_queue(), ^{
               [_tb reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            });
        };
        __weak LSponsorApproceModel * weakModel = _sponsorApproceModel;
        _cell4.LFreezeCell4Block = ^{
            next.approcePersonList = weakModel.approvalPerson;
            [weakSelf.navigationController pushViewController:next animated:NO];
        };
        return _cell4;
    }else{
        LFreezeCell5 * cell = [[LFreezeCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"freeze4"];
        cell.duplicatePersonList = _sponsorApproceModel.duplicatePerson;
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 220;
    }else if (indexPath.row == 1){
        return 175;
    }else if (indexPath.row == 2){
        return 106;
    }else if(indexPath.row == 3){
        return 140;
    }else{
        NSInteger count = _sponsorApproceModel.duplicatePerson.count;
        if (count % 3 ==0) {
            return 65 + (45 + 20)* count/3;
        }else{
            return 65 + (45 + 20)* (count/3 + 1);
        }
    }
}
@end
