//
//  LWaitCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LWaitCell.h"

@implementation LWaitCell
{
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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setTitleArr:(NSArray *)titleArr
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titleArr = titleArr;
    NSInteger count = titleArr.count;
    CGFloat margin = 15;
    CGFloat w = (SCREEN_WIDTH - 15 * 4)/3;
    for (int i = 0; i < count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(13);
        [btn setTitleColor:kLabelText_Commen_Color_9 forState:UIControlStateNormal];
        [btn setTitleColor:kPortraitCellTitle_9072 forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:kColorF5F5F5 size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kPortraitCellTitle_F3F0 size:CGSizeMake(10, 10)] forState:UIControlStateSelected];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        if (i ==0) {
            [self click:btn];
        }
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.frame = CGRectMake(15 + (i%3) * (margin + w), (margin + 40) * (i/3), w, 40);
        [self addSubview:btn];
    }
}
- (void)click:(UIButton *)btn
{
    [self refreshbtnState:btn];
    _selectBtn.selected = NO;
    _selectBtn.layer.borderWidth = 0;
    
    btn.selected = YES;
    btn.layer.borderColor = kPortraitCellTitle_9072.CGColor;
    btn.layer.borderWidth = 0.6;
    
    _selectBtn = btn;
    if (_LWaitCellBlock) {
        _LWaitCellBlock(btn.tag,btn.currentTitle);
    }
}
- (void)refreshbtnState:(UIButton *)btn
{
    for (int i = 0; i < self.subviews.count; i++) {
        UIView * view = self.subviews[i];
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * b = (UIButton *)view;
            if ([b isEqual:btn]) {
                b.backgroundColor = kBtn_Commen_Color;
                b.layer.borderColor = kBtn_Commen_Color.CGColor;
            }else{
                b.backgroundColor = [UIColor whiteColor];
                b.layer.borderColor = kLabelText_Commen_Color_9.CGColor;
            }
        }
    }
    
}
@end
