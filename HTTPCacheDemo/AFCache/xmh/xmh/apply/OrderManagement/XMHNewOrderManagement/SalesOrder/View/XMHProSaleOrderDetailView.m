//
//  XMHProSaleOrderDetailView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//
#import "XMHSaleOrderBaseDetailView.h"
#import "XMHProSaleOrderDetailView.h"
#import "XMHNumberView.h"
#import "XMHVipDiscountView.h"
#import "XMHCouponView.h"
#import "SASaleListModel.h"
#import "XMHSaleOrderRequest.h"
#import "XMHCouponDetailView.h"
#import "XMHVipDiscountDetailBaseView.h"
#import "XMHCouponDetailVC.h"
#import "XMHVipDiscountVC.h"
#import "XMHShoppingCartManager.h"
#import "UIButton+EnlargeTouchArea.h"
#import "XMHSaleOrderRequest.h"
static const CGFloat countLabW = 55;

#define Start_X          85.0f      // 第一个按钮的X坐标
#define Start_Y          56.0f     // 第一个按钮的Y坐标
#define Width_Space      15.0f      // 2个按钮之间的横间距
#define Height_Space     20.0f     // 竖间距
#define Button_Height   29.0f    // 高
#define Button_Width    55.0f    // 宽

@interface XMHProSaleOrderDetailView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *lastBtn; //最后一个疗程
@property (nonatomic, strong) UIButton *selectBtn; //第一个疗程
@property (nonatomic, copy)NSString *zhekouModelPrice;
@property (nonatomic, strong)NSMutableArray *zheKouStoredCards;

@end

@implementation XMHProSaleOrderDetailView

- (void)updateSubviews
{
    WeakSelf
     [self.closeBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    CGFloat bottom = kSafeAreaBottom + 15;
    
    self.scrollView = [[UIScrollView alloc]init];
    [self addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.bounds.size.height  - bottom - 44);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.scrollView addSubview:self.closeBtn];
  
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.left.mas_equalTo(SCREEN_WIDTH - 29);
        make.top.mas_equalTo(kMargin);
    }];
    
    
    [self.scrollView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scrollView.mas_left).mas_offset(kMargin);
        make.top.mas_equalTo(self.scrollView.mas_top).mas_offset(kMargin);
        make.width.mas_equalTo(250);
    }];

   
    [self.scrollView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(25);
        make.width.mas_equalTo(countLabW);
    }];
    [self.countLab sizeToFit];

    [self.scrollView addSubview:self.vipLab];
    [self.vipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.countLab.mas_bottom).mas_offset(20);
    }];
    [self.vipLab sizeToFit];
    
    [self.scrollView addSubview:self.vipTicketLab];
    [self.vipTicketLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.vipLab.mas_bottom).mas_offset(20);
    }];


    [self.priceLab sizeToFit];
    [self.scrollView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.vipTicketLab.mas_bottom).mas_offset(25);
    }];

    [self.scrollView addSubview:self.field];
    self.field.text = [NSString stringWithFormat:@"￥%@",self.detailModel.price_list.pro_11.price];
   
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLab.mas_right).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(125, 29));
        make.centerY.mas_equalTo(self.priceLab.mas_centerY);
    }];

   
    [self.scrollView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.priceLab.mas_bottom).mas_offset(25);
    }];
    __weak typeof(self) _self = self;
    self.numberView.didChangeBlock = ^(XMHNumberView * _Nonnull numberView) {
        __strong typeof(_self) self = _self;
        //产品要求  加减号 全部清空已选优惠券
        self.couponModel = nil;
        [self.couponView setCoupon:@"" hiddenBgView:YES];
        if ([self.detailModel respondsToSelector:@selector(setStaicketModel:)]) {
            [self.detailModel setStaicketModel:nil];
        }
        [weakSelf configTotalPrices];
    };
    [self.scrollView addSubview:self.numberView];
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numLab .mas_centerY);
        make.size.mas_equalTo(CGSizeMake(26 * 2 + 40, 30));
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);

    }];

    
    [self.scrollView addSubview:self.totalPriceLab];
    [self.totalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.numLab.mas_bottom).mas_offset(25);
    }];
 
    // 会员优惠选择
   
    self.discountView.vipDiscountBlock = ^{
        [weakSelf requestVipDiscount];
    };
    [self.scrollView addSubview:self.discountView];
    [self.discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
        make.centerY.mas_equalTo(self.vipLab.mas_centerY);
        make.width.mas_equalTo(100);
    }];

    //优惠券
    self.couponView.backgroundColor = [UIColor whiteColor];
    self.couponView.didCouponTickt = ^{
       [weakSelf requestCouponTicketData];
    };
    [self.scrollView addSubview:self.couponView];
    [self.couponView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
        make.centerY.mas_equalTo(self.vipTicketLab.mas_centerY);
        make.width.mas_equalTo(100);
    }];
    
    
    //单次零售价
    NSMutableArray *coursePriceArr = [NSMutableArray array];
    [coursePriceArr safeAddObject:self.detailModel.price_list.pro_11.price];
    //疗程成交价
    NSArray *lingShouArr = [self.detailModel.price_list.pro_21.price componentsSeparatedByString:@","];
    [coursePriceArr safeAddObjectsFromArray:lingShouArr];
    if ([self.detailModel respondsToSelector:@selector(setCoursePriceArr:)]) {
        [self.detailModel setCoursePriceArr:coursePriceArr];
    }
    //单次
    NSMutableArray *courseNumArr = [NSMutableArray array];
    [courseNumArr safeAddObject:self.detailModel.price_list.pro_11.num];
    //疗程次数
    NSArray *arrNum = [self.detailModel.price_list.pro_21.num componentsSeparatedByString:@","];
    [courseNumArr safeAddObjectsFromArray:arrNum];
    if ([self.detailModel respondsToSelector:@selector(setCourseNumArr:)]) {
        [self.detailModel setCourseNumArr:courseNumArr];
    }
    
    [self initViewValue];
    [self addButtonS];
    
    CGFloat top = self.lastBtn.frame.size.height + self.lastBtn.frame.origin.y + 20;
    [self.vipLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(top);
    }];
    self.scrollView.contentSize = CGSizeMake(0, top + 300);
    
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
    self.priceLab.text = @"零售价:￥";
}


#pragma mark --request

/**
 会员优惠列表
 */
- (void)requestVipDiscount
{
    [self.field resignFirstResponder];
    if ([self.detailModel.inputPrice floatValue] != [self lingshouDefalutPrice]) {
        if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
            [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self.detailModel.inputPrice floatValue]]];
        }

    }else{
        if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
            [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]]];
        }
    }
    WeakSelf

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.detailModel.uid) forKey:@"search_id"];
    [params setObject:self.userId?self.userId:@"" forKey:@"user_id"];
    [params setObject:self.detailModel.ciShu ?self.detailModel.ciShu:@"" forKey:@"pro_num"];
    [params setObject:self.type?self.type:@"" forKey:@"type"];
    [params setObject:self.storeCode? self.storeCode :@"" forKey:@"stored_code"];
    
    XMHVipDiscountVC *vc = [[XMHVipDiscountVC alloc]init];
    vc.params = params;
    vc.detailModel = self.detailModel;
    vc.zhekouModel = self.zhekouModel;
    
    vc.selectedModel = ^(ZheKouStored_Card * _Nonnull model) {
      
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
    WeakSelf
   
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
        [self.detailModel setInputPrice:[NSString stringWithFormat:@"%@",[self.detailModel.coursePriceArr safeObjectAtIndex:0]]];
    }
    if ([self.detailModel respondsToSelector:@selector(setCourseIndex:)]) {
        [self.detailModel setCourseIndex:0];
    }
    
    if ([self.detailModel respondsToSelector:@selector(setCiShu:)]) {
        [self.detailModel setCiShu:[self.detailModel.courseNumArr safeObjectAtIndex:0]];
    }
    
   
    [self.couponView setCoupon:@"" hiddenBgView:YES];
    self.field.text = [NSString stringWithFormat:@"%@",self.detailModel.inputPrice];
    self.totalPriceLab.text = [NSString stringWithFormat:@"总价: ￥%@",self.detailModel.inputPrice]; //初始价格
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
    return;
}

#pragma mark - 内部方法

/**
 获取默认零售价

 @return 返回默认零售价
 */
- (CGFloat)lingshouDefalutPrice
{
    CGFloat linshouPrice =  [[self.detailModel.coursePriceArr safeObjectAtIndex:self.detailModel.courseIndex] floatValue];
    return linshouPrice;
}

- (void)configTotalPrices {
    
    // model 记录购买数量
    if ([self.detailModel respondsToSelector:@selector(setSelectCount:)]) {
        [self.detailModel setSelectCount:self.numberView.currentNumber];
    }
    
    // 总价格
    CGFloat allPrice = 0;

    allPrice = [self computeZhekouTotalPrice];
    self.totalPriceLab.text = [NSString stringWithFormat:@"总价：¥%.2f", allPrice];
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
- (void)defalutConfigTotalPrices:(UIButton *)sender
{
    if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
        [self.detailModel setInputPrice:[NSString stringWithFormat:@"%@",[self.detailModel.coursePriceArr safeObjectAtIndex:sender.tag]]];
    }
    self.field.text = [NSString stringWithFormat:@"%@",self.detailModel.inputPrice];
    [self configTotalPrices];
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
-(void)addButtonS
{
    for (int i = 0 ; i < self.detailModel.courseNumArr.count; i++) {
        NSInteger index = i % 4;
        NSInteger page = i / 4;
    
        UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        mapBtn.tag = i;
        mapBtn.frame = CGRectMake(index * (Button_Width + Width_Space) + Start_X, page  * (Button_Height + Height_Space)+Start_Y, Button_Width, Button_Height);
        [mapBtn setTitle:[NSString stringWithFormat:@"%@次",self.detailModel.courseNumArr[i]] forState:UIControlStateNormal];
        mapBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.scrollView addSubview:mapBtn];
        //按钮点击方法
        [mapBtn addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        [mapBtn setTitleColor:[ColorTools colorWithHexString:@"#FF9072"] forState:UIControlStateSelected];
        [mapBtn setTitleColor:kIm_Background_Color_c forState:UIControlStateNormal];
        [mapBtn setBackgroundImage:[UIImage imageNamed:@"ddglst_liaochengweixuanzhong"] forState:UIControlStateNormal];
        [mapBtn setBackgroundImage:[UIImage imageNamed:@"ddglst_liaochengxuanzhong"] forState:UIControlStateSelected];
        if (i == self.detailModel.courseNumArr.count - 1) {
            self.lastBtn = mapBtn;
        }
        if (i==0) {
            self.selectBtn = mapBtn;
            self.selectBtn.selected = YES;
        }
    }
}

//点击按钮方法,这里容易犯错
-(void)mapBtnClick:(UIButton *)sender{
   
      sender.selected = !sender.selected;
    if (sender!=self.selectBtn) {
        self.selectBtn.selected = NO;
        self.selectBtn = sender;
    }
    self.selectBtn.selected = YES;

    if ([self.detailModel respondsToSelector:@selector(setCourseIndex:)]) {
        [self.detailModel setCourseIndex:sender.tag];
    }
 
    if ([self.detailModel respondsToSelector:@selector(setCiShu:)]) {
        [self.detailModel setCiShu:[self.detailModel.courseNumArr safeObjectAtIndex:sender.tag]];
    }
  

    // 全部清空
    //产品要求  加减号 全部清空已选优惠券,但是会员优惠不用清空
    self.couponModel = nil;
    [self.couponView setCoupon:@"" hiddenBgView:YES];
    if ([self.detailModel respondsToSelector:@selector(setStaicketModel:)]) {
        [self.detailModel setStaicketModel:nil];
    }
    
    WeakSelf
    // 选中的vip会员优惠
    if (self.zhekouModel) {
        self.zheKouStoredCards = [NSMutableArray array];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@(self.detailModel.uid) forKey:@"search_id"];
        [params setObject:self.userId?self.userId:@"" forKey:@"user_id"];
        [params setObject:self.detailModel.ciShu ?self.detailModel.ciShu:@"" forKey:@"pro_num"];
        [params setObject:self.type?self.type:@"" forKey:@"type"];
        [params setObject:self.storeCode? self.storeCode :@"" forKey:@"stored_code"];
        [XMHSaleOrderRequest requestSaleOrderVipDiscountParams:params resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
            if (isSuccess) {
                weakSelf.zheKouStoredCards =  resultArr;
                for (ZheKouStored_Card *model in resultArr) {
                    if (model.ID == weakSelf.zhekouModel.ID) {
                        weakSelf.zhekouModel = model;
                        self.zhekouModel.selected = YES;
                        break;
                    }
                }
                
                weakSelf.discountView.discount = weakSelf.zhekouModel.name;
                // 选择会员优惠则要清除优惠券数据
                self.couponModel = nil;
                [self.couponView setCoupon:@"" hiddenBgView:YES];
                if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
                    [self.detailModel setInputPrice:[NSString stringWithFormat:@"%@",self.zhekouModel.price]];
                }
                //sastoreCardModel
                if ([self.detailModel respondsToSelector:@selector(setSastoreCardModel:)]) {
                    [self.detailModel setSastoreCardModel:weakSelf.zhekouModel];
                }
                NSString *text = [NSString stringWithFormat:@"零售价:￥%.2f/",[self lingshouDefalutPrice]];
                NSString *defalutPrice = [NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]];
                NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:text];
                
                [attribtStr setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle),NSForegroundColorAttributeName:kColor9} range:NSMakeRange(4, defalutPrice.length + 1)];
                
                self.priceLab.attributedText = attribtStr;
                self.field.text = [NSString stringWithFormat:@"%@",self.detailModel.inputPrice];
                if ([self.detailModel respondsToSelector:@selector(setStaicketModel:)]) {
                    [self.detailModel setStaicketModel:nil];
                }
                
                [self configTotalPrices];
            }
            
        }];
        
    }else{
        [self defalutConfigTotalPrices:sender];
    }
    /**-------- 2019/7/5 :孟饶产品要求点击切换后清空全部的已选优惠券,会员优惠,同样加减号时也清空.因此屏蔽以下代码
    
    
    // 选中的优惠券
    if (self.couponModel) {
        NSMutableArray *selectedTickets = [XMHShoppingCartManager.sharedInstance selectedTicketArrsBaseModel:self.detailModel];
        NSMutableArray *arr = [NSMutableArray array];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@(self.detailModel.uid) forKey:@"search_id"];
        [params setObject:self.userId?self.userId:@"" forKey:@"user_id"];
        [params setObject:self.type?self.type:@"" forKey:@"type"];
        [params setObject:self.detailModel.code? self.detailModel.code :@"" forKey:@"code"];
        [params setObject:@([self.detailModel computeTotalPrice])?@([self.detailModel computeTotalPrice]) :@"" forKey:@"price"];//总价
        [XMHSaleOrderRequest requestSaleOrderVipTicketParams:params resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
            if (isSuccess) {
                
                for (int i = 0; i < resultArr.count; i++) {
                    SATicketModel *model = [resultArr safeObjectAtIndex:i];
                    
                    if ([model.is_use integerValue] == 1) {
                        [arr safeAddObject:model];
                    }
                }
                
                NSMutableArray *tempArr = [NSMutableArray arrayWithArray:arr];
                if (selectedTickets.count > 0) {
                    for (int i = 0; i < arr.count; i++) {
                        SATicketModel *model = [arr safeObjectAtIndex:i];
                        for (int j = 0; j < selectedTickets.count; j++) {
                            SATicketModel *selectModel = [selectedTickets safeObjectAtIndex:j];
                            if (selectModel.uid == model.uid) {
                                [tempArr removeObject:model];
                            }
                        }
                    }
                }
                for (SATicketModel *model in tempArr) {
                    if (model.uid == weakSelf.couponModel.uid) {
                        weakSelf.couponModel = model;
                        self.couponModel.selected = YES;
                        break;
                    }
                }
                // 选择优惠券则清空会员优惠数据
                weakSelf.zhekouModel = nil;
                weakSelf.discountView.discount = @"请选择";
                if ([self.detailModel respondsToSelector:@selector(setStaicketModel:)]) {
                    [self.detailModel setStaicketModel:self.couponModel];
                }
                CGFloat ticketPrice = 0;
                if (self.couponModel.type == 3){ //现金券
                    ticketPrice = [self.couponModel.price floatValue];
                }else if(self.couponModel.type == 4){//折扣券
                    ticketPrice = [self.detailModel.inputPrice floatValue] * ([self.couponModel.discount floatValue] / 10);
                    if ((ticketPrice >= self.couponModel.fulfill.floatValue) && (self.couponModel.fulfill.floatValue > 0)) {
                        ticketPrice = self.couponModel.fulfill.floatValue;
                    }
                }else if(self.couponModel.type == 1){//票券
                    ticketPrice = [self.couponModel.money floatValue];
                    if (ticketPrice >= [self lingshouDefalutPrice]) {
                        ticketPrice = [self lingshouDefalutPrice];
                    }
                }
                
                [self.couponView setCoupon:[NSString stringWithFormat:@"%@%.2f",@"-",ticketPrice] hiddenBgView:YES];
                if ([self.detailModel respondsToSelector:@selector(setInputPrice:)]) {
                    [self.detailModel setInputPrice:[NSString stringWithFormat:@"%.2f",[self lingshouDefalutPrice]]];
                }
                self.priceLab.text = @"零售价:￥";
                if ([self.detailModel respondsToSelector:@selector(setSastoreCardModel:)]) {
                    [self.detailModel setSastoreCardModel:nil];
                }
                self.field.text = [NSString stringWithFormat:@"%@",self.detailModel.inputPrice];
                [self configTotalPrices];
                
            }
        }];
        
    }else{
        [self defalutConfigTotalPrices:sender];
    }
    *-----------end-----------*/
    
   
}

@end
