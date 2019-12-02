//
//  XMHCouponPayInfoModel.m
//  xmh
//
//  Created by KFW on 2019/5/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponPayInfoModel.h"

@implementation XMHCouponPayInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.status = @"2";
    }
    return self;
}

/**
 拼接value描述
 */
- (NSString *)valueDes {
    if ([_status integerValue] == 1) {
        return [NSString stringWithFormat:@"支付使用，（支付金额%.2f元）", [_money floatValue]];
    } else {
        return @"不激活可使用";
    }
}

@end
