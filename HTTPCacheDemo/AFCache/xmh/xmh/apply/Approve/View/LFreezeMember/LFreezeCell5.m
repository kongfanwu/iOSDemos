//
//  LFreezeCell5.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LFreezeCell5.h"
#import <YYWebImage/YYWebImage.h>

@interface LFreezeCell5()
/** <##> */
@property (nonatomic, strong) UIView *bgView;
@end

@implementation LFreezeCell5

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
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kColorF5F5F5;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _bgView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, self.height);
    
    if (!_bgView.layer.mask) {
        [UIView addRadiusWithView:_bgView roundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    }
}

- (void)initSubViews
{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 0)];
    [self.contentView addSubview:_bgView];
    _bgView.backgroundColor = UIColor.whiteColor;
    
    _lb1 = [[UILabel alloc] init];
    _lb1.font = FONT_BOLD_SIZE(15);
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.text = @"抄送人";
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake(15, 0, _lb1.width, _lb1.height);
    [_bgView addSubview:_lb1];
}
-(void)setDuplicatePersonList:(NSArray<LDuplicatePersonModel *> *)duplicatePersonList
{
    _duplicatePersonList = duplicatePersonList;
    for (int i = 0; i < duplicatePersonList.count; i++) {
        LDuplicatePersonModel * model = duplicatePersonList[i];
        UIImageView * imV = [[UIImageView alloc] init];
        [imV yy_setImageWithURL:[NSURL URLWithString:model.head_img] placeholder:kDefaultJisImage];
        imV.frame = CGRectMake(_lb1.left  +  (i%5)* (45 + 20) , _lb1.bottom + 10  + (i/5) * (20 + 10 + 45), 45, 45);
        [imV cornerRadius:imV.width / 2.f];
        [_bgView addSubview:imV];
        
        UILabel * lb = [[UILabel alloc] init];
        lb.font = FONT_SIZE(12);
        lb.textColor = kLabelText_Commen_Color_6;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = model.name;
        [lb sizeToFit];

        lb.frame = CGRectMake(_lb1.left + (i%5) * (45 + 20), _lb1.bottom + 45 + 10 + 10 +(i/5)* (45 + 20 + 10), 45, 20);
        [_bgView addSubview:lb];
    }
}
@end
