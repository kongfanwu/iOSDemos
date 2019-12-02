//
//  XMHOrderListSeverModel.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOrderListSeverModel.h"

@implementation XMHOrderListSeverModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [XMHOrderSeverModel class]};
}
@end

@implementation XMHOrderSeverModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}
@end
