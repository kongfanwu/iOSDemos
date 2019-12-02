//
//  XMHBillRecDetailView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//
#import "XMHBillRecDetailView.h"
#import "XMHBillReListModel.h"
#import "XMHNumberView.h"
#import "XMHShoppingCartManager.h"
#import "UIButton+EnlargeTouchArea.h"
@interface XMHBillRecDetailView ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *moneyLab;
@property (nonatomic, strong)UILabel *degreeLab;// 剩余次数
@property (nonatomic, strong)UILabel *priceLab;//项目单价
@property (nonatomic, strong)UILabel *numsLab;//数量
@property (nonatomic, strong)UILabel *numsTextLab;
@property (nonatomic, strong)UILabel *recoverLab;//回收金额
@property (nonatomic, strong)UIButton *decreaseBtn;
@property (nonatomic, strong)UIButton *increaseBtn;
@property (nonatomic, strong)UIButton *allRecBtn;
@property (nonatomic, strong)UIButton *sureBtn;
@property (nonatomic, strong)UITextField *field;
@property (nonatomic, assign)CGFloat shengyuPrice;



@property (nonatomic, strong)XMHNumberView *numberView;
@end

@implementation XMHBillRecDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        [self createSubView];
    }
    return self;
}

- (void)setBillRecModel:(id)billRecModel
{
    _billRecModel = billRecModel;
    
   
    if ([_billRecModel respondsToSelector:@selector(setAllRe:)]) {
        [_billRecModel setAllRe:0];
    }
    NSString *type = [_billRecModel valueForKey:@"recoverType"];
    switch ([type integerValue]) {
        case XMHBillRecoverTypePro:
        {
            XMHBillReProModel *proModel = (XMHBillReProModel *)_billRecModel;
            self.titleLab.text = [_billRecModel valueForKey:@"name"];
            self.moneyLab.text = [NSString stringWithFormat:@"剩余金额: ¥%.2f", [proModel computeShengyuPrice]];
            // 剩余次数
            NSInteger num = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:_billRecModel];
            if (num == 0 && [proModel computeShengyuPrice] > 0) {
                num = 1;
            }
            self.degreeLab.text = [NSString stringWithFormat:@"剩余次数: %ld次",(long)num];
            self.priceLab.text = [NSString stringWithFormat:@"项目单价: ¥%@",[_billRecModel valueForKey:@"price"]];
            self.numsLab.text  =@"数量";
            if ([proModel computeShengyuPrice] < [[_billRecModel valueForKey:@"price"] floatValue]) {
                  self.recoverLab.text = [NSString stringWithFormat:@"回收金额: ¥%.2f", [proModel computeShengyuPrice]];
            }else{
                  self.recoverLab.text = [NSString stringWithFormat:@"回收金额: ¥%.2f", [[_billRecModel valueForKey:@"price"] floatValue]];
            }

        }
            break;
        case XMHBillRecoverTypeGoods:
        {
             XMHBillReGoodsModel *model = (XMHBillReGoodsModel *)_billRecModel;
            CGFloat inputPrice = 0;
            if ([_billRecModel computeShengyuPrice] < [model.price floatValue]) {
                inputPrice = [model computeShengyuPrice];
              
            }else{
                 inputPrice = [[_billRecModel valueForKey:@"price"] floatValue];
            }
            NSString *inputPriceStr = [NSString stringWithFormat:@"%.2f", inputPrice];
            if ([_billRecModel respondsToSelector:@selector(setInputPrice:)]) {
                [_billRecModel setInputPrice:inputPriceStr];
            }
            self.titleLab.text = [_billRecModel valueForKey:@"name"];
            self.moneyLab.text = [NSString stringWithFormat:@"剩余金额: ¥%.2f",[_billRecModel computeShengyuPrice]];
            // 剩余次数
            NSInteger num = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:_billRecModel];
            if (num == 0 && [model computeShengyuPrice] > 0) {
                num = 1;
            }
            self.degreeLab.text = [NSString stringWithFormat:@"剩余次数: %ld次",num];
            self.priceLab.text = [NSString stringWithFormat:@"产品单价: ¥%@",model.price];
            self.numsLab.text  = @"数量";
            self.recoverLab.text = [NSString stringWithFormat:@"回收金额:"];
            self.field.text = model.inputPrice;
            self.field.hidden = NO;
           
            
            [self.recoverLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kMargin);
                make.top.mas_equalTo
                (self.numsLab.mas_bottom).mas_offset(25);
                make.width.mas_equalTo(70);
                make.centerY.mas_equalTo(self.allRecBtn.mas_centerY);
            }];
            
            [self.field mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(85);
            }];
        }
            break;
        case XMHBillRecoverTypeNumCar:
        {
            XMHBillReNumCardModel *model = _billRecModel;
            self.titleLab.text = [_billRecModel valueForKey:@"name"];
            self.moneyLab.text = [NSString stringWithFormat:@"剩余金额: ¥%.2f",[_billRecModel computeShengyuPrice]];
            // 剩余次数
            NSInteger num = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:_billRecModel];
            if (num == 0 && [model computeShengyuPrice] > 0) {
                num = 1;
            }
            self.degreeLab.text = [NSString stringWithFormat:@"剩余数量: %ld次",num];
            self.priceLab.text = [NSString stringWithFormat:@"已用价值: ¥%@",[_billRecModel valueForKey:@"y_price"]];
            self.numsLab.text  =@"数量";
            if ([_billRecModel computeShengyuPrice] < [[_billRecModel valueForKey:@"price"] floatValue]) {
                self.recoverLab.text = [NSString stringWithFormat:@"回收金额: ¥%.2f", [_billRecModel computeShengyuPrice]];
            }else{
                self.recoverLab.text = [NSString stringWithFormat:@"回收金额: ¥%@",model.price];
            }

        }
            break;
        case XMHBillRecoverTypeStordeCar:
        {
            self.titleLab.text = [_billRecModel valueForKey:@"name"];
            self.moneyLab.text = [NSString stringWithFormat:@"剩余总金额: ¥%.2f",[_billRecModel computeShengyuPrice]];
            self.field.text = [NSString stringWithFormat:@"%.2f",[_billRecModel computeShengyuPrice]];
            self.field.hidden = NO;
            self.priceLab.hidden = YES;
            self.numsLab.hidden = YES;
            self.numberView.hidden = YES;
            self.recoverLab.text = [NSString stringWithFormat:@"回收金额:"];
           
            [self.allRecBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.moneyLab.mas_bottom).mas_offset(25);
            }];
            [self.recoverLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo
                (self.moneyLab.mas_bottom).mas_offset(25);
                make.left.mas_equalTo(kMargin);
                make.width.mas_equalTo(70);
                make.centerY.mas_equalTo(self.allRecBtn.mas_centerY);
            }];
            
            [self.field mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(85);
            }];
            
        }
            break;
        case XMHBillRecoverTypeTimeCar:
        {
          
            XMHBillReTimeModel *model = (XMHBillReTimeModel *)_billRecModel;
            CGFloat shengyuPrice = [model.price floatValue] -  [XMHShoppingCartManager.sharedInstance recoverPriceShoppingCartBaseModel:_billRecModel];
            self.titleLab.text = [_billRecModel valueForKey:@"name"];
            self.moneyLab.text = [NSString stringWithFormat:@"剩余金额: ¥%.2f",shengyuPrice];
            self.degreeLab.text = [NSString stringWithFormat:@"消耗金额: ¥%@",[_billRecModel valueForKey:@"xiaohao"]];
            self.priceLab.text = [NSString stringWithFormat:@"截止日期: %@",[_billRecModel valueForKey:@"end_time"]];
            self.numsLab.text  = @"数量";
            self.recoverLab.text = [NSString stringWithFormat:@"回收金额:"];
            self.field.text = [NSString stringWithFormat:@"%.2f",shengyuPrice];
            self.field.hidden = NO;
            
            [self.recoverLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kMargin);
                make.top.mas_equalTo
                (self.numsLab.mas_bottom).mas_offset(25);
                make.width.mas_equalTo(70);
                make.centerY.mas_equalTo(self.allRecBtn.mas_centerY);
            }];
            
            [self.field mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(85);
            }];
        }
            break;
        case XMHBillRecoverTypeTicket:
        {
            self.titleLab.text = [_billRecModel valueForKey:@"name"];
            self.moneyLab.text = [NSString stringWithFormat:@"票券价格: ¥%@",[_billRecModel valueForKey:@"money"]];//
            // 剩余次数
            NSInteger num = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:_billRecModel];
            self.degreeLab.text = [NSString stringWithFormat:@"剩余次数: %ld次",(long)num];
            self.priceLab.text = [NSString stringWithFormat:@"票券有效期: %@",[_billRecModel valueForKey:@"expiry"]];
            self.numsLab.text  =@"数量";
            self.recoverLab.text = [NSString stringWithFormat:@"回收金额: ¥%@",[_billRecModel valueForKey:@"price"]];
            
        }
            break;
        default:
            break;
    }
}

- (void)closeBtn
{
    if (_closeBlock) {
        _closeBlock();
    }
}

#pragma mark --内部方法
- (void)changeValue{
   
    // 最大购买数
    NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:_billRecModel];
  
    // 限制最大购买
    if (_numberView.currentNumber > maxNum) {
        _numberView.currentNumber -= 1;
        
        [XMHProgressHUD showOnlyText:@"库存不足"];
        return;
    }
    
    // model 记录购买数量
    if ([_billRecModel respondsToSelector:@selector(setSelectCount:)]) {
        [_billRecModel setSelectCount:_numberView.currentNumber];
    }
    
    // 总价格
    CGFloat recoverM = 0;
    NSString *type = [_billRecModel valueForKey:@"recoverType"];
    switch ([type integerValue]) {
        case XMHBillRecoverTypeGoods:
        {
            
            recoverM = _numberView.currentNumber * [[_billRecModel valueForKey:@"price"] floatValue];
            if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                [_billRecModel setRecoverPrice:recoverM];
            }

            self.field.text = [NSString stringWithFormat:@"%.2f", recoverM];
        }
            break;
        case XMHBillRecoverTypeTimeCar:
        {
            if ([_billRecModel respondsToSelector:@selector(computeTotalPrice)]) {
                recoverM = [_billRecModel computeTotalPrice];
            }
            self.field.text = [NSString stringWithFormat:@"%.2f",recoverM];
        }
            break;
        case XMHBillRecoverTypePro:
        {
            
            recoverM = _numberView.currentNumber * [[_billRecModel valueForKey:@"price"] floatValue];
            if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                [_billRecModel setRecoverPrice:recoverM];
            }

            self.recoverLab.text = [NSString stringWithFormat:@"回收金额: ¥%@",[NSString stringWithFormat:@"%.2f",recoverM]];

        }
            break;
        case XMHBillRecoverTypeNumCar:
        {
            recoverM =  [[_billRecModel valueForKey:@"price"] floatValue] * self.numberView.currentNumber;
            if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                [_billRecModel setRecoverPrice:recoverM];
            }
            self.recoverLab.text = [NSString stringWithFormat:@"回收金额: ¥%@",[NSString stringWithFormat:@"%.2f",recoverM]];

        }
            break;
        case XMHBillRecoverTypeStordeCar:
        {
            recoverM =  [self.field.text floatValue];
          
        }
            break;
        case XMHBillRecoverTypeTicket:
        {
            recoverM = _numberView.currentNumber * [[_billRecModel valueForKey:@"price"] floatValue];
            if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                [_billRecModel setRecoverPrice:recoverM];
            }
            self.recoverLab.text = [NSString stringWithFormat:@"回收金额: ¥%@",[NSString stringWithFormat:@"%.2f",recoverM]];
            
        }
            break;
            
        default:
            break;
    }
    
}
/**
 全部回收
 */
- (void)allRecBtnClick
{
     CGFloat recoverM = 0;
    NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:_billRecModel];
    if (maxNum == 0) {
        self.numberView.currentNumber = 1;
    }else{
        self.numberView.currentNumber = maxNum;
    }
    // model 记录购买数量
    if ([_billRecModel respondsToSelector:@selector(setSelectCount:)]) {
        [_billRecModel setSelectCount:_numberView.currentNumber];
    }
    
    NSString *type = [_billRecModel valueForKey:@"recoverType"];
    switch ([type integerValue]) {
        case XMHBillRecoverTypeGoods:
        {
            recoverM = [_billRecModel computeShengyuPrice];
            
            if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                [_billRecModel setRecoverPrice:recoverM];
            }
            // model 记录全部回收
            if ([_billRecModel respondsToSelector:@selector(setAllRe:)]) {
                [_billRecModel setAllRe:1];
            }
             self.field.text = [NSString stringWithFormat:@"%.2f", recoverM];
            
        }
            break;
        case XMHBillRecoverTypeTimeCar:
        {
     
            if ([_field.text floatValue] > [_billRecModel computeShengyuPrice]) {
                [MzzHud toastWithTitle:@"" message:@"回收金额不能大于剩余金额"];
                return ;
            }
            if ([XMHShoppingCartManager.sharedInstance recoverPriceShoppingCartBaseModel:_billRecModel]) {
                return;
            }
            recoverM = [_billRecModel computeShengyuPrice];
            if ([_billRecModel respondsToSelector:@selector(setInputPrice:)]) {
                [_billRecModel setInputPrice:[NSString stringWithFormat:@"%.2f",recoverM]];
            }
            // model 记录全部回收
            if ([_billRecModel respondsToSelector:@selector(setAllRe:)]) {
                [_billRecModel setAllRe:1];
            }
             self.field.text = [NSString stringWithFormat:@"%.2f", recoverM];
        }
            break;
        case XMHBillRecoverTypePro:
        {
 
            recoverM = [_billRecModel computeShengyuPrice];
            
            if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                [_billRecModel setRecoverPrice:recoverM];
            }
            // model 记录全部回收
            if ([_billRecModel respondsToSelector:@selector(setAllRe:)]) {
                [_billRecModel setAllRe:1];
            }

            self.recoverLab.text = [NSString stringWithFormat:@"回收金额: ¥%@",[NSString stringWithFormat:@"%.2f",recoverM]];
            
        }
            break;
        case XMHBillRecoverTypeNumCar:
        {
            recoverM = [_billRecModel computeShengyuPrice];
            
            if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                [_billRecModel setRecoverPrice:recoverM];
            }
            // model 记录全部回收
            if ([_billRecModel respondsToSelector:@selector(setAllRe:)]) {
                [_billRecModel setAllRe:1];
            }
            
            self.recoverLab.text = [NSString stringWithFormat:@"回收金额: ¥%@",[NSString stringWithFormat:@"%.2f",recoverM]];
            
        }
            break;
        case XMHBillRecoverTypeStordeCar:
        {
            if ([_field.text floatValue] > [_billRecModel computeShengyuPrice]) {
                [MzzHud toastWithTitle:@"" message:@"回收金额不能大于剩余金额"];
                return ;
            }
          
            recoverM = [_billRecModel computeShengyuPrice];
            
            // model 记录输入的回收金额
            if ([_billRecModel respondsToSelector:@selector(setInputPrice:)]) {
                [_billRecModel setInputPrice:[NSString stringWithFormat:@"%f",[_billRecModel computeShengyuPrice]]];
            }
            // model 记录全部回收
            if ([_billRecModel respondsToSelector:@selector(setAllRe:)]) {
                [_billRecModel setAllRe:1];
                
            }
             self.field.text = [NSString stringWithFormat:@"%.2f", recoverM];
        }
            break;
        case XMHBillRecoverTypeTicket:
        {
            recoverM = [_billRecModel computeShengyuPrice];
            
            if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                [_billRecModel setRecoverPrice:recoverM];
            }
            // model 记录全部回收
            if ([_billRecModel respondsToSelector:@selector(setAllRe:)]) {
                [_billRecModel setAllRe:1];
            }
            
            self.recoverLab.text = [NSString stringWithFormat:@"回收金额: ¥%@",[NSString stringWithFormat:@"%.2f",recoverM]];
            
        }
            break;
            
        default:
            break;
    }

}

- (void)sureBtnClick
{
    // model 记录购买数量
    if ([_billRecModel respondsToSelector:@selector(setSelectCount:)]) {
        [_billRecModel setSelectCount:_numberView.currentNumber];
    }
    NSInteger num = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:_billRecModel];
   
    NSString *type = [_billRecModel valueForKey:@"recoverType"];
    
     if ([type integerValue] == XMHBillRecoverTypeGoods ){ //产品
         if ([[_billRecModel valueForKey:@"allRe"] integerValue] == 0) {
             
             if (num == 0 && ([_billRecModel computeShengyuPrice] < [[_billRecModel valueForKey:@"price"] floatValue])) {
                 if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                     [_billRecModel setRecoverPrice:[_billRecModel computeShengyuPrice]];
                 }
                 if (_sureBlock) {
                     _sureBlock(_billRecModel);
                 }
                 return ;
             }
             CGFloat recoverM = _numberView.currentNumber * [[_billRecModel valueForKey:@"price"] floatValue];
             NSString *str = [NSString stringWithFormat:@"%.2f",recoverM];
             if (![_field.text isEqualToString:str]) {
                 if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                     [_billRecModel setRecoverPrice:[_field.text floatValue]];
                 }
             }else{
                 if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                     [_billRecModel setRecoverPrice:[str floatValue]];
                 }
             }
         }
    }else if ([type integerValue] == XMHBillRecoverTypeTimeCar) { //时间卡
    
        if ([[_billRecModel valueForKey:@"allRe"] integerValue] == 0) {
            if ([XMHShoppingCartManager.sharedInstance recoverPriceShoppingCartBaseModel:_billRecModel]) {
                return;
            }
            if ([_field.text floatValue] > [_billRecModel computeShengyuPrice]) {
                [MzzHud toastWithTitle:@"" message:@"回收金额不能大于剩余金额"];
                return ;
            }

            if ([_billRecModel respondsToSelector:@selector(setInputPrice:)]) {
                [_billRecModel setInputPrice:[NSString stringWithFormat:@"%@",_field.text]];
            }
       
        }
     
    }else if ([type integerValue] == XMHBillRecoverTypePro ||
              [type integerValue] == XMHBillRecoverTypeNumCar ||
              [type integerValue] == XMHBillRecoverTypeTicket){
       
        if ([[_billRecModel valueForKey:@"allRe"] integerValue] == 0) {
            if (num == 0 && [_billRecModel computeShengyuPrice] < [[_billRecModel valueForKey:@"price"] floatValue]) {
               
                if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                    [_billRecModel setRecoverPrice:[_billRecModel computeShengyuPrice]];
                }
                // model 记录全部回收
                if ([_billRecModel respondsToSelector:@selector(setAllRe:)]) {
                    [_billRecModel setAllRe:1];
                }
                if (_sureBlock) {
                    _sureBlock(_billRecModel);
                }
                return ;
            }
            
            CGFloat recoverM = _numberView.currentNumber * [[_billRecModel valueForKey:@"price"] floatValue];
            NSString *str = [NSString stringWithFormat:@"%.2f",recoverM];
            if ([_billRecModel respondsToSelector:@selector(setRecoverPrice:)]) {
                [_billRecModel setRecoverPrice:[str floatValue]];
            }
        }
        
    }else if ([type integerValue] == XMHBillRecoverTypeStordeCar){//储值卡
        if ([[_billRecModel valueForKey:@"allRe"] integerValue] == 0){
            if ([_field.text floatValue] > [_billRecModel computeShengyuPrice]) {
                [MzzHud toastWithTitle:@"" message:@"回收金额不能大于剩余金额"];
                return ;
            }
            if ([_billRecModel respondsToSelector:@selector(setInputPrice:)]) {
                [_billRecModel setInputPrice:[NSString stringWithFormat:@"%@",_field.text]];
            }
        }
       
        
    }

    if (_sureBlock) {
        _sureBlock(_billRecModel);
    }
}
/**
 获取默认零售价
 
 @return 返回默认零售价
 */
- (CGFloat)lingshouDefalutPrice
{
    CGFloat linshouPrice = 0;
    NSString *type = [_billRecModel valueForKey:@"type"];
    if ([type integerValue] == XMHBillRecoverTypeTimeCar) {
        XMHBillReTimeModel *model = _billRecModel;
          linshouPrice = [model.price floatValue];
    }
    return linshouPrice;
}
#pragma mark --UI
- (void)createSubView
{
    UIButton *blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [blackBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:blackBtn];
    
    [blackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(300);
    }];
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 179, SCREEN_WIDTH, SCREEN_HEIGHT - 179 )];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    
    
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = _contentView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    _contentView.layer.mask = cornerRadiusLayer;
    
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [self.contentView addSubview:closeBtn];
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textColor = kLabelText_Commen_Color_3;
    self.titleLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLab];
    
    self.moneyLab = [[UILabel alloc]init];
    self.moneyLab.textColor = kLabelText_Commen_Color_3;
    self.moneyLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.moneyLab];
    
    self.degreeLab = [[UILabel alloc]init];
    self.degreeLab.textColor = kLabelText_Commen_Color_3;
    self.degreeLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.degreeLab];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.textColor = kLabelText_Commen_Color_3;
    self.priceLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.priceLab];
    
    
    self.recoverLab = [[UILabel alloc]init];
    self.recoverLab.textColor = kLabelText_Commen_Color_3;
    self.recoverLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.recoverLab];
    
    self.numsLab = [[UILabel alloc]init];
    self.numsLab.text  =@"数量";
    self.numsLab.textColor = kLabelText_Commen_Color_3;
    self.numsLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.numsLab];
  
    WeakSelf
    self.numberView = [[XMHNumberView alloc]init];
    
    self.numberView.didChangeBlock = ^(XMHNumberView * _Nonnull numberView) {
        [weakSelf changeValue];
    };
   
    [self addSubview:self.numberView];
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numsLab .mas_centerY);
        make.size.mas_equalTo(CGSizeMake(26 * 2 + 40, 30));
        make.right.mas_equalTo(-kMargin);
        
    }];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
        make.top.mas_equalTo(kMargin);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(kMargin);
        make.right.mas_equalTo(closeBtn.mas_left).mas_offset(-kMargin);
        make.top.mas_equalTo(kMargin);
    }];
    
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(kMargin);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(25);
    }];
    
    [self.degreeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(kMargin);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.moneyLab.mas_bottom).mas_offset(25);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(kMargin);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.degreeLab.mas_bottom).mas_offset(25);
    }];
    
    [self.numsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(kMargin);
        make.width.mas_equalTo(50);
        make.top.mas_equalTo(self.priceLab.mas_bottom).mas_offset(25);
    }];
    
    
    self.allRecBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allRecBtn setTitle:@"全部回收" forState:UIControlStateNormal];
    [self.allRecBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
    self.allRecBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.allRecBtn.backgroundColor = [UIColor whiteColor];
    [self.allRecBtn addTarget:self action:@selector(allRecBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.allRecBtn];
    
    self.allRecBtn.layer.cornerRadius = 3;
    self.allRecBtn.layer.borderColor = kColorTheme.CGColor;
    self.allRecBtn.layer.borderWidth = 0.8;
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureBtn.backgroundColor = kColorTheme;
    [self.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.sureBtn];
    self.sureBtn.layer.cornerRadius =  3;//44 * 0.5;
    

    
    [self.allRecBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(92);
        make.top.mas_equalTo(self.numsLab.mas_bottom).mas_offset(25);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-kMargin);
    }];
    
    [self.recoverLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo
        (self.numsLab.mas_bottom).mas_offset(25);
        make.right.mas_equalTo(self.allRecBtn.mas_left).mas_offset(kMargin);
        make.centerY.mas_equalTo(self.allRecBtn.mas_centerY);
    }];
    
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-kMargin);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(- (kSafeAreaBottom+ 15));
    }];
    
    self.field = [[UITextField alloc]init];
    [self.contentView addSubview:self.field];
    self.field.hidden = YES;
    
    self.field.textColor = kLabelText_Commen_Color_3;
    self.field.font = [UIFont systemFontOfSize:15];
    self.field.borderStyle = UITextBorderStyleNone;
    self.field.layer.borderColor = [ColorTools colorWithHexString:@"#cccccc"].CGColor;
    self.field.layer.borderWidth = 0.8;
    self.field.delegate = self;
    
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.allRecBtn.mas_centerY);
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(29);
        make.left.mas_equalTo(self.recoverLab.right);
    }];
    
}

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
    
    if ([self isValid:checkStr withRegex:regex] && [checkStr floatValue] <= 9999999) {
        return YES;
    }
    return NO;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // model 记录输入的回收金额
    if ([_billRecModel respondsToSelector:@selector(setInputPrice:)]) {
        [_billRecModel setInputPrice:textField.text];
    }
}

@end
