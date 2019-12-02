//
//  XMHFormContentFilledCell.m
//  xmh
//
//  Created by KFW on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormContentFilledCell.h"

@interface XMHFormContentFilledCell()
/** <##> */
@property (nonatomic, strong) UILabel *valueLabel;
@end

@implementation XMHFormContentFilledCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.valueLabel = UILabel.new;
        _valueLabel.font = FONT_SIZE(12);
        _valueLabel.textColor = kColor3;
        _valueLabel.textAlignment = NSTextAlignmentLeft;
        _valueLabel.numberOfLines = 0;
        [self.contentView addSubview:_valueLabel];
        // 拉伸优先级低
        [_valueLabel setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        // 压缩优先级低
        [_valueLabel setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    }
    return self;
}

- (void)configureWithModel:(XMHFormModel *)model {
    [super configureWithModel:model];
    _valueLabel.text = model.value;
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.width.mas_equalTo(self.titleLabel.width);
    }];
    
    [_valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.right.bottom.mas_equalTo(-15);
        make.top.mas_equalTo(15);
    }];
}


@end
