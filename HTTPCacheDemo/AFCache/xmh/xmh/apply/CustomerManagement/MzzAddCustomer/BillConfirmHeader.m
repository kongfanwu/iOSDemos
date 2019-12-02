//
//  BillConfirmHeader.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BillConfirmHeader.h"

@implementation BillConfirmHeader

- (IBAction)btn1Event:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSString *state = @"0";
    BOOL _boolState = NO;
    if (sender.selected) {
        state = @"1";
        _boolState = YES;
    } else {
        state = @"0";
        _boolState = NO;
    }
    if (_btnBillConfirmHeaderBlock) {
        _btnBillConfirmHeaderBlock(state,_boolState);
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
