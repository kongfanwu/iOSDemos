//
//  XMHCredentialtenCell.m
//  xmh
//
//  Created by KFW on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentialtenCell.h"

@interface XMHCredentialtenCell()
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel, *countLabel;
/** <##> */
@property (nonatomic, strong) UIImageView *logoImageView, *arrowImageView;
@end

@implementation XMHCredentialtenCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.logoImageView = UIImageView.new;
        [self.contentView addSubview:_logoImageView];
        [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(35, 35));
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(25);
        }];
        
        self.titleLabel = UILabel.new;
        _titleLabel.font = FONT_SIZE(11);
        _titleLabel.textColor = kColor6;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_logoImageView.mas_right).offset(5);
            make.top.equalTo(_logoImageView).offset(2);
        }];
        
        self.countLabel = UILabel.new;
        _countLabel.font = FONT_SIZE(15);
        _countLabel.textColor = kColor3;
        [self.contentView addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel);
            make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        }];
        
        self.arrowImageView = [[UIImageView alloc] initWithImage:UIImageName(@"shouye-xiaojiantou")];
        [self.contentView addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(6, 10));
            make.left.mas_equalTo(_titleLabel.mas_right).offset(10);
            make.centerY.equalTo(_titleLabel);
        }];
    }
    return self;
}

- (void)configModel:(XMHCredentiaItemModel *)model {
    if (model.type == XMHCredentiaItemModelTypeArrow) {
        _arrowImageView.hidden = NO;
    } else {
        _arrowImageView.hidden = YES;
    }
    _titleLabel.text = model.title;
    _countLabel.text = model.count;
    _logoImageView.image = UIImageName(model.imageName);
}

@end
