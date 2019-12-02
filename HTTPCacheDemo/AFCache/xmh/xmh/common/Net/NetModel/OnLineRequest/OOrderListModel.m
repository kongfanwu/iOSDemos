//
//  OOrderListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OOrderListModel.h"

@implementation OOrderListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [OOrderModel class]};
}
@end

@implementation OOrderModel

@end
