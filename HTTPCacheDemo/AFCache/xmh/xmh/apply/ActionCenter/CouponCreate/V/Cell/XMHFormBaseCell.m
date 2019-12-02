//
//  XMHFormBaseCell.m
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormBaseCell.h"

@implementation XMHFormBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.whiteColor;
        
        self.lineView = UIView.new;
        _lineView.backgroundColor = kSeparatorColor;
        [self.contentView addSubview:_lineView];
        _lineView.mas_key = @"lineView";
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kSeparatorHeight);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(0);
        }];
        
        self.titleLabel = UILabel.new;
        _titleLabel.font = FONT_SIZE(15);
        _titleLabel.textColor = kColor3;
        [self.contentView addSubview:_titleLabel];
        _titleLabel.mas_key = @"titleLabel";
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isLastCell) {
        [UIView addRadiusWithView:self.contentView roundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    } else {
        self.contentView.layer.mask = nil;
    }
}

- (void)configureWithModel:(XMHFormModel *)model {
    [super configureWithModel:model];
    
    _titleLabel.attributedText = [model getTitleAttributedString];
    
    [_titleLabel sizeToFit];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_titleLabel.width);
        make.left.mas_equalTo(15);
        make.centerY.equalTo(self.contentView);
    }];
}

@end
