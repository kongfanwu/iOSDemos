//
//  XMHCredentiaManageVenditionSaleCell.m
//  xmh
//
//  Created by KFW on 2019/4/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaManageVenditionSaleCell.h"

@interface XMHCredentiaManageVenditionSaleCell()
/** <##> */
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *nameLabel, *orderTypeLabel, *openOrderLabel, *priceLabel, *dateLabel, *stateLabel, *lastLabel;
/** <##> */
@property (nonatomic, strong) UIView *toolView;
@end

@implementation XMHCredentiaManageVenditionSaleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kBackgroundColor;
        
        self.bgView = UIView.new;
        _bgView.backgroundColor = UIColor.whiteColor;
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(0);
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
        
        self.dateLabel = [self createLabel];
        [_bgView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_priceLabel.mas_bottom).offset(5);
            make.left.right.equalTo(_orderTypeLabel);
        }];
        
        self.lastLabel = [self createLabel];
        [_bgView addSubview:_lastLabel];
        [_lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_dateLabel.mas_bottom).offset(5);
            make.left.right.equalTo(_orderTypeLabel);
        }];
        self.lastLabel.hidden = YES;
        self.toolView = UIView.new;
        [_bgView addSubview:_toolView];
        [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_bgView);
            make.top.equalTo(_lastLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(34);
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
    _stateLabel.text = model.order_type_name;
    _nameLabel.text = [NSString stringWithFormat:@"%@：%@", model.user_name, model.user_mobile];
    _orderTypeLabel.text = [NSString stringWithFormat:@"开单类型：%@", model.type_name];
    _openOrderLabel.text = [NSString stringWithFormat:@"开单人：%@", model.saler];
    _priceLabel.text = [NSString stringWithFormat:@"实付金额：¥%@", model.amount];
    _dateLabel.text = [NSString stringWithFormat:@"下单时间：%@", IsEmpty(model.insert_time) ? @"" : model.insert_time];
    self.lastLabel.hidden = YES;
    if ([model.order_type_name isEqualToString:@"待付款"]) {
        _priceLabel.text = [NSString stringWithFormat:@"应付金额:  ￥%@",model.heji];
        if ([model.type isEqualToString:@"2"]) { //账单回收
             _priceLabel.text = [NSString stringWithFormat:@"回收金额:  ￥%@",model.huishou_amount];
        }
    }else if ([model.order_type_name isEqualToString:@"未还清"]){
         _priceLabel.text = [NSString stringWithFormat:@"应付金额：¥%@", model.heji];
         _dateLabel.text = [NSString stringWithFormat:@"实付金额：%@", IsEmpty(model.amount) ? @"" : model.amount];
         _lastLabel.text = [NSString stringWithFormat:@"下单时间：%@", IsEmpty(model.insert_time) ? @"" : model.insert_time];
        self.lastLabel.hidden = NO;
    }
    
    [_toolView removeAllSubViews];
    
    NSArray *items = [model itemsTitleFromType];
    if (items.count) {
        for (int i = 0; i < items.count; i++) {
            XMHCredentiaOrderStateItemModel *credentiaOrderStateItemModel = items[i];
            UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            [oneButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
            [oneButton setTitle:credentiaOrderStateItemModel.title forState:UIControlStateNormal];
            [oneButton setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
            oneButton.titleLabel.font = FONT_SIZE(13);
            oneButton.layer.cornerRadius = 5;
            oneButton.layer.masksToBounds = YES;
            oneButton.layer.borderWidth = kBorderWidth;
            oneButton.layer.borderColor = kBtn_Commen_Color.CGColor;
            [oneButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_toolView addSubview:oneButton];
            oneButton.tag = 1000 + i;
        }
        // 一个按钮布局
        if (_toolView.subviews.count ==  1) {
            UIButton *oneButton = _toolView.subviews.firstObject;
            [oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(_toolView);
                make.width.mas_equalTo(70);
                make.right.mas_equalTo(-10);
                make.bottom.equalTo(_toolView);
            }];
        }
        // 多个按钮布局
        else if (_toolView.subviews.count > 1) {
            [_toolView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(_toolView);
                make.bottom.equalTo(_toolView);
            }];
            CGFloat leftGap = (SCREEN_WIDTH - 20) - (items.count * 70) - (items.count * 10);
            [_toolView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:70 leadSpacing:leftGap tailSpacing:10];
        }
    }
}

- (void)buttonClick:(UIButton *)sender {
    NSArray *items = [(XMHCredentiaSalesOrderMdoel *)self.model itemsTitleFromType];
    NSInteger tag = sender.tag - 1000;
    XMHCredentiaOrderStateItemModel *credentiaOrderStateItemModel = items[tag];
    if (self.didSelectClickBlock) self.didSelectClickBlock(self, credentiaOrderStateItemModel);
}

@end
