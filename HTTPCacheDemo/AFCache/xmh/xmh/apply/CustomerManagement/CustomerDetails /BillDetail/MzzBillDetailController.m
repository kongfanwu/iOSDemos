//
//  MzzBillDetailController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzBillDetailController.h"
#import "MzzBillDetailCell.h"
#import "MzzBillInfoListModel.h"
#import "MzzCustomerRequest.h"
#import "MzzBillSaleDetailCell.h"
#import "MzzJiSuanViewController.h"
#import "ChuFangDetailViewController.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ApproveDetailModel.h"
#import "ApproveDetailController.h"
#import "ShareWorkInstance.h"
#import "MzzBillDetailTbCommonHeader.h"
#import "XMHNewMzzJiSuanViewController.h"
#import "BeautyCFDetailVC.h"
@interface MzzBillDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *billView;
@property (nonatomic ,strong)MzzBillInfoModel *model;
@property (nonatomic ,copy)NSString *type;
@property (nonatomic ,copy)NSString *cardName;
@end


@implementation MzzBillDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatNav];
    self.view.backgroundColor = kBackgroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"账单明细" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.backgroundColor = kBtn_Commen_Color;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)creatTableview{
    _billView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav + 10, SCREEN_WIDTH, Heigh_View_normal) style:UITableViewStylePlain];
    _billView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _billView.delegate = self;
    _billView.dataSource = self;
    _billView.tableFooterView = [[UIView alloc] init];
    _billView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_billView registerNib:[UINib nibWithNibName:@"MzzBillDetailCell" bundle:nil] forCellReuseIdentifier:@"billDetailcell"];
    if ([_model.ly_type isEqualToString:@"approval_changeorder_reg"]) {
        
    }else{
        MzzBillDetailTbCommonHeader * tbCommonHeader = loadNibName(@"MzzBillDetailTbCommonHeader");
        [tbCommonHeader updateMzzBillDetailTbCommonHeaderModel:_model];
        _billView.tableHeaderView = tbCommonHeader;
    }
    [self.view addSubview:_billView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_model.ly_type isEqualToString:@"approval_changeorder_reg"]) {
        return 115;
    }else{
        if (_model.frozen.integerValue == 1 ||_model.frozen.integerValue == 2) {
            return 155;
        }
        return 135;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    MzzBillDetailCell *billcell;
    MzzBillSaleDetailCell *billSalecell;
//    if ([_model.ly_type isEqualToString:@"approval_changeorder_reg"]) {
//        billcell = [[[NSBundle mainBundle] loadNibNamed:@"MzzBillDetailCell" owner:nil options:nil] firstObject];
//        [billcell setupModel:_model andType:_type andCardName:_cardName];
//        return billcell;
//    }else{
        billSalecell = [[NSBundle mainBundle] loadNibNamed:@"MzzBillSaleDetailCell" owner:nil options:nil].firstObject;
        [billSalecell setupModel:_model andType:_type andCardName:_cardName];
        return billSalecell;
//    }
}

- (void)setupModel:(MzzBillInfoModel *)model andType:(NSString *)type andCardName:(NSString *)cardName{
    _model = model;
    _type = type;
    _cardName = cardName;
    [self creatTableview];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([_model.ly_type isEqualToString:@"sales"]) {
        //销售单
//        MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
        XMHNewMzzJiSuanViewController * vc = [[XMHNewMzzJiSuanViewController alloc] init];
        [vc setOrderNum:_model.ordernum andYemianStyle:YemianXiangQing andType:_model.type.integerValue andUid:_user_id withName:@""];
        [self.navigationController pushViewController:vc animated:NO];
    }
    if ([_model.ly_type isEqualToString:@"serv"]) {
        //服务单
//        MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
        XMHNewMzzJiSuanViewController * vc = [[XMHNewMzzJiSuanViewController alloc] init];
        [vc setOrderNum:_model.ordernum andZt:@"1"];
        [self.navigationController pushViewController:vc animated:NO];
    }
    if ([_model.ly_type isEqualToString:@"pres"]) {
        //美丽定制
//        ChuFangDetailViewController *vc = [[ChuFangDetailViewController alloc]init];
//        LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
//        NSString    *token = model.data.token;
//        vc.billNum = _model.ordernum;
//        vc.token = token;
        BeautyCFDetailVC * vc = [[BeautyCFDetailVC alloc] init];
        WeakSelf
        vc.gkglBillDetaiCFBlock = ^{
            [weakSelf.navigationController popToViewController:self animated:NO];
        };
        NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
        [param setValue: _model.ordernum forKey:@"ordernum"];
        [param setValue:@"1" forKey:@"come"];
        vc.param = param;
        
        [self.navigationController pushViewController:vc animated:NO];
    }
    if ([_model.ly_type isEqualToString:@"pres_rec"]) {
        //美丽定制 不跳
    }
    if ([_model.ly_type isEqualToString:@"card_course"]) {
        //销售单-特惠卡 跳销售单
        //销售单
//        MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
        XMHNewMzzJiSuanViewController * vc = [[XMHNewMzzJiSuanViewController alloc] init];
        [vc setOrderNum:_model.ordernum andYemianStyle:YemianXiangQing andType:_model.type.integerValue andUid:@"" withName:@""];
        [self.navigationController pushViewController:vc animated:NO];
    }
    if ([_model.ly_type isEqualToString:@"bill_add"]) {
        //账单导入 不跳
    }
    if ([_model.ly_type isEqualToString:@"approval_changeorder_reg"]) {
        //校正记录
        LolUserInfoModel *info =  [UserManager getObjectUserDefaults:userLogInInfo];
        NSString   *token = info.data.token;
        NSString   *navTitle =@"账单校正审批";
         NSString   *url =[NSString stringWithFormat:@"%@approval/jiaozheng.html",SERVER_H5];
        NSString * accountId = [NSString stringWithFormat:@"%ld",info.data.ID];
        NSString * joincode = [ShareWorkInstance shareInstance].join_code;
        ApproveDetailModel * detailModel = [ApproveDetailModel initWithToken:token joinCode:joincode code:_model.ordernum accountId:accountId url:url navTitle:navTitle from:@"" ordernum:_model.ordernum fromList:NO];
        ApproveDetailController * next = [[ApproveDetailController alloc] init];
        next.detailModel = detailModel;
        [self.navigationController pushViewController:next animated:NO];
    }
    /** 退款审批 */
    if ([_model.ly_type isEqualToString:@"clear_card_reg"]) {
        LolUserInfoModel *info =  [UserManager getObjectUserDefaults:userLogInInfo];
        NSString   *token = info.data.token;
        NSString   *navTitle =@"退款详情";
        NSString   *url =[NSString stringWithFormat:@"%@approval/tuikuan.html",SERVER_H5];;
        NSString * accountId = [NSString stringWithFormat:@"%ld",info.data.ID];
        NSString * joincode = [ShareWorkInstance shareInstance].join_code;
        ApproveDetailModel * detailModel = [ApproveDetailModel initWithToken:token joinCode:joincode code:_model.ordernum accountId:accountId url:url navTitle:navTitle from:@"" ordernum:_model.ordernum fromList:NO];
        ApproveDetailController * next = [[ApproveDetailController alloc] init];
        next.detailModel = detailModel;
        [self.navigationController pushViewController:next animated:NO];
    }
}


@end
