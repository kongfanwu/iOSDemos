//
//  XMHSendCouponVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSendCouponVC.h"
#import "XMHACSendAddCustomer.h"
#import "XMHACSendAddCouponView.h"
#import "XMHACSelectdCustomerView.h"
#import "XMHACSelectdCouponView.h"
#import "XMHActionCenterSelectCustomerVC.h"
#import "XMHActionCenterCouponVC.h"
#import "XMHActionCenterCustomerResultVC.h"
#import "XMHPickerView.h"
#import "XMHCouponModel.h"
#import "XMHActionCenterRequest.h"
#import "XMHCouponSendCustomerListModel.h"
#import "XMHCouponSendErrorListModel.h"
#import "XMHActionCenterFilterCustomerVC.h"
#import "XMHActionCenterCendCouponErrorVC.h"
@interface XMHSendCouponVC ()<UITextFieldDelegate,XMHPickerViewResultDelegate>
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UIButton *sendBtn;
/** 添加顾客 */
@property (nonatomic, strong)XMHACSendAddCustomer *addCustomerView;
/** 添加优惠券 */
@property (nonatomic, strong)XMHACSendAddCouponView *addCouponView;
/** 已添加顾客 */
@property (nonatomic, strong)XMHACSelectdCustomerView *selectdCustomerView;
/** 已添加顾客 */
@property (nonatomic, strong)XMHACSelectdCouponView *selectdCouponView;
/** 选择的顾客 */
@property (nonatomic, strong)NSMutableArray * selectCustomerArr;
/** 选择的优惠券 */
@property (nonatomic, strong)NSMutableDictionary * selectCouponDic;
/** 选择的优惠券总数据 */
@property (nonatomic, strong)NSMutableArray * selectCouponTotal;
/** 下发张数 */
@property (nonatomic, copy)NSString * num;
/** 补充后的数据 */
@property (nonatomic, strong)NSMutableArray * dataSource;
/** 选择的优惠券数量 */
@property (nonatomic, assign)NSInteger couponNum;
@end

@implementation XMHSendCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView setNavViewTitle:@"发放优惠券" backBtnShow:YES];
    __weak typeof(self) _self = self;
    self.navView.NavViewBackBlock = ^{
        __strong typeof(_self) self = _self;
        if (self.navigationBackBlock) {
            self.navigationBackBlock();
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    
    self.navView.backgroundColor = kColorTheme;
    self.view.backgroundColor = Color_NormalBG;
    _selectCustomerArr = [[NSMutableArray alloc] init];
    [self createSubViews];
}

- (XMHACSendAddCustomer *)addCustomerView
{
    WeakSelf
    if (!_addCustomerView) {
        _addCustomerView = loadNibName(@"XMHACSendAddCustomer");
        _addCustomerView.sendAddCustomerViewBlock = ^{
            //弹出选择框
            [weakSelf showPickView];
        };
    }
    return _addCustomerView;
}

- (XMHACSelectdCustomerView *)selectdCustomerView
{
    WeakSelf
    if (!_selectdCustomerView) {
        _selectdCustomerView = loadNibName(@"XMHACSelectdCustomerView");
        _selectdCustomerView.selectdCustomerViewBlock = ^(NSMutableArray * modelArr){
            //已选顾客
            XMHActionCenterCustomerResultVC * next = [[XMHActionCenterCustomerResultVC alloc] init];
            next.selectResultArr = weakSelf.selectCustomerArr;
            next.XMHActionCenterCustomerResultVCBlock = ^(NSMutableArray * _Nonnull selectResultArr) {
                weakSelf.selectCustomerArr = selectResultArr;
                [weakSelf refreshView];
            };
            [weakSelf.navigationController pushViewController:next animated:NO];
        };
        _selectdCustomerView.addCustomerViewBlock = ^{
            //弹出选择框
            [weakSelf showPickView];
        };
    }
    return _selectdCustomerView;
}
- (XMHACSendAddCouponView *)addCouponView
{
    WeakSelf
    if (!_addCouponView) {
        _addCouponView = loadNibName(@"XMHACSendAddCouponView");
        _addCouponView.sendAddCouponViewBlock = ^{
            //添加优惠券
            XMHActionCenterCouponVC * next = [[XMHActionCenterCouponVC alloc] init];
            next.XMHActionCenterCouponVCBlock = ^(NSMutableDictionary * _Nonnull selectCouponDic) {
                weakSelf.selectCouponDic = selectCouponDic;
                [weakSelf refreshView];
            };
            [weakSelf.navigationController pushViewController:next animated:NO];
        };
    }
    return _addCouponView;
}
- (XMHACSelectdCouponView *)selectdCouponView
{
    WeakSelf
    if (!_selectdCouponView) {
        _selectdCouponView = loadNibName(@"XMHACSelectdCouponView");
        _selectdCouponView.selectdCouponViewBlock  = ^{
            //已添加优惠券
            XMHActionCenterCouponVC * next = [[XMHActionCenterCouponVC alloc] init];
            next.selectResultDic = weakSelf.selectCouponDic;
            next.XMHActionCenterCouponVCBlock = ^(NSMutableDictionary * _Nonnull selectCouponDic) {
                weakSelf.selectCouponDic = selectCouponDic;
                [weakSelf refreshView];
            };
            [weakSelf.navigationController pushViewController:next animated:NO];
        };
    }
    return _selectdCouponView;
}
- (void)createSubViews
{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bgView];
    bgView.frame = CGRectMake(0, KNaviBarHeight, SCREEN_WIDTH , 174);
    self.addCustomerView.frame = CGRectMake(10, 30, SCREEN_WIDTH - 20, 49);
    [bgView addSubview:self.addCustomerView];
    
    self.addCouponView.frame = CGRectMake(10, self.addCustomerView.bottom + 20, SCREEN_WIDTH - 20, 49);
    [bgView addSubview:self.addCouponView];
    
    self.selectdCustomerView.frame = CGRectMake(10, 30, SCREEN_WIDTH - 20, 49);
    [bgView addSubview:self.selectdCustomerView];
    self.selectdCustomerView.hidden = YES;
    
    self.selectdCouponView.frame = CGRectMake(10, self.addCustomerView.bottom + 20, SCREEN_WIDTH - 20, 49);
    [bgView addSubview:self.selectdCouponView];
    self.selectdCouponView.hidden = YES;
    
    UIView *labView = UIView.new;
    [self.view addSubview:labView];
    [labView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(33);
        make.right.mas_equalTo(-33);
        make.top.mas_equalTo(bgView.mas_bottom).mas_offset(50);
        make.height.mas_equalTo(33);
    }];
    UILabel *lab = UILabel.new;
    lab.text = @"每人发送: ";
    lab.textColor = kColor6;
    lab.font = FONT_SIZE(14);
    [labView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(labView.mas_height);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *numlab = UILabel.new;
    numlab.text = @"  张";
    numlab.textColor = kColor6;
    numlab.font = FONT_SIZE(14);
    [labView addSubview:numlab];
    [numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(labView.mas_right);
        make.height.mas_equalTo(labView.mas_height);
        make.width.mas_equalTo(40);
        make.top.mas_equalTo(0);
    }];
    
    self.textField = UITextField.new;
    self.textField.delegate = self;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.textColor = kColor6;
    self.textField.backgroundColor = UIColor.whiteColor;
    self.textField.layer.borderColor= [ColorTools colorWithHexString:@"#cccccc"].CGColor;;
    self.textField.layer.borderWidth= kBorderWidth;
    [labView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_right);
        make.right.mas_equalTo(numlab.mas_left);
        make.height.mas_equalTo(labView.mas_height);
        make.top.mas_equalTo(0);
    }];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.tag = 300;
    sendBtn.layer.cornerRadius = 5;
    sendBtn.backgroundColor = kColor9;
    sendBtn.layer.masksToBounds = YES;
    [sendBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_equalTo(-71);
        make.height.mas_equalTo(44);
    }];
    self.sendBtn = sendBtn;
    self.sendBtn.enabled = NO;
   
}
- (void)showPickView
{
    XMHPickerView * pickerView = [[XMHPickerView alloc]init];
    pickerView.type = PickerViewTypeAddType;
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
}
- (void)pickerView:(UIView *)pickerView result:(NSString *)string
{
    WeakSelf
    if ([string isEqualToString:@"逐条添加"]) {
        XMHActionCenterSelectCustomerVC * next = [[XMHActionCenterSelectCustomerVC alloc] init];
        next.selectResultArr = _selectCustomerArr;
        next.XMHActionCenterSelectCustomerVCBlock = ^(NSMutableArray * _Nonnull selectResultArr) {
            weakSelf.selectCustomerArr = selectResultArr;
            [weakSelf refreshView];
        };
        [weakSelf.navigationController pushViewController:next animated:NO];
    }
    if ([string isEqualToString:@"批量添加"]) {
        XMHActionCenterFilterCustomerVC * next = [[XMHActionCenterFilterCustomerVC alloc] init];
        next.XMHActionCenterSelectCustomerVCBlock = ^(NSMutableArray * _Nonnull selectResultArr) {
            [weakSelf mergeCustomerWithArr:selectResultArr];
            [weakSelf refreshView];
        };
        [weakSelf.navigationController pushViewController:next animated:NO];
    }
}

/** 批量添加 逐条添加  多次选择结果合并去重 */
- (void)mergeCustomerWithArr:(NSMutableArray *)selectCustomerArr
{
    for (int i = 0; i < selectCustomerArr.count; i ++) {
        XMHCouponSendCustomerModel * model = selectCustomerArr[i];
        if (!([_selectCustomerArr containsObject:model])) {
            [_selectCustomerArr addObject:model];
        }
    }
}
/** 根据数据 确定展示哪个View  还有数据 */
- (void)refreshView
{
    if (_selectCustomerArr.count > 0) {
        [_selectdCustomerView updateView:_selectCustomerArr];
        _selectdCustomerView.hidden = NO;
        _addCustomerView.hidden = YES;
    }else{
        _selectdCustomerView.hidden = YES;
        _addCustomerView.hidden = NO;
    }
    _selectCouponTotal = [[NSMutableArray alloc] init];
    NSInteger couponNum = 0;
    for (XMHCouponModel * model in _selectCouponDic[kCash]) {
        if (model.selected) {
            couponNum ++;
            [_selectCouponTotal addObject:model];
        }
    }
    for (XMHCouponModel * model in _selectCouponDic[kDiscount]) {
        if (model.selected) {
            couponNum ++;
            [_selectCouponTotal addObject:model];
        }
    }
    for (XMHCouponModel * model in _selectCouponDic[kGift]) {
        if (model.selected) {
            couponNum ++;
            [_selectCouponTotal addObject:model];
        }
    }
    if (couponNum > 0) {
        [_selectdCouponView updateView:couponNum];
        _addCouponView.hidden = YES;
        _selectdCouponView.hidden = NO;
    }else{
        _addCouponView.hidden = NO;
        _selectdCouponView.hidden = YES;
    }
    
    _couponNum = couponNum;
    
    [self updateCommitBtnbackgroundColor];
}
#pragma mark -- event
- (void)btnClick:(UIButton *)sender
{
    //发送
    [self requestSendCoupon];
    
   
}
/** 发送完成后 清空本页数据 （选择的顾客、选择的优惠券、输入的发送张数， 发送失败的数据模型）*/
- (void)clearAllSelectDataAndInputData
{
    /** 清理选择的顾客数据 */
    [_selectCustomerArr removeAllObjects];
    /** 清理选择的的优惠券数据 */
    [_selectCouponDic removeAllObjects];
    /** 清理发送失败的 数据模型 */
    [_dataSource removeAllObjects];
    /** 清理输入框数据 */
    self.textField.text = @"";
    /** 更新 UI 展示 */
    [self refreshView];
}
/** 更新按钮颜色状态 */
- (void)updateCommitBtnbackgroundColor
{
    if (_selectCustomerArr.count > 0 && _num.integerValue > 0 && _couponNum > 0) {
        self.sendBtn.backgroundColor = kColorTheme;
        self.sendBtn.enabled = YES;
    }else{
        self.sendBtn.backgroundColor = kColor9;
        self.sendBtn.enabled = NO;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length) {
        self.sendBtn.enabled = YES;
    }else{
         self.sendBtn.enabled = NO;
    }
    _num = textField.text;
    
    [self updateCommitBtnbackgroundColor];
}
#pragma mark ---网络请求
/** 发送优惠券接口 */
- (void)requestSendCoupon
{
    WeakSelf
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    
    NSMutableArray * userArr = [[NSMutableArray alloc] init];
    for (XMHCouponSendCustomerModel * model in _selectCustomerArr) {
        [userArr addObject:model.user_id];
    }
    
    NSMutableArray * ticketArr = [[NSMutableArray alloc] init];
    for (XMHCouponModel * model in _selectCouponTotal) {
        [ticketArr addObject:model.uid];
    }
    NSString * user = userArr.jsonData;
    NSString * ticket = ticketArr.jsonData;
    NSString * num = _num;
    if (_dataSource.count > 1) {
        [_dataSource removeObjectAtIndex:0];
    }
    NSMutableArray * stockArr = [[NSMutableArray alloc] init];
    for (XMHCouponSendErrorModel * model in _dataSource) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setValue:model.uid forKey:@"id"];
        [dict setValue:model.remain_num forKey:@"remain_num"];
        [dict setValue:model.supply_num forKey:@"supply_num"];
        [stockArr addObject:dict];
    }
    if (num.integerValue <= 0) {
        [XMHProgressHUD showOnlyText:@"发送张数不能为0"];
        return;
    }
    NSString * stock = stockArr.jsonData;
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:user?user:@"" forKey:@"user"];
    [param setValue:ticket?ticket:@"" forKey:@"ticket"];
    [param setValue:num?num:@"" forKey:@"num"];
    [param setValue:stock?stock:@"" forKey:@"stock"];
    
    self.sendBtn.enabled = NO;
    [XMHProgressHUD showGifImage];
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kCOUPON_SEND_COUPON_URL] refreshRequest:YES cache:NO params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        self.sendBtn.enabled = YES;
        if (isSuccess) {
            XMHCouponSendErrorListModel *model = [XMHCouponSendErrorListModel yy_modelWithDictionary:obj.data];
            if (model.list.count == 0) {
                [XMHProgressHUD showOnlyText:kNOTICE_ACTIONCENTER_SENDCOUPON_SUCCESS_MSG];
                [self clearAllSelectDataAndInputData];
            }else{
                XMHActionCenterCendCouponErrorVC * next = [[XMHActionCenterCendCouponErrorVC alloc] init];
                next.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                next.XMHActionCenterCendCouponErrorVCBlock = ^(NSMutableArray * _Nonnull dataSource) {
                    weakSelf.dataSource = dataSource;
                    [weakSelf requestSendCoupon];
                };
                XMHCouponSendErrorModel * errorModel = [[XMHCouponSendErrorModel alloc] init];
                errorModel.name = @"优惠券名称";
                errorModel.remain_num = @"剩余库存/张";
                errorModel.supply_num = @"最低补充/张";
                [model.list insertObject:errorModel atIndex:0];
                next.dataSource = model.list;
                [self presentViewController:next animated:NO completion:nil];
            }
        }else{
            
            
        }
    }];
    
}

@end
