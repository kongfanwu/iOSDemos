//
//  MzzInsertCustomerController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/14.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzInsertCustomerController.h"
#import "MzzNormalCell.h"
#import "MzzSpecialCell.h"
#import "MzzCustomerInfoController.h"
#import "MzzTagViewController.h"
#import "CustomerBillViewController.h"
#import "MzzCustomerInfoModel.h"
#import "MzzCustomerRequest.h"
#import <YYModel/NSObject+YYModel.h>
#import "ShareWorkInstance.h"
#import "MzzChangeInfoModel.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "MzzCompleteInfoTbHeaderView.h"
@interface MzzInsertCustomerController ()<UITableViewDelegate,UITableViewDataSource,MzzCustomerInfoControllerDelegate,MzzTagViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (assign ,nonatomic)BOOL havejibenziliao;
@property (assign ,nonatomic)BOOL haveBillInfo;
@property(nonatomic ,strong)InfoModel *infoModel;
@property (nonatomic ,strong)NSDictionary *tagInfoDic;
@property (nonatomic ,strong)NSDictionary *billInfoDic;
@property (nonatomic ,strong)MzzChangeInfoModel *changeInfoModel;
@property (nonatomic ,assign)NSInteger apperIndex;
@property (nonatomic ,strong)MzzSpecialCell *selectCell;
@end

@implementation MzzInsertCustomerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatNav];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(billInfoDic:) name:MzzInsertCustomerVC_BillInfoDic object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(storeCode) name:MzzInsertCustomerVC_StoreCode object:nil];
    
    MzzCompleteInfoTbHeaderView * tbHeader = loadNibName(@"MzzCompleteInfoTbHeaderView");
    tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 126);
    tbHeader.MzzCompleteInfoTbHeaderViewBlock = ^(NSInteger index) {
        switch (index) {
            case 100://基本信息
            {
                MzzCustomerInfoController *vc = [[MzzCustomerInfoController alloc] init];
                [vc setInfoModel:_infoModel];
                vc.delegate = self;
                vc.billInfoDic = _billInfoDic;
                [self.navigationController pushViewController:vc animated:NO];
            }
                break;
            case 101://顾客账单
            {
                if (!_havejibenziliao) {
                    [MzzHud toastWithTitle:@"提示" message:@"请先完成基本资料的输入"];
                    return;
                }
                CustomerBillViewController *vc = [[CustomerBillViewController alloc] init];
                if (_customerModel == nil) {
                    _customerModel = [CustomerModel new];
                }
                _customerModel.store_code = _infoModel.store_code;
                vc.customerModel = _customerModel;
                
                [self.navigationController pushViewController:vc animated:NO];
            }
                
                break;
            case 102: //顾客标签
            {
                if (!_havejibenziliao) {
                    [MzzHud toastWithTitle:@"提示" message:@"请先完成基本资料的输入"];
                    return;
                }
                MzzTagViewController *tagVc = [[MzzTagViewController alloc] init];
                [tagVc setUser_id:nil];
                tagVc.delegate = self;
                [self.navigationController pushViewController:tagVc animated:NO];
            }
                break;
                
            default:
                break;
        }
    };
    _tableview.tableHeaderView = tbHeader;
}
- (void)setCustomerModel:(CustomerModel *)customerModel
{
    _customerModel = customerModel;
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"添加顾客" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.backgroundColor = kBtn_Commen_Color;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)pop
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - tableviewdelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 5;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    if (_haveBillInfo) {
//        return 2;
//    }
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _changeInfoModel.approvalPerson.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MzzSpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"special" forIndexPath:indexPath];
    [cell setupData:[_changeInfoModel.approvalPerson objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
    //审批选择
    [_selectCell  setIsSelected:NO];
    MzzSpecialCell *specialCell = (MzzSpecialCell *)[tableView cellForRowAtIndexPath:indexPath];
    _apperIndex = indexPath.row;
    [specialCell setIsSelected:YES];
    _selectCell = specialCell;
    
}
- (void)customerInfoController:(MzzCustomerInfoController *)controller andCustomerInfo:(InfoModel *)infoModel
{
    if (infoModel) {
         _havejibenziliao = YES;
        _infoModel = infoModel;
    }
    [_tableview reloadData];
}
-(void)tagViewController:(MzzTagViewController *)tagViewController andTagInfo:(NSDictionary *)infoDic
{
    _tagInfoDic = infoDic;
}
- (void)billInfoDic:(NSNotification *)noti{
    NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithDictionary:noti.userInfo];
    [dicM removeObjectForKey:@"token"];
    [dicM removeObjectForKey:@"user_id"];
    _billInfoDic =  dicM ;
    //弹出审批人选择界面
    //请求审批信息
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"fram_id"]  = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    params[@"join_code"]  =[ShareWorkInstance shareInstance].join_code;
    params[@"store_code"]  =_infoModel.store_code;
    [MzzCustomerRequest requestChangeInfoParams:params resultBlock:^(MzzChangeInfoModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _changeInfoModel = model;
            _haveBillInfo = YES;
            _apperIndex = -1 ;
            [_tableview reloadData];
        }
    }];
    
}
- (IBAction)commit:(UIButton *)sender {
    if (!_infoModel.name) {
        [MzzHud toastWithTitle:@"提示" message:@"请填写基本信息"];
        return;
    }
    if (_haveBillInfo && _apperIndex ==-1) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择审批人"];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSDictionary *infoDic =[_infoModel yy_modelToJSONObject];
    params[@"info"]  = infoDic ;
    params[@"label"] = _tagInfoDic;
    params[@"bill"] = _billInfoDic;
    params[@"join_code"]  =[ShareWorkInstance shareInstance].join_code;
    
    NSMutableDictionary *approval = [NSMutableDictionary dictionary];
    approval[@"join_code"]  =[ShareWorkInstance shareInstance].join_code;
    approval[@"code"] = _changeInfoModel.code;
    approval[@"approvalPerson"] = [NSString stringWithFormat:@"%ld",[_changeInfoModel.approvalPerson objectAtIndex:_apperIndex].ID];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    approval[@"account_id"] =[NSString stringWithFormat:@"%ld", model.data.ID];
    [approval setValue:[NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id] forKey:@"fram_id"];
    params[@"approval"] = approval;
    
    params[@"user_id"] = [NSString stringWithFormat:@"%ld",_customerModel.uid];
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    NSMutableDictionary *data =  [NSMutableDictionary dictionary];
    data[@"data"] = params.jsonData;
    [MzzCustomerRequest requestTotal_AddParams:data resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
                [MzzHud toastWithTitle:@"提示" message:@"提交成功"];
                [self.navigationController popViewControllerAnimated:NO];
        }
    }];
}
-(void)storeCode
{
    _billInfoDic = nil;
    _haveBillInfo = NO;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
