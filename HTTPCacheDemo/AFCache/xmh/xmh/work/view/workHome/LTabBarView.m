//
//  LTabBarView.m
//  xmh
//
//  Created by ald_ios on 2018/9/11.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LTabBarView.h"

#define kLineHeight 3
@implementation LTabBarView
{
    NSArray * _titleArr;
    UIView * _line;
    UIButton * _selectBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)updateTabBarViewTitles:(NSArray *)titleArr
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titleArr = titleArr;
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = kBtn_Commen_Color;
    v.frame = CGRectMake(0, 0, 25, kLineHeight);
    v.layer.masksToBounds = YES;
    v.layer.cornerRadius = kLineHeight * 0.5;
    _line = v;
    NSInteger count = _titleArr.count;
    for (int i = 0; i<count ; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(15);
        btn.frame = CGRectMake(i * (SCREEN_WIDTH/count), 0, SCREEN_WIDTH/count, self.height-kLineHeight -1);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        if (i ==0) {
            [self btnClick:btn];
        }
        [self addSubview:btn];
    }
    UIView * line1 = [[UIView alloc] init];
    line1.backgroundColor = [ColorTools colorWithHexString:@"f5f5f5"];
    line1.frame = CGRectMake(0, self.height-kSeparatorHeight, SCREEN_WIDTH, kSeparatorHeight);

    [self addSubview:v];
    [self addSubview:line1];
}
- (void)btnClick:(UIButton *)btn
{
    [_selectBtn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    _selectBtn.titleLabel.font = FONT_SIZE(15);
    btn.titleLabel.font = FONT_BOLD_SIZE(15);
    [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    _selectBtn = btn;
    _line.backgroundColor = kBtn_Commen_Color;
    _line.centerX = btn.centerX;
    _line.y = self.height-kLineHeight -1;
    if (_TabBarViewBlock) {
        _TabBarViewBlock(btn.currentTitle);
    }
}
@end
