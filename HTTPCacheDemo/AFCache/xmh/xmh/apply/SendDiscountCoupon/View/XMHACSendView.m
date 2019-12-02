//
//  XMHACSendView.m
//  xmh
//
//  Created by ald_ios on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHACSendView.h"
#define kCornerRadius  5
@interface XMHACSendView ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end
@implementation XMHACSendView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _btn.backgroundColor = kColorF5F5F5;
    [_btn setTitleColor:kColor6 forState:UIControlStateNormal];
    _btn.titleLabel.font = FONT_SIZE(15);
    _btn.layer.cornerRadius = kCornerRadius;
}
- (IBAction)tap:(UIButton *)sender
{
    if (_XMHACSendViewBlock) {
        _XMHACSendViewBlock();
    }
}

@end
