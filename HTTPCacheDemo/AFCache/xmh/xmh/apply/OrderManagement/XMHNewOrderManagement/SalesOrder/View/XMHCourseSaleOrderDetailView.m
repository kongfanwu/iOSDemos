//
//  XMHCourseSaleOrderDetailView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCourseSaleOrderDetailView.h"
#import "XMHNumberView.h"
#import "XMHVipDiscountView.h"
#import "XMHCouponView.h"
#import "SASaleListModel.h"
#import "XMHSaleOrderRequest.h"
#import "BaoHanNeiRongView.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "XMHShoppingCartManager.h"
#import "XMHSuccessAlertView.h"
#import "UIButton+EnlargeTouchArea.h"
@interface XMHCourseSaleOrderDetailView()<UITextFieldDelegate>
/** 内容选择 */
@property (nonatomic, copy)NSString * baohanJsonStr;
/** 总价 */
@property (nonatomic, copy)NSString *totalPrice;
/** 零售价 */
@property (nonatomic, assign)CGFloat lingshouPrice;
/** 数量 */
@property (nonatomic, assign)NSInteger num;

@end


@implementation XMHCourseSaleOrderDetailView


- (void)updateSubviews
{
    WeakSelf
   
    [self addSubview:self.closeBtn];
    [self.closeBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
        make.top.mas_equalTo(kMargin);
    }];
    
    self.nameLab.text = self.detailModel.name;
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(kMargin);
        make.top.mas_equalTo(self.mas_top).mas_offset(kMargin);
        make.right.mas_equalTo(self.closeBtn.mas_left);
    }];
    
   
    self.contentLab.text = @"购买内容选择";
    [self addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(kMargin);
        make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(kMargin);
        make.right.mas_equalTo(100);
    }];
    
    //内容选择
    self.contentView.content = @"请选择";
    self.contentView.didCouponTickt = ^{
        [weakSelf baoHanNeiRongMethod];
    };
    [self addSubview:self.contentView];
    [self.contentView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
        make.centerY.mas_equalTo(self.contentLab.mas_centerY);
        make.width.mas_equalTo(100);
    }];

    self.priceLab.text = @"零售价:";
    [self.priceLab sizeToFit];
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.contentView.mas_bottom).mas_offset(25);
    }];
    
    // 零售价内容
    self.field.delegate = self;
    [self addSubview:self.field];
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLab.mas_right).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(125, 29));
        make.centerY.mas_equalTo(self.priceLab.mas_centerY);
    }];
    
    
    self.numLab.text = @"数量";
    [self addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.priceLab.mas_bottom).mas_offset(25);
    }];
    
    [self addSubview:self.numberView];
    self.numberView.didChangeBlock = ^(XMHNumberView * _Nonnull numberView) {
         [weakSelf configTotalPrices];
    };
   
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numLab .mas_centerY);
        make.size.mas_equalTo(CGSizeMake(26 * 2 + 40, 30));
        make.right.mas_equalTo(-kMargin);
        
    }];
    
  
    self.totalPriceLab.text = [NSString stringWithFormat:@"总价:"];
    [self addSubview:self.totalPriceLab];
    [self.totalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.numLab.mas_bottom).mas_offset(25);
    }];
    
   
    if (self.infoStr.length) {
        self.contentLab.text = self.infoStr;
        self.contentView.hidden = YES;
    }
    
    if (self.storeCardFlag) {
        self.contentView.hidden =YES;
        self.contentLab.hidden = YES;
        [self.priceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kMargin);
            make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(25);
        }];
    }
    
     [self initViewValue];
}

#pragma mark -- 赋值
- (void)initViewValue
{
    if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
        [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]]];
    }
    self.nameLab.text = self.detailModel.name;
    self.priceLab.text = @"零售价:￥";
    self.field.text  = [NSString stringWithFormat:@"%.2f",[self.detailModel.inputPrice floatValue]];
    self.totalPriceLab.text = [NSString stringWithFormat:@"总价: ￥%.2f",[self.detailModel computeTotalPrice]] ;

    if (self.infoStr) {
        if ([self.infoStr isEqualToString:@"卡项次数"]) {
            self.contentLab.text = [NSString stringWithFormat:@"卡项次数: %ld次",[XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:self.detailModel]];
        }else if ([self.infoStr isEqualToString:@"使用期限"]){
            self.contentLab.text = [NSString stringWithFormat:@"使用期限: %ld天",(long)self.detailModel.limit];
        }
    }
}

#pragma mark -- 购买内容选择
- (void)baoHanNeiRongMethod{
    
    BaoHanNeiRongView *baohanweb = [[BaoHanNeiRongView alloc]initWithFrame:CGRectMake(0, -StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT + StatusBarHeight)];
    [self.superview addSubview:baohanweb];
    
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    [baohanweb freshBaoHanNeiRongViewCode:self.detailModel.code Num:[NSString stringWithFormat:@"%ld",self.numberView.currentNumber] sjCode:joinCode token:token name:self.detailModel.name];
    [baohanweb freshBaoHanNeiRongViewSecondjsonText:self.detailModel.baohanJsonStr];
    __block BaoHanNeiRongView *tmpweb = baohanweb;
    baohanweb.BaoHanNeiRongViewBuanbiBlock = ^(NSString *baohanStr){
        self.baohanJsonStr = baohanStr;
        [self.contentView setCoupon:@"已选择" hiddenBgView:YES];
        if ([self.detailModel respondsToSelector:@selector(setBaohanJsonStr:)]) {
            [self.detailModel setBaohanJsonStr:baohanStr];
        }
        [tmpweb removeFromSuperview];
    };
    
}

/**
 更新零售价 两种情况.默认价格和会员优惠价格
 */
- (void)changeLingshouPrice
{
    if ([self.priceLab.text isEqualToString:@"零售价:￥"]) {
        self.field.text = [NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]];
    }
    self.lingshouPrice = [self.field.text floatValue];
}


/**
 更新总价
 */
- (void)updataTotalPrice
{
    CGFloat lingshouPrice =  [self.field.text floatValue];
    CGFloat totalPrice = lingshouPrice * self.num;
    self.totalPrice = [NSString stringWithFormat:@"%.2f",totalPrice];
    self.totalPriceLab.text = [NSString stringWithFormat:@"总价: ￥%.2f",totalPrice];
}

#pragma mark -- event

- (void)clickSureBtn
{
     NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:self.detailModel];
    if (maxNum == 0) {
      [XMHProgressHUD showOnlyText:@"库存不足"];
    }
    if (!_baohanJsonStr && [self.contentLab.text isEqualToString: @"购买内容选择"] && self.contentLab.hidden == NO) {
         [[[XMHSuccessAlertView alloc]initWithTitle:@"请选择包含内容"]show];
        return;
    }
    if ([self.detailModel.inputPrice floatValue] != [self lingshouDefalutPrice]) {
        self.detailModel.gai_price = 1;
    }else{
        self.detailModel.gai_price = 0;
    }
    
    if (self.selectedFinishBlock) {
        self.selectedFinishBlock(self.detailModel);
    }
}
#pragma mark -- 内部方法
- (void)configTotalPrices {
    // model 记录购买数量
    if ([self.detailModel respondsToSelector:@selector(setSelectCount:)]) {
        [self.detailModel setSelectCount:self.numberView.currentNumber];
    }
    // 总价格
    CGFloat allPrice = 0;
    if ([self.detailModel respondsToSelector:@selector(computeTotalPrice)]) {
        allPrice = [self.detailModel computeTotalPrice];
    }
    self.totalPriceLab.text = [NSString stringWithFormat:@"总价：¥%.2f", allPrice];
}
/**
 获取默认零售价
 
 @return 返回默认零售价
 */
- (CGFloat)lingshouDefalutPrice
{
    
    CGFloat linshouPrice = [self.detailModel.price_list.pro_11.price floatValue];
    if (self.storeCardFlag) {
        linshouPrice = [self.detailModel.price_list.pro_10.price floatValue];
    }
    
    return linshouPrice;
}

#pragma mark -- UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
        [self.detailModel setInputPrice:textField.text];
    }
    [self configTotalPrices];

    return;
}

@end
