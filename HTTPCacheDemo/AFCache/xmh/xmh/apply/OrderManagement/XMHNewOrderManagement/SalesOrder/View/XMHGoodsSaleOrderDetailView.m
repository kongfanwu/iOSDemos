//
//  XMHGoodsSaleOrderDetailView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHGoodsSaleOrderDetailView.h"
#import "XMHNumberView.h"
#import "XMHVipDiscountView.h"
#import "XMHCouponView.h"
#import "SASaleListModel.h"
#import "XMHSaleOrderRequest.h"
#import "XMHCouponDetailView.h"
#import "XMHVipDiscountDetailBaseView.h"
#import "XMHCouponDetailVC.h"
#import "XMHShoppingCartManager.h"
#import "XMHVipDiscountVC.h"
#import "UIButton+EnlargeTouchArea.h"
@interface XMHGoodsSaleOrderDetailView()<UITextFieldDelegate>

@property (nonatomic, copy)NSString *zhekouModelPrice;

@end

@implementation XMHGoodsSaleOrderDetailView

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
    
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(kMargin);
        make.top.mas_equalTo(self.mas_top).mas_offset(kMargin);
        make.right.mas_equalTo(self.closeBtn.mas_left);
    }];

    self.vipLab.text = @"会员优惠";
    [self addSubview:self.vipLab];
    [self.vipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(20);
    }];
    
    self.vipTicketLab.text = @"优惠券";
    [self addSubview:self.vipTicketLab];
    [self.vipTicketLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.vipLab.mas_bottom).mas_offset(25);
    }];

    self.priceLab.text = @"零售价:￥";
    [self.priceLab sizeToFit];
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.vipTicketLab.mas_bottom).mas_offset(25);
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
    
  
    self.numberView.didChangeBlock = ^(XMHNumberView * _Nonnull numberView) {
        //产品要求  加减号 全部清空已选优惠券
        weakSelf.couponModel = nil;
        [weakSelf.couponView setCoupon:@"" hiddenBgView:YES];
        if ([weakSelf.detailModel respondsToSelector:@selector(setStaicketModel:)]) {
            [weakSelf.detailModel setStaicketModel:nil];
        }

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
    
    // 会员优惠选择

    self.discountView.vipDiscountBlock = ^{
        [weakSelf requestVipDiscount];
    };
    [self addSubview:self.discountView];
    [self.discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
        make.centerY.mas_equalTo(self.vipLab.mas_centerY);
        make.width.mas_equalTo(100);
    }];
    
    //优惠券
   
    [self.couponView setCoupon:@"" hiddenBgView:YES];
    self.couponView.didCouponTickt = ^{
        [weakSelf requestCouponTicketData];
    };
    [self addSubview:self.couponView];
    [self.couponView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
        make.centerY.mas_equalTo(self.vipTicketLab.mas_centerY);
        make.width.mas_equalTo(100);
    }];
    
    [self initViewValue];
}

#pragma mark --request
/**
 会员优惠列表
 */
- (void)requestVipDiscount
{
    [self.field resignFirstResponder];
    WeakSelf
    if ([self.detailModel.inputPrice floatValue] != [self lingshouDefalutPrice]) {
        if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
            [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self.detailModel.inputPrice floatValue]]];
        }
        
    }else{
        if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
            [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]]];
        }
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.detailModel.uid) forKey:@"search_id"];
    [params setObject:self.userId?self.userId:@"" forKey:@"user_id"];
    [params setObject:self.type?self.type:@"" forKey:@"type"];
    [params setObject:self.storeCode? self.storeCode :@"" forKey:@"stored_code"];
    
    XMHVipDiscountVC *vc = [[XMHVipDiscountVC alloc]init];
    vc.params = params;
    vc.detailModel = self.detailModel;
    vc.zhekouModel = self.zhekouModel;
   
    vc.selectedModel = ^(ZheKouStored_Card * _Nonnull model) {
          weakSelf.couponModel = nil;
        if (model && model.selected == YES) {
            //会员优惠
            weakSelf.zhekouModel = model;
            weakSelf.discountView.discount = model.name;
            // 选择会员优惠则要清除优惠券数据
            self.couponModel = nil;
            [self.couponView setCoupon:@"" hiddenBgView:YES];
            if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
                [self.detailModel setInputPrice:[NSString stringWithFormat:@"%@",self.zhekouModel.price]];
            }
            _zhekouModelPrice = self.zhekouModel.price;

            //sastoreCardModel
            if ([self.detailModel respondsToSelector:@selector(setSastoreCardModel:)]) {
                [self.detailModel setSastoreCardModel:model];
            }
            NSString *text = [NSString stringWithFormat:@"零售价:￥%.2f/",[self lingshouDefalutPrice]];
            NSString *defalutPrice = [NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]];
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:text];
            
            [attribtStr setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle),NSForegroundColorAttributeName:kColor9} range:NSMakeRange(4, defalutPrice.length + 1)];
            
            self.priceLab.attributedText = attribtStr;
        }else{
            weakSelf.zhekouModel = nil;
            weakSelf.discountView.discount = @"请选择";
            if ([self.detailModel.inputPrice floatValue] == [_zhekouModelPrice floatValue]) { // 记录上一次选中的会员优惠与输入的金额区分
                if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
                    [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]]];
                }
            }

            if ([self.detailModel respondsToSelector:@selector(setSastoreCardModel:)]) {
                [self.detailModel setSastoreCardModel:nil];
            }
             self.priceLab.text = @"零售价:￥";

        }
          self.field.text = [NSString stringWithFormat:@"%@",self.detailModel.inputPrice];
        
        if ([self.detailModel respondsToSelector:@selector(setStaicketModel:)]) {
            [self.detailModel setStaicketModel:nil];
        }

        [self configTotalPrices];
        [[self currentViewController] dismissViewControllerAnimated:YES completion:nil];
    };
    
    [[self currentViewController] presentViewController:vc animated:YES completion:nil];
    
}


/**
 优惠券列表
 */
- (void)requestCouponTicketData
{
    [self.field resignFirstResponder];
    WeakSelf
    if ([self.detailModel.inputPrice floatValue] != [self lingshouDefalutPrice]) {
        if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
            [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self.detailModel.inputPrice floatValue]]];
        }
        
    }else{
        if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
            [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]]];
        }
    }
    CGFloat totalPrice = [self.detailModel.inputPrice floatValue] * self.detailModel.selectCount;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.detailModel.uid) forKey:@"search_id"];
    [params setObject:self.userId?self.userId:@"" forKey:@"user_id"];
    [params setObject:self.type?self.type:@"" forKey:@"type"];
    [params setObject:self.detailModel.code? self.detailModel.code :@"" forKey:@"code"];
    [params setObject:@(totalPrice)?@(totalPrice) :@"" forKey:@"price"];//总价 按照默认没有选择任何优惠券的总价也就是原来的总价

    XMHCouponDetailVC *vc = [[XMHCouponDetailVC alloc]init];
    vc.model = self.couponModel;
    vc.detailModel = self.detailModel;
    vc.params = params;
   
    vc.selectedCouponsModel = ^(SATicketModel * _Nonnull ticketModel) {
        weakSelf.couponModel = ticketModel;
        if (ticketModel && weakSelf.couponModel.selected) {
            // 选择优惠券则清空会员优惠数据
            weakSelf.zhekouModel = nil;
            weakSelf.discountView.discount = @"请选择";
            if ([self.detailModel respondsToSelector:@selector(setStaicketModel:)]) {
                [self.detailModel setStaicketModel:ticketModel];
            }
            CGFloat ticketPrice = 0;
            if (ticketModel.type == 3){ //现金券
                ticketPrice = [ticketModel.price floatValue];
            }else if(ticketModel.type == 4){//折扣券
                // 折扣 = 单价*数量后的价格 乘上 折扣
                ticketPrice = totalPrice * (1 - [ticketModel.discount floatValue] / 10);
                if ((ticketPrice >= self.couponModel.fulfill.floatValue) && (self.couponModel.fulfill.floatValue > 0)) {
                    ticketPrice = self.couponModel.fulfill.floatValue;
                }
            }else if(ticketModel.type == 1){//票券
                ticketPrice = [ticketModel.money floatValue];
                if (ticketPrice >= [self lingshouDefalutPrice]) {
                    ticketPrice = [self lingshouDefalutPrice];
                }
            }
         
             [self.couponView setCoupon:[NSString stringWithFormat:@"%@%.2f",@"-",ticketPrice] hiddenBgView:YES];
            if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
                [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]]];
            }
            self.priceLab.text = @"零售价:￥";
        }else{
            [self.couponView setCoupon:@"" hiddenBgView:YES];
            if ([self.detailModel respondsToSelector:@selector(setStaicketModel:)]) {
                [self.detailModel setStaicketModel:nil];
            }
            if (self.zhekouModel) {
                if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
                    [self.detailModel setInputPrice:[NSString stringWithFormat:@"%@",self.zhekouModel.price]];
                }
                NSString *text = [NSString stringWithFormat:@"零售价:￥%.2f/",[self lingshouDefalutPrice]];
                NSString *defalutPrice = [NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]];
                NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:text];
                
                [attribtStr setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle),NSForegroundColorAttributeName:kColor9} range:NSMakeRange(4, defalutPrice.length + 1)];
                
                self.priceLab.attributedText = attribtStr;
            }else{
                self.priceLab.text = @"零售价:￥";
            }
        }
        if ([self.detailModel respondsToSelector:@selector(setSastoreCardModel:)]) {
            [self.detailModel setSastoreCardModel:nil];
        }
        
        self.field.text = [NSString stringWithFormat:@"%@",self.detailModel.inputPrice];
       
        [self configTotalPrices];

        [[self currentViewController] dismissViewControllerAnimated:YES completion:nil];
    };
    
    [[self currentViewController] presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark -- 赋值
- (void)initViewValue
{
    if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
        [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]]];
    }
     self.field.text = [NSString stringWithFormat:@"%@",self.detailModel.inputPrice];
    self.totalPriceLab.text =     self.totalPriceLab.text = [NSString stringWithFormat:@"总价: ￥%@",self.detailModel.inputPrice]; //初始价格;
    self.nameLab.text = self.detailModel.name;
}

#pragma mark -- event

-(void)clickSureBtn
{
    NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:self.detailModel];
    if (maxNum == 0) {
        [XMHProgressHUD showOnlyText:@"库存不足"];
    }
    if ([self.detailModel.inputPrice floatValue] != [self lingshouDefalutPrice] && !self.detailModel.sastoreCardModel) {
        self.detailModel.gai_price = 1;
    }else{
        self.detailModel.gai_price = 0;
    }
    
    if (self.selectedFinishBlock) {
        self.selectedFinishBlock(self.detailModel);
    }
   
}
#pragma mark - 内部方法

/**
 获取默认零售价
 
 @return 返回默认零售价
 */
- (CGFloat)lingshouDefalutPrice
{
    //lingshouDefalutPrice
    CGFloat linshouPrice = [self.detailModel.price_list.pro_11.price floatValue];
  
    return linshouPrice;
}

- (void)configTotalPrices {
    // model 记录购买数量
    if ([self.detailModel respondsToSelector:@selector(setSelectCount:)]) {
        [self.detailModel setSelectCount:self.numberView.currentNumber];
    }
    
    // 总价格
    CGFloat allPrice = 0;
//    if ([self.detailModel respondsToSelector:@selector(computeTotalPrice)]) {
//        allPrice = [self.detailModel computeTotalPrice];
//    }
    allPrice = [self computeZhekouTotalPrice];
    self.totalPriceLab.text = [NSString stringWithFormat:@"总价：¥%.2f", allPrice];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.couponModel = nil;
    self.zhekouModel = nil;
    self.discountView.discount = @" 请选择";
    [self.couponView setCoupon:@"" hiddenBgView:YES];
    if ([self.detailModel respondsToSelector:@selector(setStaicketModel:)]) {
        [self.detailModel setStaicketModel:nil];
    }
    
    if ([self.detailModel respondsToSelector:@selector(setSastoreCardModel:)]) {
        [self.detailModel setSastoreCardModel:self.zhekouModel];
    }

    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
   
    if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
        [self.detailModel setInputPrice:textField.text];
    }
    [self configTotalPrices];
    self.priceLab.text = @"零售价:¥";
}


/**
 计算选择优惠券后的价格
 */
- (CGFloat)computeZhekouTotalPrice
{
    CGFloat allPrice = 0;
    // 总价计算
    CGFloat totalPrice = [self.detailModel.inputPrice floatValue] * self.detailModel.selectCount;
    
    if (self.couponModel.selected && self.couponModel){
        // 第三种情况:有优惠券 总价= num * 优惠券价格 优惠券分三种
        if (self.couponModel.type == 1) {
            
            totalPrice = totalPrice - [self.couponModel.money floatValue];
            if (totalPrice < 0) {
                totalPrice = 0;
            }
        }else if (self.couponModel.type == 3){
            
            if(totalPrice >= [self.couponModel.fulfill floatValue]){
                totalPrice = totalPrice - [self.couponModel.price floatValue];
                if (totalPrice < 0) {
                    totalPrice = 0;
                }
            }
        }else if (self.couponModel.type == 4){
            {
                CGFloat tempDi = 0.0f; /** 抵用券的钱 */
                //折扣:原来总价 * 折扣
                tempDi = totalPrice * ( 1 - self.couponModel.discount.floatValue/10);
                if ((tempDi >= self.couponModel.fulfill.floatValue) && (self.couponModel.fulfill.floatValue > 0)) {
                    tempDi = self.couponModel.fulfill.floatValue;
                }
                totalPrice = totalPrice - tempDi;
                if (totalPrice<0) {
                    totalPrice = 0;
                }
            }
        }
    }
    allPrice = totalPrice;
    return allPrice;
}
#pragma mark 获得当前view的控制器
- (UIViewController*)currentViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
