//
//  AddCustomerTableViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "AddCustomerViewController.h"
#import "MzzNormalCell.h"
#import "MzzSpecialCell.h"
#import "MzzCustomerInfoController.h"
#import "MzzTagViewController.h"
#import "CustomerBillViewController.h"
#import "ShareWorkInstance.h"
#import "MzzCustomerRequest.h"
#import "UserManager.h"
#import "CustomerManageViewController.h"
#import "ApproveRequest.h"
#import "SPShowChangeInfo.h"
#import "MzzCompleteInfoTbHeaderView.h"
@interface AddCustomerViewController ()<UITableViewDelegate,UITableViewDataSource,MzzCustomerInfoControllerDelegate,MzzTagViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic ,strong)InfoModel *infoModel;
@property (nonatomic ,strong)NSDictionary *tagInfoDic;
@property (nonatomic ,strong)NSDictionary *billInfoDic;
@property (nonatomic ,strong)MzzChangeInfoModel *changeInfoModel;
@property (nonatomic ,strong)SPShowChangeInfo *showChangeInfo;
@property (nonatomic ,strong)MzzSpecialCell *selectCell;
@property (nonatomic ,assign)NSInteger apperIndex;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (nonatomic ,assign)BOOL chexiaozhuangtai;
@end

@implementation AddCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MzzCompleteInfoTbHeaderView * tbHeader = loadNibName(@"MzzCompleteInfoTbHeaderView");
    tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 126);
    tbHeader.MzzCompleteInfoTbHeaderViewBlock = ^(NSInteger index) {
        switch (index) {
            case 100://基本信息
            {
                MzzCustomerInfoController *vc = [[MzzCustomerInfoController alloc] init];
                if (_infoModel) {
                    [vc setInfoModel:_infoModel];
                }else{
                     [vc setupCustomerId:[NSString stringWithFormat:@"%ld",_customerModel.uid] storeCode:_customerModel.store_code];
                }
                vc.billInfoDic = _billInfoDic;
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:NO];
            }
                break;
            case 101://顾客账单
            {
                CustomerBillViewController *vc = [[CustomerBillViewController alloc] init];
                if (_infoModel) {
                     _customerModel.store_code = _infoModel.store_code;
                }
                vc.customerModel = _customerModel;
                [self.navigationController pushViewController:vc animated:NO];
            }
                
                break;
            case 102: //顾客标签
            {
                MzzTagViewController *tagVc = [[MzzTagViewController alloc] init];
                [tagVc setUser_id:[NSString stringWithFormat:@"%ld",_customerModel.uid]];
                tagVc.delegate = self;
                [self.navigationController pushViewController:tagVc animated:NO];
            }
                break;
                
            default:
                break;
        }
    };
    _tableview.tableHeaderView = tbHeader;
    
    [self creatNav];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(billInfoDic:) name:MzzInsertCustomerVC_BillInfoDic object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(storeCode) name:MzzInsertCustomerVC_StoreCode object:nil];
//     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jishi) name:@"jishi" object:nil];
  
     _apperIndex = -1 ;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [self requestData];
}

- (void)requestData{
    //弹出审批人选择界面
    //请求审批信息
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fram_id"]  = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    params[@"join_code"]  =[ShareWorkInstance shareInstance].join_code;
    params[@"user_id"]  =[NSString stringWithFormat:@"%ld",_customerModel.uid] ;
    if (_infoModel) {
        params[@"store_code"]  =_infoModel.store_code ;
    }else{
        params[@"store_code"]  =_customerModel.store_code ;
    }
    [MzzCustomerRequest requestChangeInfoParams:params resultBlock:^(MzzChangeInfoModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _changeInfoModel = model;
            [_tableview reloadData];
        }
    }];
}

- (void)chexiaoShenpi{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    params[@"account_id"]  = infomodel.data.account;
    params[@"join_code"]  =[ShareWorkInstance shareInstance].join_code;
    params[@"type"]  =@"1";
    params[@"code"] =_changeInfoModel.code;
    params[@"reason"] =@"我怎么知道为什么用户点完提交完事就会点撤销，可能是因为爱吧";
    [MzzCustomerRequest requestApprovalChangeStateParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (model) {
            [MzzHud toastWithTitle:@"提示" message:@"撤销成功"  complete:^{
                [self chexiaoSuccess];
            }];
        }else{
            [MzzHud toastWithTitle:@"提示" message:@"撤销失败"  complete:^{
               
            }];
        }
    }];
}
- (void)setCustomerModel:(CustomerModel *)customerModel{
    _customerModel = customerModel;
}
- (void)creatNav{
    
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"完善资料" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.backgroundColor = kBtn_Commen_Color;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nav];

}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableviewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 87;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_chexiaozhuangtai) {
        return _showChangeInfo.approvalPerson.count;
    }else{
        return _changeInfoModel.approvalPerson.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_chexiaozhuangtai == NO) {
        MzzSpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"special" forIndexPath:indexPath];
        [cell setupData:[_changeInfoModel.approvalPerson objectAtIndex:indexPath.row]];
        return cell;
    }else{
        MzzSpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"special" forIndexPath:indexPath];
        [cell setupShowData:[_showChangeInfo.approvalPerson objectAtIndex:indexPath.row]];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_chexiaozhuangtai == NO) {
        //审批选择
        [_selectCell  setIsSelected:NO];
        MzzSpecialCell *specialCell = (MzzSpecialCell *)[tableView cellForRowAtIndexPath:indexPath];
        _apperIndex = indexPath.row;
        [specialCell setIsSelected:YES];
        _selectCell = specialCell;
    }
}

-(void)customerInfoController:(MzzCustomerInfoController *)controller andCustomerInfo:(InfoModel *)infoModel{
    _infoModel = infoModel;
}

- (void)billInfoDic:(NSNotification *)noti{
    NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithDictionary:noti.userInfo];
    [dicM removeObjectForKey:@"token"];
    [dicM removeObjectForKey:@"user_id"];
    _billInfoDic =  dicM ;
}

- (void)tagViewController:(MzzTagViewController *)tagViewController andTagInfo:(NSDictionary *)infoDic{
     _tagInfoDic = infoDic;
}
- (IBAction)commit:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"提交"]) {
        if ( _apperIndex ==-1) {
            [MzzHud toastWithTitle:@"提示" message:@"请选择审批人"];
            return;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSDictionary *infoDic =[_infoModel yy_modelToJSONObject];
        params[@"user_id"]  = [NSString stringWithFormat:@"%ld",_customerModel.uid] ;
        params[@"info"]  = infoDic ;
        params[@"label"] = _tagInfoDic;
        params[@"bill"] = _billInfoDic;
        params[@"join_code"]  =[ShareWorkInstance shareInstance].join_code;
        
        NSMutableDictionary *approval = [NSMutableDictionary dictionary];
        approval[@"code"] = _changeInfoModel.code;
        approval[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
        approval[@"approvalPerson"] = [NSString stringWithFormat:@"%ld",[_changeInfoModel.approvalPerson objectAtIndex:_apperIndex].ID];
        LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
        approval[@"account_id"] =[NSString stringWithFormat:@"%ld", model.data.ID];
        [approval setValue:[NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id] forKey:@"fram_id"];
        params[@"approval"] = approval;
        
        NSMutableDictionary *data =  [NSMutableDictionary dictionary];
        data[@"data"] = params.jsonData;
        [MzzCustomerRequest requestTotal_AddParams:data resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                [MzzHud toastWithTitle:@"提示" message:@"提交成功"  complete:^{
                    //提交成功
                    [self commintSuccess];
                }];
            }else{
                [MzzHud toastWithTitle:@"提示" message:@"提交失败"];
            }
        }];
    }else{
        //撤销
        [self chexiaoShenpi];
    }
    
}
- (void)commintSuccess{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"code"]  = _changeInfoModel.code;
    params[@"join_code"]  =[ShareWorkInstance shareInstance].join_code;
    
    [ApproveRequest requestShowChangeInfoParam:params resultBlock:^(SPShowChangeInfo *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
             [_commitBtn setTitle:@"撤销" forState:UIControlStateNormal];
             _chexiaozhuangtai = YES;
             _showChangeInfo = model;
            SPShowPersonModel *showModel = [[SPShowPersonModel alloc] init];
            showModel.frame_name = model.initiator;
            showModel.name = [NSString stringWithFormat:@"%@发起的申请",model.initiator];
            showModel.create_time = model.create_time;
            showModel.type = 0;
            [_showChangeInfo.approvalPerson insertObject:showModel atIndex:0];
            [_tableview reloadData];
        }else{
//            [MzzHud toastWithTitle:@"提示" message:@"撤销失败"];
        }
    }];
}


-(void)chexiaoSuccess{
    [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    _chexiaozhuangtai = NO;
    [_tableview reloadData];
}
-(void)storeCode{
    _billInfoDic = nil;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
