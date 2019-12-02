//
//  MzzShengkaXukaController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzGeXingZhiDanController.h"
#import "SaleServiceCommitHeader.h"
#import "SaleServiceCommitDownView.h"
#import "SaleServiceCommitDownTwoView.h"
#import "SLRequest.h"
#import "ShareWorkInstance.h"
#import "MzzCustomerRequest.h"
#import "SLSearchManagerModel.h"
#import "MzzStoreModel.h"
#import "SLOrderNumModel.h"
#import "UserManager.h"
#import "MzzYejihuafenView.h"
#import "MzzJisuantongjiView.h"
#import "SaleListRequest.h"
#import "OrderManagementViewController.h"
#import "ApproveRequest.h"
#import "LJiangZengListModel.h"
#import "SaleServiceJishiCell.h"
#import "MzzAwardView.h"
#import "OrderSaleViewController.h"
#import "FWDCommentCell.h"
#import "MzzJiSuanViewController.h"

@interface MzzGeXingZhiDanController ()<UITableViewDelegate,UITableViewDataSource>
{
    SaleServiceCommitHeader *_commitHeader;
    MzzJisuantongjiView   *_downView;
    NSString *_content;
    
}
@property (strong, nonatomic)  UIButton *commitBtn;
@property (strong, nonatomic)  UITableView *shenpiTb;
@property (strong ,nonatomic)  LJiangZengListModel *shenpiList;
@property (strong ,nonatomic)LJiangZengPersonModel *shenpiModel;
@property (strong ,nonatomic)MzzAwardView *awardView;
@property (strong ,nonatomic)MzzYejihuafenView *downTwoView;
@property (strong ,nonatomic)FWDCommentCell * commentCell;
@property (strong ,nonatomic)UIScrollView    *bgScroll;
@property (nonatomic ,assign)CGFloat webHeight;
@property (strong ,nonatomic)NSMutableArray *awardList;
@property (nonatomic ,assign)NSInteger heji;
@property (nonatomic ,assign)NSInteger amount_t;
@end

@implementation MzzGeXingZhiDanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self creatNav];
    [self requsetWebHeight];
}
- (void)requsetWebHeight{
    WeakSelf;
    _downView = [[MzzJisuantongjiView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 10)];
    NSMutableDictionary *toH5Dic = [[NSMutableDictionary alloc]init];
    NSMutableArray *proArr = [[NSMutableArray alloc]init];
    float totalPrice = 0.0;
    NSInteger yaunjia = 0;
    for (NSMutableDictionary *tmpDic in _commitDic[@"cart"]) {
        NSMutableDictionary *subDic = [[NSMutableDictionary alloc]init];
        subDic[@"code"] = tmpDic[@"code"];
        subDic[@"count"] = tmpDic[@"num"];
        subDic[@"money"] = tmpDic[@"price"];
        subDic[@"name"] = tmpDic[@"name"];
        [proArr addObject:subDic];
        totalPrice +=  [tmpDic[@"price"] floatValue];
        yaunjia += [tmpDic[@"amount_t"] integerValue];
    }
    _heji =totalPrice;
    _amount_t = yaunjia;
    toH5Dic[@"total"] = @(totalPrice);
    toH5Dic[@"copeWith"] = @(totalPrice);
    toH5Dic[@"pro"] = proArr;
    toH5Dic[@"riginalPricoe"] = @(yaunjia);
    if (self.toPayMoney!=0) {
        [toH5Dic setValue:[NSString stringWithFormat:@"%.2f",self.toPayMoney] forKey:@"copeWith"];
        [toH5Dic setValue:@(_heji) forKey:@"total"];
    }else{
        [toH5Dic setValue:@(_heji) forKey:@"copeWith"];
        [toH5Dic setValue:@(_heji) forKey:@"total"];
    }
    
    NSString *dataStr = toH5Dic.jsonData;
    
    NSString *js = [NSString stringWithFormat:@"GeXingZhiDanXiaoPiaocallJs('%@')",dataStr];
    
    [_downView setupRequestUrl:[NSString stringWithFormat:@"%@sales/listpage.html",SERVER_H5] andEvaluateJavaScript:js];
    [_downView setWebHeight:^(CGFloat height) {
        _webHeight = height;
        [weakSelf initsubviews];
        [weakSelf end];
    }];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"结算统计" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.lineImageView.hidden = YES;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)initsubviews{
    WeakSelf;
    _commitHeader = [[[NSBundle mainBundle] loadNibNamed:@"SaleServiceCommitHeader" owner:nil options:nil] firstObject];
    _commitHeader.frame = CGRectMake(0,Heigh_Nav, SCREEN_WIDTH, 54);
    [self.view addSubview:_commitHeader];
    _commitHeader.lb.text = [NSString stringWithFormat:@"%@ (%@)",_name,_mobile];
    
    _bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _commitHeader.bottom, SCREEN_WIDTH,SCREEN_HEIGHT - _commitHeader.bottom - 70)];
    [self.view addSubview:_bgScroll];
    
    _downView.frame = CGRectMake(15,0, SCREEN_WIDTH-30, _webHeight);
    _downView.layer.cornerRadius = 6;
    _downView.layer.masksToBounds = YES;
    [_bgScroll addSubview:_downView];
    
    _awardView  = [[[NSBundle mainBundle]loadNibNamed:@"MzzAwardView" owner:nil options:nil]firstObject];
    _awardView.store_code = _store_code;
    _awardView.user_id = _user_id;
    _awardView.frame = CGRectMake(15, _downView.bottom+10 , SCREEN_WIDTH-30, 80);
    _awardView.layer.cornerRadius = 6;
    _awardView.layer.masksToBounds = YES;
    [_awardView setAwardCommit:^(NSMutableArray<SaleModel *> *list, BOOL ifdele) {
        weakSelf.awardView.height = 80 + list.count * 44;
        weakSelf.downTwoView.frame = CGRectMake(15,weakSelf.awardView.bottom+10, SCREEN_WIDTH-30,195+_downTwoView.yuangongArrays.count*25);
        weakSelf.commentCell.frame = CGRectMake(15,_downTwoView.bottom+10, SCREEN_WIDTH-30,145);
        weakSelf.bgScroll.contentSize = CGSizeMake(SCREEN_WIDTH, weakSelf.commentCell.bottom+10);
        //奖赠数据保存
        _awardList = [NSMutableArray array];
        for (SaleModel *model in list) {
            NSMutableDictionary *modeldic = [NSMutableDictionary dictionary];
            [modeldic setObject:model.code forKey:@"code"];
            [modeldic setObject:[NSString stringWithFormat:@"%ld",model.uid] forKey:@"id"];
            [modeldic setObject:model.name forKey:@"name"];
            [modeldic setObject:[NSString stringWithFormat:@"%ld",model.mzzAwardCount] forKey:@"num"];
            [modeldic setObject:[NSString stringWithFormat:@"%ld",model.mzzAwardTotlePrice] forKey:@"price"];
            [modeldic setObject:model.cardType forKey:@"type"];
            [modeldic setObject:model.unit forKey:@"uint"];
            [weakSelf.awardList addObject:modeldic];
        }
    }];
    [_bgScroll addSubview:_awardView];
    
    
    _downTwoView = [[[NSBundle mainBundle] loadNibNamed:@"MzzYejihuafenView" owner:nil options:nil] firstObject];
    _downTwoView.frame = CGRectMake(15,_awardView.bottom+10, SCREEN_WIDTH-30,195);
    _downTwoView.layer.cornerRadius = 6;
    _downTwoView.layer.masksToBounds = YES;
    _downTwoView.storeCode = _store_code;
    _downTwoView.clickJs = ^(NSInteger count) {
        weakSelf.downTwoView.frame = CGRectMake(15,_awardView.bottom+10, SCREEN_WIDTH-30,195+count*25);
        weakSelf.commentCell.frame = CGRectMake(15,_downTwoView.bottom+10, SCREEN_WIDTH-30,145);
        weakSelf.bgScroll.contentSize = CGSizeMake(SCREEN_WIDTH, weakSelf.commentCell.bottom+10);
        
    };
    [_bgScroll addSubview:_downTwoView];
    _commentCell =  [[[NSBundle mainBundle]loadNibNamed:@"FWDCommentCell" owner:nil options:nil]firstObject];
    _commentCell.frame = CGRectMake(15,_downTwoView.bottom+10, SCREEN_WIDTH-30,145);
    _commentCell.lbLimit.hidden = YES;
    _commentCell.lb1.text = @"请输入需要让承接人知晓的信息，以此提高工作效率";
    _commentCell.FWDCommentCellBlock = ^(NSString *beizhu) {
        _content = beizhu;
    };
    [_commentCell.lb1 sizeToFit];
    [_bgScroll addSubview:_commentCell];
    _bgScroll.contentSize = CGSizeMake(SCREEN_WIDTH, _commentCell.bottom);
    
    UIView *btnBack = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 60, SCREEN_WIDTH , 60)];
    btnBack.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnBack];
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(self.toPayMoney!=0){
        [_commitBtn setTitle:@"提交结算" forState:UIControlStateNormal];
    }else{
        [_commitBtn setTitle:@"提交审批" forState:UIControlStateNormal];
    }
    [_commitBtn setBackgroundColor:kBtn_Commen_Color];
    _commitBtn.frame = CGRectMake(10,  10, SCREEN_WIDTH - 20, 40);
    _commitBtn.layer.cornerRadius = 6;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(conmitEvent) forControlEvents:UIControlEventTouchUpInside];
    [btnBack addSubview:_commitBtn];
    _downTwoView.superVc = self;
}

- (void)conmitEvent{
    if (!_downTwoView.selectYejiguishu) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择业绩归属" ];
        return ;
    }
    if (!_downTwoView.selectStoreModel.store_code) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择门店归属" ];
        return ;
    }
    if (_downTwoView.totalBfb != _heji) {
        [MzzHud toastWithTitle:@"提示" message:@"业绩归属总计不等于订单金额，请重新分配" ];
        return ;
    }
    if(self.toPayMoney!=0){
        [self commitShenpi];
    }else{
        [self requestShenpi];
    }
}

- (void)requestShenpi
{
    NSString * joincode = [ShareWorkInstance shareInstance].join_code;
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * framId = [NSString stringWithFormat:@"%ld",infomodel.data.join_code[0].fram_id];
    [ApproveRequest requestFreeOrderApproveJoinCode:joincode framId:framId resultBlock:^(LJiangZengListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _shenpiList = model;
            if (_shenpiList.approvalPerson.count > 0) {
                [self creatShenpiTb];
            }else{
                //                [self commitShenpi];
                [MzzHud toastWithTitle:@"提示" message:@"本店暂无审批人"];
            }
        }
    }];
}

- (void)creatShenpiTb{
    _shenpiTb = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200) style:UITableViewStylePlain];
    _shenpiTb.delegate = self;
    _shenpiTb.dataSource = self;
    _shenpiTb.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_shenpiTb];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"请选择审批人";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _shenpiList.approvalPerson.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SaleServiceJishiCell *cell;
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleServiceJishiCell" owner:nil options:nil] firstObject];
    }
    if (indexPath.row < _shenpiList.approvalPerson.count) {
        LJiangZengPersonModel *model = _shenpiList.approvalPerson[indexPath.row];
        [cell freshSaleServiceShenpiCell:model];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LJiangZengPersonModel *model =_shenpiList.approvalPerson[indexPath.row];
    model.isSelect = !model.isSelect;
    _shenpiModel = model;
    [self commitShenpi];
}
- (void)commitShenpi{
    NSMutableDictionary *dic = _commitDic;
    
    if ([_downTwoView.selectYejiguishu isEqualToString:@"售前业绩"]) {
        [dic setValue:@(1) forKey:@"belong"];
    }else if ([_downTwoView.selectYejiguishu isEqualToString:@"售中业绩"]){
        [dic setValue:@(2) forKey:@"belong"];
    }else if ([_downTwoView.selectYejiguishu isEqualToString:@"售后业绩"]){
        [dic setValue:@(3) forKey:@"belong"];
    }
    [dic setValue:_downTwoView.selectStoreModel.store_code forKey:@"store_code"];
    [dic setValue:_downTwoView.selectManagerModel.account forKey:@"dianzhang"];
    if (_content.length == 0) {
        [dic setValue:@"" forKey:@"content"];
    }else{
        [dic setValue:_content forKey:@"content"];
    }
    [dic setValue:[NSString stringWithFormat:@"%ld",_user_id] forKey:@"user_id"];
    //奖赠
    [dic setValue:_awardList forKey:@"award"];
    //审批
    [dic setValue:[NSString stringWithFormat:@"%ld",_shenpiModel.uid] forKey:@"approvalPerson"];
    [dic setValue:_shenpiList.code forKey:@"code"];
    //抄送人
    [dic setValue:[NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id] forKey:@"fram_id"];
    //原价 总价
    [dic setValue:[NSString stringWithFormat:@"%ld",_amount_t] forKey:@"amount_t"];
    [dic setValue:[NSString stringWithFormat:@"%ld",_heji] forKey:@"heji"];
    
    NSMutableArray *guishuArr = [[NSMutableArray alloc]init];
    NSMutableDictionary *gsDic1 = [[NSMutableDictionary alloc]init];
    [gsDic1 setValue:@"公共" forKey:@"acc"];
    [gsDic1 setValue:[NSString stringWithFormat:@"%.2f",_downTwoView.gonggongyejiBfb] forKey:@"bfb"];
    [guishuArr addObject:gsDic1];
    
    for (int i = 0; i < _downTwoView.yuangongArrays.count; i++) {
        MLJiShiModel *jishiModel = [_downTwoView.yuangongArrays objectAtIndex:i];
        NSMutableDictionary *gsDic2 = [[NSMutableDictionary alloc]init];
        [gsDic2 setValue:jishiModel.account forKey:@"acc"];
        [gsDic2 setValue:[NSString stringWithFormat:@"%.2f",jishiModel.bfb] forKey:@"bfb"];
        [guishuArr addObject:gsDic2];
    }
    
    [dic setValue:guishuArr forKey:@"guishu"];
    if (self.toPayMoney !=0) {
        [dic setValue:self.ordernum forKey:@"ordernum"];
        [dic setValue:[NSString stringWithFormat:@"%.2f",self.toPayMoney] forKey:@"shifujine"];
        LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
        [dic setValue:model.data.token forKey:@"token"];
    }
    NSString *str = dic.jsonData;
    NSMutableDictionary *parmsdic = [[NSMutableDictionary alloc]init];
    [parmsdic setValue:str forKey:@"result"];
    if (self.toPayMoney !=0) {
        if (_heji == self.toPayMoney) {
            [SaleListRequest requestKuaiSubmitCartParams:parmsdic resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    MzzHud *hud = [[MzzHud alloc] initWithTitle:@"温馨提示" message:@"开单成功，请耐心等待后续人员的操作" leftButtonTitle:@"返回列表" rightButtonTitle:@"继续开单" click:^(NSInteger index) {
                        if (index ==0) {
                            for (UIViewController *temp in self.navigationController.viewControllers) {
                                if ([temp isKindOfClass:[OrderManagementViewController class]]) {
                                    [self.navigationController popToViewController:temp animated:NO];
                                }
                            }
                        }else{
                            for (UIViewController *temp in self.navigationController.viewControllers) {
                                if ([temp isKindOfClass:[OrderSaleViewController class]]) {
                                    [self.navigationController popToViewController:temp animated:NO];
                                }
                            }
                        }
                    }];
                    hud.contentTipView.btnCancel.hidden = YES;
                    [hud show];
                }else{
                    [_shenpiTb removeFromSuperview];
                    _shenpiTb = nil;
                }
            }];
        }else{
            if (self.toPayMoney < _heji) {
                NSArray *cartArr = _commitDic[@"cart"];
                NSMutableArray *typeArray = [NSMutableArray array];
                for (NSDictionary *tempDic in cartArr) {
                    if ([[tempDic objectForKey:@"type"]isEqualToString:@"goods"]) {
                        [typeArray addObject:@"goods"];
                    }
                    if ([[tempDic objectForKey:@"type"]isEqualToString:@"card_course"]) {
                        [typeArray addObject:@"card_course"];
                    }
                    if ([[tempDic objectForKey:@"type"]isEqualToString:@"card_time"]) {
                        [typeArray addObject:@"card_time"];
                    }
                    if ([[tempDic objectForKey:@"type"]isEqualToString:@"ticket"]) {
                        [typeArray addObject:@"ticket"];
                    }
                }
                if (typeArray.count>0) {
                    [MzzHud toastWithTitle:@"提示" message:@"您的订单里包含不能分期商品，请重新下单"];
                }else{
                    MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
                    [vc setOrderDic:dic withType:6 andYemianStyle:YemianFenQi wiTitle:@"支付"];
                    [self.navigationController pushViewController:vc animated:NO];
                }
            }else{
                [MzzHud toastWithTitle:@"提示" message:@"订单金额不能小于应付金额"];
            }
        }
    }else{
        [SaleListRequest requestGeXingZhiDanParam:parmsdic resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                MzzHud *hud = [[MzzHud alloc] initWithTitle:@"温馨提示" message:@"开单成功，请耐心等待后续人员的操作" leftButtonTitle:@"返回列表" rightButtonTitle:@"继续开单" click:^(NSInteger index) {
                    if (index ==0) {
                        for (UIViewController *temp in self.navigationController.viewControllers) {
                            if ([temp isKindOfClass:[OrderManagementViewController class]]) {
                                [self.navigationController popToViewController:temp animated:NO];
                            }
                        }
                    }else{
                        for (UIViewController *temp in self.navigationController.viewControllers) {
                            if ([temp isKindOfClass:[OrderSaleViewController class]]) {
                                [self.navigationController popToViewController:temp animated:NO];
                            }
                        }
                    }
                }];
                hud.contentTipView.btnCancel.hidden = YES;
                [hud show];
            }else{
                [_shenpiTb removeFromSuperview];;
                _shenpiTb = nil;
            }
        }];
    }

}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

