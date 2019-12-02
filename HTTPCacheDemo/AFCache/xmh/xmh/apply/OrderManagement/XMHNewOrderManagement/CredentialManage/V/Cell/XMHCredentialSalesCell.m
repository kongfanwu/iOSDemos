//
//  XMHCredentialSalesCell.m
//  xmh
//
//  Created by KFW on 2019/4/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentialSalesCell.h"
#import "XMHCredentiaSalesOrderMdoel.h"
#import "XMHCredentiaServiceOrderMdoel.h"
#import "NSString+Check.h"

@interface XMHCredentialSalesCell()
/** <##> */
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *nameLabel, *orderTypeLabel, *openOrderLabel, *priceLabel, *projectLabel, *dateLabel, *stateLabel;
@end

@implementation XMHCredentialSalesCell

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
        
        self.stateLabel = [self createLabel];
        _stateLabel.textColor = kBackgroundColor_FF9072;
        _stateLabel.font = FONT_SIZE(13);
        [_bgView addSubview:_stateLabel];
        _stateLabel.text = @"111";
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
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
        }];
        
        self.dateLabel = [self createLabel];
        [_bgView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_projectLabel.mas_bottom).offset(5);
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

- (void)configureWithModel:(XMHCredentiaSalesOrderMdoel *)model {
    [super configureWithModel:model];
    
    if ([model isKindOfClass:[XMHCredentiaServiceOrderMdoel class]]) {
        XMHCredentiaServiceOrderMdoel *amodel = (XMHCredentiaServiceOrderMdoel *)model;
        
        _stateLabel.text = amodel.zt_name;
        _nameLabel.text = [NSString stringWithFormat:@"%@：%@", amodel.user_name, [amodel.mobile safeMobile]];
        _orderTypeLabel.text = [NSString stringWithFormat:@"开单类型：%@", amodel.type_name];
        _openOrderLabel.text = [NSString stringWithFormat:@"开单人：%@", amodel.inper_name];
        _priceLabel.text = [NSString stringWithFormat:@"实付金额：¥%@", amodel.z_price];
        _projectLabel.text = [NSString stringWithFormat:@"项目名称：%@", [XMHCredentiaServiceOrderMdoel proNameStr:amodel]];
        _dateLabel.text = [NSString stringWithFormat:@"开单时间：%@", amodel.stime];
    } else {
        _stateLabel.text = model.order_type_name;
        _nameLabel.text = [NSString stringWithFormat:@"%@：%@", model.user_name, [model.user_mobile safeMobile]];
        _orderTypeLabel.text = [NSString stringWithFormat:@"开单类型：%@", model.type_name];
        _openOrderLabel.text = [NSString stringWithFormat:@"开单人：%@", model.saler];
        _priceLabel.text = [NSString stringWithFormat:@"实付金额：¥%@", model.amount];
        _dateLabel.text = [NSString stringWithFormat:@"开单时间：%@", model.insert_time];
        
        [_projectLabel removeFromSuperview];
        [_dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_priceLabel.mas_bottom).offset(5);
            make.left.right.equalTo(_orderTypeLabel);
            make.bottom.mas_equalTo(-15);
        }];
    }
}

@end
