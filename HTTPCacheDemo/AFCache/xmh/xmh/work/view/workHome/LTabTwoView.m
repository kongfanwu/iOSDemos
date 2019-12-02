//
//  LTabTwoView.m
//  xmh
//
//  Created by ald_ios on 2018/9/11.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LTabTwoView.h"
//#define kMargin 40
#define kBtnHeight 25
#define kBtnWidth 80
@implementation LTabTwoView
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
- (void)updateTabTwoViewTitles:(NSArray *)titleArr
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titleArr = titleArr;
    NSInteger count = _titleArr.count;
    CGFloat magin = (SCREEN_WIDTH - count * kBtnWidth)/(count +1);
    for (int i = 0; i<count ; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(15);
        btn.frame = CGRectMake(magin* (i+1) + kBtnWidth * i, 13, kBtnWidth, kBtnHeight);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 14;
        btn.layer.borderColor = [ColorTools colorWithHexString:@"#cccccc"].CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        if (i ==0) {
            [self btnClick:btn];
        }
        [self addSubview:btn];
    }
}
- (void)btnClick:(UIButton *)btn
{
    [_selectBtn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    _selectBtn.titleLabel.font = FONT_SIZE(15);
    _selectBtn.layer.borderColor = [ColorTools colorWithHexString:@"#cccccc"].CGColor;
    btn.titleLabel.font = FONT_BOLD_SIZE(15);
    [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    btn.layer.borderColor = kBtn_Commen_Color.CGColor;
    _selectBtn = btn;
    if (_TabTwoViewBlock) {
        _TabTwoViewBlock(btn.currentTitle);
    }
}
@end
