//
//  XMHServiceOrderCell.m
//  xmh
//
//  Created by KFW on 2019/3/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderCell.h"
#import "XMHServiceBaseModel.h"
#import "XMHServiceProjectModel.h"

@interface XMHServiceOrderCell()
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel, *priceLabel, *shiChangLabel;
/** <##> */
@property (nonatomic, strong) XMHNumberView *numberView;
/** <##> */
@property (nonatomic, strong) UIButton *shopCartBtn;

@end

@implementation XMHServiceOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.shopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shopCartBtn setImage:[UIImage imageNamed:@"stdd_lebiaogouwuche"] forState:UIControlStateNormal];
        __weak typeof(self) _self = self;
        [self.shopCartBtn bk_addEventHandler:^(id sender) {
            __strong typeof(_self) self = _self;
            if (self.didAddToShopCartBlock) self.didAddToShopCartBlock();
        } forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.shopCartBtn];
        [_shopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(28, 28));
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.numberView = [[XMHNumberView alloc] init];
        _numberView.minNumber = 0;
        [self.contentView addSubview:_numberView];
        [_numberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(26 * 2 + 40, 30));
            make.right.mas_equalTo(self.shopCartBtn.mas_left).offset(-15);
            make.centerY.equalTo(self.contentView);
        }];

        [_numberView setDidChangeBlock:^(XMHNumberView * _Nonnull numberView) {
            __strong typeof(_self) self = _self;
            if (self.didChangeBlock) self.didChangeBlock(numberView);
        }];
        
        
        self.titleLabel = UILabel.new;
        _titleLabel.font = FONT_SIZE(15);
        _titleLabel.textColor = kColor3;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
        }];
        
        self.priceLabel = UILabel.new;
        _priceLabel.font = FONT_SIZE(13);
        _priceLabel.textColor = kColor9;
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(5);
            make.left.equalTo(_titleLabel);
            make.right.equalTo(_numberView.mas_left);
        }];
        // 拉伸优先级低
        [_priceLabel setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        // 压缩优先级低
        [_priceLabel setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        
        self.shiChangLabel = UILabel.new;
        _shiChangLabel.font = FONT_SIZE(13);
        _shiChangLabel.textColor = kColor9;
        [self.contentView addSubview:_shiChangLabel];
        
        UIView *lineView = UIView.new;
        lineView.backgroundColor = kColorE5E5E5;
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(15);
            make.right.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)configureWithModel:(XMHServiceBaseModel *)model {
    [super configureWithModel:model];
    
    _numberView.currentNumber = model.selectCount;
    
    // 单价 剩余次数样式
    if (model.type == XMHServiceOrderTypeChuFang || model.type == XMHServiceOrderTypeProject || model.type == XMHServiceOrderTypeGoods) {
        [_shiChangLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_priceLabel.mas_bottom).offset(5);
            make.left.equalTo(_titleLabel);
            make.bottom.mas_equalTo(-15);
        }];
        
        XMHServiceProjectModel *serviceProjectModel = (XMHServiceProjectModel *)model;
        _titleLabel.text = serviceProjectModel.name;
        _priceLabel.text = [NSString stringWithFormat:@"成交单价：¥ %@", serviceProjectModel.price];
        _shiChangLabel.text = [NSString stringWithFormat:@"剩余%ld次", (long)serviceProjectModel.numUpdate];
    }
    // 单价 时长样式
    else if (model.type == XMHServiceOrderTypeTiKaStordeCar || model.type == XMHServiceOrderTypeTiKaNumCar) {
        [_shiChangLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_priceLabel.mas_bottom).offset(5);
            make.left.equalTo(_titleLabel);
            make.bottom.mas_equalTo(-15);
        }];
        
        XMHServiceProjectModel *serviceProjectModel = (XMHServiceProjectModel *)model; // 此类型也可能是 XMHServiceGoodsModel 类型。但属性名相同
        _titleLabel.text = serviceProjectModel.name;
        _priceLabel.text = [NSString stringWithFormat:@"单价：¥ %@", serviceProjectModel.price];
        _shiChangLabel.text = [NSString stringWithFormat:@"时长：%ld分钟", serviceProjectModel.shichang];
    }
    // 时长样式
    else if (model.type == XMHServiceOrderTypeTiKaTimeCar) {
        [_shiChangLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_priceLabel.mas_bottom).offset(5);
            make.left.equalTo(_titleLabel);
            make.bottom.mas_equalTo(-15);
            make.height.mas_equalTo(0); // 隐藏
        }];
        
        XMHServiceProjectModel *serviceProjectModel = (XMHServiceProjectModel *)model; // 此类型也可能是 XMHServiceGoodsModel 类型。但属性名相同
        _titleLabel.text = serviceProjectModel.name;
        _priceLabel.text = [NSString stringWithFormat:@"时长：%ld分钟", serviceProjectModel.shichang];
        _shiChangLabel.text = nil;
    }
    
//    [_shopCartBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(28, 28));
//        make.right.mas_equalTo(-15);
//        make.bottom.equalTo(_shiChangLabel.mas_bottom);
//    }];
}

//- (void)didChangeNumberView:(XMHNumberView *)numberView {
//    if (((XMHServiceBaseModel *)self.model).type == XMHServiceOrderTypeChuFang) {
//        XMHServiceProjectModel *serviceProjectModel = (XMHServiceProjectModel *)self.model;
//
//    }
//}

@end
