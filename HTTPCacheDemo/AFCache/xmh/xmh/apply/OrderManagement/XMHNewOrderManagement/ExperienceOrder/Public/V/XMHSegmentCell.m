//
//  XMHSegmentCell.m
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSegmentCell.h"
#import "XMHSegmentVCModel.h"

@interface XMHSegmentCell()
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel, *badgeLabel;
/** <##> */
@property (nonatomic, strong)UIView *bottonLineView;
@end

@implementation XMHSegmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabel = [UILabel new];
        _titleLabel.font = FONT_SIZE(13);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
//        self.badgeLabel = [[UILabel alloc] init];
//        _badgeLabel.font = FONT_SIZE(10);
//        _badgeLabel.textColor = UIColor.whiteColor;
//        _badgeLabel.backgroundColor = kBtn_Commen_Color;
//        _badgeLabel.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:_badgeLabel];
        
        UIView *bottonLineView = [[UIView alloc] init];
        bottonLineView.backgroundColor = kSeparatorColor;
        [self.contentView addSubview:bottonLineView];
        [bottonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(kSeparatorHeight);
        }];
        self.bottonLineView = bottonLineView;
    }
    return self;
}

- (void)configModel:(XMHSegmentVCModel *)model {
    _titleLabel.text = model.text;
    if (model.select) {
        _titleLabel.textColor = kBtn_Commen_Color;
    } else {
        _titleLabel.textColor = kColor9;
    }
    
    if (model.badge) {
        _badgeLabel.hidden = NO;
        _badgeLabel.text = @(model.badge).stringValue;
        [_badgeLabel sizeToFit];
        _badgeLabel.layer.cornerRadius = _badgeLabel.height / 2.f;
        _badgeLabel.layer.masksToBounds = YES;
        
        [_badgeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.width.mas_equalTo(_badgeLabel.width + 10);
        }];
    } else {
        _badgeLabel.hidden = YES;
    }
}

@end
