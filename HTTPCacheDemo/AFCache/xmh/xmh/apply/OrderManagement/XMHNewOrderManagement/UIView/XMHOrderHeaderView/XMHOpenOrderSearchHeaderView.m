//
//  XMHOpenOrderSearchHeaderView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOpenOrderSearchHeaderView.h"

@implementation XMHOpenOrderSearchHeaderView

- (IBAction)searchCustomerBtnClick:(id)sender {
    if (_searchCustomerBtnClick) {
        _searchCustomerBtnClick();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
