//
//  CustomerBillViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/22.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerBillViewController.h"
#import "BeautyCardCell.h"
#import "MzzCustomerRequest.h"
#import "CustomerBillOne.h"
#import "CustomerBillTwo.h"
#import "CustomerBillThree.h"
#import "CustomerBillFour.h"
#import "CustomerBillFive.h"
#import "MzzUser_bill.h"
#import "CustomerBillAddModel.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "CustomerBillConfirmViewController.h"
#import "TimeTools.h"
#import "CylCustomGouWuCheCell.h"
#import "GKGLBillVerifyVC.h"
@interface CustomerBillViewController ()<UITableViewDataSource,UITableViewDelegate>{
    customNav               *nav;
    NSIndexPath             *_lastindexPath;
    NSMutableArray          *_leftArr;
    NSArray                 *_leftCardArr;
    
    CustomerBillOne         *_oneView;
    CustomerBillTwo         *_twoView;
    CustomerBillThree       *_threeView;
    CustomerBillTwo         *_threeSubView;
    CustomerBillThree       *_fourView;
    CustomerBillFour        *_fourSubView;
    CustomerBillFour        *_fiveView;
    CustomerBillFour        *_sixView;
    CustomerBillFour        *_sevenView;
    CustomerBillFour        *_eightView;
    CustomerBillFive        *_fourSubTwoView;
    
    UIView           *_downBgView;
    NSArray          *_chuzhiArr;
    NSArray          *_timeArr;
    NSArray          *_renxuanArr;
    NSArray          *_tehuiArr;
    NSArray          *_xiangmuArr;
    NSArray          *_chanpinArr;
    NSArray          *_piaojuanArr;
    
    NSInteger         _typeInteger;//左边卡的类型
    
    NSString    *_oneStr;
    NSString    *_twoStr;
    NSString    *_threeStr;
    NSString    *_fourStr;
    NSString    *_fiveStr;
    NSString    *_sixStr;
    NSString    *_sevenStr;
    NSString    *_eightStr;
    
    UIView      *_bgView;
    UIButton    *_bgBlackBtn;
    UITableView *_tbGouChe;
    
    NSMutableArray *_stored_cardArr;
    NSMutableArray *_card_timeArr;
    NSMutableArray *_card_numArr;
    NSMutableArray *_proArr;
    NSMutableArray *_goodsArr;
    NSMutableArray *_ticketArr;
    
    
}

@end

@implementation CustomerBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(218, 218, 218);
    _stored_cardArr = [[NSMutableArray alloc]init];
    _card_timeArr = [[NSMutableArray alloc]init];
    _card_numArr = [[NSMutableArray alloc]init];
    _proArr = [[NSMutableArray alloc]init];
    _goodsArr = [[NSMutableArray alloc]init];
    _ticketArr = [[NSMutableArray alloc]init];

    _leftCardArr = [@[@"储值卡",@"时间卡",@"任选卡",@"项目",@"产品",@"票券"] mutableCopy];//,@"特惠卡"
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
    params[@"join_code"] = _customerModel.join_code?_customerModel.join_code:join_code;
    params[@"user_id"] = [NSString stringWithFormat:@"%@",@(_customerModel.uid)];
    params[@"type"] = @"stored_card";
    params[@"store_code"] = _customerModel.store_code; //= @"MD000026";
    
    [self creatNav];
    [self initSubviews];
    //储值卡
    [MzzCustomerRequest requestBillParams:params resultBlock:^(MzzUser_bill *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _chuzhiArr = model.list;
           
            if (_isModify) {
                if (_sectionModify == 0) {
                    [self deepWithSelect];
                }
            } else {
                NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
                [self tableView:_tbView1 didSelectRowAtIndexPath:indexPath1];
            }
        }
    }];
    //时间卡
    params[@"type"] = @"card_time";
    [MzzCustomerRequest requestBillParams:params resultBlock:^(MzzUser_bill *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _timeArr = model.list;
            if (_isModify) {
                if (_sectionModify == 1) {
                    [self deepWithSelect];
                }
            }
        }
    }];
    //任选卡
    params[@"type"] = @"card_num";
    [MzzCustomerRequest requestBillParams:params resultBlock:^(MzzUser_bill *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _renxuanArr = model.list;
            if (_isModify) {
                if (_sectionModify == 2) {
                    [self deepWithSelect];
                }
            }
        }
    }];
    //项目
    params[@"type"] = @"pro";
    [MzzCustomerRequest requestBillParams:params resultBlock:^(MzzUser_bill *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _xiangmuArr = model.list;
            if (_isModify) {
                if (_sectionModify == 3) {
                    [self deepWithSelect];
                }
            }
        }
    }];
    //产品
    params[@"type"] = @"goods";
    [MzzCustomerRequest requestBillParams:params resultBlock:^(MzzUser_bill *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _chanpinArr = model.list;
            if (_isModify) {
                if (_sectionModify == 4) {
                    [self deepWithSelect];
                }
            }
        }
    }];
    //票券
    params[@"type"] = @"ticket";
    [MzzCustomerRequest requestBillParams:params resultBlock:^(MzzUser_bill *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _piaojuanArr = model.list;
            if (_isModify) {
                if (_sectionModify == 5) {
                    [self deepWithSelect];
                }
            }
        }
    }];
}
- (void)deepWithSelect{
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:_sectionModify inSection:0];
    [self tableView:_tbView1 didSelectRowAtIndexPath:indexPath1];
}
- (void)creatNav{
    nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"顾客账单" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)initSubviews{
    _line1.frame = CGRectMake(0, nav.bottom, SCREEN_WIDTH, 10);
    _line1.backgroundColor = [UIColor whiteColor];
    NSInteger offyset= 49;
//    if (_isModify) {
//        _downBgView.hidden = YES;
//        offyset = 0;
//    }
    
    
    _tbView1.frame = CGRectMake(0, nav.bottom+10,80,SCREEN_HEIGHT - nav.bottom-10-offyset);
    _tbView1.backgroundColor = [ColorTools colorWithHexString:@"#F5F5F5"];
    _tbView1.delegate = self;
    _tbView1.dataSource = self;
    
    _rightScroll.frame = CGRectMake(_tbView1.right, _tbView1.top, SCREEN_WIDTH - _tbView1.width, _tbView1.height);
    [self initRightOneView];
    [self initRightTwoView];
    
    _downBgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-70, SCREEN_WIDTH, 70)];
    [self.view addSubview:_downBgView];
    
    UIImage *imgGouehce = [UIImage imageNamed:@"stgkgl_gouwuchewushangpin"];
    _btnGouWuChe = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnGouWuChe.frame = CGRectMake(10,10, imgGouehce.size.width, imgGouehce.size.height);
    [_btnGouWuChe setImage:imgGouehce forState:UIControlStateNormal];
    [_downBgView addSubview:_btnGouWuChe];
    [_btnGouWuChe addTarget:self action:@selector(btnGoueCheEvent) forControlEvents:UIControlEventTouchUpInside];

    
    _lbNum = [[UILabel alloc]initWithFrame:CGRectMake(_btnGouWuChe.center.x+5, 5, 20, 15)];
    _lbNum.backgroundColor = [UIColor whiteColor];
    _lbNum.layer.masksToBounds = YES;
    _lbNum.layer.cornerRadius = 7;
    _lbNum.layer.borderColor = [Theme_RedColor CGColor];
    _lbNum.layer.borderWidth = 0.5;
    _lbNum.textColor = Theme_RedColor;
    _lbNum.font = [UIFont systemFontOfSize:12];
    _lbNum.textAlignment = NSTextAlignmentCenter;
    _lbNum.text = @"0";
    _lbNum.hidden = YES;
    [_downBgView addSubview:_lbNum];
    
    _btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnNext.frame = CGRectMake(SCREEN_WIDTH - 120*WIDTH_SALE_BASE, 70 - 49, 120*WIDTH_SALE_BASE, 49);
    [_downBgView addSubview:_btnNext];
    
    [_btnNext setTitle:@"提交" forState:UIControlStateNormal];
    [_btnNext setTitle:@"提交" forState:UIControlStateSelected];
    [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _btnNext.backgroundColor = kBtn_Commen_Color;
    _btnNext.titleLabel.font = FONT_SIZE(17);
    [_btnNext addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    
    if (_isModify) {
        _downBgView.hidden = YES;
    }
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:_tbView1 didSelectRowAtIndexPath:indexPath1];
    
    [_btn1 setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [_btn1 setTitleColor:kBtn_Commen_Color forState:UIControlStateHighlighted];
    _btn1.titleLabel.font = FONT_SIZE(15);
    _btn1.layer.cornerRadius = 5;
    _btn1.backgroundColor = [ColorTools colorWithHexString:@"#FEF2F8"];
    _btn1.frame = CGRectMake(15, 200, (_rightScroll.width - 45)/2.0, 35);
    
    [_btn2 setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [_btn2 setTitleColor:kBtn_Commen_Color forState:UIControlStateHighlighted];
    _btn2.titleLabel.font = FONT_SIZE(15);
    _btn2.layer.cornerRadius = 5;
    _btn2.backgroundColor = [ColorTools colorWithHexString:@"#FEF2F8"];
    _btn2.frame = CGRectMake(_btn1.right+15, 200, (_rightScroll.width - 45)/2.0, 35);
    
    _lbLeft.textColor = kLabelText_Commen_Color_9;
    _lbLeft.font = FONT_SIZE(10);
    
    _lb1.textColor = kLabelText_Commen_Color_9;
    _lb1.font = FONT_SIZE(10);
    
    _lb2.textColor = kLabelText_Commen_Color_9;
    _lb2.font = FONT_SIZE(10);
}
- (void)btnGoueCheEvent{
    if (_bgView) {
        [_bgView removeFromSuperview];
    }
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgView];
    
    _bgBlackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bgBlackBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    _bgBlackBtn.backgroundColor = [UIColor blackColor];
    _bgBlackBtn.alpha = 0.6;
    [_bgView addSubview:_bgBlackBtn];
    [_bgBlackBtn addTarget:self action:@selector(bgBlackBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    
    _tbGouChe  = [[UITableView alloc]initWithFrame:CGRectMake(0, _bgBlackBtn.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _bgBlackBtn.bottom) style:UITableViewStylePlain];
    _tbGouChe.dataSource = self;
    _tbGouChe.delegate = self;
    _tbGouChe.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_bgView addSubview:_tbGouChe];
    
    [self freshGouWuChe];
}
- (void)bgBlackBtnEvent{
    [_bgView removeFromSuperview];
}
#pragma 先创建
- (void)initRightOneView{
    _oneView = [[[NSBundle mainBundle]loadNibNamed:@"CustomerBillOne" owner:nil options:nil] firstObject];
    _oneView.frame = CGRectMake(0,0, _rightScroll.width, 44);
    [_rightScroll addSubview:_oneView];
}
- (void)initRightTwoView{
    _twoView = [[[NSBundle mainBundle]loadNibNamed:@"CustomerBillTwo" owner:nil options:nil] firstObject];
    _twoView.frame = CGRectMake(0,_oneView.bottom, _rightScroll.width, 44);
    [_rightScroll addSubview:_twoView];
}
- (void)initRightThreeView{
    if (!_threeView) {
        _threeView = [[[NSBundle mainBundle]loadNibNamed:@"CustomerBillThree" owner:nil options:nil] firstObject];
        _threeView.frame = CGRectMake(0,_twoView.bottom, _rightScroll.width, 44);
        [_rightScroll addSubview:_threeView];
    }else{
        _threeView.frame = CGRectMake(0,_twoView.bottom, _rightScroll.width, 44);
        _threeView.hidden = NO;
    }
}
- (void)initRightThreeSubView{
    if (!_threeSubView) {
        _threeSubView = [[[NSBundle mainBundle]loadNibNamed:@"CustomerBillTwo" owner:nil options:nil] firstObject];
        _threeSubView.frame = CGRectMake(0,_twoView.bottom, _rightScroll.width, 44);
        [_rightScroll addSubview:_threeSubView];
    } else {
        _threeSubView.frame = CGRectMake(0,_twoView.bottom, _rightScroll.width, 44);
        _threeSubView.hidden = NO;
    }
}
- (void)initRightFourView{
    if (!_fourView) {
        _fourView = [[[NSBundle mainBundle]loadNibNamed:@"CustomerBillThree" owner:nil options:nil] firstObject];
        _fourView.frame = CGRectMake(0,_threeView.hidden?_threeSubView.bottom:_threeView.bottom,_rightScroll.width, 44);
        [_rightScroll addSubview:_fourView];
    }else{
        _fourView.frame = CGRectMake(0,_threeView.hidden?_threeSubView.bottom:_threeView.bottom,_rightScroll.width, 44);
        _fourView.hidden = NO;
    }
}
- (void)initRightFourSubView{
    if (!_fourSubView) {
        _fourSubView = [[[NSBundle mainBundle]loadNibNamed:@"CustomerBillFour" owner:nil options:nil] firstObject];
        _fourSubView.frame = CGRectMake(0,_threeView?_threeView.bottom:_threeSubView.bottom,_rightScroll.width, 44);
        [_rightScroll addSubview:_fourSubView];
    }else{
        _fourSubView.frame = CGRectMake(0,_threeView?_threeView.bottom:_threeSubView.bottom,_rightScroll.width, 44);
        _fourSubView.hidden = NO;
    }
}
- (void)initRightFourSubTwoView{
    if (!_fourSubTwoView) {
        _fourSubTwoView = [[[NSBundle mainBundle]loadNibNamed:@"CustomerBillFive" owner:nil options:nil] firstObject];
        _fourSubTwoView.frame = CGRectMake(0,_threeView.bottom,_rightScroll.width, 44);
        [_rightScroll addSubview:_fourSubTwoView];
    }else{
        _fourSubTwoView.frame = CGRectMake(0,_threeView.bottom,_rightScroll.width, 44);
        _fourSubTwoView.hidden = NO;
    }
}
- (void)initRightFiveView{
    if (!_fiveView) {
        _fiveView = [[[NSBundle mainBundle]loadNibNamed:@"CustomerBillFour" owner:nil options:nil] firstObject];
        _fiveView.frame = CGRectMake(0,_fourView?_fourView.bottom:_fourSubView.bottom,_rightScroll.width, 44);
        [_rightScroll addSubview:_fiveView];
    }else{
        _fiveView.frame = CGRectMake(0,_fourView?_fourView.bottom:_fourSubView.bottom,_rightScroll.width, 44);
        _fiveView.hidden = NO;
    }
}
- (void)initRightSixView{
    if (!_sixView) {
        _sixView = [[[NSBundle mainBundle]loadNibNamed:@"CustomerBillFour" owner:nil options:nil] firstObject];
        _sixView.frame = CGRectMake(0,_fiveView.bottom,_rightScroll.width, 44);
        [_rightScroll addSubview:_sixView];
    }else{
        _sixView.frame = CGRectMake(0,_fiveView.bottom,_rightScroll.width, 44);
        _sixView.hidden = NO;
    }
}

- (void)initRightSevenView{
    if (!_sevenView) {
        _sevenView = [[[NSBundle mainBundle]loadNibNamed:@"CustomerBillFour" owner:nil options:nil] firstObject];
        _sevenView.frame = CGRectMake(0,_fourView?_fourView.bottom:_fourView.bottom,_rightScroll.width, 44);
        [_rightScroll addSubview:_sevenView];
    }else{
        _sevenView.frame = CGRectMake(0,_fourView?_fourView.bottom:_fourView.bottom,_rightScroll.width, 44);
        _sevenView.hidden = NO;
    }
}

- (void)initRightEightView{
    if (!_eightView) {
        _eightView = [[[NSBundle mainBundle]loadNibNamed:@"CustomerBillFour" owner:nil options:nil] firstObject];
        _eightView.frame = CGRectMake(0,_sevenView.bottom,_rightScroll.width, 44);
        [_rightScroll addSubview:_eightView];
    }else{
        _eightView.frame = CGRectMake(0,_sevenView.bottom,_rightScroll.width, 44);
        _eightView.hidden = NO;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbView1) {
        static NSString *BeautyCardCellindentifier = @"BeautyCardCellindentifier";
        BeautyCardCell *cell;
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BeautyCardCell" owner:nil options:nil] lastObject];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:BeautyCardCellindentifier];
        }
        if (indexPath.row<_leftCardArr.count) {
            [cell reFreshBeautyCardCell:_leftCardArr[indexPath.row]];
            cell.im1.backgroundColor = [ColorTools colorWithHexString:@"#F5F5F5"];
        }
        if (indexPath.row == 0) {
            cell.lb1.textColor = [UIColor whiteColor];
            cell.im1.backgroundColor = kBtn_Commen_Color;
        }
        return cell;
    } else {
        static NSString *CylCustomGouWuCheCellindentifier = @"CylCustomGouWuCheCell";
        CylCustomGouWuCheCell *celltwo;
        if (!celltwo) {
            celltwo = [[[NSBundle mainBundle] loadNibNamed:@"CylCustomGouWuCheCell" owner:self options:nil] lastObject];
        } else {
           celltwo = [tableView dequeueReusableCellWithIdentifier:CylCustomGouWuCheCellindentifier];
        }
        if (indexPath.row <_stored_cardArr.count) {
            NSDictionary *dic = _stored_cardArr[indexPath.row];
            [celltwo freshCylCustomGouWuCheCell:dic];
        }else if (_stored_cardArr.count<= indexPath.row &&indexPath.row <(_stored_cardArr.count + _card_timeArr.count)){
            NSDictionary *dic = _card_timeArr[indexPath.row - _stored_cardArr.count];
            [celltwo freshCylCustomTimeGouWuCheCell:dic];
        }else if ((_stored_cardArr.count + _card_timeArr.count)<= indexPath.row &&indexPath.row <(_stored_cardArr.count + _card_timeArr.count+_card_numArr.count)){
            NSDictionary *dic = _card_numArr[indexPath.row-_stored_cardArr.count -_card_timeArr.count];
            [celltwo freshCylCustomNumGouWuCheCell:dic];
           
        }else if ((_stored_cardArr.count + _card_timeArr.count+_card_numArr.count)<= indexPath.row &&indexPath.row <(_stored_cardArr.count + _card_timeArr.count+_card_numArr.count+_proArr.count)){
            
            NSDictionary *dic = _proArr[indexPath.row-_stored_cardArr.count -_card_timeArr.count -_card_numArr.count];
            [celltwo freshCylCustomNumGouWuCheCell:dic];
        }else if ((_stored_cardArr.count + _card_timeArr.count+_card_numArr.count+_proArr.count)<= indexPath.row &&indexPath.row <(_stored_cardArr.count + _card_timeArr.count+_card_numArr.count+_proArr.count+_goodsArr.count)){
            
            NSDictionary *dic = _goodsArr[indexPath.row-_stored_cardArr.count -_card_timeArr.count -_card_numArr.count-_proArr.count];
            [celltwo freshCylCustomGoodsGouWuCheCell:dic];
        }else if ((_stored_cardArr.count + _card_timeArr.count+_card_numArr.count+_proArr.count+_goodsArr.count)<= indexPath.row &&indexPath.row <(_stored_cardArr.count + _card_timeArr.count+_card_numArr.count+_proArr.count+_goodsArr.count+_ticketArr.count)){
            
            NSDictionary *dic = _ticketArr[indexPath.row-_stored_cardArr.count -_card_timeArr.count -_card_numArr.count-_proArr.count-_goodsArr.count];
            [celltwo freshCylCustomTicketGouWuCheCell:dic];
        }
        WeakSelf;
        celltwo.btnCylCustomGouWuCheCellDelBlock = ^(NSDictionary *dic) {
            
            BOOL isFind = NO;
            if (!isFind) {
                for (NSDictionary *tmpDic in _stored_cardArr) {
                    if ([dic[@"code"] isEqualToString:tmpDic[@"code"]]) {
                        [_stored_cardArr removeObject:tmpDic];
                        isFind = YES;
                        break;
                    }
                }
            }
            if (!isFind) {
                for (NSDictionary *tmpDic in _card_timeArr) {
                    if ([dic[@"code"] isEqualToString:tmpDic[@"code"]]) {
                        [_card_timeArr removeObject:tmpDic];
                        isFind = YES;
                        break;
                    }
                }
            }
            if (!isFind) {
                for (NSDictionary *tmpDic in _card_numArr) {
                    if ([dic[@"code"] isEqualToString:tmpDic[@"code"]]) {
                        [_card_numArr removeObject:tmpDic];
                        isFind = YES;
                        break;
                    }
                }
            }
            if (!isFind) {
                for (NSDictionary *tmpDic in _proArr) {
                    if ([dic[@"code"] isEqualToString:tmpDic[@"code"]]) {
                        [_proArr removeObject:tmpDic];
                        isFind = YES;
                        break;
                    }
                }
            }
            if (!isFind) {
                for (NSDictionary *tmpDic in _goodsArr) {
                    if ([dic[@"code"] isEqualToString:tmpDic[@"code"]]) {
                        [_goodsArr removeObject:tmpDic];
                        isFind = YES;
                        break;
                    }
                }
            }
            if (!isFind) {
                for (NSDictionary *tmpDic in _ticketArr) {
                    if ([dic[@"code"] isEqualToString:tmpDic[@"code"]]) {
                        [_ticketArr removeObject:tmpDic];
                        isFind = YES;
                        break;
                    }
                }
            }
            [weakSelf freshGouWuChe];
        };
        return celltwo;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tbView1) {
        return _leftCardArr.count;
    } else {
        NSInteger numm = [self jisuanNum];
        return numm;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbView1) {
        return 50;
    } else {
        return 90;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _tbView1) {
        return nil;
    } else {
       UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        header.backgroundColor = [UIColor whiteColor];
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
        lb.font = [UIFont systemFontOfSize:13];
        lb.text = @"添加账单";
        lb.textColor = kLabelText_Commen_Color_6;
        [header addSubview:lb];
        
        UILabel *lb2 = [[UILabel alloc]init];;
        lb2.textColor = kLabelText_Commen_Color_9;
        lb2.font = FONT_SIZE(13);
        lb2.text = @"清空";
        [lb2 sizeToFit];
        lb2.frame =CGRectMake(SCREEN_WIDTH-15-lb2.width, 10, lb2.width, 20);
        [header addSubview:lb2];
        
        UIImage * image4 = [UIImage imageNamed:@"beautyshanchu"];
        UIImageView *im4 = [[UIImageView alloc]init];;
        im4.image = image4;
        im4.frame =CGRectMake(lb2.left -6-image4.size.width, 0, image4.size.width, image4.size.height);
        im4.userInteractionEnabled = YES;
        im4.center = CGPointMake(im4.center.x, lb2.center.y);
        [header addSubview:im4];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(im4.left, 0, lb2.right - im4.left, 40);
        [btn1 addTarget:self action:@selector(delEvent) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:btn1];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, header.height-1, SCREEN_WIDTH, 1)];
        line.backgroundColor = kBackgroundColor;
        [header addSubview:line];
        return header;
    }
}
- (void)delEvent{
    [_stored_cardArr removeAllObjects];
    [_card_timeArr removeAllObjects];
    [_card_numArr removeAllObjects];
    [_proArr removeAllObjects];
    [_goodsArr removeAllObjects];
    [_ticketArr removeAllObjects];
    [_bgView removeFromSuperview];
     _lbNum.text = [NSString stringWithFormat:@"%@",@(0)];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _tbView1) {
        return 0;
    } else {
        return 50;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tbView1) {
        
    if (_lastindexPath) {
        BeautyCardCell *cell = [_tbView1 cellForRowAtIndexPath:_lastindexPath];
        cell.lb1.textColor = kLabelText_Commen_Color_6;
        cell.im1.backgroundColor = [ColorTools colorWithHexString:@"#F5F5F5"];
    }
    BeautyCardCell *cell = [_tbView1 cellForRowAtIndexPath:indexPath];
    cell.lb1.textColor = kBtn_Commen_Color;
    cell.im1.backgroundColor = [UIColor whiteColor];
    _lastindexPath = indexPath;
    _typeInteger = indexPath.row;
    switch (indexPath.row) {
        case 0:
        {
            [_oneView reFreshCustomerBillOnewithTitle:@"选择储值卡" withPlaceHolder:@"请选择储值卡" withValue:nil WithSource:[_chuzhiArr mutableCopy]];
            [_twoView reFreshCustomerBillTwowithTitle:@"购买日期" withPlaceHolder:@"请选择购买日期" withValue:nil];
            [self initRightThreeView];
            [_threeView reFreshCustomerBillThreeithTitle:@"购买金额" withPlaceHolder:@"请输入购买金额" withValue:nil];
            _threeSubView.hidden = YES;
            [self initRightFourView];
            [_fourView reFreshCustomerBillThreeithTitle:@"余额" withPlaceHolder:@"请输入卡中余额" withValue:nil];
            _fourSubView.hidden = YES;
            _fourSubTwoView.hidden = YES;
            _btn1.frame = CGRectMake(15, _fourView.bottom+40, (_rightScroll.width - 45)/2.0, 35);
            _btn2.frame = CGRectMake(_btn1.right+15, _fourView.bottom+40, (_rightScroll.width - 45)/2.0, 35);
            _fiveView.hidden = YES;
            _sixView.hidden = YES;
            _lbLeft.hidden = YES;
            _lb1.hidden = YES;
            _lb2.hidden = YES;
            _sevenView.hidden = YES;
            _eightView.hidden = YES;
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeView.text1.text = nil;
            _fourView.text1.text  = nil;
            
            if (_isModify) {
                if (_sectionModify == 0) {
                    _oneView.picker1.text = _dicModify[@"name"];
                    _twoView.picker1.text = _dicModify[@"pay_time"];
                    _threeView.text1.text = [NSString stringWithFormat:@"%@",_dicModify[@"denomination"]];
                    _fourView.text1.text  = [NSString stringWithFormat:@"%@",_dicModify[@"money"]];
                }
            }
        }
            break;
        case 1:
        {
            [_oneView reFreshCustomerBillOnewithTitle:@"选择时间卡" withPlaceHolder:@"请选择时间卡" withValue:nil WithSource:[_timeArr mutableCopy]];
            [_twoView reFreshCustomerBillTwowithTitle:@"购买日期" withPlaceHolder:@"请选择购买日期" withValue:nil];
            [self initRightThreeSubView];
            [_threeSubView reFreshCustomerBillTwowithTitle:@"截止日期" withPlaceHolder:@"请选择截止日期" withValue:nil];
            _threeView.hidden = YES;
            [self initRightFourView];
            [_fourView reFreshCustomerBillThreeithTitle:@"购买金额" withPlaceHolder:@"请输入购买金额" withValue:nil];
            _fourSubView.hidden = YES;
            _fourSubTwoView.hidden = YES;
            _btn1.frame = CGRectMake(15,_fourView.bottom+40 , (_rightScroll.width - 45)/2.0, 35);
            _btn2.frame = CGRectMake(_btn1.right+15, _fourView.bottom+40, (_rightScroll.width - 45)/2.0, 35);
            _btn1.hidden = NO;
            _fiveView.hidden = YES;
            _sixView.hidden = YES;
            _lbLeft.hidden = YES;
            _lb1.hidden = YES;
            _lb2.hidden = YES;
            _sevenView.hidden = YES;
            _eightView.hidden = YES;
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeSubView.picker1.text = nil;
            _fourView.text1.text  = nil;
            
            if (_isModify) {
                if (_sectionModify == 1) {
                    _oneView.picker1.text = _dicModify[@"name"];
                    _twoView.picker1.text = _dicModify[@"pay_time"];
                    _threeSubView.picker1.text = _dicModify[@"end_time"];
                    _fourView.text1.text  = [NSString stringWithFormat:@"%@",_dicModify[@"amount"]];
                }
            }
        }
            break;
        case 2:
        {
            [_oneView reFreshCustomerBillOnewithTitle:@"选择任选卡" withPlaceHolder:@"请选择任选卡" withValue:nil WithSource:[_renxuanArr mutableCopy]];
            [_twoView reFreshCustomerBillTwowithTitle:@"购买日期" withPlaceHolder:@"请选择购买日期" withValue:nil];
            [self initRightThreeView];
            [_threeView reFreshCustomerBillThreeithTitle:@"购买金额" withPlaceHolder:@"请输入购买金额" withValue:nil];
            _threeSubView.hidden = YES;
            [self initRightFourSubView];
            [_fourSubView reFreshCustomerBillFourwithTitle:@"购买次数" withPlaceHolder:@"请输入购买次数" withValue:nil];
            _fourView.hidden = YES;
            _fourSubTwoView.hidden = YES;
            [self initRightFiveView];
            [_fiveView reFreshCustomerBillFourwithTitle:@"剩余次数" withPlaceHolder:@"请输入剩余次数" withValue:nil];
            _btn1.frame = CGRectMake(15, _fiveView.bottom+40, (_rightScroll.width - 45)/2.0, 35);
            _btn2.frame = CGRectMake(_btn1.right+15, _fiveView.bottom+40, (_rightScroll.width - 45)/2.0, 35);
            _sixView.hidden = YES;
            _lbLeft.hidden = YES;
            _lb1.hidden = YES;
            _lb2.hidden = YES;
            _sevenView.hidden = YES;
            _eightView.hidden = YES;
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeView.text1.text = nil;
            _fourSubView.text1.text  = nil;
            _fiveView.text1.text = nil;
            if (_isModify) {
                if (_sectionModify == 2) {
                    _oneView.picker1.text = _dicModify[@"name"];
                    _twoView.picker1.text = _dicModify[@"pay_time"];
                    _threeView.text1.text = [NSString stringWithFormat:@"%@",_dicModify[@"amount"]];
                    _fourSubView.text1.text  = [NSString stringWithFormat:@"%@",_dicModify[@"num"]];
                    _fiveView.text1.text = [NSString stringWithFormat:@"%@",_dicModify[@"sheng_num"]];
                }
            }
        }
            break;
        case 3:
        {
            [_oneView reFreshCustomerBillOnewithTitle:@"选择项目" withPlaceHolder:@"请选择项目" withValue:nil WithSource:[_xiangmuArr mutableCopy]];
            [_twoView reFreshCustomerBillTwowithTitle:@"购买日期" withPlaceHolder:@"请选择购买日期" withValue:nil];
            [self initRightThreeView];
            [_threeView reFreshCustomerBillThreeithTitle:@"余额" withPlaceHolder:@"请输入卡中余额" withValue:nil];
            _threeSubView.hidden = YES;
            [self initRightFourView];
            [_fourView reFreshCustomerBillThreeithTitle:@"购买次数" withPlaceHolder:@"请输入购买次数" withValue:nil];
            _fourSubView.hidden = YES;
            _fourSubTwoView.hidden = YES;
            [self initRightFiveView];
            [_fiveView reFreshCustomerBillFourwithTitle:@"剩余次数" withPlaceHolder:@"请输入剩余次数" withValue:nil];
            
            _lbLeft.hidden = YES;
            _lb2.hidden = YES;
            _lb1.hidden = NO;
            _lb1.text  = @"备注：金额为0，代表为赠品";
            [_lb1 sizeToFit];
            _lb1.frame =CGRectMake(15, _fiveView.bottom+10, _lb1.width, _lb1.height);
            _btn1.frame = CGRectMake(15, _fiveView.bottom+40, (_rightScroll.width - 45)/2.0, 35);
            _btn2.frame = CGRectMake(_btn1.right+15, _fiveView.bottom+40, (_rightScroll.width - 45)/2.0, 35);
            _sixView.hidden = YES;
            _sevenView.hidden = YES;
            _eightView.hidden = YES;
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeView.text1.text = nil;
            _fourView.text1.text = nil;
            _fiveView.text1.text = nil;
            if (_isModify) {
                if (_sectionModify == 3) {
                    _oneView.picker1.text = _dicModify[@"name"];
                    _twoView.picker1.text = _dicModify[@"pay_time"];
                    _threeView.text1.text = [NSString stringWithFormat:@"%@",_dicModify[@"amount"]];//amount_p
                    _fourView.text1.text = [NSString stringWithFormat:@"%@",_dicModify[@"num"]];
                    _fiveView.text1.text = [NSString stringWithFormat:@"%@",_dicModify[@"sheng_num"]];
                }
            }
        }
            break;
        case 4:
        {
            [_oneView reFreshCustomerBillOnewithTitle:@"选择产品" withPlaceHolder:@"请选择产品" withValue:nil WithSource:[_chanpinArr mutableCopy]];
            [_twoView reFreshCustomerBillTwowithTitle:@"购买日期" withPlaceHolder:@"请选择购买日期" withValue:nil];
            [self initRightThreeView];
            [_threeView reFreshCustomerBillThreeithTitle:@"购买金额" withPlaceHolder:@"请输入购买金额" withValue:nil];
            _threeSubView.hidden = YES;
            
            [self initRightFourView];
            [_fourView reFreshCustomerBillThreeithTitle:@"余额" withPlaceHolder:@"请输入余额" withValue:nil];
            _fourSubView.hidden = YES;
            _fourSubTwoView.hidden = YES;
            
            [self initRightSevenView];
            [_sevenView reFreshCustomerBillFourwithTitle:@"购买次数" withPlaceHolder:@"请输入购买次数" withValue:nil];
            [self initRightEightView];
            [_eightView reFreshCustomerBillFourwithTitle:@"剩余次数" withPlaceHolder:@"请输入剩余次数" withValue:nil];
            
            _lbLeft.hidden = NO;
            _lbLeft.text = @"备注：";
            [_lbLeft sizeToFit];
            _lbLeft.frame =CGRectMake(15, _eightView.bottom+10, _lbLeft.width, _lbLeft.height);
            _lb1.hidden = NO;
            _lb1.text  = @"1、金额为0，代表为赠品";
            [_lb1 sizeToFit];
            _lb1.frame =CGRectMake(_lbLeft.right, _eightView.bottom+10, _lb1.width, _lb1.height);
            
            _lb2.hidden = NO;
            _lb2.text  = @"2、选择售后服务，说明该产品可以开产品服务单";
            [_lb2 sizeToFit];
            _lb2.numberOfLines = 2;
            _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+5, _rightScroll.width-_lb1.left, _lb1.height*3);
            
            _btn1.frame = CGRectMake(15, _lb2.bottom+20, (_rightScroll.width - 45)/2.0, 35);
            _btn2.frame = CGRectMake(_btn1.right+15, _lb2.bottom+20, (_rightScroll.width - 45)/2.0, 35);
            _fiveView.hidden = YES;
            _sixView.hidden = YES;
            
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeView.text1.text = nil;
            _fourView.text1.text = nil;
            _sevenView.text1.text = nil;
            _eightView.text1.text = nil;
            _fourSubTwoView.btn1.selected = NO;
            if (_isModify) {
                if (_sectionModify == 4) {
                    _oneView.picker1.text = _dicModify[@"name"];
                    _twoView.picker1.text = _dicModify[@"pay_time"];
                    _threeView.text1.text = [NSString stringWithFormat:@"%@",_dicModify[@"amount_a"]];
                    _fourView.text1.text = [NSString stringWithFormat:@"%@",_dicModify[@"amount"]];
                    _sevenView.text1.text = _dicModify[@"num"];
                    _eightView.text1.text = _dicModify[@"sheng_num"];
                }
            }
        }
            break;
        case 5:
        {
            [_oneView reFreshCustomerBillOnewithTitle:@"选择票卷" withPlaceHolder:@"请选择票卷" withValue:nil WithSource:[_piaojuanArr mutableCopy]];
            [_twoView reFreshCustomerBillTwowithTitle:@"购买日期" withPlaceHolder:@"请选择购买日期" withValue:nil];
            [self initRightThreeView];
            [_threeView reFreshCustomerBillThreeithTitle:@"购买金额" withPlaceHolder:@"请输入购买金额" withValue:nil];
            _lbLeft.hidden = YES;
            _lb2.hidden = YES;
            _lb1.hidden = NO;
            _lb1.text  = @"备注：金额为0，代表为赠品";
            [_lb1 sizeToFit];
            _lb1.frame =CGRectMake(15, _threeView.bottom+10, _lb1.width, _lb1.height);
            
            _btn1.frame = CGRectMake(15, _threeView.bottom+40, (_rightScroll.width - 45)/2.0, 35);
            _btn2.frame = CGRectMake(_btn1.right+15, _threeView.bottom+40, (_rightScroll.width - 45)/2.0, 35);
            
            _threeSubView.hidden = YES;
            _fourView.hidden = YES;
            _fourSubView.hidden = YES;
            _fourSubTwoView.hidden = YES;
            _fiveView.hidden = YES;
            _sixView.hidden = YES;
            _sevenView.hidden = YES;
            _eightView.hidden = YES;
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeView.text1.text = nil;
            if (_isModify) {
                if (_sectionModify == 5) {
                    _oneView.picker1.text = _dicModify[@"name"];
                    _twoView.picker1.text = _dicModify[@"pay_time"];
                    _threeView.text1.text = [NSString stringWithFormat:@"%@",_dicModify[@"money"]];
                }
            }
        }
            break;
        default:
            break;
    }

    }
}
- (IBAction)BtnCancleEvent:(UIButton *)sender {
//    if (_isModify) {
//        [self.navigationController popViewControllerAnimated:NO];
//    }
    switch (_typeInteger) {
        case 0:
        {
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeView.text1.text = nil;
            _fourView.text1.text  = nil;
        }
            break;
        case 1:
        {
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeSubView.picker1.text = nil;
            _fourView.text1.text  = nil;
        }
            break;
        case 2:
        {
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeView.text1.text = nil;
            _fourSubView.text1.text  = nil;
            _fiveView.text1.text = nil;
        }
            break;
        case 3:
        {
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeView.text1.text = nil;
            _fourView.text1.text = nil;
            _fiveView.text1.text = nil;
        }
            break;
        case 4:
        {
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeView.text1.text = nil;
            _fourView.text1.text = nil;
            _sevenView.text1.text = nil;
            _eightView.text1.text = nil;
        }
            break;
        case 5:
        {
            _oneView.picker1.text = nil;
            _twoView.picker1.text = nil;
            _threeView.text1.text = nil;
        }
            break;
        default:
            break;
    }
}

- (IBAction)BtnConfirmEvent:(UIButton *)sender {
    
    BOOL stop = [self checkisHaveValue];
    if (stop) {
        return;
    }
    if (!_dic) {
        _dic = [[NSMutableDictionary alloc]init];
    }
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    if (token) {
        [_dic setValue:token forKey:@"token"];
    }
    _dic[@"user_id"] = [NSString stringWithFormat:@"%@",@(_customerModel.uid)];
    switch (_typeInteger) {
        case 0: //储值卡
        {
            if (_isModify && _sectionModify == 0) {
                _dicModify[@"name"] = _oneView.picker1.text;
                if (_oneView.picker1.pickerValue && ![_oneView.picker1.pickerValue isEqualToString:@""]) {
                    _dicModify[@"code"] = _oneView.picker1.pickerValue;
                }
                _dicModify[@"pay_time"] = _twoView.picker1.text;
                _dicModify[@"denomination"] = _threeView.text1.text;
                _dicModify[@"money"] = _fourView.text1.text;
//                [MzzHud toastWithTitle:@"" message:@"修改成功"];
                [XMHProgressHUD showOnlyText:@"修改成功"];
            } else {
                NSMutableArray *arr = [_dic objectForKey:@"stored_card"];
                if (!arr) {
                    arr = [[NSMutableArray alloc]init];
                    [_dic setValue:arr forKey:@"stored_card"];
                }
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
                [arr addObject:tempDic];
                tempDic[@"code"] = _oneView.picker1.pickerValue;
                tempDic[@"name"] = _oneView.picker1.text;
                tempDic[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
                tempDic[@"store_code"] = _customerModel.store_code;
                tempDic[@"user_id"] = [NSString stringWithFormat:@"%ld",_customerModel.uid];
                tempDic[@"pay_time"] = _twoView.picker1.text;
                tempDic[@"money"] = _fourView.text1.text;
                tempDic[@"denomination"] = _threeView.text1.text;
                tempDic[@"unique"] = [TimeTools getCurrentTimestamp11];
                [XMHProgressHUD showOnlyText:@"加入购物车成功"];
            }
        }
            break;
        case 1://时间卡
        {
            if (_isModify && _sectionModify == 1) {
                _dicModify[@"name"] = _oneView.picker1.text;
                if (_oneView.picker1.pickerValue && ![_oneView.picker1.pickerValue isEqualToString:@""]) {
                    _dicModify[@"code"] = _oneView.picker1.pickerValue;
                }
                _dicModify[@"pay_time"] = _twoView.picker1.text;
                _dicModify[@"end_time"] = _threeSubView.picker1.text;
                _dicModify[@"amount"] = _fourView.text1.text;
                [XMHProgressHUD showOnlyText:@"修改成功"];
            } else {
                NSMutableArray *arr = [_dic objectForKey:@"card_time"];
                if (!arr) {
                    arr = [[NSMutableArray alloc]init];
                    [_dic setValue:arr forKey:@"card_time"];
                }
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
                [arr addObject:tempDic];
                tempDic[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
                tempDic[@"code"] = _oneView.picker1.pickerValue;
                tempDic[@"name"] = _oneView.picker1.text;
                tempDic[@"store_code"] = _customerModel.store_code;
                tempDic[@"user_id"] = [NSString stringWithFormat:@"%ld",_customerModel.uid];
                tempDic[@"pay_time"] = _twoView.picker1.text;
                tempDic[@"end_time"] = _threeSubView.picker1.text;
                tempDic[@"amount"] = _fourView.text1.text;
                tempDic[@"unique"] = [TimeTools getCurrentTimestamp11];
                [XMHProgressHUD showOnlyText:@"加入购物车成功"];
            }
        }
            break;
        case 2://人选卡
        {
            if (_isModify && _sectionModify == 2) {
                _dicModify[@"name"] = _oneView.picker1.text;
                if (_oneView.picker1.pickerValue && ![_oneView.picker1.pickerValue isEqualToString:@""]) {
                    _dicModify[@"code"] = _oneView.picker1.pickerValue;
                }
                _dicModify[@"pay_time"] = _twoView.picker1.text;
                _dicModify[@"amount"] =_threeView.text1.text;
                _dicModify[@"num"] = _fourSubView.text1.text;
                _dicModify[@"sheng_num"] = _fiveView.text1.text;
                [XMHProgressHUD showOnlyText:@"修改成功"];
            } else {
                NSMutableArray *arr = [_dic objectForKey:@"card_num"];
                if (!arr) {
                    arr = [[NSMutableArray alloc]init];
                    [_dic setValue:arr forKey:@"card_num"];
                }
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
                if (_fourSubView.text1.text.integerValue < _fiveView.text1.text.integerValue) {
                    [XMHProgressHUD showOnlyText:@"购买次数必须大于等于剩余次数"];
                    return;
                }
                [arr addObject:tempDic];
                tempDic[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
                tempDic[@"code"] = _oneView.picker1.pickerValue;
                tempDic[@"name"] = _oneView.picker1.text;
                tempDic[@"store_code"] = _customerModel.store_code;
                tempDic[@"user_id"] = [NSString stringWithFormat:@"%ld",_customerModel.uid];
                tempDic[@"pay_time"] = _twoView.picker1.text;
                tempDic[@"amount"] = _threeView.text1.text;
                tempDic[@"unique"] = [TimeTools getCurrentTimestamp11];
                tempDic[@"num"] = _fourSubView.text1.text;
                tempDic[@"sheng_num"] = _fiveView.text1.text;
                [XMHProgressHUD showOnlyText:@"加入购物车成功"];
               
            }
        }
            break;
        case 3://项目
        {
            if (_isModify && _sectionModify == 3) {
                _dicModify[@"name"] = _oneView.picker1.text;
                if (_oneView.picker1.pickerValue && ![_oneView.picker1.pickerValue isEqualToString:@""]) {
                    _dicModify[@"code"] = _oneView.picker1.pickerValue;
                }
                _dicModify[@"pay_time"] = _twoView.picker1.text;
                _dicModify[@"amount"] = _threeView.text1.text;
                _dicModify[@"num"] = _fourView.text1.text;
                _dicModify[@"sheng_num"] = _fiveView.text1.text;
                [XMHProgressHUD showOnlyText:@"修改成功"];
            } else {
                NSMutableArray *arr = [_dic objectForKey:@"pro"];
                if (!arr) {
                    arr = [[NSMutableArray alloc]init];
                    [_dic setValue:arr forKey:@"pro"];
                }
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
                if (_fourView.text1.text.integerValue <  _fiveView.text1.text.integerValue) {
                    [XMHProgressHUD showOnlyText:@"购买次数必须大于等于剩余次数"];
                    return;
                }
                [arr addObject:tempDic];
                tempDic[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
                tempDic[@"code"] = _oneView.picker1.pickerValue;
                tempDic[@"name"] = _oneView.picker1.text;
                tempDic[@"store_code"] = _customerModel.store_code;
                tempDic[@"user_id"] = [NSString stringWithFormat:@"%ld",_customerModel.uid];
                tempDic[@"pay_time"] = _twoView.picker1.text;
                tempDic[@"amount"] =_threeView.text1.text;
                tempDic[@"unique"] = [TimeTools getCurrentTimestamp11];
                tempDic[@"num"] = _fourView.text1.text;
                tempDic[@"sheng_num"] = _fiveView.text1.text;
                [XMHProgressHUD showOnlyText:@"加入购物车成功"];
            }
        }
            break;
        case 4://产品
        {
            if (_isModify && _sectionModify == 4) {
                _dicModify[@"name"] = _oneView.picker1.text;
                if (_oneView.picker1.pickerValue && ![_oneView.picker1.pickerValue isEqualToString:@""]) {
                    _dicModify[@"code"] = _oneView.picker1.pickerValue;
                }
                _dicModify[@"pay_time"] = _twoView.picker1.text;
                _dicModify[@"amount_a"] = _threeView.text1.text;
                _dicModify[@"amount"] = _fourView.text1.text;
                _dicModify[@"is_serv"] = @"0";
                _dicModify[@"num"] = _sevenView.text1.text;
                _dicModify[@"sheng_num"] = _eightView.text1.text;
                [XMHProgressHUD showOnlyText:@"修改成功"];
            } else {
                NSMutableArray *arr = [_dic objectForKey:@"goods"];
                if (!arr) {
                    arr = [[NSMutableArray alloc]init];
                    [_dic setValue:arr forKey:@"goods"];
                }
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
                if (_sevenView.text1.text.integerValue <  _eightView.text1.text.integerValue) {
                    [XMHProgressHUD showOnlyText:@"购买次数必须大于等于剩余次数"];
                    return;
                }
                [arr addObject:tempDic];
                tempDic[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
                tempDic[@"code"] = _oneView.picker1.pickerValue;
                tempDic[@"name"] = _oneView.picker1.text;
                tempDic[@"store_code"] = _customerModel.store_code;
                tempDic[@"user_id"] = [NSString stringWithFormat:@"%ld",_customerModel.uid];
                tempDic[@"pay_time"] = _twoView.picker1.text;
                tempDic[@"amount_a"] = _threeView.text1.text;
                tempDic[@"amount"] = _fourView.text1.text;
                tempDic[@"is_serv"] = @"0";
                tempDic[@"unique"] = [TimeTools getCurrentTimestamp11];
                tempDic[@"num"] = _sevenView.text1.text;
                tempDic[@"sheng_num"] = _eightView.text1.text;
                [XMHProgressHUD showOnlyText:@"加入购物车成功"];
            }
        }
            break;
        case 5://票券
        {
            if (_isModify && _sectionModify == 5) {
                _dicModify[@"name"] = _oneView.picker1.text;
                if (_oneView.picker1.pickerValue && ![_oneView.picker1.pickerValue isEqualToString:@""]) {
                    _dicModify[@"code"] = _oneView.picker1.pickerValue;
                }
                _dicModify[@"pay_time"] = _twoView.picker1.text;
                _dicModify[@"money"] = @([_threeView.text1.text integerValue]);
                [XMHProgressHUD showOnlyText:@"修改成功"];
            } else {
                NSMutableArray *arr = [_dic objectForKey:@"ticket"];
                if (!arr) {
                    arr = [[NSMutableArray alloc]init];
                    [_dic setValue:arr forKey:@"ticket"];
                }
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
                [arr addObject:tempDic];
                tempDic[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
                tempDic[@"code"] = _oneView.picker1.pickerValue;
                tempDic[@"name"] = _oneView.picker1.text;
                tempDic[@"store_code"] = _customerModel.store_code;
                tempDic[@"user_id"] = [NSString stringWithFormat:@"%ld",_customerModel.uid];
                tempDic[@"pay_time"] = _twoView.picker1.text;
                tempDic[@"money"] = _threeView.text1.text;
                tempDic[@"unique"] = [TimeTools getCurrentTimestamp11];
                [XMHProgressHUD showOnlyText:@"加入购物车成功"];
            }
        }
            break;
        default:
            break;
    }
    [self freshGouWuChe];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self freshGouWuChe];
}
- (void)freshGouWuChe{
    NSInteger numm = [self jisuanNum];
    if (numm > 0) {
        _lbNum.hidden = NO;
        UIImage * imgGouehce = UIImageName(@"stgkgl_gouwucheyoushangpin");
        [_btnGouWuChe setImage:imgGouehce forState:UIControlStateNormal];
    }else{
        _lbNum.hidden = YES;
        UIImage * imgGouehce = UIImageName(@"stgkgl_gouwuchewushangpin");
        [_btnGouWuChe setImage:imgGouehce forState:UIControlStateNormal];
    }
    _lbNum.text = [NSString stringWithFormat:@"%@",@(numm)];
    if (_tbGouChe) {
        [_tbGouChe reloadData];
    }
}
- (NSInteger )jisuanNum{
    
    _stored_cardArr = _dic[@"stored_card"]?_dic[@"stored_card"]:_stored_cardArr;
    _card_timeArr = _dic[@"card_time"]?_dic[@"card_time"]:_card_timeArr;
    _card_numArr = _dic[@"card_num"]?_dic[@"card_num"]:_card_numArr;
    _proArr = _dic[@"pro"]?_dic[@"pro"]:_proArr;
    _goodsArr = _dic[@"goods"]?_dic[@"goods"]:_goodsArr;
    _ticketArr = _dic[@"ticket"]?_dic[@"ticket"]:_ticketArr;
    NSInteger num = 0;
    num += _stored_cardArr.count;
    num += _card_timeArr.count;
    num += _card_numArr.count;
    num += _proArr.count;
    num += _goodsArr.count;
    num += _ticketArr.count;
    return num;
}
- (BOOL)checkisHaveValue{
    switch (_typeInteger) {
        case 0:
        {
            if (!_oneView.picker1.text || [_oneView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择储值卡"];
                return YES;
            }
            if (!_twoView.picker1.text || [_twoView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择购买日期"];
                return YES;
            }
            if (!_threeView.text1.text || [_threeView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入购买金额"];
                return YES;
            }
            if (!_fourView.text1.text || [_fourView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入卡中余额"];
                return YES;
            }
        }
            break;
        case 1:
        {
            if (!_oneView.picker1.text || [_oneView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择时间卡"];
                return YES;
            }
            if (!_twoView.picker1.text || [_twoView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择购买日期"];
                return YES;
            }
            if (!_threeSubView.picker1.text || [_threeSubView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择截止日期"];
                return YES;
            }
            if (!_fourView.text1.text || [_fourView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入购买金额"];
                return YES;
            }
        }
            break;
        case 2:
        {
            if (!_oneView.picker1.text || [_oneView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择任选卡"];
                return YES;
            }
            if (!_twoView.picker1.text || [_twoView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择购买日期"];
                return YES;
            }
            if (!_threeView.text1.text || [_threeView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入购买金额"];
                return YES;
            }
            if (!_fourSubView.text1.text || [_fourSubView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入购买次数"];
                return YES;
            }
            if (!_fiveView.text1.text || [_fiveView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入剩余次数"];
                return YES;
            }
        }
            break;
        case 3:
        {
            if (!_oneView.picker1.text || [_oneView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择项目"];
                return YES;
            }
            if (!_twoView.picker1.text || [_twoView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择购买日期"];
                return YES;
            }
            if (!_threeView.text1.text || [_threeView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入卡中余额"];
                return YES;
            }
            if (!_fourView.text1.text || [_fourView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入购买次数"];
                return YES;
            }
            if (!_fiveView.text1.text || [_fiveView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入剩余次数"];
                return YES;
            }
        }
            break;
        case 4:
        {
            if (!_oneView.picker1.text || [_oneView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择产品"];
                return YES;
            }
            if (!_twoView.picker1.text || [_twoView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择购买日期"];
                return YES;
            }
            if (!_threeView.text1.text || [_threeView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入购买金额"];
                return YES;
            }
            if (!_fourView.text1.text || [_fourView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入卡中余额"];
                return YES;
            }
            if (!_sevenView.text1.text || [_sevenView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入购买次数"];
                return YES;
            }
            if (!_eightView.text1.text || [_eightView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入剩余次数"];
                return YES;
            }
        }
            break;
        case 5:
        {
            if (!_oneView.picker1.text || [_oneView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择票券"];
                return YES;
            }
            if (!_twoView.picker1.text || [_twoView.picker1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请选择购买日期"];
                return YES;
            }
            if (!_threeView.text1.text || [_threeView.text1.text isEqualToString:@""]) {
                [MzzHud toastWithTitle:@"" message:@"请输入购买金额"];
                return YES;
            }
        }
            break;
        default:
            break;
    }
    return NO;
}

- (void)nextEvent{
    CustomerBillConfirmViewController *VC = [[CustomerBillConfirmViewController alloc]init];
    VC.dic = _dic;
    VC.isNewGKGL = _isNewGKGL;
    VC.customerModel = _customerModel;
    VC.delBlock = ^(NSMutableDictionary *dic, NSInteger section) {
        switch (section) {
            case 0:
            {
                NSMutableArray *arr = [_dic objectForKey:@"stored_card"];
                [arr removeObject:dic];
            }
                break;
            case 1:
            {
                NSMutableArray *arr = [_dic objectForKey:@"card_time"];
                [arr removeObject:dic];
            }
                break;
            case 2:
            {
                NSMutableArray *arr = [_dic objectForKey:@"card_num"];
                [arr removeObject:dic];
            }
                break;
            case 3:
            {
                NSMutableArray *arr = [_dic objectForKey:@"pro"];
                [arr removeObject:dic];
            }
                break;
            case 4:
            {
                NSMutableArray *arr = [_dic objectForKey:@"goods"];
                [arr removeObject:dic];
            }
                break;
            case 5:
            {
                NSMutableArray *arr = [_dic objectForKey:@"ticket"];
                [arr removeObject:dic];
            }
                break;
            default:
                
                break;
        }
    };
    VC.popBlock = ^(BOOL isModify, NSMutableDictionary *dic, NSInteger section, CustomerModel *customerModel) {
        _isModify = isModify;
        _dicModify = dic;
        _sectionModify = section;
        _customerModel = customerModel;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section inSection:0];
        [self tableView:_tbView1 didSelectRowAtIndexPath:indexPath];
    };
    if (!([_dic[@"stored_card"] count] > 0)&&!([_dic[@"card_time"] count] > 0)&&!([_dic[@"card_num"] count] > 0)&&!([_dic[@"pro"] count] > 0)&&!([_dic[@"goods"] count] > 0)&&!([_dic[@"ticket"] count] > 0)) {
        [XMHProgressHUD showOnlyText:@"购物车不能为空"];
        return;
    }
    
//    GKGLBillVerifyVC * next = [[GKGLBillVerifyVC alloc]init];
    [self.navigationController pushViewController:VC animated:NO];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

