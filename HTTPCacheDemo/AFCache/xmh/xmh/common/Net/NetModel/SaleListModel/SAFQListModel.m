//
//  SAFQListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SAFQListModel.h"

@implementation SAFQListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"cart" : [SAFQModel class],@"list" : [SAFQModel class]};
}
@end



@implementation SAFQModel

@end
