//
//  ApproveBaseController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ApproveBaseController.h"
#import "LApproveCellType1.h"
#import "LApproveCellType2.h"
#import "LApproveCellType3.h"
#import "LApproveCellType4.h"
#import "LApproveCellType5.h"
#import "LApproveCellType6.h"
#import "LApproveCellType7.h"
#import "LApproveCellType8.h"
#import "LApproveCellType9.h"
#import "LApproveCellType10.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "ApproveDetailController.h"
#import "ApproveRequest.h"
#import "ShareWorkInstance.h"
#import "LolUserInfoModel.h"
@interface ApproveBaseController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ApproveBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource = [[NSMutableArray alloc] init];
    [self loadinitData];
    [self createTableView];
//    _tb.delegate = self;
//    _tb.dataSource = self;
}
- (void)loadinitData
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    NSString * joincode = [ShareWorkInstance shareInstance].join_code;
    _joincode = joincode;
    _accountId = accountId;
    _token = infomodel.data.token;
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tb.dataSource = self;
    _tb.delegate = self;
    _tb.backgroundColor = kBackgroundColor;
    _tb.tableFooterView = [[UIView alloc] init];
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tb];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell1 = @"cell1";
    static NSString * cell2 = @"cell2";
    static NSString * cell3 = @"cell3";
    static NSString * cell4 = @"cell4";
    static NSString * cell5 = @"cell5";
    static NSString * cell6 = @"cell6";
    static NSString * cell7 = @"cell7";
    static NSString * cell8 = @"cell8";
    static NSString * cell9 = @"cell9";
    static NSString * cell10 = @"cell10";
    
    LApproveDetailModel * model = nil;
    if (_dataSource.count > indexPath.row) {
        model = _dataSource[indexPath.row];
    }
    if (model.ptype == 1) { //会员冻结
        LApproveCellType2 * cell = [tableView dequeueReusableCellWithIdentifier:cell1];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LApproveCellType2" owner:nil options:nil]lastObject];
        }
        cell.model = model;
        return cell;
    }else if (model.ptype ==2){//会员调店
        LApproveCellType1 * cell = [tableView dequeueReusableCellWithIdentifier:cell2];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LApproveCellType1" owner:nil options:nil]lastObject];
        }
        cell.model = model;
        return cell;
    }else if (model.ptype ==3){ //顾客清卡
        LApproveCellType3 * cell = [tableView dequeueReusableCellWithIdentifier:cell3];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LApproveCellType3" owner:nil options:nil]lastObject];
        }
        cell.model = model;
        return cell;
    }else if (model.ptype ==4){ //账单校正
        LApproveCellType4 * cell = [tableView dequeueReusableCellWithIdentifier:cell4];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LApproveCellType4" owner:nil options:nil]lastObject];
        }
        cell.model = model;
        return cell;
    }else if (model.ptype ==5){//完善信息
        LApproveCellType6 * cell = [tableView dequeueReusableCellWithIdentifier:cell5];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LApproveCellType6" owner:nil options:nil]lastObject];
        }
        cell.model = model;
        return cell;
    }else if (model.ptype ==6){//个性制单
        LApproveCellType8 * cell = [tableView dequeueReusableCellWithIdentifier:cell6];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LApproveCellType8" owner:nil options:nil]lastObject];
        }
        cell.model = model;
        return cell;
    }else if (model.ptype ==7){//已购置换
        LApproveCellType7 * cell = [tableView dequeueReusableCellWithIdentifier:cell7];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LApproveCellType7" owner:nil options:nil]lastObject];
        }
        cell.model = model;
        return cell;
    }else if (model.ptype ==8){//升卡续卡
        LApproveCellType9 * cell = [tableView dequeueReusableCellWithIdentifier:cell8];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LApproveCellType9" owner:nil options:nil]lastObject];
        }
        cell.model = model;
        return cell;
    }else if (model.ptype ==9){ //添加顾客
        LApproveCellType5 * cell = [tableView dequeueReusableCellWithIdentifier:cell9];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LApproveCellType5" owner:nil options:nil]lastObject];
        }
        cell.model = model;
        return cell;
    }else{//奖赠审批 
        LApproveCellType10 * cell = [tableView dequeueReusableCellWithIdentifier:cell10];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LApproveCellType10" owner:nil options:nil]lastObject];
        }
        cell.model = model;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LApproveDetailModel * model = _dataSource[indexPath.row];
    if (model.ptype == 1) {
        return 160 + 10;
    }else if (model.ptype ==2){
        return 185 + 10;
    }else if (model.ptype ==3){
        return 185 + 10;
    }else if (model.ptype ==4){
        return 160 + 10;
    }else if (model.ptype ==5){
        return 140 + 10;
    }else if (model.ptype ==6){
        return 205 + 10;
    }else if (model.ptype ==7){
        return 210 + 10;
    }else if (model.ptype ==8){
        return 210 + 10;
    }else if (model.ptype ==9){
        return 140 + 10;
    }else{
        return 185 + 10;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LApproveDetailModel * model = nil;
    if (_dataSource.count > indexPath.row) {
        model = _dataSource[indexPath.row];
    }
    NSString * navTitle = nil;
    NSString * urlStr = nil;
    BOOL isFromList = NO;
    if (model.ptype == 1) { //会员冻结
        navTitle = @"会员冻结审批";
        urlStr = [NSString stringWithFormat:@"%@approval/dongjie.html",SERVER_H5];
    }else if (model.ptype ==2){//会员调店
        navTitle = @"会员调店审批";
        urlStr = [NSString stringWithFormat:@"%@approval/tiaodian.html",SERVER_H5];
    }else if (model.ptype ==3){ //顾客清卡
        navTitle = @"退款审批";
        urlStr = [NSString stringWithFormat:@"%@approval/tuikuan.html",SERVER_H5];
    }else if (model.ptype ==4){ //账单校正
        navTitle = @"账单校正审批";
        urlStr = [NSString stringWithFormat:@"%@approval/jiaozheng.html",SERVER_H5];
    }else if (model.ptype ==5){//完善信息
        navTitle = @"完善信息";
        urlStr = [NSString stringWithFormat:@"%@approval/wanshan.html",SERVER_H5];
    }else if (model.ptype ==6){//个性制单
        navTitle = @"个性制单";
        urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
        isFromList = YES;
    }else if (model.ptype ==7){//已购置换
        navTitle = @"已购置换";
        urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
        isFromList = YES;
    }else if (model.ptype ==8){//升卡续卡
        navTitle = @"升卡续卡";
        urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
        isFromList = YES;
    }else if (model.ptype ==9){ //添加顾客
        navTitle = @"添加顾客";
        urlStr = [NSString stringWithFormat:@""];
        return;
    }else{//奖赠审批
        navTitle = @"奖赠审批";
        urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
        isFromList = YES;
    }
    ApproveDetailModel * detailModel = [ApproveDetailModel initWithToken:_token joinCode:_joincode code:model.code accountId:_accountId url:urlStr navTitle:navTitle from:_from ordernum:model.ordernum fromList:isFromList];
    ApproveDetailController * next = [[ApproveDetailController alloc] init];
    //        ClearCardDetailController * next = [[ClearCardDetailController alloc] init];
    next.detailModel = detailModel;
    [self.navigationController pushViewController:next animated:NO];
    NSString * atype = @"";
    
    if ([_from isEqualToString:@"-1"]) {//待我审批
        atype = @"1";
    }else{//抄送我的
        atype = @"2";
    }
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_joincode forKey:@"join_code"];
    [param setValue:_accountId forKey:@"account_id"];
    [param setValue:model.code forKey:@"code"];
    [param setValue:atype forKey:@"atype"];
    [ApproveRequest requestSetReadParam:param resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [[NSNotificationCenter defaultCenter]postNotificationName:Approve_refreshListData object:nil];
        }
    }];
    
    
}


@end
