//
//  XMHOrderListModel.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOrderListSaleModel.h"
@implementation XMHOrderListSaleModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [XMHOrderSaleModel class]};
}
@end

@implementation XMHOrderSaleModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end
