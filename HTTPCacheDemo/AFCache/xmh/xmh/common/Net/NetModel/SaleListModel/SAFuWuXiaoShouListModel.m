//
//  SAFuWuXiaoShouListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/1.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SAFuWuXiaoShouListModel.h"

@implementation SAFuWuXiaoShouListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"dList" : [SAFuWuXiaoShouListSubModel class]};
}
@end

@implementation SAFuWuXiaoShouListSubModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}
@end
