//
//  XMHACSendAddCustomer.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHACSendAddCustomer.h"

@implementation XMHACSendAddCustomer
- (IBAction)btn:(id)sender {
    if (_sendAddCustomerViewBlock) {
        _sendAddCustomerViewBlock();
    }
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _addCustomerBtn.backgroundColor = kColorF5F5F5;
    _addCustomerBtn.layer.cornerRadius = 5;
    _titleLab.textColor = kColor6;
    _titleLab.font = FONT_SIZE(15);
    _titleLabLeftlayout.constant = (SCREEN_WIDTH - 20) * 0.5 - 20;
  
    [self layoutIfNeeded];
}
@end
