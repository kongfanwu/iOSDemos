//
//  XMHRenewalCardDetailView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/28.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHRenewalCardDetailView.h"
#import "SASaleListModel.h"
#import "UIButton+EnlargeTouchArea.h"
@interface XMHRenewalCardDetailView ()<UITextFieldDelegate>

/** 总价 */
@property (nonatomic, copy)NSString *totalPrice;
/** 零售价 */
@property (nonatomic, assign)CGFloat lingshouPrice;
/** 数量 */
@property (nonatomic, assign)NSInteger num;
@end

@implementation XMHRenewalCardDetailView

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
    
    self.priceLab.text = @"剩余金额:￥";
    [self.priceLab sizeToFit];
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(25);
    }];
    
    
   
    self.xukaLab.text = @"续卡金额:￥";
    [self.xukaLab sizeToFit];
    [self addSubview:self.xukaLab];
    [self.xukaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.priceLab.mas_bottom).mas_offset(25);
    }];
    // 零售价内容
 
    self.field.delegate = self;
    [self addSubview:self.field];
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.xukaLab.mas_right).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 29));
        make.centerY.mas_equalTo(self.xukaLab.mas_centerY);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"元";
    lab.textColor = kLabelText_Commen_Color_3;
    lab.font = [UIFont systemFontOfSize:13];
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.field.mas_right).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 29));
        make.centerY.mas_equalTo(self.xukaLab.mas_centerY);
    }];

    //需要的时候再引用.由后台返回s对应的限制金额
//    self.limitLab = [[UILabel alloc]init];
//    self.limitLab.textAlignment = NSTextAlignmentLeft;
//    self.limitLab.text = @"元  (最低充值2000元)";
//    self.limitLab.textAlignment = NSTextAlignmentLeft;
//    self.limitLab.textColor = kLabelText_Commen_Color_9;
//    self.limitLab.font = [UIFont systemFontOfSize:11];
//    [self.limitLab sizeToFit];
//    [self addSubview:self.limitLab];
//    [self.limitLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.field.mas_right).mas_offset(5);
//        make.centerY.mas_equalTo(self.xukaLab.mas_centerY);
//    }];
    
       [self initViewValue];
}

#pragma mark -- 赋值
- (void)initViewValue
{
    if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
        [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]]];
    }
    self.priceLab.text = [NSString stringWithFormat:@"剩余金额:￥%.2f",[self.detailModel.inputPrice floatValue]];
    self.nameLab.text = self.detailModel.name;
//    self.field.text  = [NSString stringWithFormat:@"%.2f",[self.detailModel.inputPrice floatValue]];
}
#pragma mark -- 内部方法
- (void)configTotalPrices {
    // model 记录购买数量
    if ([self.detailModel respondsToSelector:@selector(setSelectCount:)]) {
        [self.detailModel setSelectCount:1];
    }
    // 总价格
    CGFloat allPrice = 0;
    if ([self.detailModel respondsToSelector:@selector(computeTotalPrice)]) {
        allPrice = [self.detailModel computeTotalPrice];
    }
    
}
/**
 获取默认零售价
 
 @return 返回默认零售价
 */
- (CGFloat)lingshouDefalutPrice
{
    CGFloat linshouPrice = [self.detailModel.money floatValue];
    return linshouPrice;
}
#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
        [self.detailModel setInputPrice:textField.text];
    }
    [self configTotalPrices];
    
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
    if ([self isValid:checkStr withRegex:regex] && [checkStr floatValue] <= 9999999) {
          return YES;
    }
    return NO;
    
    
    
}
//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}


#pragma mark -- event

- (void)clickSureBtn
{
    self.num = 1;
    // 存储输入框此时的数据,后续购物车会用
    self.detailModel.fieldPrice = self.lingshouPrice;
    self.totalPrice = [NSString stringWithFormat:@"%f",self.lingshouPrice];
    self.detailModel.lingshouMoney = [NSString stringWithFormat:@"%f",self.lingshouPrice];
    self.detailModel.addnum = self.num;
    self.detailModel.totalPrice = self.totalPrice;
    if (self.selectedFinishBlock) {
        self.selectedFinishBlock(self.detailModel);
    }
}

@end
