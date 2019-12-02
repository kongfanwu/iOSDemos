//
//  RefundGWCTbHeader.m
//  xmh
//
//  Created by ald_ios on 2018/11/14.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundGWCTbHeader.h"
@interface RefundGWCTbHeader ()

@end
@implementation RefundGWCTbHeader

- (IBAction)btnClear:(id)sender {
    if (_RefundGWCTbHeaderBlock) {
        _RefundGWCTbHeaderBlock();
    }
}

@end
