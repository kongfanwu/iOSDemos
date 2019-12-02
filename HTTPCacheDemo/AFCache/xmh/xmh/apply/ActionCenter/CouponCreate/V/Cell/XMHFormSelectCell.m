//
//  XMHFormSelectCell.m
//  xmh
//
//  Created by KFW on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormSelectCell.h"

@interface XMHFormSelectCell()
/** <##> */
@property (nonatomic, strong) UIImageView *arrowImageView;
/** <##> */
@property (nonatomic, strong) UILabel *valueLabel;
@end

@implementation XMHFormSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.arrowImageView = [[UIImageView alloc] initWithImage:UIImageName(@"huodongzhongxin_youjiantou")];
        [self.contentView addSubview:_arrowImageView];
        
        self.valueLabel = UILabel.new;
        _valueLabel.font = FONT_SIZE(15);
        _valueLabel.textColor = kColor3;
        _valueLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_valueLabel];
        _valueLabel.mas_key = @"valueLabel";
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
    
    // 编辑状态 || (非编辑状态 && model.type == XMHFormTypeSelect)
    if (model.isEdit || (!model.isEdit && model.type == XMHFormTypeSelect)) {
        _arrowImageView.hidden = NO;
        _valueLabel.numberOfLines = 1;
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.width.mas_equalTo(self.titleLabel.width);
            make.centerY.equalTo(self.contentView);
        }];
        
        [_arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            CGFloat gap = (44 - 12.5) / 2.f;
            make.size.mas_equalTo(CGSizeMake(7, 12.5));
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(gap);
            make.bottom.mas_equalTo(-gap);
        }];
        
        [_valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(10);
            make.right.equalTo(_arrowImageView.mas_left).offset(-10);
            make.centerY.equalTo(self.contentView);
        }];
    }
    // model.type == XMHFormTypeSelectNoEditContentFilled
    else {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.width.mas_equalTo(self.titleLabel.width);
        }];
        
        _arrowImageView.hidden = YES;
        _valueLabel.numberOfLines = 0;
        
        [_valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(10);
            make.right.mas_equalTo(-15);
            make.top.equalTo(self.lineView.mas_bottom).offset(15);
            make.bottom.mas_equalTo(-15);
        }];
    }
}

@end
