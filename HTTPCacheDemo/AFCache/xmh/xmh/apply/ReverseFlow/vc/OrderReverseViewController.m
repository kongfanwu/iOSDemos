//
//  OrderReverseViewController.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/12.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "OrderReverseViewController.h"
#import "OrderReverseTwoTableViewCell.h"
#import "OrderReverseThreeTableViewCell.h"
#import "OrderReverseFoureTableViewCell.h"
#import "LFWDNoticeView.h"
#import "BeautyChoiceJishi.h"
#import "MzzCustomerRequest.h"
#import "MzzStoreModel.h"
#import "LSelectBaseModel.h"
#import "ShareWorkInstance.h"
#import "SaleListRequest.h"
#import "OrderManagementViewController.h"
#import "LNavigationController.h"
#import "XMHNormalOrderManagementVC.h"
@interface OrderReverseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *reverseTb;
@property(nonatomic,strong)NSMutableArray *payWayArray;//支付方式数组

@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *sureButton;
@property(nonatomic,strong)NSString *guishu;//门店归属

@property(nonatomic,strong)NSString *realPay;//实付金额
@property(nonatomic,strong)NSString *TorealPay;//支付方式选择后的实付金额

@property(nonatomic,strong)NSString *payWay;//付款方式
@property(nonatomic,strong)NSString *content;//备注信息
@property(nonatomic,strong)NSString * phoneNumber;//手机号
@property(nonatomic,strong)NSString *backPay;//银行卡金额
@property(nonatomic,strong)NSString *chartPay;//微信金额
@property(nonatomic,strong)NSString *alPay;//支付宝金额
@property(nonatomic,strong)NSString *moneyPay;//现金金额
@property(nonatomic,strong)NSString *mendian;//门店归属

@property(nonatomic,strong)NSString *toPayMoney;//付款金额

@end

@implementation OrderReverseViewController
{
    BeautyChoiceJishi    *_beautyChoiceJishi;
    NSMutableArray *mendianArray;
    MzzStoreList * _storeListModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = Color_NormalBG;
    [self creatNav];
    mendianArray = [NSMutableArray array];
    [self.view addSubview:self.reverseTb];
    [self.view addSubview:self.bottomView];
    [self requestData];
}

/**
 请求接口
 */
-(void)requestData{
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
    [parms setValue:join_code?join_code:@"" forKey:@"join_code"];
    WeakSelf;
    [MzzCustomerRequest requestStoreListParams:parms resultBlock:^(MzzStoreList *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _storeListModel = listModel;
            for (MzzStoreModel * storeListModel in listModel.list) {
                [mendianArray addObject:storeListModel.store_name];
            }
            [weakSelf.reverseTb reloadData];
        }
    }];
}
- (UITableView *)reverseTb
{
    if (!_reverseTb) {
        _reverseTb = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav,SCREEN_WIDTH,SCREEN_HEIGHT - Heigh_Nav - 69) style:UITableViewStylePlain];
        _reverseTb.delegate = self;
        _reverseTb.dataSource = self;
        _reverseTb.backgroundColor = kBackgroundColor;
        _reverseTb.separatorStyle = UITableViewCellSeparatorStyleNone;
        _reverseTb.tableFooterView = [UIView new];
    }
    return _reverseTb;
}
-(NSMutableArray *)payWayArray
{
    if (!_payWayArray) {
        _payWayArray = [NSMutableArray array];
    }
    return _payWayArray;
}
-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 69, SCREEN_WIDTH, 69)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:self.sureButton];
    }
    return _bottomView;
}
-(UIButton *)sureButton
{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _sureButton.frame = CGRectMake(15, 13, SCREEN_WIDTH - 30, 44);
        [_sureButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.backgroundColor = kBackgroundColor_C5C5C5;
        _sureButton.layer.cornerRadius = 6;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.userInteractionEnabled = NO;
        [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

/**
 点击确认按钮
 */
-(void)sureButtonAction:(UIButton *)sender{
    sender.userInteractionEnabled= NO;
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
    [parms setValue:join_code?join_code:@"" forKey:@"join_code"];
    [parms setValue:self.realPay forKey:@"amount"];
    [parms setValue:self.payWayArray forKey:@"pay_type"];
    NSString *storeCode;
    for (MzzStoreModel * storeListModel in _storeListModel.list) {
        if ([_mendian isEqualToString:storeListModel.store_name]) {
            storeCode = storeListModel.store_code;
        }
    }
    [parms setValue:storeCode forKey:@"store_code"];
    [parms setValue:self.phoneNumber forKey:@"user_mobile"];
    [parms setValue:self.content forKey:@"content"];

    if (![self.realPay isEqualToString:self.TorealPay]) {
        sender.userInteractionEnabled = YES;
        [MzzHud toastWithTitle:@"提示" message:@"应付金额与支付金额不等"];
        return ;
    }
    if (self.phoneNumber.length == 0) {
        sender.userInteractionEnabled = YES;
        [MzzHud toastWithTitle:@"提示" message:@"请输入手机号"];
        return ;
    }
    if (self.mendian.length == 0) {
        sender.userInteractionEnabled = YES;
        [MzzHud toastWithTitle:@"提示" message:@"请选择门店归属"];
        return ;
    }
    NSString *str = parms.jsonData;
    NSMutableDictionary *parmsdic = [[NSMutableDictionary alloc]init];
    [parmsdic setValue:str forKey:@"result"];
    WeakSelf;
    [SaleListRequest requestSubmitParams:parmsdic resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
         sender.userInteractionEnabled = YES;
        if (isSuccess) {
            MzzHud * hub = [[MzzHud alloc] initWithTitle:@"" message:@"支付成功，请稍后补全订单" centerButtonTitle:@"确认" iconStr:@"_st_tkduihao" click:^(NSInteger index) {
                [weakSelf togoHomePage];
            }];
            [hub show];
            [hub.contentTipView.btnCancel addTarget:self action:@selector(togoHomePage) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }];
}
- (void)togoHomePage
{
//    XMHNormalOrderManagementVC *order = [[XMHNormalOrderManagementVC alloc]init];
//    OrderManagementViewController *order = [[OrderManagementViewController alloc]init];
//    order.from = @"快速开单";
    [self dismissViewControllerAnimated:NO completion:^{
//        LNavigationController *vc = (LNavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
//        [vc pushViewController:order animated:NO];
    }];
}
- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"支付" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lineImageView.hidden = YES;
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)back
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 184;
    }else if (indexPath.row == 2){
        return 136;
    }else{
        return 150;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0){
        static NSString *cellIdentifier = @"OrderReverseTwoTableViewCell";
        OrderReverseTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = loadNibName(@"OrderReverseTwoTableViewCell");
        }
        [cell updatedata:self.payWayArray];
        self.realPay = cell.collectField.text;
        self.TorealPay =cell.collectField.text;
        WeakSelf;
        cell.OrderReverseOneCellBlock = ^(NSString *MoneyStr) {
            NSLog(@"%@",MoneyStr);
            weakSelf.realPay = MoneyStr;
        };
        cell.OrderReverseTwoCellBlock = ^(NSString *payStr) {
            self.payWay = payStr;
            LFWDNoticeView * notice = [[LFWDNoticeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            notice.from = @"逆向";
            NSString *title;
            if ([payStr isEqualToString:@"8"]) {
                title = @"银行卡";
            }else if ([payStr isEqualToString:@"1"]){
                title = @"微信";
            }else if ([payStr isEqualToString:@"2"]){
                title = @"支付宝";
            }else{
                title = @"现金";
            }
            [notice showWithTitle:title leftBtnTitle:@"取消" rightBtnTitle:@"确定"];
            notice.reverseViewBlock = ^(NSInteger index, NSString *payStr) {
                if (index == 1) {
                    if (payStr.length !=0 && ![payStr isEqualToString:@"0"]) {
                        NSMutableDictionary *payDic = [NSMutableDictionary dictionary];
                        _sureButton.userInteractionEnabled = YES;
                        _sureButton.backgroundColor = kBtn_Commen_Color;
                        [payDic setObject:[NSString stringWithFormat:@"%.2f",[payStr floatValue]] forKey:@"price"];
                        [payDic setObject:weakSelf.payWay forKey:@"type"];
                        [weakSelf.payWayArray addObject:payDic];
                    }else{
                        if (weakSelf.payWayArray.count) {
                            for (NSDictionary *dic in weakSelf.payWayArray) {
                                if ([[dic objectForKey:@"type"]isEqualToString:weakSelf.payWay]) {
                                    [weakSelf.payWayArray removeObject:dic];
                                    break;
                                }
                            }
                        }
                    }
                    if (weakSelf.payWayArray.count==0) {
                        _sureButton.userInteractionEnabled = NO;
                        _sureButton.backgroundColor = kBackgroundColor_C5C5C5;
                    }else{
                        _sureButton.userInteractionEnabled = YES;
                        _sureButton.backgroundColor = kBtn_Commen_Color;
                    }
                    [weakSelf.reverseTb reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                }
            };
        };
        
        return cell;
    }else if (indexPath.row == 1){
        static NSString *cellIdentifier = @"OrderReverseThreeTableViewCell";
        OrderReverseThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = loadNibName(@"OrderReverseThreeTableViewCell");
        }
        if (mendianArray.count==1) {
            self.mendian = mendianArray[0];
            [cell updateGuishu:mendianArray[0]];
        }else{
            [cell updateGuishu:self.mendian];
        }
        WeakSelf;
        cell.chooseCellBlock = ^() {
            [self creatTopChooseView];
            [_beautyChoiceJishi refreshGuKeLeiBie:mendianArray withTitle:@"选择门店"];
            _beautyChoiceJishi.GuKeBlock = ^(NSString *choose) {
                weakSelf.mendian = choose;
                [weakSelf.reverseTb reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            };
        };
        cell.OrderReverseThreeCellBlock = ^(NSString *phoneStr) {
            weakSelf.phoneNumber = phoneStr;
        };
        return cell;
    }else{
        static NSString *cellIdentifier = @"OrderReverseFoureTableViewCell";
        OrderReverseFoureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = loadNibName(@"OrderReverseFoureTableViewCell");
        }
        WeakSelf;
        cell.OrderReverseFoureCellBlock = ^(NSString *beizhu) {
            NSLog(@"%@",beizhu);
            weakSelf.content = beizhu;
        };
        return cell;
    }
}
- (void)creatTopChooseView{
    if (!_beautyChoiceJishi) {
        _beautyChoiceJishi = [[[NSBundle mainBundle]loadNibNamed:@"BeautyChoiceJishi" owner:nil options:nil] firstObject];
        _beautyChoiceJishi.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:_beautyChoiceJishi];
    }else{
        _beautyChoiceJishi.hidden = !_beautyChoiceJishi.hidden;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
