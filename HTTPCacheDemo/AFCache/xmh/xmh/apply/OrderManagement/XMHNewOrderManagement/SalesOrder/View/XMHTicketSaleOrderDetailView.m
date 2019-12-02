//
//  XMHTicketSaleOrderDetailView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTicketSaleOrderDetailView.h"
#import "SASaleListModel.h"
#import "XMHNumberView.h"
#import "XMHShoppingCartManager.h"
#import "UIButton+EnlargeTouchArea.h"
@interface XMHTicketSaleOrderDetailView()<UITextFieldDelegate>
/** 总价 */
@property (nonatomic, copy)NSString *totalPrice;
/** 零售价 */
@property (nonatomic, assign)CGFloat lingshouPrice;
/** 数量 */
@property (nonatomic, assign)NSInteger num;

@end

@implementation XMHTicketSaleOrderDetailView

- (void)updateSubviews
{
    [self addSubview:self.closeBtn];
    [self.closeBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
        make.top.mas_equalTo(kMargin);
    }];
    
    
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(kMargin);
        make.top.mas_equalTo(self.mas_top).mas_offset(kMargin);
        make.right.mas_equalTo(self.closeBtn.mas_left);
    }];
    
    
    self.priceLab.text = @"零售价:￥";
    [self.priceLab sizeToFit];
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(kMargin);
        make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(25);
       
    }];
    
   
    self.field.delegate = self;
    self.field.text = [NSString stringWithFormat:@"￥%@",self.detailModel.price_list.pro_11.price];
    [self addSubview:self.field];
    
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLab.mas_right).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(125, 29));
        make.centerY.mas_equalTo(self.priceLab.mas_centerY);
    }];
    
    UIView *noticView = [[UIView alloc]init];
    [self addSubview:noticView];
    [noticView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLab.mas_bottom).mas_offset(25);
        make.height.mas_equalTo(125);
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(kMargin);
    }];
    
    UILabel *noticeLab = [[UILabel alloc]init];
    noticeLab.text = @"票券购买须知:";
    noticeLab.textAlignment = NSTextAlignmentLeft;
    noticeLab.textColor = kLabelText_Commen_Color_3;
    noticeLab.font = [UIFont systemFontOfSize:13];
    [noticView addSubview:noticeLab];
    [noticeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(noticView);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *oneLab = [[UILabel alloc]init];
    oneLab.text = @"1.本代金券不得兑换现金。";
    oneLab.textAlignment = NSTextAlignmentLeft;
    oneLab.textColor = kLabelText_Commen_Color_9;
    oneLab.font = [UIFont systemFontOfSize:13];
    [noticView addSubview:oneLab];
    
    [oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(noticeLab.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(noticView);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *towLab = [[UILabel alloc]init];
    towLab.text = @"2.有效期至。";
    towLab.textAlignment = NSTextAlignmentLeft;
    towLab.textColor = kLabelText_Commen_Color_9;
    towLab.font = [UIFont systemFontOfSize:13];
    [noticView addSubview:towLab];
    self.limitLab = towLab;
    [towLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oneLab.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(noticView);
        make.height.mas_equalTo(17);
    }];
    UILabel *threeLab = [[UILabel alloc]init];
    threeLab.text = @"3.本代金券只限一人使用一次,消费前请出示本券。";
    threeLab.textAlignment = NSTextAlignmentLeft;
    threeLab.textColor = kLabelText_Commen_Color_9;
    threeLab.font = [UIFont systemFontOfSize:13];
    [noticView addSubview:threeLab];
    
    [threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(towLab.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(noticView);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *fourLab = [[UILabel alloc]init];
    fourLab.text = @"4.不再与其他优惠同享。";
    fourLab.textAlignment = NSTextAlignmentLeft;
    fourLab.textColor = kLabelText_Commen_Color_9;
    fourLab.font = [UIFont systemFontOfSize:13];
    [noticView addSubview:fourLab];
    
    [fourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(threeLab.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(noticView);
        make.height.mas_equalTo(17);
    }];
    
   
    self.numLab.text = @"数量";
    [self addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(noticView.mas_bottom).mas_offset(25);
    }];
    
   WeakSelf
    self.numberView.didChangeBlock = ^(XMHNumberView * _Nonnull numberView) {
         [weakSelf configTotalPrices];
    };
    [self addSubview:self.numberView];
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
    
    [self initViewValue];
}



#pragma mark - 内部方法

/**
 获取默认零售价
 
 @return 返回默认零售价
 */
- (CGFloat)lingshouDefalutPrice
{
    
    CGFloat linshouPrice = [self.detailModel.price_list.pro_11.price floatValue];
    return linshouPrice;
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

#pragma mark -- 赋值
- (void)initViewValue
{
    if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
        [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]]];
    }
    self.limitLab.text = [NSString stringWithFormat:@"2.有效期至%@。",self.detailModel.end_time];
    self.nameLab.text = self.detailModel.name;
    self.field.text  = [NSString stringWithFormat:@"%.2f",[self.detailModel.inputPrice floatValue]];
    self.totalPriceLab.text = [NSString stringWithFormat:@"总价: ￥%.2f",[self.detailModel computeTotalPrice]] ;
 
}
#pragma mark -- event

- (void)clickSureBtn
{
    NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:self.detailModel];
    if (maxNum == 0) {
        [XMHProgressHUD showOnlyText:@"库存不足"];
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

#pragma mark -- UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
        [self.detailModel setInputPrice:textField.text];
    }
    [self configTotalPrices];
}


@end
