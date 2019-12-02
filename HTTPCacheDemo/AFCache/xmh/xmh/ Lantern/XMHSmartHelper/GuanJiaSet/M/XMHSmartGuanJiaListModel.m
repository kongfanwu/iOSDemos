//
//  XMHSmartGuanJiaListModel.m
//  xmh
//
//  Created by ald_ios on 2019/6/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSmartGuanJiaListModel.h"

@implementation XMHSmartGuanJiaListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [XMHSmartGuanJiaModel class] };
}
@end
@implementation XMHSmartGuanJiaModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"setID":@"id"};
}
@end
