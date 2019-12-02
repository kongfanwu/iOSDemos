//
//  LolTapView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/7/9.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LolTapView.h"
#import "XMHBadgeLabel.h"
@implementation LolTapView
{
    NSArray * _titleArr;
}
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame]) {
        _titleArr = titles;
    }
    return self;
}
- (void)initSubViews
{
    NSInteger count = _titleArr.count;
    CGFloat  x =  (SCREEN_WIDTH - 55 * count)/(count + 1);
    for (int i = 0; i < count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(12);
        [btn setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
        [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
        btn.frame = CGRectMake((i + 1)* x + 55 * i, 0, 55, 44);
        btn.tag = i;
        XMHBadgeLabel * lb = [XMHBadgeLabel defaultBadgeLabel];
        lb.backgroundColor = [ColorTools colorWithHexString:@"#f10180"];
        lb.left = btn.right;
        lb.bottom = btn.top + btn.height/2 + 4;
        lb.height = 14;
        lb.tag = i;
        lb.hidden = YES;
        [self addSubview:lb];
        if(i == 0){
            [self tap:btn];
        }
        [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
- (void)tap:(UIButton *)btn
{
    
}
@end
