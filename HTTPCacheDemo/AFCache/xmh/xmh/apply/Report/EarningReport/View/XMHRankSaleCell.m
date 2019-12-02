//
//  XMHRankSaleCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHRankSaleCell.h"
#import "XMHRankSalesListModel.h"
@interface XMHRankSaleCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *rankLab;
@property (nonatomic, strong) UIView  *lineView;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@end

@implementation XMHRankSaleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kBackgroundColor;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    self.bgView = UIView.new;
    self.bgView.backgroundColor = UIColor.whiteColor;
    self.bgView.layer.cornerRadius = 5;
    [self.contentView addSubview:self.bgView];
    
    self.nameLab = UILabel.new;
    self.nameLab.textColor = kColor3;
    self.nameLab.font = FONT_SIZE(15);
    [self.bgView addSubview:self.nameLab];
    
    self.rankLab = UILabel.new;
    self.rankLab.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    self.rankLab.font = FONT_SIZE(14);
    [self.bgView addSubview:self.rankLab];
    
    self.lineView = UIView.new;
    self.lineView.backgroundColor = kSeparatorLineColor;
    [self.bgView addSubview:self.lineView];
    
    self.lab1 = UILabel.new;
    self.lab1.textColor = kLabelText_Commen_Color_6;
    self.lab1.font = FONT_SIZE(12);
    [self.bgView addSubview:self.lab1];
    
    self.lab2 = UILabel.new;
    self.lab2.textColor = kLabelText_Commen_Color_6;
    self.lab2.font = FONT_SIZE(12);
    [self.bgView addSubview:self.lab2];
    
    self.lab3 = UILabel.new;
    self.lab3.textColor = kLabelText_Commen_Color_6;
    self.lab3.font = FONT_SIZE(12);
    [self.bgView addSubview:self.lab3];
    
    self.lab4 = UILabel.new;
    self.lab4.textColor = kLabelText_Commen_Color_6;
    self.lab4.font = FONT_SIZE(12);
    [self.bgView addSubview:self.lab4];
    
    self.nameLab.text = @"肤质";
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.rankLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(self.bgView.centerX);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLab.mas_bottom);
        make.left.right.mas_equalTo(self.bgView);
        make.height.mas_equalTo(kSeparatorHeight);
        
    }];
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-40);
    }];
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(40);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-15);
    }];
    
    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.lab1.mas_bottom).mas_offset(5);
        make.bottom.mas_equalTo(-15);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-40);
    }];
    [self.lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(40);
        make.top.mas_equalTo(self.lab1.mas_bottom).mas_offset(5);
        make.bottom.mas_equalTo(-15);
        make.right.mas_equalTo(-15);
        
//        make.left.mas_equalTo(160);
//        make.top.mas_equalTo(self.lab1.mas_bottom).mas_offset(5);
//        make.bottom.mas_equalTo(-15);
//        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-40);
    }];
}
- (void)configureWithModel:(nullable id)model
{
    XMHRankSalesModel *saleModel = (XMHRankSalesModel *)model;
    [super configureWithModel:model];
    self.nameLab.text = saleModel.name;
    self.rankLab.text = [NSString stringWithFormat:@"销售排名: %@",saleModel.pai];
    self.lab1.text = [NSString stringWithFormat:@"普及人数: %@人",saleModel.puji];
    self.lab2.text = [NSString stringWithFormat:@"售卖人数: %@人",saleModel.shoumai];
    self.lab3.text= [NSString stringWithFormat:@"销售业绩: %@元",saleModel.xiaoshou];
    self.lab4.text = [NSString stringWithFormat:@"销售占比: %@%%",saleModel.bfb];
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
