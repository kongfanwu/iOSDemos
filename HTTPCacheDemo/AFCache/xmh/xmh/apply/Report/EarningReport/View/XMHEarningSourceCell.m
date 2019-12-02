//
//  XMHEarningSourceCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHEarningSourceCell.h"
@interface XMHEarningSourceCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *rankLab;
@property (nonatomic, strong) UIView  *lineView;
@property (nonatomic, strong) UILabel *buyLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *precentLab;

@end
@implementation XMHEarningSourceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kBackgroundColor;
        [self initSubViews];
    }
    return self;
}

- (void)configureWithModel:(XMHEarningSourceModel *)model rank:(NSInteger)rank
{
    self.rankLab.text = [NSString stringWithFormat:@"销售排名: %ld",rank];
    self.nameLab.text = model.name;
    self.buyLab.text = [NSString stringWithFormat:@"购买人数:  %@人",model.num];
    self.priceLab.text = [NSString stringWithFormat:@"销售业绩:  %@元",model.amount];
    self.precentLab.text = [NSString stringWithFormat:@"业绩占比:  %.2f%%",[model.bfb floatValue]];
}
- (void)initSubViews
{
    self.bgView = UIView.new;
    self.bgView.backgroundColor = UIColor.whiteColor;
    self.bgView.layer.cornerRadius = 5;
    [self.contentView addSubview:self.bgView];
    
    self.nameLab = UILabel.new;
    self.nameLab.textColor = kColor3;
    self.nameLab.font = FONT_SIZE(16);
    [self.bgView addSubview:self.nameLab];
    
    self.rankLab = UILabel.new;
    self.rankLab.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    self.rankLab.font = FONT_SIZE(16);
    [self.bgView addSubview:self.rankLab];
    
    self.lineView = UIView.new;
    self.lineView.backgroundColor = kSeparatorLineColor;
    [self.bgView addSubview:self.lineView];
    
    self.buyLab = UILabel.new;
    self.buyLab.textColor = kLabelText_Commen_Color_9;
    self.buyLab.font = FONT_SIZE(11);
    [self.bgView addSubview:self.buyLab];
    
    self.priceLab = UILabel.new;
    self.priceLab.textColor = kLabelText_Commen_Color_9;
    self.priceLab.font = FONT_SIZE(11);
    [self.bgView addSubview:self.priceLab];
    
    self.precentLab = UILabel.new;
    self.precentLab.textColor = kLabelText_Commen_Color_9;
    self.precentLab.font = FONT_SIZE(11);
    [self.bgView addSubview:self.precentLab];
    
    
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
    
    [self.buyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_equalTo(15);
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(15);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyLab.mas_bottom).mas_equalTo(5);
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(15);
    }];
    [self.precentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLab.mas_bottom).mas_equalTo(5);
        make.bottom.mas_equalTo(-15);
        make.left.mas_equalTo(15);
    }];
    
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
