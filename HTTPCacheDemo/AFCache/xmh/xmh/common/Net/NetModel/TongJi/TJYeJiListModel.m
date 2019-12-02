//
//  TJYeJiListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJYeJiListModel.h"

@implementation TJYeJiListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [TJYeJiDataModel class]};
}
@end

@implementation TJYeJiDataModel

@end
