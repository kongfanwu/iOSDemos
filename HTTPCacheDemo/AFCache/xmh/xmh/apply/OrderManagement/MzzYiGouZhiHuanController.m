//
//  MzzShengkaXukaController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzYiGouZhiHuanController.h"
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
#import "MzzZhiHuanDuoTui.h"
#import "MzzZhiHuanShaoBu.h"
#import "MzzZhiHuanDengZhi.h"
#import "SABalanceModel.h"
#import "OrderSaleViewController.h"
#import "YiGouZhiHuanFuckHeader.h"
#import "FWDCommentCell.h"

@interface MzzYiGouZhiHuanController ()<UITableViewDelegate,UITableViewDataSource,LMJDropdownMenuDelegate,UITextFieldDelegate>
{
    SaleServiceCommitHeader *_commitHeader;
    MzzJisuantongjiView   *_downView;
    YiGouZhiHuanFuckHeader *_fuckHeader;
    NSString *leixing;
    BOOL ifOrNo;//是否走审批
    NSString *moneyStr;//少补应退款项
    NSMutableArray *guishuArr;
    NSString *_content;

}
@property (strong, nonatomic)  UIButton *commitBtn;
@property (strong, nonatomic)  UIButton *tijiaoBtn;

@property (strong, nonatomic)  UITableView *shenpiTb;
@property (strong ,nonatomic)  LJiangZengListModel *shenpiList;
@property (strong ,nonatomic)LJiangZengPersonModel *shenpiModel;
@property (nonatomic ,assign)CGFloat webHeight;
@property (strong ,nonatomic)MzzAwardView *awardView;
@property (strong ,nonatomic)MzzYejihuafenView *downTwoView;
@property (strong ,nonatomic)FWDCommentCell * commentCell;
@property (strong ,nonatomic)UIScrollView    *bgScroll;
@property (strong ,nonatomic)MzzZhiHuanDuoTui *duotui;
@property (strong ,nonatomic)MzzZhiHuanShaoBu *shaobu;
@property (strong ,nonatomic)MzzZhiHuanDengZhi *dengzhi;
@property (strong ,nonatomic)NSMutableArray *awardList;
@property (strong ,nonatomic)SABalanceModel *balanceModel;
@property (nonatomic ,assign)CGFloat tuikuaiHeight;
@property (nonatomic ,assign)CGFloat awardHeight;
@end

@implementation MzzYiGouZhiHuanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _awardHeight = 80;
   
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self creatNav];
    [self requsetWebHeight];
}

- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"结算统计" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.lineImageView.hidden = YES;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)requsetWebHeight{
    WeakSelf;
    
    _downView = [[MzzJisuantongjiView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 10)];
    NSString *dataStr;
        
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];
    NSMutableArray * ygArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *cartdic = _commitDic[@"cart"];
    
    NSMutableArray *y_awardArr = cartdic[@"y_award"];
    NSMutableArray *awardArr = cartdic[@"award"];
    
    for (NSDictionary *tmpDic in y_awardArr) {
        NSMutableDictionary *dicinside = [[NSMutableDictionary alloc]init];
        dicinside[@"count"] = [NSString stringWithFormat:@"%@",tmpDic[@"num"]];
        dicinside[@"money"] = tmpDic[@"price"];
        dicinside[@"name"] = tmpDic[@"name"];
        [ygArr addObject:dicinside];
    }
    [dataDic setValue:ygArr forKey:@"yg"];
    
    NSMutableArray * zhArr = [[NSMutableArray alloc]init];
    
    for (NSDictionary *tmpDic in awardArr) {
        NSMutableDictionary *dicinside = [[NSMutableDictionary alloc]init];
        dicinside[@"count"] = [NSString stringWithFormat:@"%@",tmpDic[@"num"]];
        dicinside[@"money"] = tmpDic[@"price"];
        dicinside[@"name"] = tmpDic[@"name"];
        [zhArr addObject:dicinside];
    }
    [dataDic setValue:zhArr forKey:@"zh"];

    dataStr = dataDic.jsonData;
    
    NSString *js = [NSString stringWithFormat:@"YiGouZhiHuanXiaoPiaocallJs('%@')",dataStr];
    [_downView setupRequestUrl:[NSString stringWithFormat:@"%@sales/list_yigou.html",SERVER_H5] andEvaluateJavaScript:js];
    [_downView setWebHeight:^(CGFloat height) {
        _webHeight = height;
        [weakSelf initsubviews];
        [weakSelf end];
    }];
}
- (void)initsubviews{
    WeakSelf;
   
    _commitHeader = [[[NSBundle mainBundle] loadNibNamed:@"SaleServiceCommitHeader" owner:nil options:nil] firstObject];
    _commitHeader.frame = CGRectMake(0,Heigh_Nav, SCREEN_WIDTH, 75);
    _commitHeader.backGroundTopView.backgroundColor = [UIColor whiteColor];
    _commitHeader.backgroundColor = [UIColor whiteColor];
    _commitHeader.viewToTopConstraint.constant = 15;
    [self.view addSubview:_commitHeader];
    _commitHeader.lb.text = [NSString stringWithFormat:@"%@ (%@)",_name,_mobile];
    
    _fuckHeader = [[[NSBundle mainBundle]loadNibNamed:@"YiGouZhiHuanFuckHeader" owner:nil options:nil] firstObject];
    _fuckHeader.frame = CGRectMake(0, _commitHeader.bottom, SCREEN_WIDTH, 51);
    [self.view addSubview:_fuckHeader];
    [_fuckHeader YiGouZhiHuanFuckHeader:3];

    _bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _fuckHeader.bottom+10, SCREEN_WIDTH,SCREEN_HEIGHT - _commitHeader.bottom-136)];
    _bgScroll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgScroll];
    
    
    _downView.frame = CGRectMake(15,0, SCREEN_WIDTH-30, _webHeight);
    _downView.layer.cornerRadius = 6;
    _downView.layer.masksToBounds = YES;
    [_bgScroll addSubview:_downView];
    
    NSString *huishou = [_commitDic objectForKey:@"huishouTotalPrice"];
    NSString *zhihuan = [_commitDic objectForKey:@"zhiHuanTotalPrice"];
    
    if (huishou.integerValue < zhihuan.integerValue) {
        _shaobu = [[NSBundle mainBundle] loadNibNamed:@"MzzZhiHuanView" owner:nil options:nil][0];
        _shaobu.frame = CGRectMake(15, _downView.bottom + 10, SCREEN_WIDTH-30, _shaobu.height);
        _shaobu.huishoujine.text = huishou;
        _shaobu.zhihuanjine.text = zhihuan;
        _shaobu.yingfukuanxiang.text = [NSString stringWithFormat:@"%.2f",zhihuan.floatValue - huishou.floatValue];
        leixing = @"少补";
        moneyStr =  _shaobu.yingfukuanxiang.text;
        _shaobu.layer.cornerRadius = 6;
        _shaobu.layer.masksToBounds = YES;
        [_bgScroll addSubview:_shaobu];
    }
  
    if (huishou.integerValue > zhihuan.integerValue) {
        _duotui = [[NSBundle mainBundle] loadNibNamed:@"MzzZhiHuanView" owner:nil options:nil][1];
        _duotui.frame = CGRectMake(15, _downView.bottom + 10, SCREEN_WIDTH-30, _duotui.height);
        _duotui.tuikuanguishu.delegate = self;
        _duotui.huishoujine.text = huishou;
        _duotui.zhihuanjine.text = zhihuan;
        _duotui.yingtuikuanxiang.text = [NSString stringWithFormat:@"%.2f",huishou.floatValue - zhihuan.floatValue];
        leixing = @"多退";
        _duotui.layer.cornerRadius = 6;
        _duotui.layer.masksToBounds = YES;
        [_bgScroll addSubview:_duotui];
        [SaleListRequest requestUserBalanceUserId:[NSString stringWithFormat:@"%ld",_user_id] resultBlock:^(SABalanceModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                _balanceModel = model;
                NSMutableArray *titlearr = [NSMutableArray array];
                for (SABalanceDataModel *data in model.data) {
                    [titlearr addObject:data.name];
                }
                [_duotui.tuikuanguishu setMenuTitles:titlearr rowHeight:30];
                _tuikuaiHeight = titlearr.count * 30;
            }
        }];
    }
    
    if (huishou.integerValue == zhihuan.integerValue) {
        _dengzhi = [[NSBundle mainBundle] loadNibNamed:@"MzzZhiHuanView" owner:nil options:nil][2];
        _dengzhi.frame = CGRectMake(15, _downView.bottom +  10, SCREEN_WIDTH-30, _dengzhi.height);
        _dengzhi.huishoujine.text = huishou;
        _dengzhi.zhihuanjine.text = zhihuan;
        leixing = @"等值";
        _dengzhi.layer.cornerRadius = 6;
        _dengzhi.layer.masksToBounds = YES;
        [_bgScroll addSubview:_dengzhi];
    }
    
    _awardView  = [[[NSBundle mainBundle]loadNibNamed:@"MzzAwardView" owner:nil options:nil]firstObject];
    _awardView.store_code = _store_code;
    _awardView.user_id = _user_id;
    CGFloat zhihuanBottom = 0;
    if (_shaobu) {
        zhihuanBottom = _shaobu.bottom;
    }
    if (_duotui) {
        zhihuanBottom = _duotui.bottom;
    }
    if (_dengzhi) {
        zhihuanBottom = _dengzhi.bottom;
    }
    _awardView.frame = CGRectMake(15, zhihuanBottom+10, SCREEN_WIDTH-30, _awardHeight);
    _awardView.layer.cornerRadius = 6;
    _awardView.layer.masksToBounds = YES;
    __weak UIButton * weaktijiaoBtn = _tijiaoBtn;
    __weak UIButton * weakcommitBtn = _commitBtn;
    [_awardView setAwardCommit:^(NSMutableArray<SaleModel *> *list, BOOL ifdele) {
        if (!ifdele) {
            [weaktijiaoBtn setBackgroundColor:[UIColor grayColor]];
            weaktijiaoBtn.userInteractionEnabled = NO;
            [weakcommitBtn setBackgroundColor:kBtn_Commen_Color];
            weakcommitBtn.userInteractionEnabled = YES;
            ifOrNo = YES;
        }else{
            if (list.count == 0) {
                [weaktijiaoBtn setBackgroundColor:kBtn_Commen_Color];
                weaktijiaoBtn.userInteractionEnabled = YES;
                [weakcommitBtn setBackgroundColor:[UIColor grayColor]];
                weakcommitBtn.userInteractionEnabled = NO;
                ifOrNo = NO;
            }else{
                [weaktijiaoBtn setBackgroundColor:[UIColor grayColor]];
                weaktijiaoBtn.userInteractionEnabled = NO;
                [weakcommitBtn setBackgroundColor:kBtn_Commen_Color];
                weakcommitBtn.userInteractionEnabled = YES;
                ifOrNo = YES;
            }

        }
        
        _awardHeight = 80 + list.count * 44;
        weakSelf.awardView.height = weakSelf.awardHeight;
         weakSelf.downTwoView.frame = CGRectMake(15,weakSelf.awardView.bottom+10, SCREEN_WIDTH-30,195+_downTwoView.yuangongArrays.count*25);
        weakSelf.commentCell.frame = CGRectMake(15,_downTwoView.bottom+10, SCREEN_WIDTH-30,145);
        weakSelf.bgScroll.contentSize = CGSizeMake(SCREEN_WIDTH, weakSelf.commentCell.bottom);
        //奖赠数据保存
        _awardList = [NSMutableArray array];
        for (SaleModel *model in list) {
            NSMutableDictionary *modeldic = [NSMutableDictionary dictionary];
            [modeldic setObject:model.code forKey:@"code"];
            [modeldic setObject:[NSString stringWithFormat:@"%ld",model.uid] forKey:@"id"];
            [modeldic setObject:model.name forKey:@"name"];
            [modeldic setObject:[NSString stringWithFormat:@"%ld",model.mzzAwardCount] forKey:@"num"];
            [modeldic setObject:[NSString stringWithFormat:@"%.2ld",model.mzzAwardTotlePrice/model.mzzAwardCount] forKey:@"price"];
            [modeldic setObject:model.cardType forKey:@"type"];
            [modeldic setObject:model.unit forKey:@"uint"];
            [weakSelf.awardList addObject:modeldic];
        }
    }];
    [_bgScroll addSubview:_awardView];
    
    //改图层
    if (_duotui) {
        [_bgScroll bringSubviewToFront:_duotui];
    }
    if (_shaobu) {
        [_bgScroll bringSubviewToFront:_shaobu];
    }
    if (_dengzhi) {
         [_bgScroll bringSubviewToFront:_dengzhi];
    }
    
    _downTwoView = [[[NSBundle mainBundle] loadNibNamed:@"MzzYejihuafenView" owner:nil options:nil] firstObject];
    _downTwoView.layer.cornerRadius = 6;
    _downTwoView.layer.masksToBounds = YES;
    _downTwoView.storeCode = _store_code;
    _downTwoView.clickJs = ^(NSInteger count) {
        weakSelf.downTwoView.frame = CGRectMake(15,_awardView.bottom+10, SCREEN_WIDTH-30,195+count*25);
        weakSelf.commentCell.frame = CGRectMake(15,_downTwoView.bottom+10, SCREEN_WIDTH-30,145);
        weakSelf.bgScroll.contentSize = CGSizeMake(SCREEN_WIDTH, weakSelf.commentCell.bottom);
        
    };
    _downTwoView.frame = CGRectMake(15,_awardView.bottom+10, SCREEN_WIDTH-30,195);
    
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
    [_commitBtn setTitle:@"提交审批" forState:UIControlStateNormal];
    [_commitBtn setBackgroundColor:[UIColor grayColor]];
    _commitBtn.userInteractionEnabled = NO;
    _commitBtn.frame = CGRectMake(SCREEN_WIDTH - (SCREEN_WIDTH/2 - 30 - 20)-30,  10, SCREEN_WIDTH/2 - 30 - 20, 40);
    _commitBtn.layer.cornerRadius = 6;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(conmitEvent) forControlEvents:UIControlEventTouchUpInside];
    [btnBack addSubview:_commitBtn];
    _tijiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tijiaoBtn setTitle:@"提交结算" forState:UIControlStateNormal];
    [_tijiaoBtn setBackgroundColor:kBtn_Commen_Color];
    _tijiaoBtn.userInteractionEnabled = YES;
    _tijiaoBtn.frame = CGRectMake(30,  10, SCREEN_WIDTH/2 - 30 - 20, 40);
    _tijiaoBtn.layer.cornerRadius = 6;
    _tijiaoBtn.layer.masksToBounds = YES;
    [_tijiaoBtn addTarget:self action:@selector(tijiaoEvent) forControlEvents:UIControlEventTouchUpInside];
    [btnBack addSubview:_tijiaoBtn];
    _downTwoView.superVc = self;
    ifOrNo = NO;
}
- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    SABalanceDataModel *model =[_balanceModel.data objectAtIndex:number];
    if (_duotui) {
        if (model.bank_id !=0) {
            [_commitDic setValue:@"1" forKey:@"tk_type"];
        }else{
            [_commitDic setValue:@"2" forKey:@"tk_type"];
            [_commitDic setValue:[NSString stringWithFormat:@"%ld",model.card_id] forKey:@"tk_code"];
        }
    }
}
- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat zhihuanBottom = 0;
        if (_duotui) {
            _duotui.height +=_tuikuaiHeight;
            zhihuanBottom = _duotui.bottom;
        }
        if (_shaobu) {
            _shaobu.height +=_tuikuaiHeight;
            zhihuanBottom = _shaobu.bottom;
        }
        if (_dengzhi) {
            _dengzhi.height +=_tuikuaiHeight;
            zhihuanBottom = _dengzhi.bottom;
        }
        _awardView.frame = CGRectMake(15, zhihuanBottom, SCREEN_WIDTH-30, _awardHeight);
        _downTwoView.frame = CGRectMake(15,_awardView.bottom, SCREEN_WIDTH-30,450);
    }];
    
}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat zhihuanBottom = 0;
        if (_duotui) {
            _duotui.height -=_tuikuaiHeight;
            zhihuanBottom = _duotui.bottom;
        }
        if (_shaobu) {
            _shaobu.height -=_tuikuaiHeight;
            zhihuanBottom = _shaobu.bottom;
        }
        if (_dengzhi) {
            _dengzhi.height -=_tuikuaiHeight;
            zhihuanBottom = _dengzhi.bottom;
        }
        _awardView.frame = CGRectMake(15, zhihuanBottom, SCREEN_WIDTH-30, _awardHeight);
        _downTwoView.frame = CGRectMake(15,_awardView.bottom, SCREEN_WIDTH-30,450);
    }];
}
#pragma mark -------------提交结算---------------
-(void)tijiaoEvent
{
    [self panduan];
}
- (void)conmitEvent{

    [self panduan];

}
-(void)panduan{
    if (!_downTwoView.selectYejiguishu) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择业绩归属" ];
        return ;
    }
    if (!_downTwoView.selectStoreModel.store_code) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择门店归属" ];
        return ;
    }
    guishuArr = [[NSMutableArray alloc]init];
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
    float bfb = 0.0;
    for (NSDictionary *yeji in guishuArr) {
        float temp = [[yeji objectForKey:@"bfb"]floatValue];
        bfb = bfb + temp;
    }
    NSLog(@"-------%f",bfb);
        if ([leixing isEqualToString:@"少补"]) {
            if ([moneyStr floatValue] != bfb) {
                [MzzHud toastWithTitle:@"提示" message:@"业绩归属总计不等于应付金额，请重新分配"];
                return ;
            }else{
                [self requestShenpi];
            }
        }else{
            if (bfb !=0) {
                [MzzHud toastWithTitle:@"提示" message:@"业绩归属总计不等于0，请重新分配"];
                return ;
            }else{
                [self requestShenpi];
            }
        }

}
- (void)requestShenpi
{
    NSString * joincode = [ShareWorkInstance shareInstance].join_code;
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * framId = [NSString stringWithFormat:@"%ld",infomodel.data.join_code[0].fram_id];
    
    
    [ApproveRequest requestExchangeApproveJoinCode:joincode framId:framId resultBlock:^(LJiangZengListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _shenpiList = model;
            if (ifOrNo) {
                [self creatShenpiTb];
            }else{
                //提交结算
                [self commitShenpi];
            }
            }else{
                [MzzHud toastWithTitle:@"提示" message:@"本店暂无审批人"];
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
    //置换
    if (_shaobu) {
        [_commitDic setValue:@"2" forKey:@"zh_type"];
        [_commitDic setValue:_shaobu.yingfukuanxiang.text forKey:@"heji"];
        [_commitDic setValue:_shaobu.yingfukuanxiang.text forKey:@"amount_t"];
        [_commitDic setValue:_shaobu.huishoujine.text forKey:@"huishou_amount"];
        [_commitDic setValue:_shaobu.zhihuanjine.text forKey:@"zhihuan_amount"];
    }
    if (_duotui) {
        [_commitDic setValue:@"1" forKey:@"zh_type"];
        [_commitDic setValue:_duotui.yingtuikuanxiang.text forKey:@"heji"];
        [_commitDic setValue:_duotui.yingtuikuanxiang.text forKey:@"amount_t"];
        [_commitDic setValue:_duotui.huishoujine.text forKey:@"huishou_amount"];
        [_commitDic setValue:_duotui.zhihuanjine.text forKey:@"zhihuan_amount"];
    }
    if (_dengzhi) {
        [_commitDic setValue:@"3" forKey:@"zh_type"];
        [_commitDic setValue:@"" forKey:@"heji"];
        [_commitDic setValue:@"" forKey:@"amount_t"];
        [_commitDic setValue:_dengzhi.huishoujine.text forKey:@"huishou_amount"];
        [_commitDic setValue:_dengzhi.zhihuanjine.text forKey:@"zhihuan_amount"];
    }
    //奖赠
     [dic setValue:_awardList forKey:@"store_give"];
    //审批
    [dic setValue:[NSString stringWithFormat:@"%ld",_shenpiModel.uid] forKey:@"transfer"];
    [dic setValue:_shenpiList.code forKey:@"code"];
    [dic setValue:[NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id] forKey:@"fram_id"];

//    NSArray * award = dic[@"cart"][@"award"];
//    for (int i = 0; i <award.count; i++) {
//        NSMutableDictionary* subdict = award[i];
//        NSString * purPrice = [NSString stringWithFormat:@"%ld",[subdict[@"price"] integerValue]/[subdict[@"num"] integerValue]];
//        [subdict setObject:purPrice forKey:@"price"];
//    }
    [dic setValue:guishuArr forKey:@"guishu"];
    if (ifOrNo) {
        [dic setValue:@(1) forKey:@"need_approval"];
    }else{
        [dic setValue:@(0) forKey:@"need_approval"];
    }
    NSString *str = dic.jsonData;
    NSMutableDictionary *parmsdic = [[NSMutableDictionary alloc]init];
    [parmsdic setValue:str forKey:@"result"];

    [SaleListRequest requestZhiHuanParams:parmsdic resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
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
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}

@end

