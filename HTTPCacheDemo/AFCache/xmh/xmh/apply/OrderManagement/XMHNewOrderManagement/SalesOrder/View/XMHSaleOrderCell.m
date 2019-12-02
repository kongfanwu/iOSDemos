//
//  XMHSaleOrderCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//
#import "XMHSaleOrderCell.h"
#import "SASaleListModel.h"
@interface XMHSaleOrderCell ()
/**对应多种类型的数据*/
@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UILabel *secondLab;
@property (strong, nonatomic) UILabel *threeLab;
@property (strong, nonatomic) UILabel *fourLab;
@property (strong, nonatomic) UILabel *fiveLab;
@property (strong, nonatomic) UILabel *sixLab;

@end
@implementation XMHSaleOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubViews];
    }
    return self;
}

- (void)refreshCellProModel:(SaleModel *)model{
    self.threeLab.hidden = NO;
    self.fourLab.hidden = YES;
    self.fiveLab.hidden = YES;
    self.sixLab.hidden = YES;
    self.nameLab.text = model.name;
//    NSArray *lingShouArr = [model.price_list.pro_22.price componentsSeparatedByString:@","];
//    CGFloat vipPrice =  [[[lingShouArr mutableCopy] safeObjectAtIndex:0] floatValue];// 会员价
    self.secondLab.text = [NSString stringWithFormat:@"零售价: ￥%.2f",[model.price_list.pro_11.price floatValue]];
    self.threeLab.text = [NSString stringWithFormat:@"会员价: ￥%.2f",[model.price_list.pro_12.price floatValue]];
}
- (void)refreshCellGoodsModel:(SaleModel *)model{
    self.threeLab.hidden = NO;
    self.sixLab.hidden = YES;
    self.fourLab.hidden = YES;
    self.fiveLab.hidden = YES;
    self.nameLab.text = model.name;
    self.secondLab.text = [NSString stringWithFormat:@"零售价: ￥%@",model.price_list.pro_11.price];
    self.threeLab.text = [NSString stringWithFormat:@"会员价: ￥%@",model.price_list.pro_12.price?model.price_list.pro_12.price:@""];
}
- (void)refreshCellCardCourseModel:(SaleModel *)model{
    self.threeLab.hidden = YES;
    self.sixLab.hidden = YES;
    self.fourLab.hidden = YES;
    self.fiveLab.hidden = YES;
    self.nameLab.text = model.name;
    self.secondLab.text = [NSString stringWithFormat:@"零售价: ￥%@",model.price_list.pro_11.price];
//    self.threeLab.text = [NSString stringWithFormat:@"会员价: ￥%@",model.price_list.pro_12.price?model.price_list.pro_12.price:@""];
}
- (void)refreshCellCardNumModel:(SaleModel *)model{
    self.threeLab.hidden = YES;
    self.fourLab.hidden = NO;
    self.fiveLab.hidden = YES;
    self.sixLab.hidden = YES;
    self.nameLab.text = model.name;
    self.secondLab.text = [NSString stringWithFormat:@"零售价: ￥%@",model.price_list.pro_11.price];
    self.fourLab.text = [NSString stringWithFormat:@"次数: %ld",(long)model.num];//[NSString stringWithFormat:@"会员价: ￥%@",model.price_list.pro_12.price?model.price_list.pro_12.price:@""];
//    self.fiveLab.text = [NSString stringWithFormat:@"次数: %ld",(long)model.num];
   
}
- (void)refreshCellStoredModel:(SaleModel *)model{
    self.threeLab.hidden = YES;
    self.fourLab.hidden = NO;
    self.fiveLab.hidden = NO;
    self.sixLab.hidden = NO;
    self.nameLab.text = model.name;
    self.secondLab.text = [NSString stringWithFormat:@"零售价: ￥%@",model.price_list.pro_10.price?model.price_list.pro_10.price:@""]; [model.xm_discount  floatValue];
    self.fourLab.text = [NSString stringWithFormat:@"商品折扣: %.1f折",[model.xm_discount  floatValue]/10];
    self.fiveLab.text = [NSString stringWithFormat:@"产品折扣: %.1f折",[model.cp_discount floatValue] /10];
    
}
- (void)refreshCellCardTimeModel:(SaleModel *)model{
    self.threeLab.hidden = NO;
    self.sixLab.hidden = YES;
    self.fourLab.hidden = YES;
    self.fiveLab.hidden = YES;
    self.nameLab.text = model.name;
    self.secondLab.text = [NSString stringWithFormat:@"零售价: ￥%@",model.price_list.pro_11.price];
    self.threeLab.text = [NSString stringWithFormat:@"期限: %ld天",model.expiry];
}
- (void)refreshCellTicketModel:(SaleModel *)model{
    self.threeLab.hidden = YES;
    self.fourLab.hidden = YES;
    self.fiveLab.hidden = YES;
    self.sixLab.hidden = YES;
    self.nameLab.text = model.name;
    self.secondLab.text = [NSString stringWithFormat:@"零售价: ￥%@",model.price_list.pro_11.price];
}

- (void)refreshCellSkxkModel:(SaleModel *)model{
    self.threeLab.hidden = YES;
    self.fourLab.hidden = YES;
    self.fiveLab.hidden = YES;
    self.sixLab.hidden = YES;
    self.nameLab.text = model.name;
    self.secondLab.text = [NSString stringWithFormat:@"剩余金额: ￥%@",model.money];
}
- (void)initSubViews
{
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.textAlignment  =NSTextAlignmentLeft;
    self.nameLab.font = [UIFont systemFontOfSize:15];
    self.nameLab.textColor = kLabelText_Commen_Color_3;
    [self.contentView addSubview:self.nameLab];
    
    self.secondLab = [[UILabel alloc]init];
    self.secondLab.textAlignment  =NSTextAlignmentLeft;
    self.secondLab.font = [UIFont systemFontOfSize:13];
    self.secondLab.textColor = kLabelText_Commen_Color_9;
    [self.contentView addSubview:self.secondLab];
    
    self.threeLab = [[UILabel alloc]init];
    self.threeLab.textAlignment  =NSTextAlignmentLeft;
    self.threeLab.font = [UIFont systemFontOfSize:13];
    self.threeLab.textColor = kLabelText_Commen_Color_9;
    [self.contentView addSubview:self.threeLab];
    
    self.fourLab = [[UILabel alloc]init];
    self.fourLab.textAlignment  =NSTextAlignmentLeft;
    self.fourLab.font = [UIFont systemFontOfSize:13];
    self.fourLab.textColor = kLabelText_Commen_Color_9;
    [self.contentView addSubview:self.fourLab];
    
    self.fiveLab = [[UILabel alloc]init];
    self.fiveLab.textAlignment  =NSTextAlignmentLeft;
    self.fiveLab.font = [UIFont systemFontOfSize:13];
    self.fiveLab.textColor = kLabelText_Commen_Color_9;
    [self.contentView addSubview:self.fiveLab];
    
    self.sixLab = [[UILabel alloc]init];
    self.sixLab.textAlignment  =NSTextAlignmentLeft;
    self.sixLab.font = [UIFont systemFontOfSize:13];
    self.sixLab.textColor = kLabelText_Commen_Color_9;
//    [self.contentView addSubview:self.sixLab];
    
   
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
   
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.right.mas_equalTo(imageV.mas_left).mas_offset(-kMargin);
        make.top.mas_equalTo(kMargin);
        
    }];
    CGFloat w = (SCREEN_WIDTH - 100) * 0.5;
    [self.secondLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.width.mas_equalTo(w);
        make.top.mas_equalTo(weakSelf.nameLab.mas_bottom).mas_offset(5);
        
    }];
    
    CGFloat x = 15 + w;
    [self.threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(x);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.top.mas_equalTo(weakSelf.nameLab.mas_bottom).mas_offset(5);
        
    }];

    [self.fourLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.secondLab.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.secondLab.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
    }];
    
    [self.fiveLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fourLab.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.left.mas_equalTo(self.fourLab.mas_left);
    }];
    
//    [self.sixLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.fiveLab.mas_bottom).mas_offset(5);
//        make.right.mas_equalTo(weakSelf.mas_right);
//        make.left.mas_equalTo(self.fiveLab.mas_left);
//    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(weakSelf.mas_right).mas_offset(-kMargin);
        make.left.mas_equalTo(weakSelf.mas_left).mas_offset(kMargin);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)resetCell
{
    self.fiveLab.text = nil;
    self.nameLab.text = nil;
    self.secondLab.text = nil;
    self.threeLab.text = nil;
    self.fiveLab.text = nil;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
