//
//  XMHCredentiaManageBossCell.m
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaManageBossCell.h"
#import "XMHShopModel.h"

@interface XMHCredentiaManageBossCell()
/** <##> */
@property (nonatomic, strong) UIView *bgView;
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel, *serviceLabel, *saleLabel;
/** <##> */
@property (nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation XMHCredentiaManageBossCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kColorF5F5F5;
        
        self.bgView = UIView.new;
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        
        self.arrowImageView = [[UIImageView alloc] initWithImage:UIImageName(@"shouye-xiaojiantou")];
        [_bgView addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(6, 10));
            make.centerY.equalTo(_bgView);
            make.right.mas_equalTo(-15);
        }];
        
        self.titleLabel = UILabel.new;
        _titleLabel.font = FONT_SIZE(16);
        _titleLabel.textColor = kColor3;
        [_bgView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
        }];
        
        self.serviceLabel = UILabel.new;
        _serviceLabel.font = FONT_SIZE(12);
        _serviceLabel.textColor = kColor6;
        [_bgView addSubview:_serviceLabel];
        [_serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
            make.left.equalTo(_titleLabel);
            make.bottom.mas_equalTo(-15);
        }];
        
        self.saleLabel = UILabel.new;
        _saleLabel.font = FONT_SIZE(12);
        _saleLabel.textColor = kColor6;
        [_bgView addSubview:_saleLabel];
        [_saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_serviceLabel.mas_right).offset(40);
            make.top.equalTo(_serviceLabel);
        }];
    }
    return self;
}

- (void)configureWithModel:(XMHShopModel *)model {
    [super configureWithModel:model];
    
    _titleLabel.text = model.name;
    _serviceLabel.text = [NSString stringWithFormat:@"服务单：%@", model.serv_num];
    _saleLabel.text = [NSString stringWithFormat:@"销售单：%@", model.sales_num];
}

@end
