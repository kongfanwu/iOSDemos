//
//  SAZhiHuanListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/2.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SAZhiHuanListModel.h"

@implementation SAZhiHuanListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"award" : [SAZhiHuanAwardModel class],@"y_award" : [SAZhiHuanAwardModel class]};
}
@end

@implementation SAZhiHuanAwardModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"range" : [SAZhiHuanRangeModel class]};
}
@end

@implementation SAZhiHuanRangeModel

@end
