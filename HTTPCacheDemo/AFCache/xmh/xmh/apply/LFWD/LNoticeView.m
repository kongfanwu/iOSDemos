//
//  LNoticeView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/5.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LNoticeView.h"

@implementation LNoticeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)refreashViewTitle:(NSString *)title content:(NSString *)content left:(NSString *)left right:(NSString *)right input:(NSString *)input{
    _lbTitle.text = title;
    _lbSubTitle.text = content;
    [_btnCancel setTitle:left forState:UIControlStateNormal];
    [_btnSure setTitle:right forState:UIControlStateNormal];
    _tf.text = input;
}
@end
