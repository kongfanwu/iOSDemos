//
//  RefundListModel.m
//  xmh
//
//  Created by ald_ios on 2018/11/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundListModel.h"

@implementation RefundListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sales" : [RefundModel class], @"stored_card" : [RefundModel class],@"bank" : [RefundModel class],@"ticket" : [RefundModel class],@"card_time" : [RefundModel class],@"card_num" : [RefundModel class],@"goods" : [RefundModel class],@"pro" : [RefundModel class],@"list" : [RefundModel class]};
}
@end
@implementation RefundModel

@end
