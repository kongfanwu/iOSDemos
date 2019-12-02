//
//  TwoBtnChoiseSectionHeader.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TwoBtnChoiseSectionHeader.h"

@implementation TwoBtnChoiseSectionHeader{
    NSMutableArray *_btnArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    _btnArray = [[NSMutableArray alloc]init];
    [_btn1 setTitle:@"账单明细" forState:UIControlStateNormal];
    [_btn1 setTitle:@"账单明细" forState:UIControlStateSelected];
    [_btn1 setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    [_btn1 setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateSelected];
    _btn1.titleLabel.font = FONT_BOLD_SIZE(15);
    CGSize titleSize = [@"账单明细" sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:_btn1.titleLabel.font.fontName size:_btn1.titleLabel.font.pointSize]}];
    float btnwidth = titleSize.width + 20;
    _btn1.frame = CGRectMake(SCREEN_WIDTH/2.0-btnwidth ,0, btnwidth, 49);
    _btn1.selected = YES;
    [_btn1 addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_btnArray addObject:_btn1];
    _btn1.tag = 1000;
    
    [_btn2 setTitle:@"顾客处方" forState:UIControlStateNormal];
    [_btn2 setTitle:@"顾客处方" forState:UIControlStateSelected];
    [_btn2 setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    [_btn2 setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateSelected];
    _btn2.titleLabel.font = FONT_BOLD_SIZE(15);
    CGSize titleSize2 = [@"顾客处方" sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:_btn1.titleLabel.font.fontName size:_btn1.titleLabel.font.pointSize]}];
    float btnwidth2 = titleSize2.width + 20;
    _btn2.frame = CGRectMake(SCREEN_WIDTH/2.0+20 ,0, btnwidth2, 49);
    [_btn2 addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_btnArray addObject:_btn2];
    _btn2.tag = 1001;
    
    _line2.frame = CGRectMake(0, 49, SCREEN_WIDTH, 1);
    _line2.backgroundColor = kBackgroundColor;
    _line1.frame = CGRectMake(_btn1.left, 47, 25, 3);
    _line1.backgroundColor= [ColorTools colorWithHexString:@"#f10180"];
    _line1.layer.cornerRadius = 2;
}
- (void)btnEvent:(UIButton *)sender{
    for (UIButton *btnTemp in _btnArray) {
        btnTemp.selected = NO;
    }
    sender.selected = YES;
    _line1.frame = CGRectMake(0, 47, 25, 3);
    _line1.center = CGPointMake(sender.center.x, _line1.center.y);
    switch (sender.tag) {
        case 1000:{
            if (_TwoBtnChoiseSectionHeaderBlock) {
                _TwoBtnChoiseSectionHeaderBlock(TwoBtnChoiseSectionTypeZhangDan);
            };
        }
            break;
        case 1001:{
            if (_TwoBtnChoiseSectionHeaderBlock) {
                _TwoBtnChoiseSectionHeaderBlock(TwoBtnChoiseSectionTypeGuKe);
            };
        }
            break;
        default:
            break;
    }
}
- (void)reFreshTwoBtnChoiseSectionHeader:(TwoBtnChoiseSectionType)type{
    switch (type) {
        case TwoBtnChoiseSectionTypeZhangDan:
        {
            _btn1.selected = YES;
            _btn2.selected = NO;
            _line1.frame = CGRectMake(0, 47, 25, 3);
            _line1.center = CGPointMake(_btn1.center.x, _line1.center.y);
        }
            break;
        case TwoBtnChoiseSectionTypeGuKe:
        {
            _btn1.selected = NO;
            _btn2.selected = YES;
            _line1.frame = CGRectMake(0, 47, 25, 3);
            _line1.center = CGPointMake(_btn2.center.x, _line1.center.y);
        }
            break;
        default:
            break;
    }
}
@end
