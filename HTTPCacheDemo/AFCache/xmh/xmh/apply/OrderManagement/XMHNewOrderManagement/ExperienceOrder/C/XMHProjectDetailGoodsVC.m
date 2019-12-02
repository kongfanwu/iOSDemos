//
//  XMHProjectDetailGoodsVC.m
//  xmh
//
//  Created by KFW on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHProjectDetailGoodsVC.h"
#import "XMHNumberView.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"
#import "SLSCourseExper.h"
#import "XMHShoppingCartManager.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "XMHExperienceOrderRequest.h"
#import "XMHTicketVC.h"
#import "XMHTicketModel.h"
#import "NSString+Costom.h"
#import "NSString+Check.h"

@interface XMHProjectDetailGoodsVC () <UITextFieldDelegate>
@property (nonatomic, strong) UIView *contentView;
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;
/** 是否有优惠券 */
@property (nonatomic) BOOL isCoupan;
/** 选择的优惠券model */
@property (nonatomic, strong) XMHTicketModel *selectTicketModel;
/**  */
@property (nonatomic, strong) UIView *couponBGView;
@property (nonatomic, strong) UILabel *couponTitleLabel;
/** <##> */
@property (nonatomic, strong) UIView *priceBGView;
@property (nonatomic, strong) UITextField *priceTextField;
/** <##> */
@property (nonatomic, strong) XMHNumberView *numberView;
/** 总价格 */
@property (nonatomic, strong) UILabel *totalPricesLabel;

/** 项目 产品名称 */
@property (nonatomic, copy) NSString *name;
/** 零售价 */
@property (nonatomic, copy) NSString *price;
/** 礼品卷集合 */
@property (nonatomic, strong) NSArray <XMHTicketModel *> *ticketModelArray;
@end

@implementation XMHProjectDetailGoodsVC

- (UIModalPresentationStyle)modalPresentationStyle {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
        return UIModalPresentationOverCurrentContext;
    }
    return UIModalPresentationCurrentContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = RGBColor(146, 146, 146);
    self.view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    self.isCoupan = YES;
    
    UIControl *bgViwe = [UIControl new];
    bgViwe.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:bgViwe];
    [bgViwe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    __weak typeof(self) _self = self;
    [bgViwe bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.contentView];
    
    [self getTicketData];
}

- (void)createSubViews {
    // 刷新 移除子视图
    [_contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.couponBGView = nil;
    self.priceBGView = nil;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [_contentView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.right.top.equalTo(_contentView);
    }];
    __weak typeof(self) _self = self;
    [closeBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [UILabel new];
    _titleLabel.textColor = kColor3;
    _titleLabel.font = FONT_SIZE(15);
    [_contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.right.equalTo(closeBtn);
    }];
    
    if (_isCoupan) {
        [_contentView addSubview:self.couponBGView];
        [self.couponBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60);
            make.left.right.equalTo(_contentView);
            make.height.mas_equalTo(30);
        }];
    }
    
    [_contentView addSubview:self.priceBGView];
    [self.priceBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_isCoupan) {
            make.top.equalTo(self.couponBGView.mas_bottom).offset(10);
        } else {
            make.top.mas_equalTo(60);
        }
        make.left.right.equalTo(_contentView);
        make.height.mas_equalTo(30);
    }];
    
    self.totalPricesLabel = [UILabel new];
    _totalPricesLabel.textColor = kColor3;
    _totalPricesLabel.font = FONT_SIZE(13);
    [_contentView addSubview:_totalPricesLabel];
    [_totalPricesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceBGView.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.right.equalTo(_contentView);
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setBackgroundImage:[UIImage imageWithColor:kBtn_Commen_Color size:CGSizeMake(self.view.width - 30, 44)] forState:UIControlStateNormal];
    [submitButton setTitle:@"确认" forState:UIControlStateNormal];
    [submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    submitButton.titleLabel.font = FONT_SIZE(17);
    submitButton.layer.cornerRadius = 3;//44 / 2.f;
    submitButton.layer.masksToBounds = YES;
    [_contentView addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(-25);
    }];
    WeakSelf
    [submitButton bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        // 添加购物车
        if ([weakSelf.model respondsToSelector:@selector(selectCount)]) {
            NSInteger selectCount = ((XMHShoppingCartBaseModel *)weakSelf.model).selectCount;
            if (selectCount <= 0) {
                [XMHProgressHUD showOnlyText:@"请选择购买数量"];
                return;
            }
            
            // 最大购买数
            NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:self.model];
            // 限制最大购买
            if (selectCount > maxNum) {
                [XMHProgressHUD showOnlyText:@"库存不足"];
                return;
            }
        }
        [XMHShoppingCartManager.sharedInstance addModel:weakSelf.model];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
}

/**
 获取礼品卷数据
 */
- (void)getTicketData {
//    LolUserInfoModel *userModel = [UserManager getObjectUserDefaults:userLogInInfo];
    NSNumber *framId = @([ShareWorkInstance shareInstance].share_join_code.fram_id);
    NSString *code;
    // 项目
    if ([_model isKindOfClass:[SLS_Pro class]]) {
        SLS_Pro *projectModel = (SLS_Pro *)_model;
        code = projectModel.pro_code;
    }
    // 产品
    else if ([_model isKindOfClass:[SLGoodModel class]]) {
        SLGoodModel *goodModel = (SLGoodModel *)_model;
        code = goodModel.goods_code;
    }
    
    // 体验服务-项目
    else if ([_model isKindOfClass:[SLPro_ListM class]]) {
        SLPro_ListM *projectModel = (SLPro_ListM *)_model;
        code = projectModel.pro_code;
    }
    // 体验服务-产品
    else if ([_model isKindOfClass:[SLGoods_ListM class]]) {
        SLGoods_ListM *goodModel = (SLGoods_ListM *)_model;
        code = goodModel.goods_code;
    }

    NSMutableDictionary *params = NSMutableDictionary.new;
    params[@"user_id"] = @(_selectUserModel.uid).stringValue;
    params[@"code"] = code;  // 对应的项目或者产品的code
    params[@"fram_id"] = framId;
    [XMHExperienceOrderRequest requestSellProTicketParam:params resultBlock:^(NSArray <XMHTicketModel *>*modelArray, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        self.ticketModelArray = modelArray;
        NSArray *useModelArray = [XMHTicketModel useModelArray:self.ticketModelArray];
        // 是否存在礼品券
        self.isCoupan = useModelArray.count;
        [self createSubViews];
        [self configDataUseCount:useModelArray.count];
    }];
}

- (void)configDataUseCount:(NSInteger)useCount {
    // 项目
    if ([_model isKindOfClass:[SLS_Pro class]]) {
        SLS_Pro *projectModel = (SLS_Pro *)_model;
        _name = projectModel.name;
        _price = projectModel.r_price;
    }
    // 产品
    else if ([_model isKindOfClass:[SLGoodModel class]]) {
        SLGoodModel *goodModel = (SLGoodModel *)_model;
        _name = goodModel.name;
        _price = goodModel.r_price;
    }
    
    // SLPro_ListM SLGoods_ListM
    // 体验服务-项目
    else if ([_model isKindOfClass:[SLPro_ListM class]]) {
        SLPro_ListM *projectModel = (SLPro_ListM *)_model;
        _name = projectModel.name;
        _price = projectModel.price;
    }
    // 体验服务-产品
    else if ([_model isKindOfClass:[SLGoods_ListM class]]) {
        SLGoods_ListM *goodModel = (SLGoods_ListM *)_model;
        _name = goodModel.name;
        _price = goodModel.price;
    }
    
    _titleLabel.text = _name;
    _couponTitleLabel.text = [NSString stringWithFormat:@"%ld张可用", useCount];
    _priceTextField.text = _price;

//    [self configTotalPrices];
    // 总价格
    CGFloat allPrice = 0;
    if ([_model respondsToSelector:@selector(computeTotalPrice)]) {
        allPrice = [_model computeTotalPrice];
    }
    _totalPricesLabel.text = [NSString stringWithFormat:@"合计：¥%.2f", allPrice];
}

- (void)configTotalPrices {
    // 最大购买数
    NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:_model];
    // 限制最大购买
    if (_numberView.currentNumber > maxNum) {
        _numberView.currentNumber -= 1;
        
        [XMHProgressHUD showOnlyText:@"库存不足"];
    }
    
    // model 记录购买数量
    if ([_model respondsToSelector:@selector(setSelectCount:)]) {
        [_model setSelectCount:_numberView.currentNumber];
    }
    
    // 总价格
    CGFloat allPrice = 0;
    if ([_model respondsToSelector:@selector(computeTotalPrice)]) {
        allPrice = [_model computeTotalPrice];
    }
    _totalPricesLabel.text = [NSString stringWithFormat:@"合计：¥%.2f", allPrice];
}

#pragma mark - Lazy

- (UIView *)contentView {
    if (_contentView) return _contentView;
    
    CGFloat contentViewHeight = self.view.height * 0.73;
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - contentViewHeight, self.view.width, contentViewHeight)];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = _contentView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    _contentView.layer.mask = cornerRadiusLayer;
    return _contentView;
}

- (UIView *)couponBGView {
    if (_couponBGView) return _couponBGView;
    
    _couponBGView = UIView.new;
    _couponBGView.backgroundColor = UIColor.whiteColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(couponBGViewClick:)];
    [_couponBGView addGestureRecognizer:tap];
    
    if (self.selectTicketModel) {
        UILabel *ticketLabel = [UILabel new];
        ticketLabel.textColor = kColor3;
        ticketLabel.font = FONT_SIZE(13);
        [_couponBGView addSubview:ticketLabel];
        [ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(_couponBGView);
        }];
        ticketLabel.text = self.selectTicketModel.name;
    } else {
        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:UIImageName(@"shouye-xiaojiantou")];
        [_couponBGView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(6, 10)); // 24 40
            make.centerY.equalTo(_couponBGView);
            make.right.mas_equalTo(-15);
        }];
        
        UIImageView *couponNumbetBGView = [[UIImageView alloc] initWithImage:UIImageName(@"ddgl_youhuiquan")];
        [_couponBGView addSubview:couponNumbetBGView];
        [couponNumbetBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(64, 19));
            make.centerY.equalTo(_couponBGView);
            make.right.equalTo(arrowImageView.mas_left).offset(-14);
        }];
        
        UIImageView *couponNumbetIconView = [[UIImageView alloc] initWithImage:UIImageName(@"hongbao")];
        [couponNumbetBGView addSubview:couponNumbetIconView];
        [couponNumbetIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 12));
            make.centerY.equalTo(_couponBGView);
            make.left.mas_equalTo(5);
        }];
        
        self.couponTitleLabel = [UILabel new];
        _couponTitleLabel.textColor = UIColor.whiteColor;
        _couponTitleLabel.font = FONT_SIZE(10);
        _couponTitleLabel.textAlignment = NSTextAlignmentCenter;
        _couponTitleLabel.adjustsFontSizeToFitWidth = YES;
        [couponNumbetBGView addSubview:_couponTitleLabel];
        [_couponTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(couponNumbetIconView.mas_right).offset(5);
            make.right.equalTo(couponNumbetBGView).offset(-5);
            make.centerY.equalTo(couponNumbetBGView);
        }];
    }

    UILabel *titleLabel = [UILabel new];
    titleLabel.textColor = kColor3;
    titleLabel.font = FONT_SIZE(13);
    [_couponBGView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(_couponBGView);
    }];
    titleLabel.text = @"优惠卷";
    
    return _couponBGView;
}

- (UIView *)priceBGView {
    if (_priceBGView) return _priceBGView;
    
    _priceBGView = UIView.new;
    _priceBGView.backgroundColor = UIColor.whiteColor;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.textColor = kColor3;
    titleLabel.font = FONT_SIZE(13);
    [_priceBGView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(_priceBGView);
    }];
    titleLabel.text = @"零售价：";
    
    self.priceTextField = [[UITextField alloc] init];
    _priceTextField.textAlignment = NSTextAlignmentCenter;
    _priceTextField.delegate = self;
    _priceTextField.textColor = kColor3;
    _priceTextField.font = FONT_SIZE(13);
    _priceTextField.layer.borderWidth = 0.5;
    _priceTextField.layer.borderColor = kBackgroundColor_CCCCCC.CGColor;
    _priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [_priceBGView addSubview:_priceTextField];
    [_priceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(125, 30));
        make.centerY.equalTo(_priceBGView);
        make.left.equalTo(titleLabel.mas_right);
    }];
    
    self.numberView = [[XMHNumberView alloc] init];
    _numberView.minNumber = 0;
    [_priceBGView addSubview:_numberView];
    [_numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(26 * 2 + 40, 30));
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(_priceBGView);
    }];
    
    WeakSelf
    [_numberView setDidChangeBlock:^(XMHNumberView * _Nonnull numberView) {
        [weakSelf configTotalPrices];
    }];
    
    // 赋值初始数据
    if ([_model respondsToSelector:@selector(setSelectCount:)]) {
        NSInteger selectCount = ((SLS_Pro *)_model).selectCount;
        _numberView.currentNumber = selectCount;
    }
    
    return _priceBGView;
}

#pragma mark - Evnet

// 选择优惠券
- (void)couponBGViewClick:(UITapGestureRecognizer *)tap {
    XMHTicketVC *ticketVC = XMHTicketVC.new;
    ticketVC.ticketModelArray = self.ticketModelArray;
    [self presentViewController:ticketVC animated:YES completion:nil];
    __weak typeof(self) _self = self;
    [ticketVC setDidSelectBlock:^(XMHTicketVC * _Nonnull vc, XMHTicketModel * _Nonnull selectModel) {
        __strong typeof(_self) self = _self;
        self.selectTicketModel = selectModel;
        
        // 商品model 保留礼品卷model
        if ([self.model respondsToSelector:@selector(setTicketModel:)]) {
            [self.model setTicketModel:self.selectTicketModel];
        }
        
        [self createSubViews];
        
        NSArray *useModelArray = [XMHTicketModel useModelArray:self.ticketModelArray];
        [self configDataUseCount:useModelArray.count];
    }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.model respondsToSelector:@selector(setInputPrice:)]) {
        [self.model setInputPrice:[NSString stringWithFormat:@"%.2f", [textField.text floatValue]]];
    }
    
    [self configTotalPrices];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return [newText isVerifyPrice];
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
