//
//  XMHTBillRecCell.m
//  xmh
//
//  Created by 杜彩艳 on 2019/3/17.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTBillRecCell.h"
#import "XMHBillReListModel.h"
#import "XMHShoppingCartManager.h"
#import "XMHNumberView.h"
#import "XMHShoppingCartManager.h"
#define kMargin 15

@interface XMHTBillRecCell ()
{
    NSInteger _count;
    id _model;
}
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *moneyLab;
@property (strong, nonatomic) UILabel *countLab;
@property (strong, nonatomic) UILabel *recoverLab;//回收金额
@property (strong, nonatomic) UILabel *timeLab;//有效期
@property (strong, nonatomic) UILabel *priceLab;//票券价格
@property (strong, nonatomic) UILabel *numLab;
@property (nonatomic, strong)UIButton *decreaseBtn;
@property (nonatomic, strong)UIButton *increaseBtn;
@property (nonatomic, strong)UIView *btnBgView;
@property (nonatomic, strong)XMHNumberView *numberView;

@end

@implementation XMHTBillRecCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshCellModel:(id)model
{
    _model = model;
    self.countLab.hidden = NO;
    
    NSString *title;
    NSString *money;
    NSString *count;

    if ([model isKindOfClass:[XMHBillReProModel class]]) {
        XMHBillReProModel *pro = (XMHBillReProModel *)model;
        title = pro.name;
       
        money = [NSString stringWithFormat:@"剩余金额： ¥%.2f",[pro computeShengyuPrice]];
        count = [NSString stringWithFormat:@"剩余次数： %ld次", [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:pro]];
    }
    if ([model isKindOfClass:[XMHBillReGoodsModel class]]) {//产品
        XMHBillReGoodsModel *pro = (XMHBillReGoodsModel *)model;
        title = pro.name;
        money = [NSString stringWithFormat:@"剩余金额： ¥%.2f",[pro computeShengyuPrice]];
        count = [NSString stringWithFormat:@"剩余次数： %ld次",[XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:pro]];
        
    }else if ([model isKindOfClass:[XMHBillReCardModel class]]){
        XMHBillReCardModel *pro = (XMHBillReCardModel *)model;
        title = pro.name;
        money = [NSString stringWithFormat:@"剩余金额： ¥%.2f",[pro computeShengyuPrice]];
        self.countLab.hidden = YES;
    }
    else if ([model isKindOfClass:[XMHBillReTimeModel class]]){
        XMHBillReTimeModel *pro = (XMHBillReTimeModel *)model;
        title = pro.name;
        money = [NSString stringWithFormat:@"剩余金额:  ¥%.2f",[pro computeShengyuPrice]];
        count = [NSString stringWithFormat:@"消费金额:  ¥%@",pro.xiaohao];
    }
    else if ([model isKindOfClass:[XMHBillReNumCardModel class]]){//任选卡
        XMHBillReNumCardModel *pro = (XMHBillReNumCardModel *)model;
        title = pro.name;
    
        money = [NSString stringWithFormat:@"剩余金额： ¥%.2f",[pro computeShengyuPrice]];
        count = [NSString stringWithFormat:@"剩余数量： %ld次",[XMHShoppingCartManager.sharedInstance maxNumShoppingCartBillRecoverBaseModel:pro]];
    }
    else if ([model isKindOfClass:[XMHBillReTicketModel class]]){//票券
        XMHBillReTicketModel *pro = (XMHBillReTicketModel *)model;
        title = pro.name;
        money = [NSString stringWithFormat:@"票券价格: ￥%@",pro.money];
        [self updataLayout];
        [self refreshTicketModel:pro];
    }
    
    self.titleLab.text = title;
    self.moneyLab.text = money;
    self.countLab.text = count;
}

- (void)refreshTicketModel:(XMHBillReTicketModel *)model
{
    self.priceLab.text = [NSString stringWithFormat:@"票券有效期: %@",model.expiry];
    self.timeLab.text = [NSString stringWithFormat:@"票券有效期: %@",model.expiry];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.textAlignment  =NSTextAlignmentLeft;
        self.titleLab.font = [UIFont systemFontOfSize:15];
        self.titleLab.textColor = kLabelText_Commen_Color_3;
        [self.contentView addSubview:self.titleLab];
       
        
        self.moneyLab = [[UILabel alloc]init];
        self.moneyLab.textAlignment  =NSTextAlignmentLeft;
        self.moneyLab.font = [UIFont systemFontOfSize:13];
        self.moneyLab.textColor = kLabelText_Commen_Color_9;
        [self.contentView addSubview:self.moneyLab];
        
        self.countLab = [[UILabel alloc]init];
        self.countLab.textAlignment  =NSTextAlignmentLeft;
        self.countLab.font = [UIFont systemFontOfSize:13];
        self.countLab.textColor = kLabelText_Commen_Color_9;
        [self.contentView addSubview:self.countLab];
        
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:@"gengduo.png"];
        [self addSubview:imageV];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = kSeparatorLineColor;
        [self.contentView addSubview:line];
        
        WeakSelf
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(6);
            make.height.mas_equalTo(11);
            make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
            make.top.mas_equalTo(kMargin);
        }];
        
        
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kMargin);
            make.right.mas_equalTo(imageV.mas_left).mas_offset(-kMargin);
            make.top.mas_equalTo(kMargin);
            
        }];
        
        CGFloat w = self.frame.size.width * 0.5;
        [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kMargin);
            make.width.mas_equalTo(w);
            make.top.mas_equalTo(weakSelf.titleLab.mas_bottom).mas_offset(5);
            
        }];
        
        CGFloat x = 15 + w;
        [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(x);
            make.right.mas_equalTo(weakSelf.mas_right);
            make.top.mas_equalTo(weakSelf.titleLab.mas_bottom).mas_offset(5);
            
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.mas_equalTo(weakSelf.mas_right).mas_offset(-kMargin);
            make.left.mas_equalTo(weakSelf.mas_left).mas_offset(kMargin);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        self.priceLab = [[UILabel alloc]init];
        self.priceLab.textAlignment  =NSTextAlignmentLeft;
        self.priceLab.font = [UIFont systemFontOfSize:13];
        self.priceLab.textColor = kLabelText_Commen_Color_9;
        [self.contentView addSubview:self.priceLab];
        
        self.timeLab = [[UILabel alloc]init];
        self.timeLab.textAlignment  =NSTextAlignmentLeft;
        self.timeLab.font = [UIFont systemFontOfSize:13];
        self.timeLab.textColor = kLabelText_Commen_Color_9;
        [self.contentView addSubview:self.timeLab];

        self.numberView = [[XMHNumberView alloc]init];
        self.numberView.didChangeBlock = ^(XMHNumberView * _Nonnull numberView) {
           
            [weakSelf changeCartNum];
        };
        [self addSubview:self.numberView];
        [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(26 * 2 + 40, 30));
            make.right.mas_equalTo(-kMargin);
            
        }];
        self.numberView.hidden = YES;
        [self.priceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.moneyLab.mas_bottom).mas_offset(5);
            make.left.mas_equalTo(self.titleLab.mas_left);
            make.right.mas_equalTo(self.numberView .mas_left);
        }];
        
        [self.timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.priceLab.mas_bottom).mas_offset(5);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.left.mas_equalTo(self.titleLab.mas_left);
        }];
    
    }
    return self;
}

- (void)updataLayout
{
    self.countLab.hidden = YES;
    self.numberView.hidden = YES;
    self.timeLab.hidden = NO;
    self.priceLab.hidden = NO;
    self.recoverLab.hidden = NO;
    self.timeLab.hidden = YES;
    
    [self.priceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyLab.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.right.mas_equalTo(self.contentView .mas_right);
    }];
}

- (void)changeCartNum
{
    self.numberView.currentNumber = 1;
    [XMHProgressHUD showOnlyText:@"库存不足"];
}
- (void)resetCell
{
    self.countLab.hidden = NO;
    self.numberView.hidden = YES;
    self.timeLab.hidden = YES;
    self.priceLab.hidden = YES;
    self.recoverLab.hidden = YES;
    self.timeLab.text = nil;
    self.priceLab.text = nil;
    self.countLab.text = nil;
    self.titleLab.text = nil;
    self.numLab.text = nil;
    self.recoverLab.text = nil;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
