//
//  XMHCredentialSalesRefundCell.m
//  xmh
//
//  Created by KFW on 2019/4/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentialSalesRefundCell.h"
#import "XMHCredentiaRefundModel.h"
#import "NSString+Check.h"

@interface XMHCredentialSalesRefundCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *nameLabel, *orderTypeLabel, *openOrderLabel, *priceLabel, *projectLabel;
@end

@implementation XMHCredentialSalesRefundCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kBackgroundColor;
        
        self.bgView = UIView.new;
        _bgView.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
        }];
        
        self.nameLabel = [self createLabel];
        [_bgView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(15);
        }];
        
        self.orderTypeLabel = [self createLabel];
        [_bgView addSubview:_orderTypeLabel];
        [_orderTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).offset(5);
            make.left.equalTo(_nameLabel);
            make.right.mas_equalTo(0);
        }];
        
        self.openOrderLabel = [self createLabel];
        [_bgView addSubview:_openOrderLabel];
        [_openOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_orderTypeLabel.mas_bottom).offset(5);
            make.left.right.equalTo(_orderTypeLabel);
        }];
        
        self.priceLabel = [self createLabel];
        [_bgView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_openOrderLabel.mas_bottom).offset(5);
            make.left.right.equalTo(_orderTypeLabel);
        }];
        
        self.projectLabel = [self createLabel];
        [_bgView addSubview:_projectLabel];
        [_projectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_priceLabel.mas_bottom).offset(5);
            make.left.right.equalTo(_orderTypeLabel);
            make.bottom.mas_equalTo(-15);
        }];
    }
    return self;
}

- (UILabel *)createLabel {
    UILabel *label = UILabel.new;
    label.font = FONT_SIZE(12);
    label.textColor = kColor6;
    return label;
}

- (void)configureWithModel:(XMHCredentiaRefundModel *)model {
    [super configureWithModel:model];
    
    _nameLabel.text = [NSString stringWithFormat:@"%@：%@", model.user_name, [model.user_mobile safeMobile]];
    _orderTypeLabel.text = [NSString stringWithFormat:@"发起人：%@", model.inper_name];
    _openOrderLabel.text = [NSString stringWithFormat:@"退款金额：%@", model.actual];
    _priceLabel.text = [NSString stringWithFormat:@"所属门店：%@", model.store_name];
    _projectLabel.text = [NSString stringWithFormat:@"退款时间：%@", model.create_time];
}

@end
