//
//  LApproveBtnView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LApproveBtnView.h"

@implementation LApproveBtnView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imgName:(NSString *)imgName
{
    if (self = [super initWithFrame:frame]) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn1 setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        _btn1.frame = CGRectMake(5, 5, self.width - 10, self.width - 10);
        _btn1.layer.cornerRadius = 3;
        _btn1.layer.masksToBounds = YES;
        [self addSubview:_btn1];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.font = FONT_SIZE(13);
        _lbTitle.text = title;
        [_lbTitle sizeToFit];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.frame = CGRectMake(0, _btn1.bottom + 5, self.width, _lbTitle.height);
        [self addSubview:_lbTitle];
    }
    return self;
}

@end
