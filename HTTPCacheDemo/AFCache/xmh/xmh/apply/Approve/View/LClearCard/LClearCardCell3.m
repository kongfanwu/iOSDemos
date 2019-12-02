//
//  LClearCardCell3.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LClearCardCell3.h"

@implementation LClearCardCell3
{
    NSArray * _titles;
    UIButton * _selectBtn;
}
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
        _titles = @[@"支付宝",@"微信",@"银行卡转账",@"现金"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews
{
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = kBackgroundColor;
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    [self addSubview:line];
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"清卡方式";
    lb.font = FONT_BOLD_SIZE(14);
    lb.textColor = kLabelText_Commen_Color_3;
    [lb sizeToFit];
    lb.frame = CGRectMake(15, line.bottom + 15, lb.width, lb.height);
    [self addSubview:lb];
    CGFloat margin = 5;
    CGFloat w = (SCREEN_WIDTH - margin *_titles.count)/4;
    for (int i = 0; i< _titles.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"syspyyzhifuxuanzeweixuan"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"syspyyzhifuxuanze"] forState:UIControlStateSelected];
        btn.titleLabel.font = FONT_SIZE(14);
        [btn setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
        btn.frame = CGRectMake((margin + w) * i + margin , lb.bottom + 19, w, 20);
        [self addSubview:btn];
        btn.tag = i + 1;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [btn addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)payClick:(UIButton *)btn
{
    _selectBtn.selected = NO;
    btn.selected = YES;
    _selectBtn = btn;
    if (_LClearCardCell3Block) {
        _LClearCardCell3Block([NSString stringWithFormat:@"%ld",btn.tag]);
    }
}
@end
