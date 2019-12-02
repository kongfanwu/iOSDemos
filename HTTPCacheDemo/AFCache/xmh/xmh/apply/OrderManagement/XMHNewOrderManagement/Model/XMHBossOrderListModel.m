//
//  XMHBossOrderListModel.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBossOrderListModel.h"

@implementation XMHBossOrderListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [XMHBossOrderModel class]};
}
@end

@implementation XMHBossOrderModel

@end
