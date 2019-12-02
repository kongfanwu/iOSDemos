//
//  LClearCardController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LClearCardController.h"
#import "LVerifyMemberView.h"
#import "LClearCardCell1.h"
#import "LClearCardCell2.h"
#import "LClearCardCell3.h"
#import "LClearCardCell4.h"
#import "ApproveRequest.h"
#import "LolUserInfoModel.h"
#import "ShareWorkInstance.h"
#import "LFreezeCell1.h"
#import "UserManager.h"
#import "NSString+Check.h"
#import "LFreezeCell4.h"
#import "ApproveRequest.h"
#import "LFreezeSubmitView.h"
#import "LSelectApprovalController.h"
#import "LClearCardCell1Model.h"
#import "Base64.h"
#import "BaseModel.h"
@interface LClearCardController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation LClearCardController
{
    LVerifyMemberView * _verifyView;
    UITableView * _tb;
    NSString * _fram_id;
    NSString * _account;
    NSString * _joinCode;
    NSString * _phoneNum;
    NSString * _code;
    NSString * _accountId;
    LSponsorApproceModel * _sponsorApproceModel;
    LFreezeSubmitView * _submit;
    LApprocePersonModel * _personModel;
    LFreezeCell4 * _cell5;
    LClearCardCell1Model * _cardCell1Model;
    NSString * _cause;
    NSString * _payType;
    LFreezeCell1 * _cell0;
    LClearCardCell1 * _cell1;
    LClearCardCell2 * _cell2;
    LClearCardCell3 * _cell3;
    LClearCardCell4 * _cell4;
    NSArray * _imgsArr;
    NSArray * _imgUrls;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self loadinitData];
    [self initSubViews];
//    [self loadData];
}
- (void)initSubViews
{
    [self createNav];
    [self createVerifyMemberView];
    [self createTableView];
    [self createSubmitView];
}
- (void)loadData
{
//    _phoneNum = @"18810760819";
    [ApproveRequest requestSponsorClearCardJoinCode:_joinCode phone:_phoneNum account:_account framId:_fram_id resultBlock:^(LSponsorApproceModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _sponsorApproceModel = model;
            [_tb reloadData];
        }
    }];
}
- (void)loadinitData
{
    NSString * fram_id = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    _fram_id = fram_id;
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = infomodel.data.account;
    _account = account;
    _accountId = [NSString stringWithFormat:@"%ld",(long)infomodel.data.ID];
    _joinCode = [ShareWorkInstance shareInstance].join_code;
}
- (void)createNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"顾客清卡审批" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)createVerifyMemberView
{
    LVerifyMemberView * verifyView = [[[NSBundle mainBundle]loadNibNamed:@"LVerifyMemberView" owner:nil options:nil]lastObject];
    _verifyView = verifyView;
    [verifyView.btnSendCode addTarget:self action:@selector(sendCodeClick) forControlEvents:UIControlEventTouchUpInside];
    [verifyView.btnVerifyCode addTarget:self action:@selector(verifyCodeClick) forControlEvents:UIControlEventTouchUpInside];
    verifyView.frame = CGRectMake(15, 75 + Heigh_Nav, SCREEN_WIDTH - 15 * 2, 233);
    [self.view addSubview:verifyView];
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
    NSMutableString * imgs =  [[NSMutableString alloc] init];
    NSMutableString * duplicatePerson = [[NSMutableString alloc] init];
    for (int i = 0; i < _sponsorApproceModel.duplicatePerson.count; i++) {
        LDuplicatePersonModel * model = _sponsorApproceModel.duplicatePerson[i];
        [duplicatePerson appendString:[NSString stringWithFormat:@"%ld,",(long)model.u_id]];
    }
    for (int i = 0; i < _imgUrls.count; i++) {
        [imgs appendString:[NSString stringWithFormat:@"%@,",_imgUrls[i]]];
    }
    if (!(imgs.length > 0)) {
        [XMHProgressHUD showOnlyText:@"请选择图片"];
        return;
    }
    [imgs replaceCharactersInRange:NSMakeRange(imgs.length -1, 1) withString:@""];
    if ((duplicatePerson.length > 0)) {
        [duplicatePerson replaceCharactersInRange:NSMakeRange(duplicatePerson.length -1, 1) withString:@""];
    }
    if (!_cause || !(_cause.length > 0)){
        [XMHProgressHUD showOnlyText:@"请填写清卡原因"];
        return;
    }
    NSString * approvalPerson = [NSString stringWithFormat:@"%ld",(long)_personModel.u_id];
    if (!(approvalPerson.length > 0) || !_personModel) {
         [XMHProgressHUD showOnlyText:@"请选择审批人"];
        return;
    }
    [ApproveRequest requestClearCardSubmitJoinCode:_joinCode code:_sponsorApproceModel.code approvalPerson:approvalPerson duplicatePerson:duplicatePerson accountId:_accountId cause:_cause userId:[NSString stringWithFormat:@"%ld",_sponsorApproceModel.user_id] remainder:_cardCell1Model.remainder presmoney:_cardCell1Model.pres_money freeze:_cardCell1Model.freeze timeCardRemainder:_cardCell1Model.timeCard_remainder goodsRemainder:_cardCell1Model.goods_remainder ticketRemainder:_cardCell1Model.ticket_remainder total:_cardCell1Model.total actual:_cardCell1Model.actual clearType:_payType imgs:imgs user_store_id:_sponsorApproceModel.user_store_id resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [XMHProgressHUD showOnlyText:@"提交成功"];
            [weakSelf performSelector:@selector(back) withObject:nil afterDelay:2];
        }
    }];
}
- (void)sendCodeClick
{
   _phoneNum = _verifyView.tfPhoneNum.text;
    [_verifyView.tfPhoneNum resignFirstResponder];
    if (![_phoneNum isMobileNumber]) {
        [[[MzzHud alloc]initWithTitle:@"注意" message:@"请输入正确的手机号" centerButtonTitle:@"确定" click:^(NSInteger index) {
            
        }]show];
    }else{
        [ApproveRequest requestSendCodeJoinCode:_joinCode phone:_phoneNum phType:@"2" account:_account framId:_fram_id resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
               
            }
        }];
    }
}
- (void)verifyCodeClick
{
    WeakSelf
    _code = _verifyView.tfCode.text;
    [_verifyView.tfCode resignFirstResponder];
    if (!(_code.length > 0)) {
        [[[MzzHud alloc]initWithTitle:@"注意" message:@"请输入验证码" centerButtonTitle:@"确定" click:^(NSInteger index) {
            
        }]show];
        return;
    }
    if (!(_phoneNum.length > 0)) {
        [[[MzzHud alloc]initWithTitle:@"注意" message:@"手机号不能为空" centerButtonTitle:@"确定" click:^(NSInteger index) {
            
        }]show];
        return;
    }
    [ApproveRequest requestCheckCodeJoinCode:_joinCode phone:_phoneNum phcode:_code resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _verifyView.hidden = YES;
            _tb.hidden = NO;
            _submit.hidden = NO;
            [weakSelf loadData];
        }else{
            
        }
    }];
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, Heigh_View_normal - 70) style:UITableViewStylePlain];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.hidden = YES;
    [self.view addSubview:_tb];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    if (indexPath.row ==0) {
        if (!_cell0) {
           _cell0 = [[[NSBundle mainBundle]loadNibNamed:@"LFreezeCell1" owner:nil options:nil]lastObject];
        }
        _cell0.model = _sponsorApproceModel;
        return _cell0;
    }else if (indexPath.row ==1) {
        if (!_cell1) {
           _cell1 = [[[NSBundle mainBundle]loadNibNamed:@"LClearCardCell1" owner:nil options:nil]lastObject];
        }
        _cell1.model = _sponsorApproceModel;
        _cell1.LClearCardCell1Block = ^(LClearCardCell1Model *model) {
            _cardCell1Model = model;
        };
        return _cell1;
    }else if (indexPath.row ==2){
        if (!_cell2) {
            _cell2 = [[[NSBundle mainBundle]loadNibNamed:@"LClearCardCell2" owner:nil options:nil]lastObject];
        }
        _cell2.LClearCardCell2Block = ^(NSString *cause) {
            _cause = cause;
        };
        return _cell2;
    }else if (indexPath.row == 3){
        if (!_cell3) {
          _cell3 = [[LClearCardCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardCell3"];
        }
        _cell3.LClearCardCell3Block = ^(NSString *type) {
            _payType = type;
        };
        return _cell3;
        
    }else if (indexPath.row ==4){
        if (!_cell4) {
            _cell4 = [[LClearCardCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5"];
        }
        _cell4.LClearCardCell4Block = ^(NSArray *imgs) {
            _imgsArr = imgs;
            [weakSelf uploadImg];
        };
        return _cell4;
    }else{
        
        if (!_cell5) {
            _cell5 = [[LFreezeCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"freeze4"];
        }
        if (!_cell5.model) {
            if (_sponsorApproceModel.approvalPerson.count ==1) {
                _personModel = _sponsorApproceModel.approvalPerson[0];
            }
            _cell5.approcePersonList = _sponsorApproceModel.approvalPerson;
        }
        LSelectApprovalController * next = [[LSelectApprovalController alloc] init];
        next.LSelectApprovalControllerBlock = ^(LApprocePersonModel *model) {
            _cell5.model = model;
            _personModel = model;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tb reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            });
        };
        __weak LSponsorApproceModel * weakModel = _sponsorApproceModel;
        _cell5.LFreezeCell4Block = ^{
            next.approcePersonList = weakModel.approvalPerson;
            [weakSelf.navigationController pushViewController:next animated:NO];
        };
        return _cell5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        return 230;
    }else if (indexPath.row == 1) {
        return 370;
    }else if (indexPath.row == 2){
        return 98;
    }else if (indexPath.row ==3){
        return 90;
    }else if (indexPath.row ==4){
        return 140;
    }else{
        return 125;
    }
}
- (void)uploadImg
{
    NSMutableArray * imgs = [[NSMutableArray alloc] init];
    for (int i = 0; i< _imgsArr.count; i++) {
        UIImage * img = _imgsArr[i];
        NSData * data = [img imageCompressToData];
        [imgs addObject:[Base64 stringByEncodingData:data]];
    }
    if (_imgsArr.count ==0) {
        return;
    }
//    UIImage * img =kDefaultImage;
//    UIImage * img1 =[UIImage imageNamed:@"meilidingzhi"];
//    NSData  * imgData = UIImagePNGRepresentation(img);
//    NSData  * imgData1 = UIImagePNGRepresentation(img1);
//    imgs = [@[[Base64 stringByEncodingData:imgData1],[Base64 stringByEncodingData:imgData]]mutableCopy];
    [ApproveRequest requestUploadImg:imgs resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            // 不成功可能是因为图片过大  解决方案 服务器解决 或者 app 压缩图片 https://www.jianshu.com/p/99c3e6a6c033
            _imgUrls = model.data[@"list"];
        }
    }];
}

@end
