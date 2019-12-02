//
//  XMHTicketCell.m
//  xmh
//
//  Created by KFW on 2019/3/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTicketCell.h"
#import "XMHTicketModel.h"

@interface XMHTicketCell()
/** <##> */
@property (nonatomic, strong) UIImageView *bgImageView;
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;
/** <##> */
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UILabel *joinNameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation XMHTicketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.bgImageView = UIImageView.new;
        _bgImageView.image = UIImageName(@"youhuiquan_zhekouquan_normal");
        _bgImageView.highlightedImage = UIImageName(@"youhuiquan_zhekouquan_select");
        [self.contentView addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 5, 0, 5));
        }];
        
        self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:UIImageName(@"danxuan-weixuanze") forState:UIControlStateNormal];
        [_selectButton setImage:UIImageName(@"danxue-yixuan") forState:UIControlStateSelected];
        [_bgImageView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.centerY.equalTo(_bgImageView);
            make.right.mas_equalTo(-15);
        }];
        
        self.titleLabel = UILabel.new;
        _titleLabel.font = FONT_SIZE(22);
        [_bgImageView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(75);
            make.top.mas_equalTo(27);
        }];
        // 拉伸优先级低
        [_titleLabel setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        // 压缩优先级低
        [_titleLabel setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        
        self.joinNameLabel = UILabel.new;
        _joinNameLabel.font = FONT_SIZE(12);
        _joinNameLabel.textColor = UIColor.whiteColor;
        _joinNameLabel.layer.cornerRadius = 4;
        _joinNameLabel.layer.masksToBounds = YES;
        _joinNameLabel.textAlignment = NSTextAlignmentCenter;
        [_bgImageView addSubview:_joinNameLabel];
        
        self.dateLabel = UILabel.new;
        _dateLabel.font = FONT_SIZE(12);
        [_bgImageView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
            make.left.equalTo(_titleLabel);
            make.right.equalTo(_bgImageView).offset(-10);
        }];
    }
    return self;
}

- (void)configModel:(XMHTicketModel *)model {
    BOOL is_user = [model.is_use isEqualToString:@"1"];
    
    _titleLabel.text = model.name;
    _joinNameLabel.text = model.join_name;
    _dateLabel.text = [NSString stringWithFormat:@"有效期：%@-%@    限门店使用", model.start_time, model.end_time];
    
    _bgImageView.highlighted = is_user;
    if (is_user) {
        _selectButton.hidden = NO;
        _selectButton.selected = model.select;
        
        _titleLabel.textColor = [ColorTools colorWithHexString:@"#FC558B"];
        _joinNameLabel.backgroundColor = [ColorTools colorWithHexString:@"#FC558B"];
        _dateLabel.textColor = kColor9;
    } else {
        _selectButton.hidden = YES;
        
        _titleLabel.textColor = kBackgroundColor_CCCCCC;
        _joinNameLabel.backgroundColor = kBackgroundColor_CCCCCC;
        _dateLabel.textColor = kBackgroundColor_CCCCCC;
    }
    
    CGSize joinSize = [_joinNameLabel sizeThatFits:CGSizeMake(100, 20)];
    [_joinNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(33);
        make.left.equalTo(_titleLabel.mas_right);
        make.width.mas_equalTo(joinSize.width + 10);
        make.height.mas_equalTo(joinSize.height + 6);
        if (is_user) {
            make.right.equalTo(_selectButton.mas_left).offset(-10);
        } else {
            make.right.equalTo(_bgImageView.mas_right).offset(-20);
        }
    }];
}

@end
