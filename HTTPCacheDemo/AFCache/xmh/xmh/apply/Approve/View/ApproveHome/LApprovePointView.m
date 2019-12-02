//
//  LApprovePointView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LApprovePointView.h"

@implementation LApprovePointView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imgName:(NSString *)imgName
{
    self = [super initWithFrame:frame];
    if (self) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn1 setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        _btn1.frame = CGRectMake(self.width/4, 8, self.width/2, self.width/2);
        [self addSubview:_btn1];
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.font = FONT_SIZE(13);
        _lbTitle.textColor = kColor3;
        _lbTitle.text = title;
        [_lbTitle sizeToFit];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.frame = CGRectMake(0, _btn1.bottom + 5, self.width, _lbTitle.height);
        [self addSubview:_lbTitle];
        _lbPoint = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 30, 10, 10, 10)];
        _lbPoint.layer.cornerRadius = 5;
        _lbPoint.layer.masksToBounds = YES;
        _lbPoint.backgroundColor = kBtn_Commen_Color; //[ColorTools colorWithHexString:@"#f86f5c"];
        _lbPoint.hidden = YES;
        [self addSubview:_lbPoint];
    }
    return self;
}
@end
