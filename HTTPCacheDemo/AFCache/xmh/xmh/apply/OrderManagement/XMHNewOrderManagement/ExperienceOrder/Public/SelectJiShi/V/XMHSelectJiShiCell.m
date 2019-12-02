//
//  XMHSelectJiShiCell.m
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSelectJiShiCell.h"
#import "MLJishiSearchModel.h"

@interface XMHSelectJiShiCell()
/** <##> */
@property (nonatomic, strong) UIImageView *stateImageView;
/** <##> */
@property (nonatomic, strong) UILabel *nameLabel, *addressLabel;
@end

@implementation XMHSelectJiShiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.stateImageView = [[UIImageView alloc] init];
        _stateImageView.image = UIImageName(@"service_normal");
        _stateImageView.highlightedImage = UIImageName(@"service_select");
        [self.contentView addSubview:_stateImageView];
        [_stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(15, 15));
//            make.top.mas_equalTo(12);
//            make.bottom.mas_equalTo(-12);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.addressLabel = UILabel.new;
        _addressLabel.font = FONT_SIZE(14);
        _addressLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_addressLabel];
        
        // 拉伸优先级低
//        [_addressLabel setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        // 压缩优先级低
//        [_addressLabel setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        
        self.nameLabel = UILabel.new;
        _nameLabel.font = FONT_SIZE(14);
        [self.contentView addSubview:_nameLabel];
        
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(_nameLabel);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_stateImageView.mas_right).offset(10);
            make.right.equalTo(_addressLabel.mas_left).offset(10);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(_addressLabel);
        }];
    }
    return self;
}

- (void)configureWithModel:(id)model {
    [super configureWithModel:model];
    MLJiShiModel *jiShiModel = (MLJiShiModel *)model;
    
    _nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", jiShiModel.name, jiShiModel.phone];
    _addressLabel.text = jiShiModel.store_name;
    if (jiShiModel.isSelect) {
        _stateImageView.highlighted = YES;
        _nameLabel.textColor = kLabelText_Commen_Color_ea007e;
        _addressLabel.textColor = kLabelText_Commen_Color_ea007e;
    } else {
        _stateImageView.highlighted = NO;
        _nameLabel.textColor = kColor3;
        _addressLabel.textColor = kColor3;
    }
}

@end
