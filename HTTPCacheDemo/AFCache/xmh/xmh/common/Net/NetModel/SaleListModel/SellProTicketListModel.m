//
//  SellProTicketListModel.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/10/29.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "SellProTicketListModel.h"

@implementation SellProTicketListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SellProTicketModel class]};
}
@end

@implementation SellProTicketModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}
@end
