//
//  XMHOrderProjectCell.m
//  xmh
//
//  Created by KFW on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOrderProjectCell.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"
#import "SLSCourseExper.h"

@interface XMHOrderProjectCell()
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel, *priceLabel, *vipPriceLabel;
@end

@implementation XMHOrderProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.titleLabel = UILabel.new;
        _titleLabel.font = FONT_SIZE(15);
        _titleLabel.textColor = kColor3;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(15);
        }];
        
        self.priceLabel = UILabel.new;
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        _priceLabel.font = FONT_SIZE(13);
        _priceLabel.textColor = kColor9;
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
            make.left.equalTo(_titleLabel);
            make.bottom.mas_equalTo(-15);
            make.width.equalTo(self.contentView).multipliedBy(0.5).offset(-(5 + 7.5));
        }];
        
        
        self.vipPriceLabel = UILabel.new;
        _vipPriceLabel.adjustsFontSizeToFitWidth = YES;
        _vipPriceLabel.font = FONT_SIZE(13);
        _vipPriceLabel.textColor = kColor9;
        [self.contentView addSubview:_vipPriceLabel];
        [_vipPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_priceLabel.mas_right).offset(10);
            make.top.width.equalTo(_priceLabel);
            make.right.equalTo(self.contentView);
        }];
        // 拉伸优先级低
        [_vipPriceLabel setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        // 压缩优先级低
        [_vipPriceLabel setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        
        UIView *lineView = UIView.new;
        lineView.backgroundColor = kSeparatorColor;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kSeparatorHeight);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)configModel:(id)model {
    // 项目
    if ([model isKindOfClass:[SLS_Pro class]]) {
        SLS_Pro *projectModel = (SLS_Pro *)model;
        _titleLabel.text = projectModel.name;
        _priceLabel.text = [NSString stringWithFormat:@"成交单价：¥%@", projectModel.r_price];
        _vipPriceLabel.text = [NSString stringWithFormat:@"会员价：¥%@", projectModel.vip_price];
    }
    // 产品
    else if ([model isKindOfClass:[SLGoodModel class]]) {
        SLGoodModel *goodModel = (SLGoodModel *)model;
        _titleLabel.text = goodModel.name;
        _priceLabel.text = [NSString stringWithFormat:@"成交单价：¥%@", goodModel.r_price];
        _vipPriceLabel.text = [NSString stringWithFormat:@"会员价：¥%@", goodModel.vip_price];
    }
    
    // SLPro_ListM SLGoods_ListM
    // 体验服务-项目
    else if ([model isKindOfClass:[SLPro_ListM class]]) {
        SLPro_ListM *projectModel = (SLPro_ListM *)model;
        _titleLabel.text = projectModel.name;
        _priceLabel.text = [NSString stringWithFormat:@"成交单价：¥%@", projectModel.price];
        _vipPriceLabel.text = [NSString stringWithFormat:@"共%ld次", projectModel.num];
    }
    // 体验服务-产品
    else if ([model isKindOfClass:[SLGoods_ListM class]]) {
        SLGoods_ListM *goodModel = (SLGoods_ListM *)model;
        _titleLabel.text = goodModel.name;
        _priceLabel.text = [NSString stringWithFormat:@"成交单价：¥%@", goodModel.price];
        _vipPriceLabel.text = [NSString stringWithFormat:@"共%ld次", goodModel.num];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
