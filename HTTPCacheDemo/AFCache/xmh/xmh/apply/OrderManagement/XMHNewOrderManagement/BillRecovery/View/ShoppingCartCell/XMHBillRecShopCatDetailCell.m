//
//  XMHBillRecShopCatDetailCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBillRecShopCatDetailCell.h"
#import "XMHBillReListModel.h"
#import "XMHNumberView.h"
#import "XMHShoppingCartManager.h"
#import "XMHShoppingCartBaseModel.h"

@interface XMHBillRecShopCatDetailCell()

/** <##> */
@property (nonatomic, strong) id model;
@end

@implementation XMHBillRecShopCatDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.numberView = [[XMHNumberView alloc] init];
        _numberView.minNumber = 0;
        [self.contentView addSubview:self.numberView];
        [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(26 * 2 + 40, 30));
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(self.contentView);
        }];
        
       
        WeakSelf
        
        self.numberView.addChangeBlock = ^(XMHNumberView * _Nonnull numberView) {
            if ([weakSelf.model isKindOfClass:[XMHBillReGoodsModel class]]||
                [weakSelf.model isKindOfClass:[XMHBillReProModel class]]||
                [weakSelf.model isKindOfClass:[XMHBillReNumCardModel class]]||
                [weakSelf.model isKindOfClass:[XMHBillReTicketModel class]]) {
                // 1 购买数量减到0，移除购物车
                if (numberView.currentNumber == 0) {
                    [XMHShoppingCartManager.sharedInstance deleteModel:weakSelf.model];
                    if (weakSelf.didDeleteBlock) weakSelf.didDeleteBlock(weakSelf);
                    return;
                    
                }
                
                if ([weakSelf.model respondsToSelector:@selector(setSelectCount:)]) {
                    // 最大购买数
                    NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:weakSelf.model];
                    // 限制最大购买
                    if (numberView.currentNumber > maxNum) {
                        numberView.currentNumber = maxNum;
                        
                        [XMHProgressHUD showOnlyText:@"库存不足"];
                        return;
                    }
                    
                    [weakSelf.model setValue:@(numberView.currentNumber) forKey:@"selectCount"];
                    
                    CGFloat m = [[weakSelf.model valueForKey:@"recoverPrice"] floatValue];
                    m = m + [[weakSelf.model valueForKey:@"price"] floatValue];
                    if ([weakSelf.model respondsToSelector:@selector(setRecoverPrice:)]) {
                        [weakSelf.model setRecoverPrice:m];
                    }
                    [XMHShoppingCartManager.sharedInstance computePrice];
                }
                
                [weakSelf configModel:weakSelf.model];
            }
           
        };
        self.numberView.delectChangeBlock = ^(XMHNumberView * _Nonnull numberView) {
            if ([weakSelf.model isKindOfClass:[XMHBillReGoodsModel class]]||
                [weakSelf.model isKindOfClass:[XMHBillReProModel class]]||
                [weakSelf.model isKindOfClass:[XMHBillReNumCardModel class]]||
                [weakSelf.model isKindOfClass:[XMHBillReTicketModel class]]){
                // 1 购买数量减到0，移除购物车
                if (numberView.currentNumber == 0) {
                    [XMHShoppingCartManager.sharedInstance deleteModel:weakSelf.model];
                    if (weakSelf.didDeleteBlock) weakSelf.didDeleteBlock(weakSelf);
                    return;
                }
                if ([weakSelf.model respondsToSelector:@selector(setSelectCount:)]) {
                    // 最大购买数
                    NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:weakSelf.model];
                    // 限制最大购买
                    if (numberView.currentNumber > maxNum) {
                        numberView.currentNumber = maxNum;
                        
                        [XMHProgressHUD showOnlyText:@"库存不足"];
                        return;
                    }
                    
                    [weakSelf.model setValue:@(numberView.currentNumber) forKey:@"selectCount"];
                    CGFloat m = [[weakSelf.model valueForKey:@"recoverPrice"] floatValue];
                    if (m > [[weakSelf.model valueForKey:@"price"] floatValue]) {
                        m = m - [[weakSelf.model valueForKey:@"price"] floatValue];
                    }else{
                        [XMHShoppingCartManager.sharedInstance deleteModel:weakSelf.model];
                        if (weakSelf.didDeleteBlock) weakSelf.didDeleteBlock(weakSelf);
                        return;
                    }
                    
                    if ([weakSelf.model respondsToSelector:@selector(setRecoverPrice:)]) {
                        [weakSelf.model setRecoverPrice:m];
                    }
                    [XMHShoppingCartManager.sharedInstance computePrice];
                }
                
                [weakSelf configModel:weakSelf.model];
            }
      
        };
        
        [self.numberView setDidChangeBlock:^(XMHNumberView * _Nonnull numberView) {
            if ([weakSelf.model isKindOfClass:[XMHBillReGoodsModel class]] ||
                [weakSelf.model isKindOfClass:[XMHBillReProModel class]] ||
                [weakSelf.model isKindOfClass:[XMHBillReNumCardModel class]]||
                [weakSelf.model isKindOfClass:[XMHBillReTicketModel class]]) {
                
            }else{
                // 1 购买数量减到0，移除购物车
                if (numberView.currentNumber == 0) {
                    [XMHShoppingCartManager.sharedInstance deleteModel:weakSelf.model];
                    if (weakSelf.didDeleteBlock) weakSelf.didDeleteBlock(weakSelf);
                    return;
                }
                if ([weakSelf.model respondsToSelector:@selector(setSelectCount:)]) {
                    // 最大购买数
                    NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:weakSelf.model];
                    // 限制最大购买
                    if (numberView.currentNumber > maxNum) {
                        numberView.currentNumber = maxNum;
                        
                        [XMHProgressHUD showOnlyText:@"库存不足"];
                        return;
                    }
                    [weakSelf.model setValue:@(numberView.currentNumber) forKey:@"selectCount"];
                    [XMHShoppingCartManager.sharedInstance computePrice];
                }
                
                [weakSelf configModel:weakSelf.model];
            }
      
        }];
        
        
        
        self.priceLab = UILabel.new;
        _priceLab.font = FONT_SIZE(15);
        _priceLab.textColor = kColor3;
        _priceLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        [self.priceLab sizeToFit];
        
        self.titleLabel = UILabel.new;
        self.titleLabel.font = FONT_SIZE(15);
        self.titleLabel.textColor = kColor3;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.equalTo(_priceLab.mas_left).mas_offset(-10);
            make.centerY.equalTo(self.contentView);
        }];
        
    }
    return self;
}
- (void)configModel:(id)model
{
    self.numberView.maxNumber = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:model];
    _model = model;
    
    if ([model isKindOfClass:[XMHBillReProModel class]]) {
        XMHBillReProModel *pro = (XMHBillReProModel *)model;
        self.titleLabel.text = pro.name;
        self.numberView.currentNumber = pro.selectCount;
        self.priceLab.text = [NSString stringWithFormat:@"￥%.2f",pro.recoverPrice];//[NSString stringWithFormat:@"￥%.2f",[pro computeTotalPrice]];
    }
    if ([model isKindOfClass:[XMHBillReGoodsModel class]]) {
        XMHBillReGoodsModel *pro = (XMHBillReGoodsModel *)model;
        self.titleLabel.text = pro.name;
        self.numberView.currentNumber = pro.selectCount;
        self.priceLab.text = [NSString stringWithFormat:@"￥%.2f",pro.recoverPrice];

    }else if ([model isKindOfClass:[XMHBillReCardModel class]]){
        XMHBillReCardModel *pro = (XMHBillReCardModel *)model;
        self.titleLabel.text = pro.name;
        self.numberView.currentNumber = pro.selectCount;
        self.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[pro computeTotalPrice]];
    }
    else if ([model isKindOfClass:[XMHBillReTimeModel class]]){
        XMHBillReTimeModel *pro = (XMHBillReTimeModel *)model;
        self.titleLabel.text = pro.name;
        self.numberView.currentNumber = pro.selectCount;
        self.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[pro computeTotalPrice]];
    }
    else if ([model isKindOfClass:[XMHBillReNumCardModel class]]){//任选卡
        XMHBillReNumCardModel *pro = (XMHBillReNumCardModel *)model;
        self.titleLabel.text = pro.name;
        self.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[pro.price floatValue]];
        self.numberView.currentNumber = pro.selectCount;
        self.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[pro computeTotalPrice]];
    }
    else if ([model isKindOfClass:[XMHBillReTicketModel class]]){
        XMHBillReTicketModel *pro = (XMHBillReTicketModel *)model;
        self.titleLabel.text = pro.name;
        self.numberView.currentNumber = pro.selectCount;
        self.priceLab.text = [NSString stringWithFormat:@"￥%.2f",pro.recoverPrice];//[NSString stringWithFormat:@"￥%.2f",[pro computeTotalPrice]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
