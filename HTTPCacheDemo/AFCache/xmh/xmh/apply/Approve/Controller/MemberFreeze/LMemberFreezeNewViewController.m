//
//  LMemberFreezeNewViewController.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LMemberFreezeNewViewController.h"
#import "LNavView.h"


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
#import "XMHDongJieCell1.h"
#import "XMHDongJieCell2.h"
#import "XMHDongJieCell3.h"
#import <YYWebImage/YYWebImage.h>
@interface LMemberFreezeNewViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
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
    XMHDongJieCell3 * _cell3;
    BOOL _isHaveData;
    NSString * _cause;
    UILabel *_lbTips;
    CGFloat _footerH;
    CGFloat _itemViewH;
    UIView *_itemView;
    NSArray<LDuplicatePersonModel *> *_duplicatePersonList;
}
@property (strong, nonatomic)NSArray<LApprocePersonModel *> *approcePersonList;//审批人数组
@end

@implementation LMemberFreezeNewViewController

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
    _footerH = 244;
    _itemViewH = 90;
    [self createNav];
    [self searchView];
    [self createtabelView];
    [self createSubmitView];
}

- (void)createtabelView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, Heigh_View_normal - 70) style:UITableViewStylePlain];
    [self.view addSubview:_tb];
    _tb.hidden = YES;
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tb.backgroundColor =  UIColor.lightGrayColor;
}
- (void)createSubmitView
{
    LFreezeSubmitView * submit = [[[NSBundle mainBundle]loadNibNamed:@"LFreezeSubmitView" owner:nil options:nil]lastObject];
    submit.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
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
        _lbTips.text = @"请先输入正确的手机号";
        _lbTips.hidden = NO;
    }else{
        [self queryMember];
    }
    [_queryView.tfQuery resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isMobileNumber]) {
        [self queryMember];
    }else{
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
    _cell3.placeholdLab.text = @"";
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
    if (indexPath.row == 0) {
        XMHDongJieCell1 * cell = [[[NSBundle mainBundle]loadNibNamed:@"XMHDongJieCell1" owner:nil options:nil]lastObject];
        cell.model = _sponsorApproceModel;
        return cell;
    }else if(indexPath.row ==1){
        XMHDongJieCell2 * cell = [[[NSBundle mainBundle]loadNibNamed:@"XMHDongJieCell2" owner:nil options:nil]lastObject];
        cell.model = _sponsorApproceModel;
        return cell;
    }else if (indexPath.row == 2){
        _cell3 = [[[NSBundle mainBundle]loadNibNamed:@"XMHDongJieCell3" owner:nil options:nil]lastObject];
        _cell3.contentTexView.delegate = self;
        return _cell3;
    }else if(indexPath.row ==3){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
            cell.backgroundColor = kBackgroundColor;
        }
        
        UIView *view = [self lastCell];
        [cell.contentView addSubview:view];
        return cell;
    }
    return UITableViewCell.new;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 179;
    }else if (indexPath.row == 1){
        return 143;
    }else if (indexPath.row == 2){
        return 106;
    }else{
        return _footerH;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return _footerH;
//}

- (UIView *)lastCell
{
    _duplicatePersonList = _sponsorApproceModel.duplicatePerson;
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, _footerH)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIView *shenpiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, footerView.width, 108)];
    shenpiView.backgroundColor = [UIColor yellowColor];
    [footerView addSubview:shenpiView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 15, 100, 18)];
    title.text = @"审批人";
    title.font = [UIFont systemFontOfSize:15];
    title.textColor = kLabelText_Commen_Color_3;
    [shenpiView addSubview:title];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, 10 + title.bottom, 44, 44)];
    iconView.userInteractionEnabled = YES;
    
    iconView.image = [UIImage imageNamed:@"stspyytajiantupian"];
    iconView.layer.cornerRadius = 44 /2;
    iconView.layer.masksToBounds = YES;
    [iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addApprovl)]];
    [shenpiView addSubview:iconView];
    
    UILabel *addTitle = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, iconView.bottom + 5, 100, 16)];
    addTitle.text = @"添加审批人";
    addTitle.font = [UIFont systemFontOfSize:12];
    addTitle.textColor = kLabelText_Commen_Color_6;
    [shenpiView addSubview:addTitle];
    
    if (!_personModel) {
        if (_sponsorApproceModel.approvalPerson.count ==1) {
            _personModel = _sponsorApproceModel.approvalPerson[0];
        }
        self.approcePersonList = _sponsorApproceModel.approvalPerson;
    }
    LApprocePersonModel * model = self.approcePersonList[0];
    if (self.approcePersonList.count == 1) {
        addTitle.text = model.name;
        [iconView yy_setImageWithURL:[NSURL URLWithString:model.head_img] placeholder:kDefaultJisImage];
    }else{
        iconView.image = [UIImage imageNamed:@"stspyytajiantupian"];
    }
    
    
    UIView *chaosongView = [[UIView alloc]initWithFrame:CGRectMake(0, shenpiView.bottom , footerView.width, 133)];
    shenpiView.backgroundColor = [UIColor greenColor];
    [footerView addSubview:chaosongView];

    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 25, 100, 18)];
    title1.text = @"抄送人";
    title1.font = [UIFont systemFontOfSize:15];
    title1.textColor = kLabelText_Commen_Color_3;
    [chaosongView addSubview:title1];

    _itemView = [[UIView alloc]initWithFrame:CGRectMake(0, title1.bottom + 10 , footerView.width, _itemViewH)];
    _itemView.backgroundColor = [UIColor blueColor];
    [chaosongView addSubview:_itemView];
    //一行2个item
    CGFloat itemH ;
//    NSInteger maxNum = 5;//一行显示5个item
//    NSInteger row = _duplicatePersonList.count / maxNum; //行
//    NSInteger column = _duplicatePersonList.count % maxNum;//列
    CGFloat itemW = itemH = 44;
//    CGFloat tap = (_itemView.width - 5 * itemW - 30)/4;
 

//    for (int i = 0; i < _duplicatePersonList.count; i++) {
        LDuplicatePersonModel * model1 = _duplicatePersonList[0];
        UIImageView *itemImageView = [[UIImageView alloc] init];
        itemImageView.layer.cornerRadius = itemW /2;
        itemImageView.layer.masksToBounds = YES;
        [itemImageView yy_setImageWithURL:[NSURL URLWithString:model.head_img] placeholder:kDefaultJisImage];

//        if (_duplicatePersonList.count < 5) {
//            row = 1;
//        }
//WithFrame:CGRectMake(kMargin, 10, itemW, itemW)
//        itemImageView.frame = CGRectMake(kMargin + column * (tap + itemW), row * (itemH +16 + 15) , itemW, itemH);
    itemImageView.frame = CGRectMake(kMargin, 10, itemW, itemW);
        [_itemView addSubview:itemImageView];

        UILabel * lb = [[UILabel alloc] init];
        lb.font = FONT_SIZE(14);
        lb.textColor = kLabelText_Commen_Color_9;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = model1.name;
        lb.frame = CGRectMake(itemImageView.left, itemImageView.bottom + 9, itemW, 16);
        [_itemView addSubview:lb ];
//    }
    return footerView;
}


- (void)addApprovl
{
    if (_approcePersonList.count > 1) {
        LSelectApprovalController * next = [[LSelectApprovalController alloc] init];
        next.LSelectApprovalControllerBlock = ^(LApprocePersonModel *model) {
            _personModel = model;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tb reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            });
        };
        next.approcePersonList = _sponsorApproceModel.approvalPerson;
        [self.navigationController pushViewController:next animated:NO];
    }else{
        [XMHProgressHUD showOnlyText:@"无审批人"];
    }
}
/*
 -(void)setDuplicatePersonList:(NSArray<LDuplicatePersonModel *> *)duplicatePersonList
 {
 _duplicatePersonList = duplicatePersonList;
 for (int i = 0; i < duplicatePersonList.count; i++) {
 LDuplicatePersonModel * model = duplicatePersonList[i];
 UIImageView * imV = [[UIImageView alloc] init];
 [imV yy_setImageWithURL:[NSURL URLWithString:model.head_img] placeholder:kDefaultImage];
 imV.frame = CGRectMake(_lb1.left  +  (i%5)* (45 + 20) , _lb1.bottom + 10  + (i/5) * (20 + 10 + 45), 45, 45);
 [self addSubview:imV];
 UILabel * lb = [[UILabel alloc] init];
 lb.font = FONT_SIZE(14);
 lb.textColor = kLabelText_Commen_Color_9;
 lb.textAlignment = NSTextAlignmentCenter;
 lb.text = model.name;
 [lb sizeToFit];
 
 lb.frame = CGRectMake(_lb1.left + (i%5) * (45 + 20), _lb1.bottom + 45 + 10 + 10 +(i/5)* (45 + 20 + 10), 45, 20);
 [self addSubview:lb];
 }
 }
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
