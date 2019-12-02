//
//  RefundDetailVC.m
//  xmh
//
//  Created by ald_ios on 2018/11/14.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundDetailVC.h"
/** View */
#import "RefundDetailTbSectionFooter.h"
#import "RefundDetailCustomerInfoView.h"
#import "RefundDetailSectionH1.h"
#import "RefundDetailSectionH2.h"
#import "RefundTbFooterView.h"
#import "CommonSubmitView.h"
#import "FWDSelectView.h"
/** Cell */
#import "RefundDetailCell1.h"
#import "RefundDetailCell2.h"
/** Model */
#import "RefundInfoModel.h"
#import "RefundListModel.h"
#import "MLJishiSearchModel.h"
#import "FWDYeJGuiShuModel.h"
#import "RefundPerformanceModel.h"
#import "MLJishiSearchModel.h"
#import "SLSearchManagerModel.h"
#import "LSponsorApproceModel.h"

#import "ApproveRequest.h"
#import "SLRequest.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"

#import "LSelectApprovalController.h"
@interface RefundDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)RefundDetailCustomerInfoView * customerView;
@property (nonatomic, strong)RefundDetailSectionH1 * tbHeader1;
@property (nonatomic, strong)RefundDetailSectionH2 * tbHeader2;
@property (nonatomic, strong)RefundTbFooterView * tbFooterView;
@property (nonatomic, strong)CommonSubmitView * submitView;
@property (nonatomic, strong)RefundListModel * refundListModel;
@property (nonatomic, strong)FWDSelectView * refundSelectView;
/** tbView section cell 数据源 */
@property (nonatomic, strong)NSMutableArray * refundPerformanceModelArr;
/** 退款原因 */
@property (nonatomic, strong)NSString * cause;
/** 审批人 */
@property (nonatomic, strong)ApprovalInfo * approvalInfo;
@end
@implementation RefundDetailVC
{
    NSMutableArray * _dataSource;
    /** 退款总价  实际退款总金额*/
    CGFloat  _totalRefund;
    /** 技师model */
    MLJishiSearchModel *_jisListModel;
    /** 业绩归属数组 */
    NSArray * _yejiguishuArr;
//    /** tbView section cell 数据源 */
//    NSMutableArray * _refundPerformanceModelArr;
    /** 店长数据源 */
    NSMutableArray * _shopManagerArr;
    
    /** 退款金额 项目的总额 */
    NSInteger _totalAmount;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 初始化 */
    _refundPerformanceModelArr = [[NSMutableArray alloc] init];
    _shopManagerArr = [[NSMutableArray alloc] init];
    _totalRefund = 0.00;
    _totalAmount = 0.00;
    
    
    [self initSubViews];
    /** 获取顾客所购买的所有商品 */
    if (_dataSource.count == 0) {
        [self requestAllBackData];
    }
    /** 获取技师数据 */
    [self requestJisData];
    /** 初始化 业绩归属 数据源 */
    [self initYeJiGuiShuData];
    /** 初始化 tbView  section中cell 数据源 */
    [self initCellContentModelData];
    /** 获取店长归属数据 */
    [self requestDianZhangData];
}
- (void)initYeJiGuiShuData
{
    FWDYeJGuiShuModel * model = [[FWDYeJGuiShuModel alloc]init];
    model.showName = @"售前业绩";
    model.belong = @"1";
    FWDYeJGuiShuModel * model1 = [[FWDYeJGuiShuModel alloc]init];
    model1.showName = @"售中业绩";
    model1.belong = @"2";
    FWDYeJGuiShuModel * model2 = [[FWDYeJGuiShuModel alloc]init];
    model2.showName = @"售后业绩";
    model2.belong = @"3";
    _yejiguishuArr = @[model,model1,model2];
}
- (void)initCellContentModelData
{
    RefundPerformanceModel * model1 = [RefundPerformanceModel createModelName:@"业绩归属" Type:1 valueName:nil ];
    RefundPerformanceModel * model2 = [RefundPerformanceModel createModelName:@"门店归属" Type:2 valueName:_refundInfoModel.store_name];
    RefundPerformanceModel * model3 = [RefundPerformanceModel createModelName:@"店长归属" Type:3 valueName:nil];
    RefundPerformanceModel * model4 = [RefundPerformanceModel createModelName:@"员工归属" Type:4 valueName:nil];
//    RefundPerformanceModel * model5 = [RefundPerformanceModel createModelName:@"公共业绩" Type:5 valueName:nil account:@"0"];
    [_refundPerformanceModelArr addObject:model1];
    [_refundPerformanceModelArr addObject:model2];
    [_refundPerformanceModelArr addObject:model3];
    [_refundPerformanceModelArr addObject:model4];
//    [_refundPerformanceModelArr addObject:model5];
}
- (void)initSubViews
{
    /** Nav */
    [self.navView setNavViewTitle:@"退款审批" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    [self.view addSubview:self.customerView];
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.submitView];
    [self.view addSubview:self.refundSelectView];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _customerView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _customerView.bottom - 70) style:UITableViewStyleGrouped];
        _tbView.backgroundColor = kColorE;
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableFooterView = self.tbFooterView;
    }
    return _tbView;
}
- (RefundDetailCustomerInfoView *)customerView
{
    if (!_customerView) {
        _customerView = loadNibName(@"RefundDetailCustomerInfoView");
        [_customerView updateRefundDetailCustomerInfoViewModel:_refundInfoModel];
        _customerView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 44);
    }
    return _customerView;
}
- (RefundDetailSectionH1 *)tbHeader1
{
    if (!_tbHeader1) {
        _tbHeader1 = loadNibName(@"RefundDetailSectionH1");
        _tbHeader1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90);
    }
    return _tbHeader1;
}
- (RefundDetailSectionH2 *)tbHeader2
{
    if (!_tbHeader2) {
        _tbHeader2 = loadNibName(@"RefundDetailSectionH2");
        _tbHeader2.frame = CGRectMake(0, 0, SCREEN_WIDTH, 135);
    }
    return _tbHeader2;
}
- (RefundTbFooterView *)tbFooterView
{
    WeakSelf
    if (!_tbFooterView) {
        _tbFooterView = loadNibName(@"RefundTbFooterView");
        _tbFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 230);
        _tbFooterView.RefundTbFooterViewInputBlock = ^(NSString *input) {
            weakSelf.cause = input;
        };
        _tbFooterView.RefundTbFooterViewApprovalTapBlock = ^{
            LSelectApprovalController * next = [[LSelectApprovalController alloc] init];
            /** 转模型 */
            NSMutableArray * approvalArr = [[NSMutableArray alloc] init];
            for (int i = 0; i< weakSelf.refundInfoModel.approvalPerson.count; i++) {
                ApprovalInfo * model = weakSelf.refundInfoModel.approvalPerson[i];
                LApprocePersonModel * approvalModel = [[LApprocePersonModel alloc]init];
                approvalModel.u_id = model.uid.integerValue;
                approvalModel.name = model.name;
                approvalModel.frame_name = model.frame_name;
                approvalModel.head_img = model.head_img;
                [approvalArr addObject:approvalModel];
            }
            next.approcePersonList = [[NSArray alloc] initWithArray:approvalArr];
            next.LSelectApprovalControllerBlock = ^(LApprocePersonModel *model) {
                ApprovalInfo * approvalInfo = [[ApprovalInfo alloc] init];
                approvalInfo.uid = [NSString stringWithFormat:@"%ld",model.u_id];
                approvalInfo.head_img = model.head_img;
                approvalInfo.frame_name = model.frame_name;
                approvalInfo.name = model.name;
                [weakSelf.tbFooterView updateRefundTbFooterViewApprovalInfoModel:approvalInfo];
                weakSelf.approvalInfo = approvalInfo;
            };
            [weakSelf.navigationController pushViewController:next animated:NO];
        };
    }
    return _tbFooterView;
}
- (CommonSubmitView *)submitView
{
    WeakSelf
    if (!_submitView) {
        _submitView = loadNibName(@"CommonSubmitView");
        _submitView.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
        [_submitView updateCommonSubmitViewTitle:@"提交"];
        _submitView.CommonSubmitViewBlock = ^{
            [weakSelf requestCommit];
        };
    }
    return _submitView;
}
- (FWDSelectView *)refundSelectView
{
    WeakSelf
    if (!_refundSelectView) {
        _refundSelectView = [[FWDSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _refundSelectView.hidden = YES;
        _refundSelectView.FWDSelectViewBlock = ^(id model) {
            /** 技师 */
            if ([model isKindOfClass:[MLJiShiModel class]]) {
                MLJiShiModel * jisModel = (MLJiShiModel *)model;
                RefundPerformanceModel * refundPerformanceModel = [RefundPerformanceModel createModelName:jisModel.name Type:6 valueName:nil account:jisModel.account];
                [weakSelf.refundPerformanceModelArr addObject:refundPerformanceModel];
            }
            /** 店长 */
            if ([model isKindOfClass:[SLManagerModel class]]) {
                SLManagerModel * shopManager = (SLManagerModel *)model;
                RefundPerformanceModel * refundPerformanceModel = [weakSelf.refundPerformanceModelArr objectAtIndex:2];
                refundPerformanceModel.valueName = shopManager.name;
                refundPerformanceModel.account = shopManager.account;
            }
            /** 业绩归属 */
            if ([model isKindOfClass:[FWDYeJGuiShuModel class]]) {
                FWDYeJGuiShuModel * guiShuModel = (FWDYeJGuiShuModel *)model;
                RefundPerformanceModel * refundPerformanceModel = [weakSelf.refundPerformanceModelArr objectAtIndex:0];
                refundPerformanceModel.valueName = guiShuModel.showName;
                refundPerformanceModel.belong = guiShuModel.belong;
            }
            /** 刷新section 1 */
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            [weakSelf.tbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }
    return _refundSelectView;
}
#pragma mark ------UITableViewDelegate------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _dataSource.count;
    }
    if (section == 1) {
        return _refundPerformanceModelArr.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    static NSString * kDetailCell1 = @"kDetailCell1";
    static NSString * kDetailCell2 = @"kDetailCell2";
    if (indexPath.section == 0) {
        RefundDetailCell1 * detailCell1 = [tableView dequeueReusableCellWithIdentifier:kDetailCell1];
        if (!detailCell1) {
            detailCell1 = loadNibName(@"RefundDetailCell1");
        }
        [detailCell1 updateRefundDetailCell1Model:_dataSource[indexPath.row]];
        detailCell1.RefundDetailCell1Block = ^(RefundModel *model) {
            if ([weakSelf.dataSource containsObject:model]) {
                [weakSelf.dataSource replaceObjectAtIndex:[weakSelf.dataSource indexOfObject:model] withObject:model];
            }
            [weakSelf countTotalRefund];
        };
        return detailCell1;
    }
    if (indexPath.section == 1) {
        RefundDetailCell2 * detailCell2 = [tableView dequeueReusableCellWithIdentifier:kDetailCell2];
        if (!detailCell2) {
            detailCell2 = loadNibName(@"RefundDetailCell2");
        }
        /** 更新cell */
        [detailCell2 updateRefundDetailCell2Model:_refundPerformanceModelArr[indexPath.row]];
        /** 输入内容回调 */
        detailCell2.RefundDetailCell2InputBlock = ^(RefundPerformanceModel *refundPerformanceModel) {
            if ([weakSelf.refundPerformanceModelArr containsObject:refundPerformanceModel]) {
                [weakSelf.refundPerformanceModelArr replaceObjectAtIndex:[weakSelf.refundPerformanceModelArr indexOfObject:refundPerformanceModel] withObject:refundPerformanceModel];
            }
        };
        /** 加号按钮点击回调 */
        detailCell2.RefundDetailCell2AddBlock = ^(RefundPerformanceModel *refundPerformanceModel) {
            weakSelf.refundSelectView.hidden = NO;
            if (refundPerformanceModel.type == 4) {
                weakSelf.refundSelectView.listModel = _jisListModel;
            }
        };
        /** 叉号按钮点击回调 */
        detailCell2.RefundDetailCell2MinusBlock = ^(RefundPerformanceModel *refundPerformanceModel) {
            [weakSelf.refundPerformanceModelArr removeObject:refundPerformanceModel];
            [weakSelf.tbView reloadData];
        };
        /** 请选择按钮点击回调 */
        detailCell2.RefundDetailCell2SelectBlock = ^(RefundPerformanceModel *refundPerformanceModel) {
            weakSelf.refundSelectView.hidden = NO;
            if (refundPerformanceModel.type == 1) {
                weakSelf.refundSelectView.listModel = _yejiguishuArr;
            }
            if (refundPerformanceModel.type == 3) {
                weakSelf.refundSelectView.listModel = _shopManagerArr;
            }
        };
        return detailCell2;
    }
    UITableViewCell * cell;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.tbHeader1;
    }
    if (section == 1) {
        [self.tbHeader2 updateRefundDetailSectionH2Value:_totalRefund];
       return self.tbHeader2;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    RefundDetailTbSectionFooter * footer = loadNibName(@"RefundDetailTbSectionFooter");
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 90;
    }
    if (section == 1) {
        return 135;
    }
    return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 30.0f;
    }
    if (indexPath.section ==1) {
        return 30.0f;
    }
    return 0.0f;
}
/** 计算退款总价*/
- (void)countTotalRefund
{
    _totalRefund = 0.00;
    for (int i = 0; i < _dataSource.count; i++) {
        RefundModel * model = _dataSource[i];
        _totalRefund = _totalRefund + model.actualValue.floatValue;
        _totalAmount = _totalAmount + model.money.floatValue;
        if (model.paramValue.length > 0) {
            _totalAmount = _totalAmount + model.paramValue.floatValue;
        }
    }
    [_tbHeader2 updateRefundDetailSectionH2Value:_totalRefund];
}
/** 判断是否所有商品全部都输入了 实际退款金额 */
- (BOOL)verifyModelActualValue
{
    for (int i = 0; i < _dataSource.count; i++) {
        RefundModel * model = _dataSource[i];
        if (model.actualValue.integerValue == 0) {
            return NO;
        }
    }
    return YES;
}
#pragma mark ------网络请求------
/** 获取顾客购买的所有东西 */
- (void)requestAllBackData
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_refundInfoModel.user_id?_refundInfoModel.user_id:@"" forKey:@"user_id"];
//    [param setValue:@"22359" forKey:@"user_id"];
    [ApproveRequest requestClearBackAll:param resultBlock:^(RefundListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_dataSource addObjectsFromArray:model.list];
            [_tbView reloadData];
        }else{}
    }];
}
/** 提交 */
- (void)requestCommit
{
    if (![self verifyModelActualValue]) {
        [XMHProgressHUD showOnlyText:@"有商品没有填入实际退款金额"];
        return;
    };
    /** 参数准备 */
    
    /** 发起人的岗位id */
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    /** 门店编码 */
    NSString * storeCode = _refundInfoModel.store_code;
    /** 登录人id */
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    /** 顾客的id */
    NSString * userId = _refundInfoModel.user_id;
    /** 退款总金额 */
    NSString * amount = [NSString stringWithFormat:@"%ld",_totalAmount];
    /** 实际退款金额 */
    NSString * refund = [NSString stringWithFormat:@"%.2f",_totalRefund];
    /** 业绩归属 1：售前业绩 2：售中业绩 3：售后业绩 */
    NSString * belong = [_refundPerformanceModelArr[0] belong];
    if (!belong) {
        [XMHProgressHUD showOnlyText:@"请选择业绩归属"];
        return;
    }
    /** 店长业绩归属 店长的唯一标识 */
    NSString * dianzhang = [_refundPerformanceModelArr[2] account];
    /** 发起人的唯一标识 */
    NSString * inper = infomodel.data.account;
    /** 用户所属门店id */
    NSString * userStoreId = _refundInfoModel.user_store_id;
    /** 业绩归属 */
//    NSString * guishu = [_refundPerformanceModelArr[4] valueInput];
    NSMutableArray * guiShuArr = [[NSMutableArray alloc] init];
    NSInteger totalValueInput = 0;
    for (int i = 4; i < _refundPerformanceModelArr.count; i++) {
        RefundPerformanceModel * model = _refundPerformanceModelArr[i];
        NSMutableDictionary * dict  = [[NSMutableDictionary alloc] init];
        [dict setValue:model.account forKey:@"acc"];
        [dict setValue:model.valueInput forKey:@"bfb"];
        totalValueInput = totalValueInput + model.valueInput.integerValue;
        [guiShuArr addObject:dict];
    }
    /** 判断业绩归属总和不能超过实际退款总和 */
    if (totalValueInput > _totalRefund) {
        [XMHProgressHUD showOnlyText:@"员工归属业绩进而之和不可超过退款总价"];
        return;
    }
    /** 退款的实际内容 */
    NSMutableArray * backArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < _dataSource.count; i++) {
        NSMutableDictionary * backDict = [[NSMutableDictionary alloc] init];
        RefundModel * model = _dataSource[i];
        [backDict setValue:model.code?model.code:@"" forKey:@"code"];
        [backDict setValue:model.did?model.did:@"" forKey:@"did"];
        [backDict setValue:model.name?model.name:@"" forKey:@"name"];
        [backDict setValue:model.type?model.type:@"" forKey:@"type"];
        if (model.paramValue) {
            [backDict setValue:model.paramValue?model.paramValue:@"" forKey:@"price"];
        }else{
            [backDict setValue:model.money?model.money:@"" forKey:@"price"];
        }
        if (model.quitNum.length > 0) {
            [backDict setValue:model.quitNum ?model.quitNum:@"" forKey:@"num"];
        }else{
           [backDict setValue:model.num.integerValue != 0?model.num:@"1" forKey:@"num"];
        }
        [backDict setValue:model.actualValue?model.actualValue:@"" forKey:@"refund"];
        [backArr addObject:backDict];
    }
//    NSString * back = [backArr jsonData];
    /** 退款原因 */
    NSString * cause = _cause;
    /** 组织result参数 */
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    NSMutableDictionary * result = [[NSMutableDictionary alloc] init];
    [result setValue:storeCode?storeCode:@"" forKey:@"store_code"];
    [result setValue:userId?userId:@"" forKey:@"user_id"];
    [result setValue:accountId?accountId:@"" forKey:@"account_id"];
    [result setValue:amount?amount:@"" forKey:@"amount"];
    [result setValue:refund?refund:@"" forKey:@"refund"];
    [result setValue:framId?framId:@"" forKey:@"fram_id"];
    [result setValue:belong?belong:@"" forKey:@"belong"];
    [result setValue:dianzhang?dianzhang:@"" forKey:@"dianzhang"];
    [result setValue:inper?inper:@"" forKey:@"inper"];
    [result setValue:cause?cause:@"" forKey:@"cause"];
    [result setValue:guiShuArr?guiShuArr:@"" forKey:@"guishu"];
    [result setValue:backArr?backArr:@"" forKey:@"back"];
    [result setValue:joinCode?joinCode:@"" forKey:@"join_code"];
    [result setValue:userStoreId?userStoreId:@"" forKey:@"user_store_id"];
    NSString * resultJsonStr = result.jsonData;
    
    /** 组织提交参数 */
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_refundInfoModel.orderNum?_refundInfoModel.orderNum:@"" forKey:@"orderNum"];
    NSMutableString * duplicatePerson = [[NSMutableString alloc] init];
    for (int i= 0; i < _refundInfoModel.duplicatePerson.count; i ++) {
        ApprovalInfo * approvalInfo = _refundInfoModel.duplicatePerson[i];
        [duplicatePerson appendString:approvalInfo.uid];
        if (i == _refundInfoModel.duplicatePerson.count - 1) {
            
        }else{
            [duplicatePerson appendString:@","];
        }
    }
    if (!_approvalInfo) {
        [XMHProgressHUD showOnlyText:@"请选择审批人"];
        return;
    }
    [param setValue:_approvalInfo.uid?_approvalInfo.uid:@"" forKey:@"approvalPerson"];
    [param setValue:duplicatePerson?duplicatePerson:@"" forKey:@"duplicatePerson"];
    [param setValue:resultJsonStr?resultJsonStr:@"" forKey:@"result"];
    [ApproveRequest requestCommitRefundParam:param resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [XMHProgressHUD showOnlyText:@"退款成功"];
            [self performSelector:@selector(pop) withObject:nil afterDelay:2];
        }else{}
    }];
}
/** 获取技师数据 */
- (void)requestJisData
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    NSString * framId = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    [param setValue:framId?framId:@"" forKey:@"fram_id"];
    [SLRequest requesSearchJisParams:param resultBlock:^(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _jisListModel = model;
        }
    }];
}
/** 获取店长归属数据 */
- (void)requestDianZhangData
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:_refundInfoModel.store_code forKey:@"store_code"];
    [SLRequest  requesSearchManagerParams:param resultBlock:^(SLSearchManagerModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_shopManagerArr addObjectsFromArray:model.list];;
        }
    }];
}
/** 提交成功推到部分退款发起界面 */
- (void)pop
{
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
}
@end
