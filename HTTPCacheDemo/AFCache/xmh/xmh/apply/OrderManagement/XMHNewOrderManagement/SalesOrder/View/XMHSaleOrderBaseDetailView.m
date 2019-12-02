//
//  XMHSaleOrderBaseDetailView.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSaleOrderBaseDetailView.h"
#import "XMHNumberView.h"
#import "XMHVipDiscountView.h"
#import "XMHCouponView.h"
#import "SASaleListModel.h"
@interface XMHSaleOrderBaseDetailView()<UITextFieldDelegate,UIScrollViewDelegate>

@end

@implementation XMHSaleOrderBaseDetailView

- (instancetype)initWithFrame:(CGRect)frame userId:(NSString *)userId storeCode:(NSString *)storeCode type:(NSString *)type detailModel:(nonnull SaleModel *)detailModel
{
    if (self = [super initWithFrame:frame]) {
        self.userId = userId;
        self.storeCode = storeCode;
        self.type = type;
        self.detailModel = detailModel;
        if ([type isEqualToString:@"card_num"]) {
            self.infoStr = @"卡项次数";
        }else if ([type isEqualToString:@"card_time"]){
             self.infoStr = @"使用期限";
        }else if ([type isEqualToString:@"stored_card"]){
            self.storeCardFlag = YES;
        }
        [self createSubViews];
        
    }
    return self;
}
-(void)createSubViews{

    self.backgroundColor = [UIColor whiteColor];
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = self.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    self.layer.mask = cornerRadiusLayer;
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureBtn.backgroundColor = kColorTheme;
    [self addSubview:self.sureBtn];
    self.sureBtn.layer.cornerRadius =  3;//44 * 0.5;
    CGFloat bottom = kSafeAreaBottom + 15;
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-bottom);
    }];
    __weak typeof(self) _self = self;
    [self.sureBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self clickSureBtn];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [self.closeBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self clickCloseBtn];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.textAlignment = NSTextAlignmentLeft;
    self.nameLab.textColor = kLabelText_Commen_Color_3;
    self.nameLab.font = [UIFont systemFontOfSize:15];

    
    self.countLab = [[UILabel alloc]init];
    self.countLab.text = @"疗程次数";
    self.countLab.textAlignment = NSTextAlignmentLeft;
    self.countLab.textColor = kLabelText_Commen_Color_3;
    self.countLab.font = [UIFont systemFontOfSize:13];

    [self.countLab sizeToFit];
    
    self.vipLab = [[UILabel alloc]init];
    self.vipLab.text = @"会员优惠";
    self.vipLab.textAlignment = NSTextAlignmentLeft;
    self.vipLab.textColor = kLabelText_Commen_Color_3;
    self.vipLab.font = [UIFont systemFontOfSize:13];
   
    [self.vipLab sizeToFit];
    
    self.vipTicketLab = [[UILabel alloc]init];
    self.vipTicketLab.text = @"优惠券";
    self.vipTicketLab.textAlignment = NSTextAlignmentLeft;
    self.vipTicketLab.textColor = kLabelText_Commen_Color_3;
    self.vipTicketLab.font = [UIFont systemFontOfSize:13];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.textAlignment = NSTextAlignmentLeft;
    self.priceLab.text = @"零售价:￥";
    self.priceLab.textColor = kLabelText_Commen_Color_3;
    self.priceLab.font = [UIFont systemFontOfSize:13];
    [self.priceLab sizeToFit];
   
   
    
    // 零售价内容
    self.field = [[UITextField alloc]init];
    self.field.keyboardType = UIKeyboardTypeDecimalPad;
    self.field.borderStyle =  UITextBorderStyleRoundedRect;
    self.field.font = [UIFont systemFontOfSize:13];
    self.field.delegate = self;
 
    
    self.numLab = [[UILabel alloc]init];
    self.numLab.textAlignment = NSTextAlignmentLeft;
    self.numLab.text = @"数量";
    self.numLab.textColor = kLabelText_Commen_Color_3;
    self.numLab.font = [UIFont systemFontOfSize:13];
    
    // 加减号
    self.numberView = [[XMHNumberView alloc]init];
    // 会员优惠选择
    self.discountView = [[XMHVipDiscountView alloc]init];
    //优惠券
    self.couponView = [[XMHCouponView alloc]init];
    self.couponView.backgroundColor = [UIColor whiteColor];
 
    self.totalPriceLab = [[UILabel alloc]init];
    self.totalPriceLab.textAlignment = NSTextAlignmentLeft;
    self.totalPriceLab.text = [NSString stringWithFormat:@"总价:"];
    self.totalPriceLab.textColor = kLabelText_Commen_Color_3;
    self.totalPriceLab.font = [UIFont systemFontOfSize:13];
    
    self.xukaLab = [[UILabel alloc]init];
    self.xukaLab.textAlignment = NSTextAlignmentLeft;
    self.xukaLab.text = @"续卡金额:￥";
    self.xukaLab.textColor = kLabelText_Commen_Color_3;
    self.xukaLab.font = [UIFont systemFontOfSize:13];
    [self.xukaLab sizeToFit];
    
    self.contentLab = [[UILabel alloc]init];
    self.contentLab.textAlignment = NSTextAlignmentLeft;
    self.contentLab.text = @"购买内容选择";
    self.contentLab.textColor = kLabelText_Commen_Color_3;
    self.contentLab.font = [UIFont systemFontOfSize:13];
    
    //内容选择
    self.contentView = [[XMHCouponView alloc]init];
    self.contentView.content = @"请选择";
    self.contentView.backgroundColor = [UIColor whiteColor];

}

#pragma mark -- event 
- (void)clickSureBtn{}
- (void)clickCloseBtn{
    [self.detailModel reset];
    if (_closeDetailView) {
        _closeDetailView();
    }
}
- (void)updateSubviews{}


//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //新输入的
    if (string.length == 0) {
        return YES;
    }
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //正则表达式（只支持两位小数）
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    //判断新的文本内容是否符合要求
    return [self isValid:checkStr withRegex:regex];
}
@end
