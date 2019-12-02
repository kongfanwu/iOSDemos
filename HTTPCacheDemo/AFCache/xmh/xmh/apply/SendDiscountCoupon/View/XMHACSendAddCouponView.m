//
//  XMHACSendAddCouponView.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHACSendAddCouponView.h"

@implementation XMHACSendAddCouponView
- (IBAction)btnClick:(id)sender {
    if (_sendAddCouponViewBlock) {
        _sendAddCouponViewBlock();
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _addCouponBtn.backgroundColor = kColorF5F5F5;
    _addCouponBtn.layer.cornerRadius = 5;
    _infoLab.textColor = kColor6;
    _infoLab.font = FONT_SIZE(15);
    _infoLabLeftLayout.constant = (SCREEN_WIDTH - 20) * 0.5 - 20;
    
    [self layoutIfNeeded];
}

@end
